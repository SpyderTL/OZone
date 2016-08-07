		.386
		option	segment:use16, proc:private

		include	char.a
		include	stdin.a

		echo	AtoF
	

; Note: this is in $segSTDIO because it shares some code in that same
;	segment with putf.

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing


dp		textequ	<dword ptr>
byp		textequ	<byte ptr>

Sign		byte	0
ExpSign		byte	0

; The following are the same variable.  They are split so I can access
; the DigitsInNum array using indexes in the range 1..18 rather than 0..19.

DigitStr	byte	?
DigitsInNum	byte	19 dup (0)

BCDStr		equ	this tbyte
BCDValue	byte	10 dup (0)

;----------------------------------------------------------------------------
;	       Text => Floating Point (Input) Conversion Routines
;----------------------------------------------------------------------------
;
;
; ATOF-		ES:DI points at a string containing (hopefully) a numeric
;		value in floating point format.  This routine converts that
;		value to a number and puts the result in fpacc.  Allowable
;		strings are described by the following regular expression:
;
;		{" "}* {+ | -} ( ([0-9]+ {"." [0-9]*}) | ("." [0-9]+)}
;				{(e | E) {+ | -} [0-9] {[0-9]*}}
;
; "{}" denote optional items.
; "|"  denotes OR.
; "()" groups items together.
;
; Returns carry set if an error occurs.  ATOFX returns with the DI register pointing
; at the character it failed on.
;
; Returns carry clear if no conversion error (note, however, that it may stop on an
; illegal character and return without error if everything up to that point was fine).
; Further, if an exponent is present, at least one decimal digit must follow the "E"/'e'
; or following "+"/"-" character.  An error also occurs if the exponent is outside
; the range +/-4930 (the range of extended precision value is approximately 
;
;	+/-3.37 x 10**-4932  to  +/-1.18 x 10**4932
;
;
; AtofX-	Like Atof, but does not preserve the DI register.
; AtofStk-	Pointer to string is passed on stack rather than in ES:DI

		public	$Atof
$AtoF		proc	far
		push	di
		call	$atofx
		pop	di
		ret
$AtoF		endp

		public	$atofStk
$AtofStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+6]
		call	$atofx
		pop	di
		pop	es
		pop	bp
		ret	4
$AtofStk	endp


		public	$AtofCS
$AtofCS		proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, [di]		;Get ptr to String.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$atofx

		pop	di
		pop	es
		pop	bp
		ret
$AtofCS		endp






AtofGet		proc	near
		mov	al, es:[di]
		inc	di
		ret
AtofGet		endp

AtofPeek	proc	near
		mov	al, es:[di]
		ret
AtofPeek	endp

		public	$AtofX
$ATOFX		proc	far
		push	offset AtofGet
		push	offset AtofPeek
		call	$T2FP
		ret
$ATOFX		endp

$segSTDIO      ends
		end