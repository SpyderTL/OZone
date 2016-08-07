		include	file.a

		echo	fPuti, fPutiStk, fPutiCS
		echo	fPutiSize, fPutiSizeStk, fPutiSizeCS
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing


; $fPuti-	prints the value in AX as a signed integer value.
;		It cheats.  It simply sign extends the value to
;		32-bits and calls $fPutD
;		FS:SI contain a pointer to the file variable.

		public	$fPuti
$fPuti		proc	far
		push	eax
		movsx	eax, ax
		call	$fputl
		pop	eax
		ret
$fPuti		endp


; $PutiStk-	TOS is a pointer to a 16-bit var.
;		NOS points at the file variable.

		public	$fPutiStk
$fPutiStk	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	fs
		push	si

		lfs	si, [bp+6]
		mov	ax, fs:[si]

		lfs	si, [bp+10]
		call	$fputi

		pop	si
		pop	fs
		pop	ax
		pop	bp
		ret	8
$fPutiStk	endp

; $PutiStk-	Outputs the 16-bit integer on the TOS.
;		NOS points at the file variable.

		public	$fPutiTOS
$fPutiTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	fs
		push	si

		mov	ax, [bp+6]
		lfs	si, [bp+8]
		call	$fputi

		pop	si
		pop	fs
		pop	ax
		pop	bp
		ret	6
$fPutiTOS	endp



; fPutiCS-	Outputs the 16-bit signed value in AX to the
;		file specified by the pointer following the
;		call in the code stream.

		public	$fPutiCS
$fPutiCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fPuti

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fPutiCS	endp





; $fPutISize-	Outputs a 16-bit signed integer (in AX) using the
;		minimum field width in CX.  It cheats, it does
;		this by sign extending AX to EAX and calling
;		the fPutLSize routine.  Note that FS:SI points
;		at the file variable.

		public	$fPutiSize
$fPutISize	proc	far
		push	eax
		movsx	eax, ax
		call	$fPutLSize
		pop	eax
		ret
$fPutISize	endp




; $fPutiSizeStk	Stack contains the following:
;
;	TOS-	Minimum field width
;	TOS+4-	Signed value to print
;	TOS+6-	Pointer to file variable.
;
;	This routine prints the specified value to the file using
;	the specified number of print positions.

		public	$fPutiSizeStk
$fPutiSizeStk	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	cx
		push	fs
		push	si

		mov	cx, [bp+6]
		mov	ax, [bp+8]
		lfs	si, [bp+10]
		call	$fputisize

		pop	si
		pop	fs
		pop	cx
		pop	eax
		pop	bp
		ret	8
$fPutiSizeStk	endp


; fPutiSizeCS-	The pointer following the call points at a file variable.
;		AX contains an integer.
;		CX contains a file size.
;		Print the specified value.

		public	$fPutiSizeCS
$fPutiSizeCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fPutiSize

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fPutiSizeCS	endp


$segSTDIO	ends
		end
