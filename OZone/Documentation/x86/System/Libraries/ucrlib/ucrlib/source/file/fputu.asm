		.386
		option	segment:use16, proc:private

		include	conv.a
		include	file.a

		echo	fPutu, fPutuStk, fPutuCS
		echo	fPutuSize, fPutuSizeStk, fPutuSizeCS
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing

byp             textequ <byte ptr>
wp		textequ	<word ptr>




; FPutu-	Prints the value in AX as a 16-bit unsigned integer to
;		the file specified by FS:SI.
;
;		AX-	Value to print.
;		FS:SI-	Pointer to file variable.
;
; FPutuStk-	Pointer to file variable is on NOS, Value to print
;		is on TOS.
;
; FPutuCS-	Pointer to file variable follows in the code stream.
;		Value to print is in AX.


		public	$fPutuStk
$FPutuStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	ax

		lfs	si, [bp+6]	;Get ptr to file variable.
		mov	ax, [bp+10]	;Get value to print.
		call	$fputu

		pop	ax
		pop	si
		pop	fs
		pop	bp
		ret	6
$FPutuStk	endp

		public	$fPutuCS
$fPutuCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fPutu

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fPutuCS	endp



		public	$fPutu
$fPutu		proc	far
		push	eax
		movzx	eax, ax
		call	$fPutul
		pop	eax
		ret
$fPutu		endp



; $fPutUSize-	Outputs a 16-bit unsigned integer.
;		AX- 	Unsigned value to print.
;		CX- 	Minimum number of print positions to use.
;		FS:SI-	Pointer to file variable.

		public	$fPutuSize
$fPutUSize	proc	far
		push	eax
		movzx	eax, ax
		call	$fPutULSize
		pop	eax
		ret
$fPutUSize	endp



; $fPutuSizeStk(filevar, value, size)
;
;	TOS-	16-bit value specifying minimum field width.
;	TOS+2-	16-bit unsigned value to print.
;	TOS+4-	32-bit pointer to file variable.

		public	$fPutuSizeStk
$fPutuSizeStk	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	cx
		push	fs
		push	si


		mov	cx, [bp+6]
		movzx	eax, word ptr [bp+8]
		lfs	si, [bp+10]
		call	$fPutULSize

		pop	si
		pop	fs
		pop	cx
		pop	eax
		pop	bp
		ret	4
$fPutuSizeStk	endp


; fPutuSizeCS-	AX contains value to print, minimum size and file var
;		ptr follow in code stream.  Note that the size is
;		a constant, not a pointer to a var.  It is a 32-bit
;		constant for convenience.
;
;		call	$fPutuSizeCS
;		dword	filevar, size

		public	$fPutuSizeCS
$fPutuSizeCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	cx

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		mov	cx, fs:[si+4]	;Get width.
		lfs	si, fs:[si]	;Get ptr to fv.
		call	$fPutu

		add	wp [bp+2], 8	;Skip over parameters.

		pop	cx
		pop	si
		pop	fs
		pop	bp
		ret
$fputuSizeCS	endp


$segSTDIO	ends
		end
