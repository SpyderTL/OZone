		.386
		option	segment:use16, proc:private

		include	stdin.a
		include	conv.a
		include	excepts.a
		include	file.a

		echo	fgetf
	

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing

wp		textequ	<word ptr>

FileVarPtr	dword	?

FGFGet		proc	near
		push	fs
		push	si
		lfs	si, FileVarPtr
		call	$fgetc
		pop	si
		pop	fs
		ret
FGFGet		endp

FGFPeek		proc	near
		push	fs
		push	si
		lfs	si, FileVarPtr
		call	$fpeekc
		pop	si
		pop	fs
		ret
FGFPeek		endp


; FGETF-	FS:SI points at a file variable.
;		Fgetf reads a floating point value from the file and
;		pushes the result onto the FP stack.
;		See GETF for the gory details.

		public	$fGetf
$Fgetf		proc	far
		push	ax
		push	cx

		mov	wp FileVarPtr, si
		mov	wp FileVarPtr+2, fs

		push	offset FGFGet
		push	offset FGFPeek
		call	$T2FP
		jc	HasError

		call	$GetTermCh	;Get optional termination char.
		mov	cl, al
		call	$fpeekc		;Make sure the next character
		jc	GoodGetf	; is a reasonable character
		cmp	al, " "		; (or the end of file)
		jb	GoodGetf	; to end an FP number on.
		cmp	al, cl		;See if termination character.
		je	EatChar
		cmp	al, ","
		jne	ConvErr
EatChar:	call	$fgetc		;Get the comma or terminator.
GoodGetf:	pop	cx
		pop	ax
		clc
		ret

ConvErr:	mov	ax, $Conversion
HasError:	push	ax		;Save error code.
		call	$GetXEnabled
		cmp	ax, 0
		je	JustReturn
		pop	ax		;Retrieve exception code
		call	$Raise		; and raise an exception.

JustReturn:	pop	ax		;Retrieve error code.
		pop	cx
		add	sp, 2		;Skip original AX value.
		stc			;Return error status.
		ret
$fgetf		endp


; FGetfStk-	Like FGETF except the pointer to the string and file
;		variables are passed on the stack rather than in ES:DI
;		and FS:SI.
;
; fGetfStk(filevar)

		public	$fGetfStk
$FGetfStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]	;Get ptr to file variable.
		call	$fgetf

		pop	si
		pop	fs
		pop	bp
		ret	4
$FGetfStk	endp


; FGetfCS-	Pointer to file variable is passed in the
;		code stream.
;
;		fgetsl
;		dword	fvar

		public	$fGetfCS
$FGetfCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		les	di, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fgetf

		add	wp [bp+2], 4	;Skip over parameters.
		pop	si
		pop	fs
		pop	bp
		ret
$FGetfCS	endp

$segSTDIO       ends
		end