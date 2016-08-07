		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrTrim, StrTrimStk, StrTrimCs, StrTrimCs, StrTrimX
	

$SegStrings	segment	para public 'Strings'
		assume	cs:$SegStrings, ds:nothing


; StrTrim -	Removes trailing blanks from a string by moving the
;		terminating zero byte down in memory.
;
; inputs:
;		es:di-	Zero-terminated source string.
;
; outputs:
;		es:di-	Points at destination string.
;
; StrTrimStk -	Address of string is passed on the stack (preservers ES:DI).
;
; StrTrimCs -	Address of string is passed in the code stream.
;
; StrTrimX -	ES:DI returns pointing at the zero byte.


$StrTrim	proc	far
		pushf
		push	ax
		push	cx
		push	di
		cld

		mov	cx, 0ffffh		;Allow any length string.
		mov	al, 0
		cmp	al, es:[di]		;Zero length string?
		je	StrTrimDone

	repne	scasb				;Find end of string.
		dec	di			;Back up one char (di is 2
		dec	di			; chars beyond the end).

		not	cx			;Only allow as many chars as
		dec	cx			; we started with.
		std
		mov	al, ' '
	repe	scasb
		inc	di
		inc	di
		cmp	al, es:[di]
		jne	StrTrimDone		;Only if no blanks at the end.
		mov	byte ptr es:[di], 0

StrTrimDone:	pop	di
		pop	cx
		pop	ax
		popf
		ret
$StrTrim	endp


$StrTrimStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+6]
		call	$StrTrim

		pop	di
		pop	es
		pop	bp
		ret	4
$StrTrimStk	endp


$StrTrimCs	proc	far
		push	bp
		mov	bp, sp

		les	di, [bp+2]
		les	di, es:[di]
		add	word ptr [bp+2], 4
		call	$StrTrim

		pop	bp
		ret
$StrTrimCs	endp


$StrTrimX	proc	far
		pushf
		push	ax
		push	cx
		cld

		mov	cx, 0ffffh		;Allow any length string.
		mov	al, 0
		cmp	al, es:[di]		;Zero length string?
		je	StrTrimXDone

	repne	scasb				;Find end of string.
		dec	di			;Back up one char (di is 2
		dec	di			; chars beyond the end).

		not	cx			;Only allow as many chars as
		dec	cx			; we started with.
		std
		mov	al, ' '
	repe	scasb
		inc	di
		inc	di
		cmp	al, es:[di]
		jne	StrTrimXDone		;Only if no blanks at the end.
		mov	byte ptr es:[di], 0
		dec	di

StrTrimXDone:	
		pop	cx
		pop	ax
		popf
		ret
$StrTrimX	endp


$SegStrings	ends
		end
