; MEMORY.ASM-	Memory manager code for the standard library.
;		This module contains the commonly used routines.



		.386
		option	segment:use16, proc:private

		include	memory.a
		include	excepts.a

		echo	Memory: MemInit, Malloc, Free

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing, es:nothing







; Memory allocation routines: MemInit, malloc, and free.
;
;
; Local variables:

$StartOfHeap	dw	?
$SizeOfHeap	dw	?
$FreeSpace	dw	?
$EndOfHeap	dw	?
$PSP		dw	?


; MemInit- Initializes the memory manager.
;
;	On entry- Nothing.
;
;	On Exit-  CX contains the number of paragraphs of memory actually 
;		  allocated to the heap.
;
;		  AX contains the starting segment address of the free
;		  memory block.
;
; WARNING: for this routine to work properly, the last segment
; in the program must be "zzzzzzseg" and this guy should NOT contain any
; valid data (except, perhaps, for the heap definition).


		public	$MemInit
$MemInit	proc	far
		assume	ds:ucrlib

		push	bx
		push	dx
		push	es
		push	ds

		mov	ax, cs
		mov	ds, ax

		mov	ah, 62h			;Get the address of the PSP.
		int	21h
		mov	es, bx

		mov	ax, seg zzzzzzseg	;Pointer to start of heap.
		mov	bx, es:[2]		;Get address of last para
		mov	$EndOfHeap, bx		; from the heap and compute
		sub	bx, ax			; the heap size.
		mov	$StartOfHeap, ax	;Save pointer to memory.
		mov	$FreeSpace, ax		;Save pointer to 1st free blk.
		mov	$SizeOfHeap, bx		;Size of heap in paragraphs.

		mov	es, ax			;Init pointer to heap.
		xor	ax, ax
		mov	esptr.blksize, bx	;Size of this block (paras).
		mov	esptr.bwdptr, ax  	;Back pointer is NIL.
		mov	esptr.fwdptr, ax  	;Fwd pointer is NIL.
		mov	esptr.refcnt, ax  	;Reference Count is zero.
		mov	esptr.freebwdptr, ax 	;Free list bwd ptr is NIL.
		mov	esptr.freefwdptr, ax 	;Free list fwd ptr is NIL.

		mov	cx, bx			;Return size in CX
		mov	ax, $StartOfHeap
MemInitDone:	pop	ds
		pop     es
		pop	dx
		pop	bx
		ret
$MemInit	endp




;============================================================================
;
;    *     *      *      *        *         *****       *****
;    **   **     * *     *        *        *     *     *     *
;    * * * *    *   *    *        *        *     *     *
;    *  *  *    *****    *        *        *     *     *
;    *     *    *   *    *	  *        *     *     *
;    *     *    *   *    *        *        *     *     *     *
;    *     *    *   *    *****    *****     *****       *****
;
;============================================================================
;
;
; malloc-  On entry, CX contains a byte count.  Malloc allocates a block
;	   of storage of the given size and returns a pointer to this block
;	   in ES:DI.  The value in ES:DI is always normalized, so you can
;	   compare pointers allocated via malloc as 32-bit values.  Note
;	   that malloc always allocates memory in paragraph chunks.
;	   Therefore, this routine returns the actual number of bytes of
;	   memory allocated in the CX register (this may be as much as 15
;	   greater than the actual number asked for).
;
;	   Malloc returns carry clear if it allocated the storage without
;	   error.  It returns carry set if it could not find a block large
;	   enough to satisfy the request.
;
;	   If exceptions are enabled, MALLOC raises an $InsuffMem exception
;	   if it cannot allocate sufficient memory.
;
;
; Data structure for memory allocation blocks:
;
; offset:
;
;   0	Size of Blk
;   2   Back link
;   4   Fwd Link
;   6   Reference Count
;   8   Data, if this block is allocated, prev link if on free list.
;  10	Data, if this block is allocated, next link if on free list.


		public	$Malloc
$malloc		proc	far
		assume	ds:nothing

		push	ax
		push	si
		push	ds

; Convert byte count to paragraph count, since we always allocate whole
; paragraphs.

		add	cx, 8			;We have eight bytes of overhead!
		rcr	cx, 1			;Use rcr because of add above.
		adc	cx, 0
		shr	cx, 1
		adc	cx, 0
		shr	cx, 1
		adc	cx, 0
		shr	cx, 1
		adc	cx, 0

; Go find a block in the free list that is large enough.


		cmp	$FreeSpace, 0		;See if no free space.
		jz	MemoryFull
		mov	ds, $FreeSpace
		mov	ax, ds			;In case first block is it.
FindBlk:	cmp	cx, dsptr.blksize	;See if blk is large enuf.
		jbe	FoundBlk		;Go for it!
		mov 	ax, dsptr.freefwdptr	;Get ptr to next free block.
		mov	ds, ax			;Set up pointer.
		or	ax, ax			;See if NIL
                jnz	FindBlk			;Repeat until NIL.

; If we drop down here, we've got some big problems.

MemoryFull:	call	$GetXEnabled
		cmp	ax, 0
		je	JustReturn
		mov	ax, $InsuffMem
		call	$Raise

JustReturn:	pop	ds
		pop	si
		pop	ax
		mov	es, $StartOfHeap	;In case they use this ptr
		mov	di, 8			; anyway.
		stc				;Return error status.
		ret

; When we come down here, we've found a block large enough to satisfy the
; current memory request.  If necessary, split the block up into two
; pieces and return the unused half back to the free pool.

FoundBlk:       jne	SplitBlock


;***************************************************************************
; Exact fit, remove this guy from the free list and go for it!
;***************************************************************************
;
; There are four cases to deal with if this is an exact fit:
;
;	1) The block we're allocating is the first block in the free list.
;	   In this case, FreeSpace points at this block and the freebwdptr
;	   entry is NIL.
;
;	2) The block we're allocating is neither the first or last in the
;	   free list.
;
;	3) The block we're allocating is the last block in the free list.
;	   In this case, the freefwdptr will be NIL.
;
;	4) The block is both the first and last (i.e., only) block in the
;	   the free list.
;
; At this point, DS points at the block we're going to allocate.

		mov	ax, dsptr.freefwdptr	;Pointer to next free block.
		cmp	dsptr.freebwdptr, NIL	;First item in list?
		jnz	NotFirst

; Case (1) and (4) drop down here.
;
; If this is the first free block in the free link list, point FreeSpace
; beyond this guy rather than going through the usual linked list stuff.
;
; AX contains a pointer to the next free block (after this one) if it exists.
; DS points at the current free block.
;
; Since we are removing the first free block, we need to update the FreeSpace
; pointer so that it points at the next free block in the free block list.

		mov	$FreeSpace, ax		;Note: AX may be NIL if case (4).

; See if there is another block after this one.  If not (case 4) then jump
; off to FixThisBlk.

		or	ax, ax			;Is there another free blk?
		jz	FixThisBlk		;If not, don't patch next adrs.

; Case (1), only, down here.  The current block is the one we want and
; there is another free block after this one.  AX Points at the next free
; block.  DS points at the current block.

		mov	es, ax           	;Point ES at next free block.
		mov	esptr.freebwdptr, NIL	;Set next guy's back link to NIL.
		jmp	short FixThisBlk

; If the current block is not the first free block in the free block list
; handle it down here. This corresponds to cases 2 or 3.  On entry, DS
; points at the current block, AX points at the next free block (if present).

NotFirst:	mov	es, dsptr.freebwdptr	;Get ptr to prev blk.
		mov	esptr.freefwdptr, ax	;Skip over current blk.
		mov	ax, es			;Load AX with prev blk adrs.

; Now we need to figure out if there is a next free block (is this case 2?).

		cmp	dsptr.freefwdptr, NIL
		jz	FixThisBlk

; Definitely Case (2) here.  Patch the next free block's prev field with
; the address of the previous block.

		mov	es, dsptr.freefwdptr	;Point ES at next block.
		mov	esptr.freebwdptr, ax	;Save link to prior block.

; All four cases converge down here to clean up things and store the
; ovrhead info for the newly allocated block.
;
FixThisBlk:	mov	dsptr.blksize, cx	;Save its size.
		mov	dsptr.refcnt, 1		;Reference count = 1.
		mov	di, 8			;Pointer to data area.
		mov	ax, ds
		mov	es, ax
		shl	cx, 4			;Convert para size to bytes
		pop	ds
		pop	si
		pop	ax
		clc
		ret

;****************************************************************************
; The current free block is bigger than we need, SPLIT it in half down here.
;****************************************************************************
;
;
; If allocating this block splits a free block in half, we handle that
; down here.

SplitBlock:     mov	ax, ds			;Get start of block.
		add	ax, dsptr.blksize	;Add in size of block.
		sub	ax, cx			;Subtract part we're keeping.
		mov	es, ax			;Point at data block.
		mov	esptr.blksize, cx	;Save size of block
		mov	esptr.bwdptr, ds	;Save back pointer.
		mov	esptr.refcnt, 1		;Init reference count.
		mov	ax, dsptr.fwdptr	;Get prev fwd ptr.
		mov	dsptr.fwdptr, es	;Save new fwd point in free blk.
		mov	esptr.fwdptr, ax	;New forward pointer for us.
		mov	si, es			;Save ptr to this blk.
		mov	es, ax			;Point es at last blk.
		mov	esptr.bwdptr, si	;Chain it in properly.
		mov	es, si			;Restore so we can return it.
		mov	ax, dsptr.blksize	;Compute new size of free blk.
		sub	ax, cx
		mov	dsptr.blksize, ax
		mov	di, 8			;Init pointer to data.
		shl	cx, 4			;Convert para size to bytes.
		pop	ds
		pop	si
		pop	ax
		clc
		ret
$malloc		endp





;===========================================================================
;
;  ******     *****       ******     ******
;  *          *    *      *          *
;  *          *    *      *          *
;  ****       * ***       ****       ****
;  *          *  *        *          *
;  *          *   *       *          *
;  *          *    *      ******     ******
;
;===========================================================================
;
; Free-	Returns a block of storage to the free list.
;
; On Entry-	ES:DI points at the block to free.
; On Exit-	Carry is clear if free was okay, set if invalid pointer.
;		If exceptions are enabled and the users attempts to free
;		a bad pointer, this code raises the $MemFree exception.


		public	$Free
$free		proc	far
		push	ax
		push	si
		push	ds
		push	es
		mov	si, di

; See if this is a valid pointer:

		cmp	si, 8
		jne	BadPointer
		mov	si, es			;Make seg ptr convenient.
		mov	ds, $StartOfHeap
		cmp	si, $StartOfHeap	;Special case if first block.
		jne	Not1stBlock

; The block the user wants to free up is the very first block.  Handle that
; right here.

		cmp	dsptr.refcnt, 0
		je	BadPointer
		dec	dsptr.refcnt		;Decrement reference count.
		jnz	QuitFree		;Done if other references.

; Call coalesce to possibly join this block with the next block.  We do not
; have to check to see if this call joins the current block with the prev
; block because the current block is the very first block in the memory
; space.

		call	Coalesce

; Adjust all the pointers as appropriate:

		mov	dsptr.freebwdptr, NIL
		mov	ax, $FreeSpace		;Get and set up the fwd ptr.
		mov	dsptr.freefwdptr, ax
		mov	es, $FreeSpace
		mov	esptr.freebwdptr, ds	;Set up other back pointer.
		mov	$FreeSpace, ds		;Fix FreeSpace.
		jmp	short QuitFree


BadPointer:	call	$GetXEnabled
		cmp	ax, 0
		jne	RaiseFree
		stc
		jmp	short Quit2

RaiseFree:	mov	ax, $BadPointer
		call	$Raise

QuitFree:	clc
Quit2:		pop	es
		pop	ds
		pop	si
		pop	ax
		ret

; If this is not the first block in the list, see if we can coalesce any
; free blocks immediately around this guy.

Not1stBlock:    cmp	esptr.refcnt, 0
		je	BadPointer
		dec	esptr.refcnt		;Decrement reference count.
		jnz	QuitFree		;Done if other references.

		call	Coalesce
		jc	QuitFree

; Okay, let's put this free block back into the free list.

		mov	ax, $FreeSpace
		mov	esptr.freefwdptr, ax	;Set as pointer to next item.
		mov	esptr.freebwdptr, NIL	;NIL back pointer.
		mov	$FreeSpace, es
		jmp	QuitFree

$free		endp



; Coalesce routine: On entry, ES points at the block we're going to free.
; This routine coalesces the current block with any free blocks immediately
; around it and then returns ES pointing at the new free block.
; This routine returns the carry flag set if it was able to coalesce the
; current free block with a block immediately in front of it.
; It returns the carry clear if this was not the case.


Coalesce	proc	near
		push	ds
		push	es

		mov	ds, esptr.fwdptr	;Get next contiguous block.
		cmp	dsptr.refcnt, 0		;Is that block free?
		jnz	NextBlkNotFree

; If the next block is free, merge it into the current block here.
;
; Memory arrangement is currently something like this:
;
;        +------------------------+      +---------+   <-These are dbl links.
;        |                        |      |         |
;   |prevfree|     |CurFreeBlk| |FollowingBlk|   |NextFreeBlk|
;
; We want to wind up with:
;
;
;        +------------------------------------------+   <-These are dbl links.
;        |                                          |
;   |prevfree|     |CurFreeBlk| |FollowingBlk|   |NextFreeBlk|
;
;
; First, merge the current free block and the following block together.

		mov	ax, dsptr.blksize		;Get size of next block.
		add	esptr.blksize, ax		; Join the blocks together.
		mov	ax, dsptr.fwdptr
		mov	esptr.fwdptr, ax
		or	ax, ax
		jz	DontSetBwd
		push	ds
		mov	ds, ax
		mov	dsptr.bwdptr, es
		pop	ds

; Make sure that there is a |prevfree| block.

DontSetBwd:	mov	ax, dsptr.freebwdptr
		or	ax, ax
		jz	SetFreeSpcPtr

; prevfree.fwd := following.fwd;

		mov	es, dsptr.freebwdptr	;Point ES at previous guy.
		mov	ax, dsptr.freefwdptr
		mov	esptr.freefwdptr, ax	;Skip over current guy.

; If the fwd pointer is NIL, no need to continue.

		or	ax, ax			;See if end of list.
		jz	NextBlkNotFree

; nextfree.bwd := following.bwd (prevfree).

		mov	ax, es			;Save ptr to this guy.
		mov	es, dsptr.freefwdptr
		mov	esptr.freebwdptr, ax
		jmp	short NextBlkNotFree

; If FollowingBlk is the first free block in the free list, we have to
; execute the following code.

SetFreeSpcPtr:  mov	es, dsptr.freefwdptr
		mov	esptr.freebwdptr, NIL
		mov	$FreeSpace, es




; After processing the block following this block, or if the next block
; was not free, come down here and check to see if the previous block
; was free.

NextBlkNotFree:	pop	es		;Restore pointer to current block.
		push	es
		mov	ax, esptr.bwdptr
		or	ax, ax		;Is it a NIL pointer
		jz	NoPrevBlock
		mov	ds, ax
		cmp     dsptr.refcnt, 0	;Is that block free?
		jnz	NoPrevBlock

; Okay, the block in front is free.  Merge the current block into that one.

		mov	ax, esptr.blksize
		add	dsptr.blksize, ax
		mov	ax, esptr.fwdptr
		mov	dsptr.fwdptr, ax
		or	ax, ax			;See if there is a next blk.
		jz	NoNextBlk
		mov	es, ax
		mov	esptr.bwdptr, ds
NoNextBlk:	stc
		pop	es
		pop	ds
		ret

NoPrevBlock:	clc
		pop	es
		pop	ds
		ret
Coalesce	endp

ucrlib		ends


zzzzzzseg	segment	para public 'zzzzzz'
LastBytes	db	16 dup (?)
zzzzzzseg	ends
		end
