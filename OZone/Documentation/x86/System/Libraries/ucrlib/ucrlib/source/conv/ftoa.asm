		include	char.a
		include conv.a

		.386
		option	segment:use16, proc:private
		echo	FTOA, FTOAx, ETOA, ETOAx

ucrlib          segment para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing

byp		textequ	<byte ptr>
wp		textequ	<word ptr>
dp		textequ	<dword ptr>

Digits		byte	32 dup (0)
Sign		byte	?
ExpSign		byte	?
Exponent	word	?

MaxDigits	real10	1.0e+17
Zero		real8	0.0
One		real8	1.0

BCDResult	byte	10 dup (0)



; FTOA-		Converts extended precision value in ST(0) to a decimal
;		string.  AL contains the field width, AH contains the
;		number of positions after the decimal point.  The format
;		of the converted string is:
;
;			sd.e
;
;		where "s" is a single character which is either a space
;		or "-", "e" is some number of digits which is equal to
;		the value passed in AL, and "d" is the number of digits
;		given by  (AL-AH-2).  If the field width is too small,
;		this routine creates a string of "#" characters AH long.
;
;		ES:DI contains the address where we're supposed to put
;		the resulting string.  This code assumes that there is
;		sufficient memory to hold (AL+1) characters at this address.

		public	$ftoa
$ftoa		proc	far
		push	di
		call	$ftoax
		pop	di
		ret
$ftoa		endp




		public	$ftoax
$ftoax		proc	far
		assume	ds:ucrlib

		pushf
		push	ds
		push	ax
		push	bx
		push	cx
		push	dx
		push	si

		cld
		mov	bx, ucrlib
		mov	ds, bx

		mov	cx, ax		;Save field width/dec pts here.

		call	fpdigits	;Convert fpacc to digit string.

; Round the string of digits to the number of significant digits we want to
; display for this number:

		mov	bx, Exponent
		cmp	bx, 18
		jb	PosRS
		xor	bx, bx		;Force to zero if negative or too big.

PosRS:		add	bl, ch	       	;Compute position where we should start
		adc	bh, 0		; the rounding.
		inc	bx		;Tweak next digit.
		cmp	bx, 18		;Don't bother rounding if we have
		jae	RoundDone	; more than 18 digits here.

; Add 5 to the digit after the last digit we want to print.  Then propogate
; any overflow through the remaining digits.

		mov	al, Digits [bx]
		add	al, 5
		mov	Digits [bx], al
		cmp	al, "9"
		jbe     RoundDone
		sub	Digits [bx], 10
RoundLoop:	dec	bx
		js	FirstDigit
		inc	Digits[bx]
		cmp	Digits[bx], "9"
		jbe	RoundDone
		sub	Digits[bx], 10
		jmp	RoundLoop

; If we hit the first digit in the string, we've got to shift all the
; characters down one position and put a "1" in the first character
; position.

FirstDigit:     mov	bx, Exponent
		cmp	bx, 18
		jb	FDOkay
		xor	bx, bx

FDOkay:		mov	bl, ch
		mov	bh, 0
		inc	bx
FDLp:		mov	al, byte ptr Digits[bx-1]
		mov	Digits [bx], al
		dec	bx
		jnz	FDLp
		mov	Digits, "1"
		inc	Exponent	;Cause we just added a digit.

RoundDone:

; See if we're dealing with values greater than one (abs) or between 0 & 1.

		cmp	Exponent, 0	;Handle positive/negative exponents
		jge	PositiveExp	; separately.

; Handle values between 0 & 1 here (negative powers of ten).

		mov	dl, ch		;Compute #'s width = DecPlaces+3
		add   	dl, 3		;Make room for "-0."
		jc	BadFieldWidth

		cmp	dl, 4
		jae	LengthOK
		mov	dl, 4		;Minimum string is "-0.0"

LengthOK:	cmp	dl, cl		;Make sure caller allows this many
		ja	BadFieldWidth	; characters.

		mov	al, ' '
PutSpcs2:       cmp	dl, cl
		jae	PS2Done
		stosb
		inc	dl
		jmp	PutSpcs2

PS2Done:       	mov	al, Sign
		stosb
		mov	al, "0"		;Output "0." before the number.
		stosb
		mov	al, "."
		stosb

		mov	ah, 0		;Used to count output digits
		lea	bx, Digits	;Pointer to number string.
PutDigits2:	mov	al, '0'		;Assume we just output a zero.
		inc	Exponent
		js	PutAL		;If exp still neg, just output zeros.

		cmp	ah, 18		;If more than 18 digits so far, just
		jae	PutAL		; output zeros.

		mov	al, [bx]
		inc	bx
PutAL:		stosb

TestDone2:	inc	ah		;Bump # of digits processed.
		dec	ch		;Output the field width yet?
		jnz     PutDigits2

		mov	byte ptr es:[di], 0
		jmp	ftoaDone


; Okay, we've got a positive exponent here.  First, let's adjust the field
; width value (in CH) so that it includes the sign and possible decimal point.

PositiveExp:	mov	dx, Exponent	;Get actual # of digits to left of "."
		inc	dx		;Allow for sign and the fact that there
		inc	dx		; is always one digit to left of ".".
		cmp	ch, 0		;# of chars after "." = 0?
		je	NoDecPt
		add	dl, ch		;Add in number of chars after "."
		adc	dh, 0
		inc	dx		;Make room for "."
NoDecPt:


; Make sure the field width is bigger than the number of decimal places to
; print.

		cmp	cl, ch
		jb	BadFieldWidth


; Okay, now see if the user is trying to print a value which is too large
; to fit in the given field width:

		cmp	dh, 0
		jne	BadFieldWidth	;Sorry, no output >= 256 chars.
		cmp	dl, cl		;Need field width > specified FW?
		jbe	GoodFieldWidth

; If we get down here, then we've got a number which will not fit in the
; specified field width.  Fill the string with #'s (sorta like FORTRAN).

BadFieldWidth:	mov	ch, 0		;Set CX=field width.
		mov	al, "#"
	rep	stosb
		mov	byte ptr es:[di], 0
		jmp	ftoaDone


; Output any necessary spaces in front of the number.

GoodFieldWidth:	call	PutSpaces

; Output the sign character (" " or "-"):

		mov	al, Sign
		stosb

; Okay, output the digits for this number here.

		mov	ah, 0		;Counts off output characters.
		lea	bx, Digits	;Pointer to digit string.
		mov	cl, ch		;CX := # of chars after "."
		mov	ch, 0	       	; plus number of characters before
		add	cx, Exponent	; the ".".
		inc	cx		;Always at least one digit before "."
OutputLp:	cmp	ah, 18		;Exceeded 18 digits?
		jae	PutZeros
		mov	al, [bx]
		inc	bx
		jmp	PutChar

PutZeros:	mov	al, '0'
PutChar:	stosb
		cmp	Exponent, 0
		jne	DontPutPoint
		mov	al, '.'
		stosb

DontPutPoint:	dec	Exponent
		inc	ah
		loop	OutputLp
		mov	byte ptr es:[di], 0 	;Output the zero byte.

ftoaDone:	pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	ds
		popf
		ret
$ftoax		endp



; $ETOA-	Converts value in FPACC to exponential form.  AL contains
;		the number of print positions.  ES:DI points to the array
;		which will hold this string (it must be at least AL+1 chars
;		long).
;
;		The output string takes the format:
;
;		{" "|-} [0-9] "." [0-9]* "E" [+|-] [0-9]{2,4}
;
;		(The term "[0-9]{2,4}" means either two or four digits)
;
;		AL must be at least eight or this code outputs #s.


		public	$etoa
$etoa		proc	far
		push	di
		call	$etoax
		pop	di
		ret
$etoa		endp


		public	$etoax
$etoax		proc	far
		assume	ds:ucrlib

		pushf
		push	ds
		push	ax
		push	bx
		push	cx
		push	si

		cld
		mov	bx, ucrlib
		mov	ds, bx

		call	fpdigits

; See if we have sufficient room for the number-

		mov	ah, 0
		mov	cx, ax

; Okay, take out spots for sign, ".", "E", sign, and at least four exponent
; digits and the exponent's sign:

Subtract2:	sub	ax, 8
		jc	BadEWidth
		jnz	DoTheRound	;Make sure at least 1 digit left!

BadEWidth:	mov	ch, 0
		mov	al, "#"
	rep	stosb
		mov	al, 0
		stosb
		jmp	etoaDone

; Round the number to the specified number of places.

DoTheRound:	mov	ch, al		;# of decimal places is # of posns.
		mov	bl, ch	       	;Compute position where we should start
		mov	bh, 0		; the rounding.
		cmp	bx, 18		;Don't bother rounding if we have
		jae	eRoundDone	; more than 18 digits here.

; Add 5 to the digit after the last digit we want to print.  Then propogate
; any overflow through the remaining digits.

		mov	al, Digits [bx]
		add	al, 5
		mov	Digits [bx], al
		cmp	al, "9"
		jbe     eRoundDone
		sub	Digits [bx], 10
eRoundLoop:	dec	bx
		js	eFirstDigit
		inc	Digits[bx]
		cmp	Digits[bx], "9"
		jbe	eRoundDone
		sub	Digits[bx], 10
		jmp	eRoundLoop

; If we hit the first digit in the string, we've got to shift all the
; characters down one position and put a "1" in the first character
; position.

eFirstDigit:    mov	bl, ch
		mov	bh, 0
		inc	bx
eFDLp:		mov	al, Digits[bx-1]
		mov	Digits [bx], al
		dec	bx
		jnz	eFDLp
		mov	Digits, "1"
		inc	Exponent	;Cause we just added a digit.

eRoundDone:

; Okay, output the value here.

		mov	cl, ch		;Set CX=Number of output chars
		mov	ch, 0
		mov	al, Sign
		stosb
		lea	si, Digits
		movsb			;Output first char.
		dec	cx		;See if we're done!
		jz	PutExponent

; Output the fractional part here

		mov	al, "."
		stosb
		mov	ah, 17		;Max # of chars to output.
PutFractional:	cmp	ah, 0
		jz	NoMoreDigs
		movsb
		dec	ah
		jmp	NextFraction

; If we've output more than 18 digits, just output zeros.

NoMoreDigs:	mov	al, "0"
		stosb

NextFraction:	loop	PutFractional
PutExponent:	mov	al, "e"
		stosb
		mov	al, "+"
		cmp	Exponent, 0
		jge	NoNegExp
		mov	al, "-"
		neg	Exponent

NoNegExp:	stosb
		mov	ax, Exponent
		cwd			;Sets DX := 0.
		mov	cx, 1000
		div	cx
		cmp	al, 0
		je	Skip1000out

		or	al, "0"
		stosb			;Output 1000's digit

Skip1000out:	xchg	ax, dx
		cwd
		mov	cx, 100
		div	cx
		cmp	al, 0
		je	Skip100out

		or	al, "0"		;Output 100's digit
		stosb

Skip100out:	xchg	ax, dx
		cwd
		mov	cx, 10
		div	cx
		or	al, "0"		;Output 10's digit
		stosb
		xchg	ax, dx
		or	al, "0"		;Output 1's digit
		stosb
		mov	byte ptr es:[di], 0	;Output zero byte.

etoaDone:	pop	si
		pop	cx
		pop	bx
		pop	ax
		pop	ds
		popf
		ret
$etoax		endp



; Okay, now we need to insert any necessary leading spaces.  We need to
; put (FieldWidth - ActualWidth) spaces before the string of digits.

PutSpaces	proc	near
		cmp	dl, cl		;See if print width >= field width
		jae	NoSpaces
		mov	ah, cl
		sub	ah, dl		;Compute # of spaces to print.
		mov	al, ' '
PSLp:		stosb
		dec	ah
		jnz	PSLp
NoSpaces:	ret
PutSpaces	endp









; FPDigits- Converts the floating point number in FPACC to a string of
;	    digits (in DecDigits), an integer exponent value (DecExp),
;	    and a sign character (DecSign).  The decimal point is assumed
;	    to be between the first and second characters in the string.

FPDigits	proc	near
		assume	ds:ucrlib
		push	ds
		push	es
		push	eax
		push	bx
		push	di

		mov	ax, ucrlib
		mov	ds, ax


		fcom	zero
		fstsw	ax
		sahf
		jnz	fpdNotZero

; Well, it's zero.  Handle this as a special case:

		mov	eax, 30303030h		;"0000"
		mov	dp Digits[0], eax
		mov	dp Digits[4], eax
		mov	dp Digits[8], eax
		mov	dp Digits[12], eax
		mov	dp Digits[16], eax
		mov	dp Digits[20], eax
		mov	Exponent, 0
		mov	Sign, ' '
		jmp	fpdDone


; If the number is not zero, first fix up the sign:

fpdNotZero:	mov	Sign, ' '		;Assume it's postive
		jnb	WasPositive
		fabs
		mov	Sign, '-'

WasPositive:	mov	Exponent, 0		;Initialize exponent.

; Get the number between one and ten so we can figure out what the exponent is.
; Begin by checking to see if we have a positive or negative exponent.

		fcom	One			;See if exponent is (+) or (-)
		fstsw	ax
		sahf
		jae	PosExp

; We've got a value between zero and one, exclusive, at this point.  That means
; this number has a negative exponent.  Multiply the number by an appropriate
; power of ten until we get it in the range 1..10.

		mov	bx, ExpSize*10
		mov	di, ExpSize*2
CmpNegExp:	sub	bx, 10
		sub	di, 2
		fld	PotTblN [bx]
		fcomp
		fstsw	ax
		sahf
		jbe	CmpNegExp

		mov	ax, ExpTbl [di]
		test	ax, ax
		jz	LastNegDiv

		sub	Exponent, ax
		fld	PotTblP [bx]
		fmul
		jmp	CmpNegExp


LastNegDiv:	fld	PotTblP10
		fmul
		dec	Exponent
		jmp	InRange1_10
		

; Handle values with positive exponents down here.

PosExp:		mov	bx, ExpSize*10
		mov	di, ExpSize*2
CmpPosExp:	sub	bx, 10
		sub	di, 2
		fld	PotTblP [bx]
		fcomp
		fstsw	ax
		sahf
		ja	CmpPosExp

		mov	ax, ExpTbl [di]
		test	ax, ax
		jz	InRange1_10

		add	Exponent, ax
		fld	PotTblP [bx]
		fdiv
		jmp	CmpPosExp




; Okay, at this point the number is in the range 1<=x<10,
; Let's multiply it by 1e+18 to put the most sigificant digit
; into the 18th print position.  Then convert the result to
; a BCD value and store away in memory.

InRange1_10:	fld	MaxDigits
		fmul
		fbstp	tbyte ptr BCDResult

; Now BCDResult contains 18 digits (in BCD form).  Convert these to
; ASCII characters.

		mov	di, ds
		mov	es, di
		lea	di, Digits

		mov	al, BCDResult+8
		call	$htoax
		mov	ax, wp BCDResult+6
		call	$wtoax
		mov	ax, wp BCDResult+4
		call	$wtoax
		mov	ax, wp BCDResult+2
		call	$wtoax
		mov	ax, wp BCDResult
		call	$wtoax


fpdDone:	pop	di
		pop	bx
		pop	eax
		pop	es
		pop	ds
		ret
FPDigits	endp


; Power of ten tables used by the floating point I/O routines.
;
; This first table contains the negative powers of ten as follows:
;
;   for n:= 0 to 12 do
;	entry [12-n] := 10 ** (-2 ** n)
;   entry [13] := 1.0



PotTblN		real10	1.0
		real10	1.0e-1
		real10	1.0e-2
		real10	1.0e-4
		real10	1.0e-8
		real10	1.0e-16
		real10	1.0e-32
		real10	1.0e-64
		real10	1.0e-128
		real10	1.0e-256
		real10	1.0e-512
		real10	1.0e-1024
		real10	1.0e-2048
		real10	1.0e-4096

; PotTblP- Power of ten table.  Holds powers of ten raised to positive
;	   powers of two;

PotTblP		real10	1.0
PotTblP10	real10	1.0e+1
		real10	1.0e+2
		real10	1.0e+4
		real10	1.0e+8
		real10	1.0e+16
		real10	1.0e+32
		real10	1.0e+64
		real10	1.0e+128
		real10	1.0e+256
		real10	1.0e+512
		real10	1.0e+1024
		real10	1.0e+2048
		real10	1.0e+4096


ExpTbl		word	0
		word	1
		word	2
		word	4
		word	8
		word	16
		word	32
		word	64
		word	128
		word	256
		word	512
		word	1024
		word	2048
		word	4096
ExpSize		=	($-ExpTbl)/2
ucrlib		ends
		end
