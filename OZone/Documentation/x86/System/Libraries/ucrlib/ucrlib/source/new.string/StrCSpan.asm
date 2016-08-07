		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	Strcspan, Strcspancsi, StrcspanStk
	

$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; strcspan-	Returns the number of characters at the beginning of a string
;		which are NOT from a specified set.
;
; inputs:
;		ES:DI - Points at string to test.
;		FS:SI -	Points at set of characters (zero terminated string).
;
; outputs:
;		CX - Number of characters not in the set which are the
;		prefix of the test string.
;
; Strcspancsi -	The character set is passed as a literal in the code stream.
;
; StrcspanStk -	Both the String address and pointer to the character set are
;		passed on the stack.


$strcspan	proc	far
		pushf
		push	es
		push	ds
		push	ax
		push	bx
		push	dx
		push	si
		push	di
		cld

		push	es
		pop	ds
		push	fs
		pop	es
		xchg	si, di

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
		jnz	StrLp			;Repeat while not in set.

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
		ret
$strcspan	endp


$strcspancsi	proc	far
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

; Okay, now we can see how many characters from the set match the prefix
; characters in the string.

StrLp:		lodsb				;Get next char in string.
		mov	cx, dx			;Get length of char set.
		mov	di, bx			;Get ptr to char set
	repne	scasb				;See if in set
		jnz	StrLp			;Repeat while not in set.

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
$strcspancsi	endp


$StrcspanStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	si
		push	di

		les	di, [bp+6]
		lfs	si, [bp+10]
		call	Strcspan

		pop	di
		pop	si
		pop	fs
		pop	es
		pop	bp
		ret	8
$StrcspanStk	endp


stdlib		ends
		end