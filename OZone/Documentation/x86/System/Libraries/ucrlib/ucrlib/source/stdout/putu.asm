		include	stdout.a

		echo	Putu, PutuStk, PutuSize, PutuSizeStk

	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing




; $Putu-	Prints the value in AX as an unsigned integer value.
;		Like $PUTI, this routine simply zero extends AX into
;		EAX and calls the $PUTUL routine.

		public	$Putu
$PutU		proc	far
		push	eax
		movzx	eax, ax
		call	$putul
		pop	eax
		ret
$PutU		endp



; $PutuTOS-	Outputs the 16-bit unsigned integer on the TOS.

		public	$putuTOS
$PutuTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	ax, [bp+6]
		call	$putu
		pop	ax
		pop	bp
		ret	2
$PutuTOS	endp



; $PutuStk-	The address of the word to print is 
;		passed on the stack. This routine fetches
;		the word at the address specified by
;		the pointer on the stack and calls $putu 
;		to print it.

		public	$PutuStk
$PutuStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]
		mov	ax, [si]
		call	$putu
		
		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4
$PutuStk	endp






; $PutuCS-	The address of an unsigned integer variable follows in the code
;		stream.

		public	$PutuCS
$PutuCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	ax, [si]		;Get the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		call	$putu

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$PutuCS		endp



; $PutUSize-	Outputs a 16-bit unsigned integer.  Like PutISize above.

		public	$PutuSize
$PutUSize	proc	far
		push	eax
		movzx	eax, ax
		call	$PutULSize
		pop	eax
		ret
$PutUSize	endp



; $PutuSizeStk	TOS (16-bits) contains a field width.  NOS (32-bits) is
;		an unsigned integer.  Print that value using the
;		specified number of print positions.

		public	$PutuSizeTOS
$PutuSizeTOS	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	cx

		mov	cx, [bp+6]
		mov	ax, [bp+8]
		call	$putusize

		pop	cx
		pop	eax
		pop	bp
		ret	4
$PutuSizeTOS	endp



; $PutuSizeStk-	The stack contains a pointer to an integer
;		and a minimum field width.  Get the integer
;		and print it using putisize.

		public	$PutuSizeStk
$PutuSizeStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		push	cx
		
		lds	si, [bp+8]
		mov	cx, [bp+6]
		mov	ax, [si]
		call	$putuSize
		
		pop	cx
		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	6
$PutuSizeStk	endp








; $PutuSizeCS-	The address of an unsigned integer variable follows in the code
;		stream, a 32-bit minimum field width constant follows
;		that (32-bit is for convenience, eight would have been
;		enough).

		public	$PutuSizeCS
$PutuSizeCS	proc	far
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

		call	$putuSize

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$PutuSizeCS	endp

$segSTDIO	ends
		end
