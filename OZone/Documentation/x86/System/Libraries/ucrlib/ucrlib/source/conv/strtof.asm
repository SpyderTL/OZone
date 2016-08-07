		.386
		option	segment:use16, proc:private

		include	conv.a
		include	excepts.a

		echo	toFlt, toFltStk
	
ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing


byp		textequ	<byte ptr>

; These routines are functionally equivalent to the atof* routines with two 
; differences:
;
; (1)	These routines are much more rigorous about what they accept.
;	They do not allow leading spaces and they do not allow any
;	trailing characters other than a zero byte.
;
; (2)	If exceptions are enabled, these routines raise a conversion
;	exception if there is a problem converting the string to
;	some sort of integer.
;
; Since these routines require all characters in the string to be a part of
; the number they are converting, there is no need for *****x routines since
; there would be little call to leave the DI register pointing at the
; zero terminating byte.
;
;
;
; toFlt, toFltCS, toFltStk:
;
; These routines convert a string to an real.  See ATOF for the details.

		public	$toFltStk
$toFltStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+6]
		call	$toFlt
		pop	di
		pop	es
		pop	bp
		ret	4
$toFltStk	endp


		public	$toFltCS
$toFltCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]
		les	di, es:[di]
		add	wp [bp+2], 4

		call	$toFlt

		pop	di
		pop	es
		pop	bp
		ret
$toFltCS	endp


		public	$toFlt
$toFlt		proc	far
		push	di
		cmp	byp es:[di], ' '	;Don't allow leading spaces
		je	short PossibleRaise
		call	$atofx
		jc	short PossibleRaise	;Atolx return an error?
		cmp	byp es:[di], 0		;Make sure this is the end
		jne	short PossibleRaise	; of the string.
		pop	di
		ret				;Return result if okay.

PossibleRaise:	pop	di		;Pushed by routines above.
		call	$GetXEnabled
		cmp	ax, 1
		je	RaiseExcept
		clc			;If exceptions are off, return error
		ret			; status in carry flag.

RaiseExcept:	mov	ax, $Conversion
		call	$Raise
$toFlt		endp

ucrlib		ends
		end
