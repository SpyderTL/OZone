		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrSpan, StrSpanCsi, StrSpanStk
	

$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; StrSpan-	Returns the number of characters (from a set) which
;		precede a string.
;
; inputs:
;		ES:DI - Points at string to test.
;		FS:SI -	Points at set of characters (zero terminated string).
;
; outputs:
;		CX - Number of characters in set which are the prefix of
;		the test string.
;
; StrSpanCsi -	Set of characters (zero terminated string) is passed in the
;		code stream.
;
; StrSpanStk -	String to test and set of characters are passed on stack.


$StrSpan	proc	far
		pushf
		push	es
		push	fs
		push	ds
		push	ax
		push	bx
		push	dx
		push	si
		push	di
		cld

		xchg	di, si
		push	es
		pop	ds
		push	fs
		pop	es

		mov	bx, di			;Preserve ptr to char set.
		mov	cx, 0ffffh
		mov	al, 0
	repne	scasb				;Compute length of char set.
		neg	cx
		dec	cx
		dec	cx
		mov	dx, cx			;Save for use later.

; Okay, now we can see how many characters from the set match the prefix
; characters in the string.

StrLp:		lodsb				;Get next char in string.
		mov	cx, dx			;Get length of char set.
		mov	di, bx			;Get ptr to char set
	repne	scasb				;See if in set
		jz	StrLp			;Repeat while in set.

		pop	cx
		mov	di, cx
		sub	cx, si
		neg	cx
		dec	cx
		pop	si
		pop	dx
		pop	bx
		pop	ax
		pop	ds
		pop	fs
		pop	es
		popf
		ret
$StrSpan	endp


$StrSpanCsi	proc	far
		push	bp
		mov	bp, sp
		pushf
		push	es
		push	ds
		push	ax
		push	bx
		push	dx
		push	si
		push	di
		cld

; Put the pointers into a couple of better locations.

		mov	ax, es
		mov	ds, ax
		mov	si, di
		les	di, [bp+2]

		mov	bx, di			;Preserve ptr to char set.
		mov	cx, 0ffffh
		mov	al, 0
	repne	scasb				;Compute length of char set.
		neg	cx
		dec	cx
		dec	cx
		mov	[bp+2], di		;Save new return address
		mov	dx, cx			;Save for use later.
;
; Okay, now we can see how many characters from the set match the prefix
; characters in the string.

StrCsiLp:	lodsb				;Get next char in string.
		mov	cx, dx			;Get length of char set.
		mov	di, bx			;Get ptr to char set
	repne	scasb				;See if in set
		jz	StrCsiLp		;Repeat while in set.

		pop	di
		mov	cx, di
		sub	cx, si
		neg	cx
		dec	cx
		pop	si
		pop	dx
		pop	bx
		pop	ax
		pop	ds
		pop	es
		popf
		pop	bp
		ret
$StrSpanCsi	endp


$StrSpanStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	di
		push	si

		les	di, [bp+10]	; String to test.
		lfs	si, [bp+6]	; Character Set.
		call	$StrSpan

		pop	si
		pop	di
		pop	fs
		pop	es
		pop	bp
		ret	8
$StrSpanStk	endp


$SegStrings	ends
		end
