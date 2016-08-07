		include	file.a

		echo	fPuts, fPutsStk, fPrint

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO,ds:nothing

wp		textequ	<word ptr>
dp		textequ	<dword ptr>

; $Puts prints a string (pointed at by ES:DI) to the file pointed at by
;	FS:SI.

		public	$fPuts
$fPuts		proc    far
		push    di
		call	fputs2
		pop     di
		ret
$fPuts		endp



; $fPutsStk-	A far pointer to a string is on the stack.  NOS
;		contains a pointer to the file variable. Print 
;		that string to the specified file.

		public	$fPutsStk
$fPutsStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	fs
		push	si

		les	di, [bp+6]	;Get ptr to string.
		lfs	si, [bp+10]	;Get ptr to file var.
		call	fputs2

		pop	si
		pop	fs
		pop	di
		pop	es
		pop	bp
		ret	8
$fPutsStk	endp



; fputsCS-	The dword following the call points at a file variable.
;		The next dword points at a string.

		public	$fPutsCS
$fputsCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	es
		push	di

		lfs	si, [bp+2]
		les	di, fs:[si+4]
		lfs	si, fs:[si]
		call	fputs2
		add	wp [bp+2], 8

		pop	di
		pop	es
		pop	si
		pop	fs
		pop	bp
		ret
$fputsCS	endp






; $fPRINT-	Prints the literal string constant following 
;		the call to the print routine.  This routine grabs the
;		(far) return address off the stack and uses it as a
;		pointer to the string.  It passes this pointer to fPUTS2
;		to actually print the string.  On return, it pushes the
;		address of the first byte beyond the zero byte as the
;		new return address.
;
;		A dword pointer to the file variable immediately follows
;		the call, the string literal follows that.
;
;		Note that this is equivalent to the fPutsCS routine.

		public	$fPrint
$fprint		proc	far
		push	bp
		mov	bp, sp		
		push	es
		push	di
		push	fs
		push	si

		les	di, 2[bp]	;Get return address
		lfs	si, es:[di]	;Get ptr to file var.
		add	di, 4		;Skip file ptr.
		call	fputs2

		inc	di		;Point past zero byte
		mov	2[bp], di	;Restore return address.

		pop	si
		pop	fs
		pop	di
		pop	es
		pop	bp
		ret
$fprint		endp



; fPUTS2-	Like $fPuts, except it doesn't preserve the DI register.
;		This is a utility routine for use by $fPUTS, $fPUTSSTK,
;		and $fPRINT

fPuts2		proc	near
		push	ax
		jmp	short PS2

PSLp:		call	$fputc		;Print the character.
		inc	di		;Move on to next character.
PS2:		mov	al, es:[di]	;Get the next character.
		cmp	al, 0		;If it's not the zero byte,
		jne	PSLp		; repeat this loop.
		pop	ax
		ret
fPuts2		endp

$segSTDIO	ends
		end
