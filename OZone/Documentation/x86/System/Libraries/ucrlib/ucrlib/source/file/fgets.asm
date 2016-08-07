		include	consts.a
		include	file.a
		include	excepts.a

		echo	fgets, fgetsStk, fgetsL
	
$segFile	segment	para public 'Files'
		assume	cs:$segFile, ds:nothing


wp		textequ	<word ptr>


; FGETS-	Reads a line of text from the user (up to 128 characters) and
;		stores it into the buffer specified by the caller.  Note that
;		the semantics are somewhat different from the standard GETS
;		routine -- a line ends with a line feed and this code throws
;		out all carriage returns encountered.  This is because lines
;		in a text file (under DOS) end with a cr/lf pair.
;
;		On Entry:
;
;			es:di-	Points at string buffer.
;			fs:si-	Points at file variable.

		public	$fGets
$fgets		proc	far
		push	di
		push	ax

		call	$feof		;See if EOF at start of line.
		test	ax, ax
		jz	NotAtEOF
		GetXEnabled
		test	ax, ax		;See if exceptions are active.
		stc
		jz	BadfGets	;Return with carry set if no
		mov	ax, $EndOfFile	; exceptions are active.
		Raise

NotAtEOF:	dec	di
CopyChars:	inc	di
EatCR:		call	$feof		;Treat EOF as though it were

		test	ax, ax		; a line terminator.
		jnz	EndLine

		call	$fgetc		;Read next available character
		cmp	al, cr
		je	EatCR
		mov	es:[di], al
		cmp	al, lf
		jne	CopyChars
		
EndLine:	mov	byte ptr es:[di], 0
		clc
BadFGets:	pop	ax
		pop	di
		ret
$fgets		endp




; FGetsStk-	Like FGETS except the pointer to the string and file
;		variables are passed on the stack rather than in ES:DI
;		and FS:SI.
;
; fGetsStk(filevar, buffer)

		public	$fGetsStk
$FGetsStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	es
		push	di

		les	di, [bp+10]	;Get ptr to buffer.
		lfs	si, [bp+6]	;Get ptr to file variable.
		call	$fgets

		pop	di
		pop	es
		pop	si
		pop	fs
		pop	bp
		ret	8
$FGetsStk	endp


; FGetsCS-	Pointer to file variable and buffer are passed in the
;		code stream.
;
;		fgetsCS
;		dword	fvar, buffer

		public	$fGetsCS
$FGetsCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	es
		push	di

		les	di, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		les	di, es:[di+4]	;Get ptr to buffer.
		call	$fgets

		add	wp [bp+2], 8	;Skip over parameters.
		pop	si
		pop	es
		pop	si
		pop	fs
		pop	bp
		ret
$FGetsCS	endp

$segFile	ends
		end
