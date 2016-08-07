		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrTrimM, StrTrimStk, StrTrimMCs
	

$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; StrRrimM -	Creates a new copy of the input string with trailing
;		blanks removed.
;
; inputs:
;		es:di -	Zero-terminated source string.
; outputs:
;		es:di -	Points at destination string (on heap).
;
; StrTrimMStk -	Address of string is passed on the stack.
;
; StrTrimMCs -	Address of string is passed in the code stream.


$StrTrimM	proc	far
		push	ds
		push	ax
		push	cx
		push	dx
		push	si
		pushf
		cld
		mov	ax, es
		mov	ds, ax
		mov	si, di

; Count the number of characters in the string which aren't part of a
; trailing blank suffix.  DX is keeping track of the current length of
; the string.  CX is keeping track of all chars in the string except
; trailing blanks.

		xor	cx, cx		;CX=character string length
		mov	dx, cx		;DX= total string length.
FindEnd:	lodsb
		cmp	al, 0
		je	EndOfStr
		cmp	al, ' '
		je	NoIncCX
		mov	cx, dx
		inc	cx
NoIncCX:	inc	dx
		jmp	FindEnd

EndOfStr:	mov	si, di
		inc	cx		;Make room for terminating zero byte.
		push	cx
		call	sl_malloc	;Allocate enough memory for the string.
		jc	BadSTD
		pop	cx
		dec	cx		;Copy up to zero byte position
		push	di		;Save ptr to start
	rep	movsb
		mov	byte ptr es:[di], 0
		pop	di
		popf
		clc
		jmp	STDDone

BadSTD:		pop	cx
		popf
		stc
STDDone:	pop	si
		pop	dx
		pop	cx
		pop	ax
		pop	ds
		ret
$StrTrimM	endp


$StrTrimMStk	proc	far
		push	bp
		mov	bp, sp

		les	di, [bp+6]
		call	$StrTrimM

		pop	bp
		ret	4
$StrTrimMStk	endp


$StrTrimMCs	proc	far
		push	bp
		mov	bp, sp

		les	di, [bp+2]
		les	di, es:[di]
		add	word ptr [bp+2], 4
		call	$StrTrimM

		pop	bp
		ret
$StrTrimMCs	endp


$SegStrings	ends
		end