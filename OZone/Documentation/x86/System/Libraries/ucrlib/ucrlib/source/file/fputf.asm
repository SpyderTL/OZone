		include	file.a
		include	consts.a
		include	conv.a

		echo	fPutf, fPute
	
$segSTDIO	segment	para public '$segSTDIO'
		assume	cs:$segSTDIO, ds:nothing


fBuffer		byte	32 dup (0)

; fPutf-ST(0) contains a floating point value, print it to the display.
;	AL- Minimum field width
;	AH- Number of positions *after* the decimal point.
;	FS:SI- Pointer to file variable.
;
; Note: This routine limits the minimum field width to 30 characters.


		public	$fPutf
$fputf		proc	far
		push	ax
		push	es
		push	di

		cmp	al, 30
		jb	GoodMinWidth
		mov	al, 30
GoodMinWidth:
		lesi	fBuffer		;Convert ST(0) to a string
		call	$ftoa
		call	$fputs		;Print it.
PutfError:	pop	di
		pop	es
		pop	ax
		ret
$fputf		endp




; $fPutfStk-	Outputs the fp value in ST(0).
;		TOS (8086) contains pointer to file variable.
;		AL/AH contain same values as fputf.

		public	$fPutfStk
$fPutfStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]
		call	$fputf

		pop	si
		pop	fs
		pop	bp
		ret	4
$fPutfStk	endp


; fPutfCS-	Outputs the fp value in ST(0) to the
;		file specified by the pointer following the
;		call in the code stream.
;		AL/AH contain same values as fputf.

		public	$fPutfCS
$fPutfCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fPutf

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fPutfCS	endp






; fPute-ST(0) contains a floating point value, print it to the display using
;	scientific notion format.
;
;	AL- Minimum field width (should be at least eight!)
;	FS:SI- Pointer to file variable.


		public	$fPute
$fpute		proc	far
		push	ax
		push	es
		push	di
		cmp	al, 30
		jb	WidthOK
		mov	al, 30
WidthOK:	lesi	fBuffer
		call	$etoa		;Convert ST(0) to a string
		call	$fputs		;Print it.

		pop	di
		pop	es
		pop	ax
		ret
$fpute		endp


; $fPuteStk-	Outputs the fp value in ST(0) in scientific form.
;		TOS (8086) contains pointer to file variable.

		public	$fPuteStk
$fPuteStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]
		call	$fpute

		pop	si
		pop	fs
		pop	bp
		ret	4
$fPuteStk	endp




; fPuteCS-	Outputs the fp value in ST(0) to the
;		file specified by the pointer following the
;		call in the code stream.
;		AL contains the same value as fpute.

		public	$fPuteCS
$fPuteCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fPute

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fPuteCS	endp



$segSTDIO	ends
		end
