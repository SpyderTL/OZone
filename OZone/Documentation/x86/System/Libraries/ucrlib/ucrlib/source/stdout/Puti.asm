		include	stdout.a

		echo	Puti, PutiStk, PutiSize, PutiSizeStk
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing


; $Puti-	prints the value in AX as a signed integer value.
;		It cheats.  It simply sign extends the value to
;		32-bits and calls $PUTL

		public	$Puti
$Puti		proc	far
		push	eax
		movsx	eax, ax
		call	$putl
		pop	eax
		ret
$Puti		endp


; $PutiTOS-	Outputs the 16-bit integer on the TOS.

		public	$PutiTOS
$PutiTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	ax, [bp+6]
		call	$puti
		pop	ax
		pop	bp
		ret	2
$PutiTOS	endp



; $PutiStk-	The address of the word to print is 
;		passed on the stack. This routine fetches
;		the word at the address specified by
;		the pointer on the stack and calls $puti 
;		to print it.

		public	$PutiStk
$PutiStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]
		mov	ax, [si]
		call	$puti
		
		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4
$PutiStk	endp






; $PutiCS-	The address of an integer variable follows in the code
;		stream.

		public	$PutiCS
$PutiCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	ax, [si]		;Get the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		call	$puti

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$PutiCS		endp




; $PutISize-	Outputs a 16-bit signed integer (in AX) using the
;		minimum field width in CX.  It cheats, it does
;		this by sign extending AX to EAX and calling
;		the PutLSize routine.

		public	$putISize
$PutISize	proc	far
		push	eax
		movsx	eax, ax
		call	$PutLSize
		pop	eax
		ret
$PutISize	endp




; $PutiSizeTOS	TOS (16-bits) contains a field width.  NOS (32-bits) is
;		a signed integer.  Print that value using the
;		specified number of print positions.

		public	$PutiSizeTOS
$PutiSizeTOS	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	cx

		mov	cx, [bp+6]
		mov	ax, [bp+8]
		call	$putisize

		pop	cx
		pop	eax
		pop	bp
		ret	4
$PutiSizeTOS	endp



; $PutiSizeStk-	The stack contains a pointer to an integer
;		and a minimum field width.  Get the integer
;		and print it using putisize.

		public	$PutiSizeStk
$PutiSizeStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		push	cx
		
		lds	si, [bp+8]
		mov	cx, [bp+6]
		mov	ax, [si]
		call	$putiSize
		
		pop	cx
		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	6
$PutiSizeStk	endp







; $PutiSizeCS-	The address of an integer variable follows in the code
;		stream, a 32-bit minimum field width constant follows
;		that (32-bit is for convenience, eight would have been
;		enough).

		public	$PutiSizeCS
$PutiSizeCS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si
		push	cx

		lds	si, [bp+2]		;Get return address.
		mov	cx, [di+4]		;Get Field Width.
		lds	si, [si]		;Get ptr to int var.
		mov	ax, [si]		;Get the value.
		add	word ptr [bp+2], 8	;Skip data in code stream.

		call	$putiSize

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$PutiSizeCS	endp

$segSTDIO	ends
		end
