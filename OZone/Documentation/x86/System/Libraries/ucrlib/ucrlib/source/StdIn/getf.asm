		.386
		option	segment:use16, proc:private

		include	stdin.a
		include	conv.a
		include	excepts.a

		echo	Getf
	

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing



GFGet		proc	near
		call	$getc
		ret
GFGet		endp

GFPeek		proc	near
		call	$peekc
		ret
GFPeek		endp


		public	$Getf
$Getf		proc	far
		push	ax
		push	cx


		push	offset GFGet
		push	offset GFPeek
		call	$T2FP
		jc	HasError

		call	$getclen	;See if at end of line.
		cmp	cx, 0		;=0 if at EOLN
		je	GoodGetf

		call	$GetTermCh	;Get optional termination char.
		mov	cl, al
		call	$peekc		;Make sure the next character
		cmp	al, " "		; is a reasonable character
		jb	GoodGetf	; to end an FP number on.
		cmp	al, cl		;See if termination character.
		je	EatChar
		cmp	al, ","
		jne	ConvErr
EatChar:	call	$getc		;Get the comma or terminator.
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
$Getf		endp
$segSTDIO       ends
		end