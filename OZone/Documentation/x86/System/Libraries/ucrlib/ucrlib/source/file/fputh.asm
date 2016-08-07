		.386
		option	segment:use16, proc:private

		include	conv.a
		include	file.a

		echo	fputh, fPuthCS, fPuthStk
		echo	fputw, fPutwCS, fPutwStk
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing

byp             textequ <byte ptr>
wp		textequ	<word ptr>


; Buffer to hold converted string.

fPuthBuf	byte	4 dup (0)



; fputw-	Writes a 16-bit hexadecimal value to the specified file.
;		AX-	Contains 16-bit signed integer;
;		FS:SI-	Pointer to file variable.	  
;
; FPutwStk-	Pointer to file variable is on the top of stack.  Value
;		to write is on NOS.
;
; FPutwCS-	AX contains value to write. Pointer to file variable 
;		follows in the code stream.

		public	$fPutwStk
$FPutwStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	ax

		lfs	si, [bp+6]	;Get ptr to file variable.
		mov	ax, [bp+10]	;Value to write.
		call	$fputw

		pop	ax
		pop	si
		pop	fs
		pop	bp
		ret	6
$FPutwStk	endp

		public	$fPutwCS
$fPutwCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	ax

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fgetw

		add	wp [bp+2], 4	;Skip over parameter.

		pop	ax
		pop	si
		pop	fs
		pop	bp
		ret
$fPutwCS	endp



		public	fPutw
$fPutw		proc	far
		xchg	al, ah
		call	$fPuth
		xchg	al, ah
		call	$fPuth
		ret
$fPutw		endp




; FPuth-	Like FPutw above except it only writes an eight bit value.
;		Value to output is in AL.
;		Pointer to file variable is in FS:SI.
;
; FPuthStk-	Pointer to file variable is on the top of stack.  Value to
;		output is in the L.O. byte of NOS.
;
; FPuthCS-	Pointer to file variable follows in the code stream.  Value
;		to output is in AL.

		public	$fPuthStk
$FPuthStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	ax

		lfs	si, [bp+6]	;Get ptr to file variable.
		mov	al, [bp+10]	;Get value to output.
		call	$fgeth

		pop	si
		pop	fs
		pop	bp
		ret	6
$FPuthStk	endp

		public	$fPuthCS
$fPuthCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fgeth

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fPuthCS	endp



; $fPuth- Outputs value in AL as two hex digits.

		public	$fPuth
$fPuth		proc	far
		push	es
		push	di
		push	ax

		mov	di, seg fPuthBuf
		mov	es, di
		mov	di, offset fPuthBuf
		call	$HtoA
		call	$fputs

		pop	ax
		pop	di
		pop	es
		ret
$fPuth		endp



; fputhd-	Writes a 32-bit hexadecimal value to the specified file.
;		EAX-	Contains 32-bit signed integer;
;		FS:SI-	Pointer to file variable.	  
;
; FPuthdStk-	Pointer to file variable is on the top of stack.  Value
;		to write is on NOS.
;
; FPuthlCS-	EAX contains value to write. Pointer to file variable 
;		follows in the code stream.

		public	$fPuthlStk
$FPuthlStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	eax

		lfs	si, [bp+6]	;Get ptr to file variable.
		mov	eax, [bp+10]	;Value to write.
		call	$fputhd

		pop	eax
		pop	si
		pop	fs
		pop	bp
		ret	8
$FPuthlStk	endp

		public	$fPuthlCS
$fPuthlCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fputhd

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fPuthlCS	endp



		public	$fPuthl
$fPuthl		proc	far
		rol	eax, 16
		call	$fPutw
		rol	eax, 16
		call	$fPutw
		ret
$fPuthl		endp




$segSTDIO	ends
		end
