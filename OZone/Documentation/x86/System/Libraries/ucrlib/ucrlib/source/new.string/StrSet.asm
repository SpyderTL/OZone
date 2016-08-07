		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrSet, StrSetStk, StrSetCs, StrSetX
	

$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; StrSet - 	Copies the character in al over the top of each character
;		in the string the es:si points at.  Does not affect the
;		trailing zero byte in the string.
;
; inputs:
;		AL - Character to copy.
;		ES:DI - Points at string to overwrite.
;
; StrSetStk -	Pointer to the string is passed on the stack.
;
; StrSetCS -	Pointer to the string is passed in the code stream.
;
; StrSetX -	ES:DI returns pointing at the zero byte.


$StrSet		proc	far
		pushf
		push	di
		push	ax

		cld
		mov	ah, 0			;Zero terminating byte
		jmp	short StartLp

SetLp:		stosb				;Store next char
StartLp:	cmp	ah, es:[di]		;End of string?
		jnz	SetLp

		pop	ax
		pop	di
		popf
		ret
$StrSet		endp


$StrSetStk	proc	far
		push	bp
		mov	bp, sp

		les	di, [bp+6]
		call	$StrSet

		pop	bp
		ret	4
$StrSetStk	endp


$StrSetCs	proc	far
		push	bp
		mov	bp, sp

		les	di, [bp+2]
		les	di, es:[di]
		add	word ptr [bp+2], 4
		call	$StrSet

		pop	bp
		ret
$StrSetCs	endp


$StrSetX	proc	far
		pushf
		push	ax

		cld
		mov	ah, 0			;Zero terminating byte
		jmp	short StartXLp

SetXLp:		stosb				;Store next char
StartXLp:	cmp	ah, es:[di]		;End of string?
		jnz	SetLpX

		dec	di

		pop	ax
		popf
		ret
$StrSetX	endp


$segStrings	ends
		end
