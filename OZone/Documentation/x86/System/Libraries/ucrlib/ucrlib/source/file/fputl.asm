		.386
		option	segment:use16, proc:private

		include	file.a
		include	conv.a

		echo	fPutl, fPutlStk, fPutlCS
		echo	fPutul, fPutulStk, fPutulCS
		echo	fPutlSize, fPutlSizeStk, fPutlSizeCS
		echo	fPutulSize, fPutulSizeStk, fPutulSizeCS
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing

; fPutl2-	This routine, based on some code submitted by
;		David Holm, converts a 32-bit integer value
;		(in eax) to a string of digits and prints them.
;		On entry, fs:si points at the file variable.

fPutl2		proc	near
		push	ebx
		push	edx
		push	cx
		pushf

		mov	ebx, 10
		xor	cx, cx
Putl2Lp:	xor	edx, edx
		div	ebx
		or	dl, '0'
		push	dx
		inc	cx
		or	eax, eax
		jnz	Putl2Lp

Popl2lp:	pop	ax
		call	$fputc
		loop	Popl2lp

		popf
		pop	cx
		pop	edx
		pop	ebx
		ret
fPutl2		endp





; fPutl prints the value in EAX as a signed dword integer value.
; fs:si points at the file variable.

		public	$fPutl
$fPutl		proc	far
		push	eax
		test	eax, eax
		jns	Doit

		push	fs
		push	si
		push	'-'
		call	$fputcStk
		neg	eax

DoIt:		call	fputl2
		pop	eax
		ret
$fPutl		endp



; Putul prints the value in EAX as an unsigned dword integer value
;	to the file specified by fs:si.

		public	$fPutul
$fPutul		proc	far
		push	eax
		call	fPutl2
		pop	eax
		ret
$fPutul		endp



; $fPutlStk-	Outputs the 32-bit integer on the TOS.
;		NOS points at the file variable.

		public	$fPutlStk
$fPutlStk	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	fs
		push	si

		mov	eax, [bp+6]
		lfs	si, [bp+10]
		call	$fputl

		pop	si
		pop	fs
		pop	eax
		pop	bp
		ret	8
$fPutlStk	endp





; $fPutulStk-	Outputs the 32-bit unsigned integer on the TOS.
;		NOS points at the file variable.

		public	$fPutulStk
$fPutulStk	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	fs
		push	si

		mov	eax, [bp+6]
		lfs	si, [bp+10]
		call	$fputul

		pop	si
		pop	fs
		pop	eax
		pop	bp
		ret	8
$fPutulStk	endp


; fPutlCS-	EAX contains a value to print.
;		The first dword in the code stream is a pointer to the file var.

		public	$fPutlCS
$fPutlCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, fs:[si]	;Get ptr to fv.
		call	$fPutl

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fPutlCS	endp




; fPutulCS-	EAX contains an unsigned value to print.
;		The first dword in the code stream is a pointer to the file var.

		public	$fPutulCS
$fPutulCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, fs:[si]	;Get ptr to fv.
		call	$fPutul

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fPutulCS	endp







; $fPutulSize-	EAX contains a 32-bit unsigned integer.  CX contains a
;		minimum field width.  FS:SI contains a pointer to a
;		file variable. Print the integer using at least
;		that many print positions to the specified file.

		public	$fPutulSize
$fPutulSize	proc	far
		push	eax
		push	cx
		call	$ULSize
		sub	cx, ax
		js	NoSpcs
		jcxz	NoSpcs
		mov	al, ' '
PutSpcs:	fputc
		loop	PutSpcs

NoSpcs:		pop	cx
		pop	eax
		call	$fputul
		ret
$fPutulSize	endp




; $fPutulSizeStk TOS (16-bits) contains a field width.  NOS (32-bits) is
;		an unsigned integer.  Above that is a 32-bit pointer
;		to a file variable. Print the value using the
;		specified number of print positions to the specified file.

		public	$fPutulSizeStk
$fPutulSizeStk	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	cx
		push	si
		push	fs

		mov	cx, [bp+6]
		mov	eax, [bp+8]
		lfs	si, [bp+12]
		call	$fputulsize

		pop	fs
		pop	si
		pop	cx
		pop	eax
		pop	bp
		ret	10
$fPutulSizeStk	endp



; fPutulSizeCS-	EAX contains an unsigned value to print.
;		The first dword in the code stream is a pointer to the file var.
;		The second dword in the code stream is the field width.

		public	$fPutulSizeCS
$fPutulSizeCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	cx

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		mov	cx, fs:[si+4]
		lfs	si, fs:[si]	;Get ptr to fv.
		call	$fPutul

		add	wp [bp+2], 8	;Skip over parameter.

		pop	cx
		pop	si
		pop	fs
		pop	bp
		ret
$fPutulSizeCS	endp





; $fPutlSize-	Like $fPutudSize above except this guy outputs signed
;		32-bit integers.

		public	$fPutlSize
$fPutlSize	proc	far
		push	eax
		push	cx
		call	$LSize
		sub	cx, ax
		js	NoSpcs
		jcxz	NoSpcs
		mov	al, ' '
PutSpcs:	call	$fputc
		loop	PutSpcs

NoSpcs:		pop	cx
		pop	eax
		call	$fputl
		ret
$fPutlSize	endp



; $PutlSizeStk TOS (16-bits) contains a field width.  NOS (32-bits) is
;		a signed integer.  Above that is a 32-bit pointer to a
;		file variable. Print the value using the
;		specified number of print positions.

		public	$fPutlSizeStk
$fPutlSizeStk	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	cx
		push	fs
		push	si

		mov	cx, [bp+6]
		mov	eax, [bp+8]
		lfs	si, [bp+12]
		call	$fputlsize

		pop	si
		pop	fs
		pop	cx
		pop	eax
		pop	bp
		ret	10
$fPutlSizeStk	endp


; fPutlSizeCS-	EAX contains a signed value to print.
;		The first dword in the code stream is a pointer to the file var.
;		The second dword in the code stream is the field width.

		public	$fPutlSizeCS
$fPutlSizeCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	cx

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		mov	cx, fs:[si+4]
		lfs	si, fs:[si]	;Get ptr to fv.
		call	$fPutl

		add	wp [bp+2], 8	;Skip over parameters.

		pop	cx
		pop	si
		pop	fs
		pop	bp
		ret
$fPutlSizeCS	endp





$segSTDIO	ends
		end
