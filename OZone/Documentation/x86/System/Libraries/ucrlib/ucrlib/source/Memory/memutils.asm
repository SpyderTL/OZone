
		.386
		option	segment:use16, proc:private

		include	memory.a
		include	excepts.a

		echo	Memory: DupPtr, IsInHeap, IsPtr
		echo	Memory: HeapStart, BlockSize, MemAvail, MemFree

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing, es:nothing



;============================================================================
;
;   ********      *        *     ********    ********    *******   *******
;   *       *     *        *     *       *   *       *      *      *      *
;   *       *     *        *     *       *   *       *      *      *      *
;   *       *     *        *     ********    ********       *      *******
;   *       *     *        *     *           *              *      *   *
;   *       *     *        *     *           *              *      *    *
;   *       *     *        *     *           *              *      *     *
;   ********       ********      *           *              *      *      *
;
;============================================================================
;
;
; Dupptr - Bumps up the reference count for a particular pointer by one.
;	   Returns carry = 1 if initial pointer is illegal, returns carry=0
;	   if no error.  Returns pointer in ES:DI.  You must pass the pointer
;	   to increment in ES:DI.

		public	$DupPtr
$DupPtr		proc	far
		cmp	di, 8			;See if this is a valid ptr.
		je	GoodPtr

		push	ax
		call	$GetXEnabled
		cmp	ax, 0
		je	JustReturn
		mov	ax, $BadPointer
		call	$Raise

JustReturn:	pop	ax
		stc
		ret

GoodPtr:	inc	esptr.refcnt		;Bump up the reference cnt.
		clc
		ret
$DupPtr		endp




;============================================================================
;
; *****   *****   *****   *   *   *   *   *****     *     *****
;   *     *         *     **      *   *   *        * *    *    *
;   *      ***      *     * * *   *****   ***     *****   *    *
;   *         *     *     *  **   *   *   *       *   *   *****
;   *         *     *     *   *   *   *   *       *   *   *
; *****   *****   *****   *   *   *   *   *****   *   *   *
;
;============================================================================
;
; IsInHeap-	Returns carry clear if the pointer passed in es:di is within
;		the heap.  Returns carry set if this pointer is outside the
;		heap.  Note that this routine will not raise any exceptions if
;		the pointer is outside the heap.


		public	$IsInHeap
$IsInHeap	proc	far
		push	ax
		push	bx
		mov	bx, es
		mov	ax, $StartOfHeap
		cmp	bx, ax
		jb	Outside
		add	ax, $SizeOfHeap
		mov	bx, es
		cmp	bx, ax
		ja	Outside
		clc
		pop	bx
		pop	ax
		ret

Outside:	stc
		pop	bx
		pop	ax
		ret
$IsInHeap	endp



;============================================================================
;
; *****   *****   *****	   *****   *****
;   *     *       *    *     *     *    *
;   *      ***    *****      *     *****
;   *         *   *          *     * *
;   *         *   *          *     *  *
; *****   *****   *          *     *   *
;
;============================================================================
;
; IsPtr-	Returns the carry flag clear if es:di points at the beginning
;		of an allocated block in the heap.  Returns with the carry
;		flag clear if es:di points at a deallocated block or is not
;		pointing at a block.


		public	$IsPtr
$IsPtr		proc	far
		cmp	di, 8 		;All of our ptrs have an offset of 8.
		jne	NotPtr2

		push	ax
		push	bx
		push	es
		mov	ax, es

		mov	bx, $StartOfHeap
CmpLoop:	cmp	bx, ax
		je	MightBe
		ja	NotPtr
		mov	es, bx
		mov	bx, esptr.fwdptr
		or	bx, bx		;See if NIL link.
		jnz	CmpLoop

NotPtr:		pop	es
		pop	bx
		pop	ax
NotPtr2:	stc
		ret

; Might be a pointer, let's see if this guy's allocation count is greater
; than zero.

MightBe:	mov	es, bx
		cmp	esptr.blksize, 0
		je	NotPtr
		clc
		pop	es
		pop	bx
		pop	ax
		ret
$IsPtr		endp





;============================================================================
;
; BasePtr-	The pointer in ES:DI points at an arbitrary memory location.
;		This routine returns the base address of a block on the
;		heap if ES:DI points somewhere within that block.  This routine
;		returns the carry flag clear if this is the case.
;
;		If ES:DI doesn't point into the heap, or if it points into
;		control information (rather than into the data area), this
;		routine returns the carry flag set and returns the original
;		pointer in ES:DI.


		public	$BasePtr
$BasePtr	proc	far
		push	es
		push	di
		push	ax
		push	bx
		push	si

; Whatever DI currently contains, it must contain 08 if it's a base
; pointer in our heap.  So go ahead and take care of that now.

		mov	si, di		;Save original offset for final chk.
		mov	di, 8

; Okay, now check to see if the new ES:DI pointer matches the address
; of some currently allocated block on the heap

		mov	bx, $StartOfHeap
		mov	ax, es
CmpLoop:	cmp	bx, ax
		je	MightBe
		ja	NotPtr
		mov	es, bx
		mov	bx, esptr.fwdptr
		or	bx, bx		;See if NIL link.
		jnz	CmpLoop

NotPtr:		pop	si
		pop	bx
		pop	ax
		pop	di
		pop	es
		stc
		ret

; Might be a pointer, let's see if this guy's allocation count is greater
; than zero.

MightBe:	mov	es, bx
		cmp	esptr.blksize, 0
		je	NotPtr

; Okay, things are good so far, check the original pointer in SI to make
; sure it is greater than 8 and less than the size of our block.

		sub	si, 8
		jb	NotPtr

		shr	si, 1			;Convert byte offset to 
		adc	si, 0			; a paragraph count.
		shr	si, 1
		adc	si, 0
		shr	si, 1
		adc	si, 0
		shr	si, 1
		adc	si, 0
		cmp	si, esptr.BlkSize 	;See if beyond the end of
		jae	NotPtr			; this block.

; Okay, we're in good shape, return.

		clc
		pop	si
		pop	bx
		pop	ax
		add	sp, 4			;Ignore ES:DI value on stk.
		ret
$BasePtr	endp






;============================================================================
;
;  *   *   *****     *     ****     ****   *****     *     ****    *****
;  *   *   *        * *    *   *   *         *      * *    *   *     *
;  *   *   *       *   *   *   *   *         *     *   *   *   *     *
;  *****   ****    *****   ****     ***      *     *****   ****      *
;  *   *   *       *   *   *           *     *     *   *   * *       *
;  *   *   *       *   *   *           *     *     *   *   *  *      *
;  *   *   *****   *   *   *       ****      *     *   *   *   *     *
;
;============================================================================
;
; sl_HeapStart-	Returns a pointer to the start of the heap.  Useful for various
; 		operations involving DOS memory management functions (like
;		deallocating the heap).


		public	$HeapStart
$HeapStart	proc	far
		mov	ax, $StartOfHeap
		ret
$HeapStart	endp




;============================================================================
;
; BlockSize-	Returns the size of the block pointed at by ES:DI.  If
;		ES:DI is not in the heap, then it returns zero.  Returns
;		the size, in bytes, in the CX register.



		public	$BlockSize
$BlockSize	proc	far
		cmp	di, 8			;All ptrs have 8 as offset
		jne	BadBlkSize
		mov	cx, es
		cmp	cx, $StartOfHeap
		jb	BadBlkSize
		cmp	cx, $EndOfHeap
		jae	BadBlkSize
		mov	cx, esptr.BlkSize	;Get size of this block.
		clc
		ret

BadBlkSize:	xor	cx, cx
		stc
		ret
$BlockSize	endp



;============================================================================
;
; MemAvail-	Returns the size of the largest free block available in
;		the heap.
;
; On Entry-	Nothing
; On Exit-	CX contains the size of the largest free block (in paras).


		public	$MemAvail
$MemAvail	proc	far
		push	es
		push	ax
		xor	cx, cx			;Assume no free space.
		mov	ax, $FreeSpace
		or	ax, ax
		je	MADone
FreeSpaceLp:	mov	ax, esptr.blksize
		cmp	ax, cx
		jb	NextFree
		mov	cx, ax
NextFree:	mov	es, esptr.FreeFwdPtr
		mov	ax, es
		or	ax, ax			;Quit when Fwd ptr is NIL.
		jnz	FreeSpaceLp

MADone:		pop	ax
		pop	es
		ret
$MemAvail	endp





;============================================================================
;
; MemFree-	Returns the size of all the free blocks in the heap.
;
; On Entry-	Nothing
; On Exit-	CX contains the size of the free blocks (in paras).

		public	$MemFree
$MemFree	proc	far
		push	es
		push	ax
		xor	cx, cx			;Assume no free space.
		mov	ax, $FreeSpace
		or	ax, ax
		je	MFDone
FreeLp:		add	cx, esptr.blksize
		mov	ax, esptr.FreeFwdPtr
		mov	es, ax
		or	ax, ax
		jnz	FreeLp

MFDone:		pop	ax
		pop	es
		ret
$MemFree	endp

ucrlib		ends
		end
