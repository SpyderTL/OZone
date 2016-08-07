		.386
		option	segment:use16, proc:private

		include	conv.a
		include	excepts.a

		echo	toInt, toIntStk, toUns, toUnsStk
		echo	toLong, toLongStk, toULong, toULongStk
	
ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing


byp		textequ	<byte ptr>

; These routines are functionally equivalent to the
; atoi*, atou*, atol*, atoul*, atoh*, and atolh* routines with two 
; differences:
;
; (1)	These routines are much more rigorous about what they accept.
;	They do not allow leading spaces and they do not allow any
;	trailing characters other than a zero byte (note, however,
;	that these routines still allow underscores in the middle
;	of a string of digits).
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
; General description of routines by suffix.
;
; No Suffix (e.g. toHex)
;
;	Converts a string to a numeric value and returns it in AL/AX/EAX.
;	ES:DI points at a string of characters to convert.
;
; CS suffix (e.g., toHexCS)
;
;	Converts a string to a numeric value and returns it in AL/AX/EAX.
;	Dword immediately following call contains the pointer to the string.
;
; STK suffix (e.g., toHexStk)
;
;	TOS holds a pointer to a byte, word, or dword (depends on call).
;	NOS contains a pointer to a string.  The routines with the STK
;	suffix convert the string to a number and store it into the
;	specified destination address.
;
; TOS suffix (e.g, toHexTOS)
;
;	TOS holds a pointer to a string.  The routines with the TOS
;	suffix convert the string to a word or dword value and leave
;	this result on TOS.
;
;
; toHex, toHexCS, toHexStk, toHexTOS:
;
; These routine convert a string of hexadecimal digits to an unsigned
; integer.  See AtoH for details.
;
;
; $toHexCS-	The address of a string follows in the code
;		stream.  Convert it to a binary and return
;		that integer in AX.

		public	$toHexCS
$toHexCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$toHex

		pop	di
		pop	es
		pop	bp
		ret
$toHexCS	endp


; toHexStk-	Just like toHex except the pointer to the string is on the
;		stack rather than in the ES:DI register pair.
;		TOS- Points at location to store the result.
;		NOS-Points at the string.

		public	$toHexStk
$toHexStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+10]
		call	$toHex
		les	di, [bp+6]
		mov	es:[di], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$toHexStk	endp


; toHexTOS-	Ptr to string buffer on NOS.
;		Leaves result on TOS.

		public	$toHexTOS
$toHexTOS       proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+6]
		call	$toHex
		
		mov	[bp+6], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	2
$tohexTOS	endp




; toLHex, toLHexStk:
;
; These routine convert a string of hexadecimal digits to a 32-bit unsigned
; integer.  See AtoH for details.
;
; $toLHexCS-	The address of a string follows in the code
;		stream.  Convert it to a binary and return
;		that integer in EAX.

		public	$toLHexCS
$toLHexCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$toLHex

		pop	di
		pop	es
		pop	bp
		ret
$toLHexCS	endp


; toLHexStk-	Just like toLHex except the pointer to the string is on the
;		stack rather than in the ES:DI register pair.
;		TOS- Points at location to store the result.
;		NOS-Points at the string.

		public	$toLHexStk
$toLHexStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+10]
		call	$toLHex
		les	di, [bp+6]
		mov	es:[di], eax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret	8
$toLHexStk	endp


; toLHexTOS-	Ptr to string buffer on NOS.
;		Leaves result on TOS.

		public	$toLHexTOS
$toLHexTOS	proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+6]
		call	$toLHex
		
		mov	[bp+6], eax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret
$toLhexTOS	endp





; toInt, toIntCS, toIntTOS, toIntStk:
;
; These routines convert a string to an integer.  See ATOI for the details.
;
; $toIntCS-	The address of a string follows in the code
;		stream.  Convert it to an integer and return
;		that integer in AX.

		public	$toIntCS
$toIntCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$toInt

		pop	di
		pop	es
		pop	bp
		ret
$toIntCS	endp


; toIntStk-	Just like toInt except the pointer to the string is on the
;		stack rather than in the ES:DI register pair.
;		TOS- Points at location to store the result.
;		NOS-Points at the string.

		public	$toIntStk
$toIntStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+10]
		call	$toInt
		les	di, [bp+6]
		mov	es:[di], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$toIntStk	endp


; toIntTOS-	Ptr to string buffer on NOS.
;		Leaves result on TOS.

		public	$toIntTOS
$toIntTOS       proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+6]
		call	$toInt
		
		mov	[bp+6], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	2
$toIntTOS	endp







; ToUnsigned, toUnsignedStk
;
; See Atou* for details.
;
; $toUnsCS-	The address of a string follows in the code
;		stream.  Convert it to an integer and return
;		that integer in AX.

		public	$toUnsCS
$toUnsCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$toUns

		pop	di
		pop	es
		pop	bp
		ret
$toUnsCS	endp


; toUnsStk-	Just like toInt except the pointer to the string is on the
;		stack rather than in the ES:DI register pair.
;		TOS- Points at location to store the result.
;		NOS-Points at the string.

		public	$toUnsStk
$toUnsStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+10]
		call	$toUns
		les	di, [bp+6]
		mov	es:[di], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$toUnsStk	endp


; toUnsTOS-	Ptr to string buffer on NOS.
;		Leaves result on TOS.

		public	$toUnsTOS
$toUnsTOS       proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+6]
		call	$toUns
		
		mov	[bp+6], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	2
$toUnsTOS	endp










; toLong, toLongCS, toLongTOS, toLongStk.  See AtoL* for details.
;
; $toLHexCS-	The address of a string follows in the code
;		stream.  Convert it to a binary and return
;		that integer in EAX.

$toLongCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$toLong

		pop	di
		pop	es
		pop	bp
		ret
$toLongCS	endp


; toLongStk-	Just like toLong except the pointer to the string is on the
;		stack rather than in the ES:DI register pair.
;		TOS- Points at location to store the result.
;		NOS-Points at the string.

$toLongStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+10]
		call	$toLong
		les	di, [bp+6]
		mov	es:[di], eax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret	8
$toLongStk	endp


; toLongTOS-	Ptr to string buffer on NOS.
;		Leaves result on TOS.

$toLongTOS	proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+6]
		call	$toLong
		
		mov	[bp+6], eax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret
$toLongTOS	endp







; toULong, toULongStk
; $toLHexCS-	The address of a string follows in the code
;		stream.  Convert it to a binary and return
;		that integer in EAX.

$toULongCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$toULong

		pop	di
		pop	es
		pop	bp
		ret
$toULongCS	endp


; toULongStk-	Just like toULong except the pointer to the string is on the
;		stack rather than in the ES:DI register pair.
;		TOS- Points at location to store the result.
;		NOS-Points at the string.

$toULongStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+10]
		call	$toULong
		les	di, [bp+6]
		mov	es:[di], eax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret	8
$toULongStk	endp


; toULongTOS-	Ptr to string buffer on NOS.
;		Leaves result on TOS.

$toULongTOS	proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+6]
		call	$toULong
		
		mov	[bp+6], eax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret
$toULongTOS	endp








; Note: these routines were placed down here so they'd be near the
;	PossibleRaise code and could transfer to them using a
;	short jmp.


$toLHex		proc	far
		push	di
		cmp	byp es:[di], ' '	;Don't allow leading spaces
		je	near ptr PossibleRaise
		call	$atolhx
		jc	near ptr PossibleRaise	;Atohx return an error?
		cmp	byp es:[di], 0		;Make sure this is the end
		jne	near ptr PossibleRaise	; of the string.
		pop	di
		clc				;No error
		ret				;Return result if okay.
$toLHex		endp



$toHex		proc	far
		push	di
		cmp	byp es:[di], ' '	;Don't allow leading spaces
		je	short PossibleRaise
		call	$atohx
		jc	short PossibleRaise	;Atolx return an error?
		cmp	byp es:[di], 0		;Make sure this is the end
		jne	short PossibleRaise	; of the string.
		pop	di
		clc				;No error
		ret				;Return result if okay.
$toHex		endp



$toInt		proc	far
		push	di
		cmp	byp es:[di], ' '	;Don't allow leading spaces
		je	short PossibleRaise
		call	$atoix
		jc	short PossibleRaise	;Atolx return an error?
		cmp	byp es:[di], 0		;Make sure this is the end
		jne	short PossibleRaise	; of the string.
		pop	di
		clc				;No error
		ret				;Return result if okay.
$toInt		endp



$toUns		proc	far
		push	di
		cmp	byp es:[di], ' '	;Don't allow leading spaces
		je	short PossibleRaise
		call	$atoux
		jc	short PossibleRaise
		cmp	byp es:[di], 0
		jne	short PossibleRaise
		pop	di
		clc				;No error
		ret
$toUns		endp



$toLong		proc	far
		push	di
		cmp	byp es:[di], ' '	;Don't allow leading spaces
		je	short PossibleRaise
		call	$atolx
		jc	short PossibleRaise
		cmp	byp es:[di], 0
		jne	short PossibleRaise
		pop	di
		clc				;No error
		ret
$toLong		endp





$toULong	proc	far
		push	di
		cmp	byp es:[di], ' '	;Don't allow leading spaces
		je	short PossibleRaise
		call	$atoulx
		jc	short PossibleRaise
		cmp	byp es:[di], 0
		jne	short PossibleRaise
		pop	di
		clc				;No error
		ret
$toULong	endp


; Note that we only jump to this procedure.  It never gets called.
; Therefore there is no return address (for this procedure) on the stack.
; The return address is for one of the routines above.

PossibleRaise	proc	far
		pop	di		;Pushed by routines above.
		Call	$GetXEnabled
		cmp	ax, 1
		je	RaiseExcept
		stc			;If exceptions are off, return error
		ret			; status in carry flag.

RaiseExcept:	mov	ax, $Conversion
		call	$Raise
PossibleRaise	endp
ucrlib		ends
		end
