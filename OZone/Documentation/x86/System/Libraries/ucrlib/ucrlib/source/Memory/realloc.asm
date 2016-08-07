
		.386
		option	segment:use16, proc:private

		include	memory.a
		include	excepts.a

		echo	Memory: REALLOC

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing, es:nothing

;============================================================================
;
; *****      *******       *      *        *         *****       *****
; *    *     *            * *     *        *        *     *     *     *
; *    *     *           *   *    *        *        *     *     *
; *****      *****       *****    *        *        *     *     *
; *  *       *           *   *    *	   *        *     *     *
; *   *      *           *   *    *        *        *     *     *     *
; *    *     *******     *   *    *****    *****     *****       *****
;
;============================================================================
;
;
; REALLOC - This routine expects a pointer in ES:DI and a new size in CX.
;	    If the specified block is larger than the value in CX then
;	    realloc shrinks the size of the block and returns the left over
;	    information to the system heap.  If CX is larger than the speci-
;	    fied block then realloc allocates a new block and copies the
;	    data from the old block to the new block and then frees the
;	    old block.  In any case, realloc returns a pointer to the
;	    (possibly new) block in ES:DI.  Carry=0 on return if no error,
;	    carry=1 on return if there wasn't enough room on the heap to
;	    reallocate a larger block.  If exceptions are enabled and an
;	    error occurs, Realloc raises the $InsuffMem exception.
;	    If the pointer is bad, Realloc raises the $BadPointer error.
;
; 	    Note: if the reference count is not one, REALLOC will not
;	    make the block smaller.  It will not signal an error, however.
;
;	    If the reference count is not one and the request is to make
;	    the block larger, REALLOC will only decrement the reference
;           count of the old block, it won't actually free it (actually,
;           a call to FREE handles this event).



		public	$Realloc
$realloc	proc	far
		cmp	di, 8			;Is this a realistic pointer?
		jz	DoREALLOC

		push	ax
		call	$GetXEnabled
		cmp	ax, 0
		je	JustReturn
		mov	ax, $BadPointer
		call	$Raise

JustReturn:	pop	ax
		stc				;Return with error, if not.
		ret

DoREALLOC:	push	ax 
		push	cx
		push	ds
		push	si

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

; See if the new block size is larger or smaller than the old block size.

		cmp	cx, esptr.BlkSize
		ja	MakeBigger

; If the reference count is not one, don't bother making the block smaller.
; The other pointer(s) to this block may not be aware of the resizing.

		cmp	esptr.refcnt, 1
		ja	ReallocDone

; New desired size is less than or equal to the current size.  If no more
; than 32 bytes larger, don't even bother with the operation.

		inc	cx
		inc	cx
		cmp	cx, esptr.BlkSize
		jae	ReallocDone
		dec	cx
		dec	cx

; Okay, the new block size is seriously smaller here.  Turn the last group
; of bytes into a free block.

		mov	ax, es			;Get ptr to block
		add	ax, cx			;Add in new length
		mov	ds, ax			;Point at new block.
		mov	ax, esptr.BlkSize	;Compute the size of the
		sub	ax, cx			; new block.
		mov	dsptr.BlkSize, ax	;Save away the link.
		mov	dsptr.bwdptr, es	;Set up back pointer.
		mov	ax, esptr.fwdptr	;Copy old fwd ptr to new
		mov	dsptr.fwdptr, ax	; fwd ptr.
		mov	dsptr.refcnt, 1		;Init reference count to 1.
		mov	esptr.fwdptr, ds	;Set up new fwd ptr.
		mov	esptr.BlkSize, cx	;Set up new length.
		push	es 
		mov	di, 8
		mov	ax, ds
		mov	es, ax
		call	$Free			;Free the new block.
		mov	di, 8
		pop	es			;Get pointer to original blk

ReAllocDone:	pop	si 
		pop	ds 
		pop	cx
		pop	ax
		clc
		ret



; If they had the nerve to want this block larger, come down here and allocate
; a new block, copy the old data to the new block, and then free the old block.


MakeBigger:	mov	ax, es			;Preserve pointer to old blk.
		mov	ds, ax
		mov	si, di			;Contains "8".
		call	$Malloc			;Allocate new block.
		jc	BadRealloc

; Okay, copy the old block to the new block.  Note that both SI and DI
; contain 8 at this point.  We can make this assumption here because,
; after all, this is the memory manager code and it knows the internal
; representation.

		mov	cx, dsptr.BlkSize	;Get original block size
		shl	cx, 2			;Convert from paras to dwords
		pushf
		cld
	rep	movsd				;Note we're moving dwords!
		popf

; Okay, free up the old block and we're done.

		mov	di, 8
		push	es   			;Save ptr to new block.
		mov	ax, ds
		mov	es, ax
		call	$Free
		clc
		mov	di, 8			;Restore new block ptr.
		pop	es 
		pop	si 
		pop	ds 
		pop	cx 
		pop	ax
		ret

; Note: the only code that jumps to this point is the test for carry
; set after the call to Malloc.  Therefore, we don't have to raise an
; exception if exceptions are enabled.  Malloc would have already done
; that for us.

BadRealloc:	stc
		pop	si 
		pop	ds 
		pop	cx 
		pop	ax
		ret
$realloc	endp
ucrlib		ends
		end
