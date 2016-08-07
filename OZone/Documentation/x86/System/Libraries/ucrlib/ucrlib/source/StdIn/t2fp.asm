		.386
		option	segment:use16, proc:private

		include	char.a
		include	excepts.a

		echo	T2FP
	

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing


dp		textequ	<dword ptr>
byp		textequ	<byte ptr>

Sign		byte	0
ExpSign		byte	0

; The following are the same variable.  They are split so I can access
; the DigitsInNum array using indexes in the range 1..18 rather than 0..19.

DigitStr	byte	20 dup (0)

BCDStr		equ	this tbyte
BCDValue	byte	10 dup (0)

;----------------------------------------------------------------------------
;	       Text => Floating Point (Input) Conversion Routines
;----------------------------------------------------------------------------
;
; Peek routine returns the next available character without eating it.
; Get routine returns the next available character and moves past it.

Peek		textequ	<call near ptr [bp+4]>
Get		textequ	<call near ptr [bp+6]>

		public	$T2FP
$T2FP		proc	near
		assume	cs:$segSTDIO, ds:$segSTDIO

		push	bp
		mov	bp, sp

		push	ds
		push	eax
		push	bx
		push	dx

		mov	ax, cs
		mov	ds, ax

; Initialize the DigitsInNum string with all zeros.

		xor	eax, eax
		mov	dp DigitStr, eax
		mov	dp DigitStr+4, eax
		mov	dp DigitStr+8, eax
		mov	dp DigitStr+12, eax
		mov	dp DigitStr+16, eax

; First, skip any leading spaces:

SkipBlanks:	get
		cmp	al, " "
		je	SkipBlanks


; Check for + or -.

		mov	Sign, 80h
		cmp	al, "-"
		je	SkipSign
		mov	Sign, 0
		cmp	al, "+"
		jne	NoEat

SkipSign:	get		;Eat the sign character.


; Init some important local vars:
;
; DX- Exponent.  Initialize to -18 since we have to account for BCD conversion.
; BX- Index into DigitStr array and # of significant digits left to process.


NoEat:		mov	dx, -18		;Initial exponent to account for BCD conversion.
		mov	bx, 18		;# of significant digits left to process.

; If the first character (beyond the spaces and sign, if present) is not a digit
; or a decimal point, we've got an error.

		isdigit
		je	OkaySoFar

		cmp	al, '.'
		jne	ConvErr
		jmp	GetFraction

; First, eliminate any leading zeros before the decimal point
; (which do not count as significant digits):

Eliminate0s:	get
OkaySoFar:	cmp	al, '0'
		je	Eliminate0s

; When we reach the end of the leading zeros, first check for a decimal
; point.  If the number is of the form "0---0.0000" we need to get rid
; of the zeros after the decimal point and not count them as significant
; digits.

EndOfZeros:	cmp	al, "."
		jne	DoDigits

; Okay, the number is of the form ".xxxxx".  Strip all zeros immediately
; after the decimal point and decrement the exponent by one for each
; such zero.  Since these zeros do not count as significant digits,
; leave BX alone while skipping zeros.
;
; Note: we're still looking at the "." so we have to read a character
;	to get past it.

GetFraction:	get
		cmp	al, '0'
		jne	FractionPart2
		dec	dx
		jmp	GetFraction


; If the number is of the form "yyy.xxxx" (where y <> 0) then process it
; down here.  If "YYY" is more than 18 significant digits long, simply increment
; the exponent (DX) and forget about capturing these characters.
; Note that this code stores the characters backwards in the DigitStr array.
; This turns out to be convenient because the Most Significant Digit should
; be in the H.O. byte.
;
; Since we've already accounted for up to 18 digits in the BCDString (with
; respect to the exponent), to not adjust the exponent while processing
; significant digits.  However, once we exceed 18 significant digits, we need
; to decrement the exponent since the BCD conversion only allows for 18 digits.

WhileDigits:	get				;Get the next character.
DoDigits:	sub	al, "0"
		cmp	al, 10
		jae	NotADigit

		inc	dx			;Adjust exponent for new digit.
		test	bx, bx			;See if we've already processed
		jz	WhileDigits		; 18 significant digits.

		mov	DigitStr[bx], al
		dec	bx
		jmp	WhileDigits


; Check to see if there is a decimal point here:

NotADigit:	cmp	al, "."-"0"
		jne	NotADecPt

; Okay, process the digits to the right of the decimal point here.
; for each such digit (up to the number of significant digits) we
; need to increment the exponent since the BCD conversion doesn't
; allow for fractional values.

FractionPart:	get				;Eat current digit.
FractionPart2:	sub	al, "0"
		cmp	al, 10
		jae	NotADecPt

		test	bx, bx			;Too many significant digits?
		jz	FractionPart		;If so, ignore them.

		mov	DigitStr[bx], al	;If not, save them up.
		dec	bx			;Yet another significant digit.
		jmp	FractionPart



; Process the exponent down here

NotADecPt:	cmp	al, "e"-"0"
		je	IsExponent
		cmp	al, "E"-"0"
		jne	NoExponent

; Okay, we just saw the "E" character, now read in the exponent value
; and add it into DX (the current BCD conversion adjusted exponent).

IsExponent:	mov	ExpSign, 0		;Assume positive exponent.
		get				;Get char after exponent.
		cmp	al, "+"
		je	EatExpSign
		cmp	al, "-"
		jne	ExpNotNeg
		mov	ExpSign, 1		;Exponent is negative.
EatExpSign:	get

; Okay, we've just bypassed the sign in the exponent.  We must have at least
; one decimal digit at this point.

ExpNotNeg:	isDigit
		jne	ConvErr

		xor	bx, bx
		mov	ah, bh
		jmp	ExpLoop

ExpLpTop:	imul	bx, 10			;Convert the digit chars
		add	bx, ax			; after the exponent to
		get				; an integer value.
ExpLoop:	sub	al, '0'
		cmp	al, 10
		jb	ExpLpTop

		cmp	ExpSign, 0		;If the exponent was
		je	PosExp			; negative, negate it here.
		neg	bx
PosExp:		add	dx, bx			;Add in the BCD adjustment

; Okay, convert the Digitstr variable to a BCD value

NoExponent:	mov	al, DigitStr+18
		shl	al,4
		or	al, DigitStr+17
		mov	BCDValue+8, al

		mov	al, DigitStr+16
		shl	al, 4
		or	al, DigitStr+15
		mov	BCDValue+7, al

		mov	al, DigitStr+14
		shl	al, 4
		or	al, DigitStr+13
		mov	BCDValue+6, al

		mov	al, DigitStr+12
		shl	al, 4
		or	al, DigitStr+11
		mov	BCDValue+5, al

		mov	al, DigitStr+10
		shl	al, 4
		or	al, DigitStr+9
		mov	BCDValue+4, al

		mov	al, DigitStr+8
		shl	al, 4
		or	al, DigitStr+7
		mov	BCDValue+3, al

		mov	al, DigitStr+6
		shl	al, 4
		or	al, DigitStr+5
		mov	BCDValue+2, al

		mov	al, DigitStr+4
		shl	al, 4
		or	al, DigitStr+3
		mov	BCDValue+1, al

		mov	al, DigitStr+2
		shl	al, 4
		or	al, DigitStr+1
		mov	BCDValue, al

; Okay, load this BCD value into the FPU.

		fbld	BCDStr


; Okay, We've got the mantissa in the FPU.  Now multiply by 10 the number of times
; specified in Exponent.  Obviously, this uses the power of ten tables
; to speed up this operation (and make it more accurate).
;
; Okay, the exponent is positive, handle that down here.
; This is some tricky code that does the following:
;
; We want to determine which power of ten is just less than the value
; of our exponent.  The powers of ten we're checking are 10**4096,
; 10**2048, 10**1024, 10**512, etc.
;
; A slick way to do this check is by shifting the bits in the exponent
; to the left.  Bit #12 is the 4096 bit.  So if this bit is set our
; exponent is >= 10**4096.  If not, check the next bit down, and so on.


		cmp	dx, 4930	;Check to see if exponent is
		jg	OverflwErr	; out of range.
		cmp	dx, -4930
		jl	OverflwErr

		mov	bx, -10		;Initial index into our table.
		test	dx, dx		;See if exp is negative
		js	NegExp

		shl	dx, 3		;Bit 12 -> bit 15.



PosExpLp:	test	dx, dx		;See if the exp has become zero.
		jz	MulExpDone
		add	bx, 10
		shl	dx, 1
		jnc	PosExpLp
		fld	PotTblP[bx]
		fmul
		jmp	PosExpLp


; Okay, the exponent is negative, handle that down here.

NegExp:		neg	dx
		shl	dx, 3

NegExpLp:	test	dx, dx		;See if the exp has become zero.
		jz	MulExpDone
		add	bx, 10
		shl	dx, 1
		jnc	NegExpLp

		fld	PotTblP[bx]
		fdiv
		jmp	NegExpLp


MulExpDone:     cmp	Sign, 0
		je	NumIsPos
		fchs

NumIsPos:	pop	dx
		pop	bx
		pop	eax
		pop	ds
		pop	bp

		clc
		ret	4


ConvErr:	pop	dx
		pop	bx
		pop	eax
		pop	ds
		pop	bp
		mov	ax, $Conversion
		stc
		ret	4



OverFlwErr:	pop	dx
		pop	bx
		pop	eax
		pop	ds
		pop	bp
		mov	ax, $Overflow
		stc
		ret	4
$T2FP		endp



PotTblP		real10	1.0e+4096
		real10	1.0e+2048
		real10	1.0e+1024
		real10	1.0e+512
		real10	1.0e+256
		real10	1.0e+128
		real10	1.0e+64
		real10	1.0e+32
		real10	1.0e+16
		real10	1.0e+8
		real10	1.0e+4
		real10	1.0e+2
		real10	1.0e+1
		real10	1.0e0

$segSTDIO       ends
		end