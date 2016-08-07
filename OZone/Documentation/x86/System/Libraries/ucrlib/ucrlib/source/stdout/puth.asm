		include	stdout.a
		include	conv.a

		echo	PUTH, PUTHSTK, PUTW, PUTWSTK

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing

PuthBuf		byte	4 dup (0)

; $Puth- Outputs value in AL as two hex digits.

		public	$Puth
$Puth		proc	far
		push	es
		push	di
		push	ax

		mov	di, seg PuthBuf
		mov	es, di
		mov	di, offset PuthBuf
		call	$HtoA
		call	$puts

		pop	ax
		pop	di
		pop	es
		ret
$Puth		endp



; $PuthTOS-	Outputs the 16-bit value on TOS as two hex digits.
;		(L.O. byte only)

		public	$PuthTOS
$PuthTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	al, [bp+6]
		call	$puth
		pop	ax
		pop	bp
		ret	2
$PuthTOS	endp



; $PuthStk-	The address of the byte to print is 
;		passed on the stack. This routine fetches
;		the byte at the address specified by
;		the pointer on the stack and calls $puth 
;		to print it.

		public	$PuthStk
$PuthStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]
		mov	al, [si]
		call	$puth
		
		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4
$PuthStk	endp





; $PuthCS-	The address of a byte variable follows in the code
;		stream.

		public	$PuthCS
$PuthCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		add	word ptr [bp+2], 4	;Skip ptr to byte.
		mov	al, [si]		;Get the byte.

		call	$puth

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$PuthCS		endp



; $Putw-	Outputs word in AX as four hexadecimal digits.

		public	$Putw
$Putw		proc	far
		xchg	al, ah
		call	$puth
		xchg	al, ah
		call	$puth
		ret
$Putw		endp



; $PutwTOS-	Outputs the 16-bit value on TOS as four hex digits.

		public	$PutwTOS
$PutwTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	ax, [bp+6]
		call	$putw
		pop	ax
		pop	bp
		ret	2
$PutwTOS	endp



; $PutwStk-	The address of the word to print is 
;		passed on the stack. This routine fetches
;		the word at the address specified by
;		the pointer on the stack and calls $putw 
;		to print it.

		public	$PutwStk
$PutwStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]
		mov	ax, [si]
		call	$putw
		
		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4
$PutwStk	endp




; $PutwCS-	The address of a word variable follows in the code
;		stream.

		public	$PutwCS
$PutwCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	ax, [si]		;Get the word.
		add	word ptr [bp+2], 4	;Skip ptr to word.

		call	$puth

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$PutwCS		endp





$segSTDIO	ends
		end
