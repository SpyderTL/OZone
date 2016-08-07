		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	strcat, strcatcsi, strcatx, strcatxcsi
		echo	strcatstk, strcatstkcsi
	

$SegStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; strcat    -	Appends one string to the end of another.
;
; inputs:
;		es:di - Points at destination string, the one to which the
;		source string will be appended.
;
;		fs:si- Points at the string to append.
;
; strcatcsi  -	String to append is passed as a literal in the code stream
;               rather than in fs:si.
;
; strcatx    -	es:di returns pointing at the end of the concatenated strings.
;
; strcatxcsi -	String to append is passed as a literal in the code stream
;               rather than in fs:si. es:di returns pointing at the end of
;               the concatenated strings.
;
; strcatstk  -	Addresses both strings are passed on the stack.  
;
; strcatstkcsi-	String to append is passed as a literal in the code stream.
;		The dest. is passed on the stack. Preserves es:di.
;
;
; Note: 	The destination string's (ES:DI) buffer must be sufficiently
;		large to hold the result of the concatentation of the two strings.
;

$strcat		proc	far
		push	di

		call	$strcatx

		pop	di
		ret
$strcat		endp


$strcatcsi	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	cx
		push	ax
		pushf
		push	si
		push	di

		cld
;
; Find the end of the destination string:
;
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
;
; Copy the second string to the end of the current string.
;
		lds	si, [bp+2]		;Get Return Address
		dec	di
CpyLp:		lodsb
		stosb
		cmp	al, 0
		jnz	CpyLp

		mov	[bp+2], si		;Save new return address.
		pop	di
		pop	si
		popf
		pop	ax
		pop	cx
		pop	ds
		pop	bp
		ret
$strcatcsi	endp


$strcatx	proc	far
		push	ds
		push	cx
		push	ax
		pushf
		push	si

		push	fs
		pop	ds
		cld
;
; Find the end of the destination string:
;
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
;
; Copy the second string to the end of the current string.
;
		dec	di
CpyLp:		lodsb
		stosb
		cmp	al, 0
		jnz	CpyLp

		pop	si
		popf
		pop	ax
		pop	cx
		pop	ds
		ret
$strcatx	endp


$strcatxcsi	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	cx
		push	ax
		pushf
		push	si

		cld
;
; Find the end of the destination string:
;
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
;
; Copy the second string to the end of the current string.
;
		lds	si, [bp+2]		;Get Return Address
		dec	di
CpyLp:		lodsb
		stosb
		cmp	al, 0
		jnz	CpyLp

		mov	[bp+2], si		;Save new return address.
		pop	si
		popf
		pop	ax
		pop	cx
		pop	ds
		pop	bp
		ret
$strcatxcsi	endp


$strcpystk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	di
		push	si

		les	di, [bp+6]	; Destination
		lfs	si, [bp+10]	; Source
		call	$strcat

		pop	si
		pop	di
		pop	fs
		pop	es
		pop	bp
		ret	8
$strcpystk	endp


$strcatstkcsi	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	di
		push	si

		les	di, [bp+6]	; Destination
		call	$strcatl

		pop	si
		pop	di
		pop	fs
		pop	es
		pop	bp
		ret	4
$strcatstkcsi	endp


$SegStrings	ends
		end