		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrStr, StrStrCsi, StrStrStk


$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; StrStr -	Returns the position of a substring in another string.
;
; inputs:
;		es:di- address of string to search through.
;		fs:si- address of substring to search for.
; outputs: 
;		cx - position of character in string (if present).
;		carry=0 if character found.
;		carry=1 if character is not present in string.
;
; StrStrCsi -	Address of substring to search for is passed in the code stream.
;
; StrStrStk -	Both the search string and the substring are passed on the stack.
;		Preserves ES:DI and FS:SI.


$StrStr		proc	far
		push	ds
		push	fs
		push	es
		pushf
		push	si
		push	di
		push	ax
		push	bx
		push	dx
		cld

		push	es
		pop	ds
		push	fs
		pop	es
		xchg	si, di

		mov	bx, di		;Save ptr to substring.

; Compute the length of the substring:

		mov	cx, 0ffffh
		mov	al, 0
	repne	scasb
		neg	cx
		dec	cx
		dec	cx
		mov	dx, cx		;Save length of smaller string.

		mov	ax, si		;Save ptr to string.
		mov	di, bx		;Restore ptr to substring.
StrLp:		mov	cx, dx
	repe	cmpsb			;Compare the strings
		jz	StrsAreEql	;Jump if substring exists.
		inc	ax		;Bump pointer into string.
		mov	si, ax		;Restore pointers.
		mov	di, bx
		cmp	byte ptr [si], 0 ;Done yet?
		jne	StrLp

; Bad news down here, the substring isn't present in the source string.

		xor	cx, cx
		pop	dx
		pop	bx
		pop	ax
		pop	di
		pop	si
		popf
		pop	es
		pop	fs
		pop	ds
		stc
		ret

StrsAreEql:
		mov	cx, ax			;Save ptr to string
		pop	dx
		pop	bx
		pop	ax
		pop	di
		sub	cx, di			;Compute index to substring.
		pop	si
		popf
		clc
		pop	es
		pop	fs
		pop	ds
		ret
$StrStr		endp


$StrStrCsi	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	es
		pushf
		push	si
		push	di
		push	ax
		push	bx
		push	dx
		cld

		mov	ax, es
		mov	ds, ax
		mov	si, di
		les	di, [bp+2]

		mov	bx, di		;Save ptr to substring.

; Compute the length of the substring:

		mov	cx, 0ffffh
		mov	al, 0
	repne	scasb
		neg	cx
		dec	cx
		dec	cx
		mov	dx, cx		;Save length of smaller string.
		mov	2[bp], di	;Save new return address.

		mov	ax, si		;Save ptr to string.
StrCsiLp:	mov	cx, dx
	repe	cmpsb			;Compare the strings
		jz	StrsCsiAreEql	;Jump if substring exists.
		inc	ax		;Bump pointer into string.
		mov	si, ax		;Restore pointers.
		mov	di, bx
		cmp	byte ptr [si], 0 ;Done yet?
		jne	StrCsiLp

; Bad news down here, the substring isn't present in the source string.

		xor	cx, cx
		pop	dx
		pop	bx
		pop	ax
		pop	di
		pop	si
		popf
		pop	es
		pop	ds
		pop	bp
		stc
		ret

StrsCsiAreEql:
		mov	cx, ax			;Save ptr to string
		pop	dx
		pop	bx
		pop	ax
		pop	di
		sub	cx, di			;Compute index to substring.
		pop	si
		popf
		clc
		pop	es
		pop	ds
		pop	bp
		ret
$StrSTrCsi	endp


$StrStrStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	di
		push	si

		les	di, [bp+10]	; String to search.
		lfs	si, [bp+6]	; Substring to find.
		call	$StrStr

		pop	si
		pop	di
		pop	fs
		pop	es
		pop	bp
		ret	8
$StrStrStk	endp


$SegStrings	ends
		end