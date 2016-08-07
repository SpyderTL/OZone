		include	stdout.a

		echo	Puts, PutsStk, Print

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO,ds:nothing

wp		textequ	<word ptr>
dp		textequ	<dword ptr>

; $Puts prints a string (pointed at by ES:DI) to the standard output.

		public	$Puts
$Puts		proc    far
		push    di
		call	puts2
		pop     di
		ret
$Puts		endp



; $PutsStk-	A far pointer to a string is on the stack.  Print 
;		that string to the standard output.

		public	$PutsStk
$PutsStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+6]	;Get ptr to string.
		call	puts2
		pop	di
		pop	es
		pop	bp
		ret	4
$PutsStk	endp


; $PutsCS-	A far pointer to a string follows in the code stream.
;		This routine prints that string.

		public	$PutsCS
$PutsCS		proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]
		les	di, es:[di]
		add	wp [bp+2], 4
		call	puts2
		
		pop	di
		pop	es
		pop	bp
		ret
$PutsCS		endp





; $PRINT-	Prints the literal string constant immediately following 
;		the call to the print routine.  This routine grabs the
;		(far) return address off the stack and uses it as a
;		pointer to the string.  It passes this pointer to PUTS2
;		to actually print the string.  On return, it pushes the
;		address of the first byte beyond the zero byte as the
;		new return address.

		public	$print
$print		proc	far
		push	bp
		mov	bp, sp		
		push	es
		push	di

		les	di, 2[bp]	;Get return address
		call	puts2

		inc	di		;Point past zero byte
		mov	2[bp], di	;Restore return address.

		pop	di
		pop	es
		pop	bp
		ret
$print		endp



; PUTS2-	Like $Puts, except it doesn't preserve the DI register.
;		This is a utility routine for use by $PUTS, $PUTSSTK,
;		and $PRINT

Puts2		proc	near
		push	ax
		jmp	short PS2a

PSLp:		call	$putc		;Print the character.
		inc	di		;Move on to next character.
PS2a:		mov	al, es:[di]	;Get the next character.
		cmp	al, 0		;If it's not the zero byte,
		jne	PSLp		; repeat this loop.
		pop	ax
		ret
Puts2		endp

$segSTDIO	ends
		end
