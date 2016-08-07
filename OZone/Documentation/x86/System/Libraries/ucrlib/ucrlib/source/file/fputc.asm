		.386
		option	segment:use16, proc:private

		include	file.a
		include	excepts.a

		echo	fputc, fputcstk, fputcl
	

$segFile	segment	para public 'Files'
		assume	cs:$segFile, ds:nothing


dp		textequ	<dword ptr>
wp		textequ	<word ptr>
byp		textequ	<byte ptr>





; fputc-	Writes a single byte to a file.
;
;	On Entry:
;		FS:SI-	Points at file variable.
;		AL-	Contains the output character.
;
;	On Exit:
;		AX contains error code (if error, C=1).
;
; fputcStk-	Char to print is on TOS, filevar is on NOS.
; fputcCS-	Char to print is in AL, filevar follows in code stream.



		public	$fPutc
$fputc		proc	far
		push	bx

		cmp     fs:[si].FileVar.fvMode, 1	;Writing file?
		jne	BadPutc

		mov	bx, fs:[si].FileVar.fvIndex
		mov	fs:[bx+si].FileVar.fvBuffer, al
		inc	bx
		cmp	bx, 512
		jae	WriteNewBlock
		mov	fs:[si].FileVar.fvIndex, bx
		pop	bx
		clc
		ret


; If bx gets bumped to 512, we need to read a new block of data from the
; file.

WriteNewBlock:	push	ds
		push	cx
		push	dx
		push	ax

		mov	ah, 40h
		mov	bx, fs:[si].FileVar.fvHandle
		mov	cx, 512
		lea	dx, [si].FileVar.fvBuffer
		push	fs
		pop	ds
		int	21h
		jc	BadWB

		mov	fs:[si].FileVar.fvIndex, 0

		pop	ax
		pop	dx
		pop	cx
		pop	ds
		pop	bx
		clc
		ret

BadWB:		cmp	ax, 5
		jne	TryInvH
BadPutc:	mov	ax, $AccessDenied
		call	TestExcepts
		mov	ax, 5
		jmp	putcErr2

TryInvH:	cmp	ax, 6
		jne	DoFileIOErr
		mov	ax, $InvalidHandle
		call	TestExcepts
		mov	ax, 6
		jmp	putcErr2

DoFileIOErr:	push	ax
		mov	ax, $FileIO
		call	TestExcepts
		pop	ax

putcErr2:	pop	dx			;Keep error code in AX
		pop	dx
		pop	cx
		pop	ds
		pop	bx
		stc
		ret
$fputc		endp



; fputc(var fv, var char)

		public	$fPutcStk
$fputcStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	ax

		lfs	si, [bp+6]
		mov	al, fs:[si]	;Get the character.

		lfs	si, [bp+10]
		call	$fputc

		pop	ax
		pop	si
		pop	fs
		pop	bp
		ret	8
$fputcStk	endp


; fputc(fv, char)

		public	$fPutcTOS
$fputcTOS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	ax

		mov	al, [bp+6]
		lfs	si, [bp+8]
		call	$fputc

		pop	ax
		pop	si
		pop	fs
		pop	bp
		ret	6
$fputcTOS	endp




; fputcCS	-- Character is in AL.
; dword	fv

		public	$fPutcCS
$fputcCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		lfs	si, [bp+2]
		lfs	si, fs:[si]
		call	$fputc
		add	wp [bp+2], 4
		pop	si
		pop	fs
		pop	bp
		ret
$fputcCS	endp


; testExcepts-	If exceptions are enabled, this routine raises the exception
;		found in the AX register.  Otherwise it simply returns with
;		the carry flag set.

testExcepts	proc	near
		push	ax
		GetXEnabled
		test	ax, ax
		pop	ax
		jz	TERtn
		Raise
TERtn:		stc
		ret
testExcepts	endp
$segFile	ends
		end
