		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrLwr, StrLwrStk

$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; StrLwr -	Converts to lower case all upper case characters in
;		the string pointed at by es:di.
;
; inputs:
;		es:di - Buffer for destination string.
;
; outputs:
;		es:di - Points at converted string.
;
; StrLwrStk - 	Address of the string to convert is passed on the stack.
;
; StrLwrcs - 	Address of the string to convert is passed in the
;		code stream.


$StrLwr		proc	far
		push	es
		push	ds
		push	ax
		push	bx
		pushf
		push	si
		push	di

		mov	si, es
		mov	ds, si
		mov	si, di
		lea	bx, StdGrp:$lwrtbl
ToUprLp:	lodsb
		xlat 	StdGrp:$lwrtbl
		stosb
		cmp	al, 0
		jne	ToUprLp

		pop	di
		pop	si
		popf
		pop	bx
		pop	ax
		pop	ds
		pop	es
		ret
$StrLwr		endp


$StrLwrStk	proc	far
		push	bp
		mov	bp, sp

		les	di, [bp+6]
		call	$StrLwr

		pop	bp
		ret	4
$StrLwrStk	endp


$StrLwrCs	proc	far
		push	bp
		mov	bp, sp

		les	di, [bp+2]
		les	di, es:di
		add	word ptr [bp+2], 4
		call	$StrLwr

		pop	bp
		ret
$StrLwrCs	endp


$segStrings	ends
		end
