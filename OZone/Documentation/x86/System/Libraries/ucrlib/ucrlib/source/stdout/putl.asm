		include	stdout.a
		include	conv.a

		echo	PutL, PutUL, PutLStk, PutULStk
		echo	PutLSize, PutULSize, PutLSizeStk, PutULSizeStk
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing

; Putl2-	This routine, based on some code submitted by
;		David Holm, converts a 32-bit integer value
;		(in eax) to a string of digits and prints them.

Putl2		proc	near
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
		call	$putc
		loop	Popl2lp

		popf
		pop	cx
		pop	edx
		pop	ebx
		ret
Putl2		endp






; Putul prints the value in EAX as an unsigned dword integer value.

		public	$putUL
$PutUL		proc	far
		push	eax
		call	Putl2
		pop	eax
		ret
$PutUL		endp




; $PutulTOS-	Outputs the 32-bit unsigned integer on the TOS.

		public	$PutulTOS
$PutulTOS	proc	far
		push	bp
		mov	bp, sp
		push	eax
		mov	eax, [bp+6]
		call	$putul
		pop	eax
		pop	bp
		ret	4
$PutulTOS	endp


; $PutulStk-	The address of the dword to print is 
;		passed on the stack. This routine fetches
;		the dword at the address specified by
;		the pointer on the stack and calls $putul 
;		to print it.

		public	$PutulStk
$PutulStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	eax
		
		lds	si, [bp+6]
		mov	eax, [si]
		call	$putul
		
		pop	eax
		pop	si
		pop	ds
		pop	bp
		ret	4
$PutulStk	endp





; $PutulCS-	The address of a 32-bit unsigned integer variable follows in the code
;		stream.

		public	$PutulCS
$PutulCS	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	eax, [si]		;Get the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		call	$putul

		pop	si
		pop	ds
		pop	eax
		pop	bp
		ret
$PutulCS	endp









; Putl prints the value in EAX as a signed dword integer value.

		public	$Putl
$Putl		proc	far
		push	eax
		test	eax, eax
		jns	Doit

		push	'-'
		putc
		neg	eax

DoIt:		call	putl2
		pop	eax
		ret
$Putl		endp



; $PutlTOS-	Outputs the 32-bit integer on the TOS.

		public	$PutlTOS
$PutlTOS	proc	far
		push	bp
		mov	bp, sp
		push	eax
		mov	eax, [bp+6]
		call	$putl
		pop	eax
		pop	bp
		ret	4
$PutlTOS	endp


; $PutlStk-	The address of the dword to print is 
;		passed on the stack. This routine fetches
;		the dword at the address specified by
;		the pointer on the stack and calls $putl 
;		to print it.

		public	$PutlStk
$PutlStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	eax
		
		lds	si, [bp+6]
		mov	eax, [si]
		call	$putl
		
		pop	eax
		pop	si
		pop	ds
		pop	bp
		ret	4
$PutlStk	endp









; $PutlCS-	The address of an integer variable follows in the code
;		stream.

		public	$PutlCS
$PutlCS		proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	eax, [si]		;Get the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		call	$putl

		pop	si
		pop	ds
		pop	eax
		pop	bp
		ret
$PutlCS		endp









; $PutULSize-	EAX contains a 32-bit unsigned integer.  CX contains a
;		minimum field width.  Print the integer using at least
;		that many print positions.

		public	$PutULSize
$PutULSize	proc	far
		push	eax
		push	cx
		call	$ULSize
		sub	cx, ax
		js	NoSpcs
		jcxz	NoSpcs
		mov	al, ' '
PutSpcs:	putc
		loop	PutSpcs

NoSpcs:		pop	cx
		pop	eax
		call	$putul
		ret
$PutULSize	endp




; $PutulSizeTOS TOS (16-bits) contains a field width.  NOS (32-bits) is
;		an unsigned integer.  Print that value using the
;		specified number of print positions.

		public	$PutulSizeTOS
$PutulSizeTOS	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	cx

		mov	cx, [bp+6]
		mov	eax, [bp+8]
		call	$putulsize

		pop	cx
		pop	eax
		pop	bp
		ret	6
$PutulSizeTOS	endp



; $PutulSizeStk-The address of the dword to print is 
;		passed on the stack. The minimum field
;		width is also on the stack. This routine fetches
;		the dword at the address specified by
;		the pointer on the stack and calls $putulsize 
;		to print it.

		public	$PutulSizeStk
$PutulSizeStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	eax
		push	cx
		
		lds	si, [bp+8]
		mov	eax, [si]
		mov	cx, [bp+6]
		call	$putulsize
		
		pop	cx
		pop	eax
		pop	si
		pop	ds
		pop	bp
		ret	6
$PutulsizeStk	endp






; $PutulSizeCS-	The address of a 32-bit integer variable follows in the code
;		stream, a 32-bit minimum field width constant follows
;		that (32-bit is for convenience, eight would have been
;		enough).

		public	$PutulSizeCS
$PutulSizeCS	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	ds
		push	si
		push	cx

		lds	si, [bp+2]		;Get return address.
		mov	cx, [di+4]		;Get Field Width.
		lds	si, [si]		;Get ptr to int var.
		mov	eax, [si]		;Get the value.
		add	word ptr [bp+2], 8	;Skip data in code stream.

		call	$putulSize

		pop	si
		pop	ds
		pop	eax
		pop	bp
		ret
$PutulSizeCS	endp




; $PutLSize-	Like $PutULSize above except this guy outputs signed
;		32-bit integers.

		public	$PutlSize
$PutLSize	proc	far
		push	eax
		push	cx
		call	$LSize
		sub	cx, ax
		js	NoSpcs
		jcxz	NoSpcs
		mov	al, ' '
PutSpcs:	call	$putc
		loop	PutSpcs

NoSpcs:		pop	cx
		pop	eax
		call	$putl
		ret
$PutLSize	endp




; $PutulSizeTOS TOS (16-bits) contains a field width.  NOS (32-bits) is
;		a signed integer.  Print that value using the
;		specified number of print positions.

		public	$PutlSizeTOS
$PutlSizeTOS	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	cx

		mov	cx, [bp+6]
		mov	eax, [bp+8]
		call	$putlsize

		pop	cx
		pop	eax
		pop	bp
		ret	6
$PutlSizeTOS	endp



; $PutlSizeStk-	The address of the dword to print is 
;		passed on the stack. The minimum field
;		width is also on the stack. This routine fetches
;		the dword at the address specified by
;		the pointer on the stack and calls $putulsize 
;		to print it.

		public	$PutlSizeStk
$PutlSizeStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	eax
		push	cx
		
		lds	si, [bp+8]
		mov	eax, [si]
		mov	cx, [bp+6]
		call	$putlsize
		
		pop	cx
		pop	eax
		pop	si
		pop	ds
		pop	bp
		ret	6
$PutlsizeStk	endp





; $PutlSizeCS-	The address of a 32-bit integer variable follows in the code
;		stream, a 32-bit minimum field width constant follows
;		that (32-bit is for convenience, eight would have been
;		enough).

		public	$PutlSizeCS
$PutlSizeCS	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	ds
		push	si
		push	cx

		lds	si, [bp+2]		;Get return address.
		mov	cx, [di+4]		;Get Field Width.
		lds	si, [si]		;Get ptr to int var.
		mov	eax, [si]		;Get the value.
		add	word ptr [bp+2], 8	;Skip data in code stream.

		call	$putlSize

		pop	si
		pop	ds
		pop	eax
		pop	bp
		ret
$PutlSizeCS	endp

$segSTDIO	ends
		end
