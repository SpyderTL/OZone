		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrRev, StrRevStk, StrRevCs
	

$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; StrRev -	Reverses the characters in a string.
;
; inputs:
;		ES:DI - Points at the string to reverse.
; outputs:
;		ES:DI - Points at reversed string
;
; StrRevStk - 	Pointer to the string is passed on the stack.
;
; StrRevCS -	Pointer to the string is passed in the code stream.


$StrRev		proc	far
		push	ds
		push	si
		push	di
		push	ax
		push	cx
		pushf
		cld

; Init ptr to the start of the string

		mov	si, es
		mov	ds, si
		mov	si, di
;
; Compute the length of the string:
;
		mov	cx, 0ffffh
		mov	al, 0
	repne	scasb
		neg	cx
		dec	cx
		dec	cx
		shr	cx, 1		;Only have to do half the bytes.
		jcxz	StrRvsd
		dec	di     		;Point at zero byte.

; Okay, swap the bytes in the string.

SwapBytes:	dec	di
		lodsb
		xchg	al, [di]	;Note: es=ds.
		mov	[si-1], al
		loop	SwapBytes
;
StrRvsd:        popf
		pop	cx
		pop	ax
		pop	di
		pop	si
		pop	ds
		ret
$StrRev		endp


$StrRevStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+6]
		call	$StrRev

		pop	di
		pop	es
		pop	bp
		ret	4
$StrRevStk	endp


$StrRevCs	proc	far
		push	bp
		mov	bp, sp

		les	di, [bp+2]
		les	di, es:[di]
		add	word ptr [bp+2], 4
		call	$StrRev

		pop	bp
		ret
$StrRevCs	endp


		
$segStrings	ends
		end
