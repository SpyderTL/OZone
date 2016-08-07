		include	stdout.a
		include	conv.a
		include	consts.a

		echo	Putf, Pute
	
$segSTDIO	segment	para public '$segSTDIO'
		assume	cs:$segSTDIO, ds:nothing


fBuffer		byte	32 dup (0)

; Putf-	ST(0) contains a floating point value, print it to the display.
;	AL- Minimum field width
;	AH- Number of positions *after* the decimal point.
;
; Note: This routine limits the minimum field width to 30 characters.


		public	$Putf
$putf		proc	far
		push	ax
		push	es
		push	di

		cmp	al, 30
		jb	GoodMinWidth
		mov	al, 30
GoodMinWidth:
		lesi	fBuffer		;Convert ST(0) to a string
		call	$ftoa
		call	$puts		;Print it.
PutfError:	pop	di
		pop	es
		pop	ax
		ret
$putf		endp





; Pute-	FPACC contains a floating point value, print it to the display using
;	scientific notion format.
;
;	AL- Minimum field width (should be at least eight!)


		public	$pute
$pute		proc	far
		push	ax
		push	es
		push	di
		cmp	al, 30
		jb	WidthOK
		mov	al, 30
WidthOK:	lesi	fBuffer
		call	$etoa		;Convert ST(0) to a string
		call	$puts		;Print it.

		pop	di
		pop	es
		pop	ax
		ret
$pute		endp

$segSTDIO	ends
		end
