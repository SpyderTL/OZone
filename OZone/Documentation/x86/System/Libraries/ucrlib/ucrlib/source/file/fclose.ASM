		.386
		option	segment:use16, proc:private

		include	file.a
		include	excepts.a

		echo	fclose, fcloseL, fcloseStk
		echo	fflush, fflushL, fflushStk
	

$segFile	segment	para public 'Files'
		assume	cs:$segFile, ds:nothing


dp		textequ	<dword ptr>
wp		textequ	<word ptr>
byp		textequ	<byte ptr>




; sl_fclose-	Closes a file.
;
;	On Entry:
;		FS:SI points at a file variable.
;
;	On Exit:
;		Carry flag denotes error (AX contains error code).
;
; FCloseStk-	Pointer to file variable is passed on the stack.
; FCloseCS-	Pointer to file variable follows in the code stream.


		public	$FCloseStk
$FCloseStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]
		call	$FClose

		pop	si
		pop	fs
		pop	bp
		ret	4
$FCloseStk	endp



;	FCloseCS
;	dword	fVar


		public	$FCloseCS
$FCloseCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get ptr to file variable.
		lfs	si, fs:[si]	;Point ES:DI at file var.
		add	wp [bp+2], 4	;Skip file variable


		call	$FClose		;Do the Close.

		pop	si
		pop	fs
		pop	bp
		ret
$FCloseCS	endp





		public	$FClose
$fclose		proc	far
		push	ax
		push	bx

		cmp	fs:[si].FileVar.fvMode, 1	;Opened for read(0)
		jb	NoFlush				; or write(1)?
		ja	BadClose			;Sanity check for 1.

		call	$fflush				;Flush buffer if
		jc	CloseError			; opened for write.

NoFlush:	mov	bx, fs:[si].FileVar.fvHandle	;Get DOS file buffer.
		cmp	bx, 5				;Don't close STD I/O
		jz	CloseDone			; devices.
		mov	ah, 3eh
		int	21h
		jc	CloseError
CloseDone:	pop	bx
		pop	ax
		clc
		ret

BadClose:	mov	ax, 6			;Invalid handle error.
CloseError:	push	ax
		GetXEnabled
		test	ax, ax
		jz	RtnError
		cmp	ax, 6
		jne	NotInvHndl
		mov	ax, $InvalidHandle
		Raise

NotInvHndl:	mov	ax, $FileIO
		Raise


RtnError:	pop	ax
		pop	bx
		add	sp, 2			;Return error in AX.
		stc
		ret
$fclose		endp



; fflush-	Flushes a file buffer to disk.
;
;	On Entry:
;		FS:SI points at a file variable
;
;	On Exit:
;		Carry flag denotes error status (AX contains error #).
;
; FFlushStk-	Pointer to file variable is on the stack.
; FFlushCS-	Pointer to file variable follows in the code stream.



		public	$FFlushStk
$FFlushStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]
		call	$FFlush

		pop	si
		pop	fs
		pop	bp
		ret	4
$FFlushStk	endp



;	FFlushCS
;	dword	fVar


		public	$FFlushCS
$FFlushCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		lfs	si, [bp+2]	;Get ptr to file variable.
		lfs	si, es:[di]	;Point ES:DI at file var.


		call	$FFlush		;Do the Flush.

; Skip past the file variable in the code stream.

		pushf
		add	wp [bp+2], 4
		popf			;Restore DFlag and error status.

		pop	si
		pop	fs
		pop	bp
		ret
$FFlushCS	endp




		public	$FFlush
$fflush		proc	far
		push	ds
		push	ax
		push	bx
		push	cx
		push	dx

		cmp	fs:[si].FileVar.fvMode, 1	;Opened for reading(0)
		jb	NoWrite				; or writing(1)?
		ja	BadFlush			;Sanity check for 1.

		cmp	fs:[si].FileVar.fvIndex, 0	;Any data in buffer?
		je	NoWrite				;Skip if no data.

		lea	dx, [si].FileVar.fvBuffer	;Get DOS file var and
		push	es				; write the rest of the
		pop	ds				; data in the buffer to
		mov	cx, fs:[si].FileVar.fvIndex	; the disk.
		mov	bx, fs:[si].FileVar.fvHandle
		mov	ah, 40h
		int	21h
		jc	FlushError
		mov	fs:[si].FileVar.fvIndex, 0	;Reset byte count to zero.
NoWrite:	pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	ds
		clc
		ret

BadFlush:       mov	ax, 6
FlushError:	push	ax
		GetXEnabled
		test	ax, ax
		pop	ax
		jz	RtnError
		cmp	ax, 6
		jne	NotInvHndl
		Raise

NotInvHndl:	mov	ax, $FileIO
		Raise


RtnError:	pop	dx
		pop	cx
		pop	bx
		add	sp, 2		;Return error code in AX
		pop	ds
		stc
		ret
$fflush		endp

$segFile	ends
		end
