		.386
		option	segment:use16, proc:private

		include	conv.a
		include	macros.a

		echo	atoi, atoix, atou, atoux, atol, atolx, atoul, atoulx
		echo	atoh, atohx, atohl, atohlx
	
ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing




; Atoh-		Converts string of hexadecimal digits (ES:DI) to a 16-bit binary
;		number and returns this value in AX.  Returns with the carry flag
;		set if a conversion error occured.
;
; Atohx-	Like Atoh but does not preserve the value in the DI register.
;
; AtohCS-	A pointer to the string follows in the code stream.
;
; AtohStk-	Expects the pointer to the string on the stack rather than in 
;		ES:DI.  A pointer to a 16-bit variable where the routine
;		stores the result is on TOS.  Ptr to string is in NOS.
;
; AtohTOS-	The value to convert is on TOS, a pointer to the string buffer
;		is on NOS. Returns the converted value on TOS.

		public	$atoh
$atoh           proc    far
		push	di
		call	$atohx
		pop	di
		ret
$atoh		endp


; $AtohCS-	The address of a string follows in the code
;		stream.  Convert it to an binary value and return
;		that value in AX.

		public	$AtohCS
$AtohCS		proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$atoh

		pop	di
		pop	es
		pop	bp
		ret
$AtohCS		endp



; atohStk-	Ptr to string buffer on NOS.
;		Address of result variable is on TOS.

		public	$atohStk
$atohStk        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+10]
		
		call	$atohx
		
		les	di, [bp+6]
		mov	es:[di], ax	;Save away return result.
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$atohStk	endp


; atohTOS-	Ptr to string buffer on TOS.
;		Leaves result on TOS.

		public	$AtohTOS
$atohTOS        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+6]
		call	$atohx
		
		mov	[bp+6], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	2
$atohTOS	endp





		public	$atohX
$atohx		proc	far
		push	eax
		call	$atolhx
		jc	Overflow
		test	eax, 0FFFF0000h
		jnz	Overflow
		add	sp, 2
		push	ax
		pop	eax
		clc
		ret

Overflow:	pop	eax
		stc
		ret
$atohx		endp





; Atolh-	Converts string of hexadecimal digits (ES:DI) to a 32-bit binary
;		number and returns this value in EAX.
;
; Atolhx-	Like Atolh but it doesn't preserve DI.
;
; AtolhCS-	A pointer to the string follows in the code stream.
;
; AtolhStk-	Expects the string pointer on the stack rather than in ES:DI.
;		Pointer to string is on NOS, pointer to dword to store the
;		result is on TOS.
;
; AtolhTOS-	Expects the string pointer on the stack rather than in ES:DI.
;		Leaves the 32-bit result on the stack.

		public	$atolh
$atolh		proc	far
		push	di
		call	$atolhx
		pop	di
		ret
$atolh		endp


; $AtolhCS-	The address of a string follows in the code
;		stream.  Convert it to an binary value and return
;		that value in EAX.

		public	$atolhCS
$AtolhCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$atolh

		pop	di
		pop	es
		pop	bp
		ret
$AtolhCS	endp


; AtolhStk-	Expects the string pointer on the stack (TOS)  rather than in 
;		ES:DI.
;		Stores the 16-bit result at the address appearing on TOS

		public	$atolhStk
$atolhStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+6]
		call	$atolhx
		
		les	di, [bp+6]
		mov	es:[di], eax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret	8
$atolhStk	endp



; atolhTOS-	Ptr to string buffer on TOS.
;		Leaves the result on TOS.

		public	$atolhTOS
$atolhTOS       proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+6]
		
		call	$atolhx
		
		mov	[bp+6], eax	;Save away return result.
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret
$atolhTOS	endp



; IsItHex- This routine returns the carry clear if AL contains a valid
;	   hex digit.  It returns the carry set otherwise.
;	   If AL is a valid hex digit, this routine also converts
;	   AL to the corresonding value in the range 0..F.
;	   Tricky Code: Note that JB = JC, likewise, JNB=JNC.
;	   Also note that the AND instruction clears the carry flag.

IsItHex		proc	near
		xor	al, '0'
		cmp	al, 10
		cmc				;Carry clear if AL < 10!
		jnc	GotDigit		;If < 10, it's a dec digit.
		or	al, 20h			;l.c. -> U.C. (after xor).
		add	al, 89h			;0Ah..0Fh -> 0FAh..0FFh.
		cmp	al, 0fah
		jb	GotDigit		;Skip if not a digit (C=1).
		and	al, 0Fh			;Convert to 0A..0F (Clears C).
GotDigit:	ret
IsItHex		endp



		public	$atolhx
$atolhx		proc	far
		push	ecx
		xor	ecx, ecx

		call	SkipSpaces		;Skip any leading spaces.

		call	IsItHex			;We must have at least one hex
		jc	BadX			; digit, test for that here.

CnvrtLp:	shl	ecx, 4			;Merge current digit into value.
		or	cl, al

CnvrtLp2:      	inc	di
		mov	al, es:[di]
		cmp	al, "_"			;Allow underscores in the
		je	CnvrtLp2		; middle of a number.

		call	IsItHex			;If a hex digit, convert,
		jc	Done			; else we're done.

GotDigit2:	test	ecx, 0f0000000h		;See if overflow will occur
		jz	CnvrtLp			; when we shift by 4 bits.

BadX:		stc
		pop	ecx
		ret

Done:		cmp	byp es:[di-1], "_"	;Make sure number doesn't end
		je	BadX			; with an underscore
		clc
		mov	eax, ecx
		pop	ecx
		ret
$atolhx		endp





; ATOI-	Converts the string pointed at by ES:DI to a signed integer value
;	and returns this integer in the AX register.
;
;	Note: this routine skips any leading spaces.
;	      It terminates with the first non-digit character (except for
;             a leading sign).  It returns the carry flag set if there
;             were no decimal digits in the number or if an overflow
;	      occured during conversion.


		public	$atoi
$atoi		proc	far
		push	di
		call	$atoix
		pop	di
		ret
$atoi		endp



; $AtoiCS-	The address of a string follows in the code
;		stream.  Convert it to an integer and return
;		that integer in AX.

		public	$atoiCS
$AtoiCS		proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$atoi

		pop	di
		pop	es
		pop	bp
		ret
$AtoiCS		endp


; AtoiStk-	Just like Atoi except the pointer to the string is on the
;		stack rather than in the ES:DI register pair.
;		TOS- Points at location to store the result.
;		NOS-Points at the string.

		public	$atoiStk
$AtoiStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+10]
		call	$atoix
		les	di, [bp+6]
		mov	es:[di], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$AtoiStk	endp


; atoiTOS-	Ptr to string buffer on NOS.
;		Leaves result on TOS.

		public	$atoiTOS
$atoiTOS        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+6]
		call	$atoix
		
		mov	[bp+6], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	2
$atoiTOS	endp





; AtoiX-	Like Atoi except this guy does not preserve ES:DI.  It leaves
;		the DI register pointing at the first character in the string
;		that was not a decimal digit (assuming this routine returns
;		without error).

		public	$atoix
$atoix		proc	far
		push	eax

		call	$atolx
		jc	BadAtoi		;Atolx return an error?

		cmp	eax, 32768	;See if the input value is
		jge	BadAtoi		; within the appropriate range:
		cmp	eax, -32768	; -32768 <= eax <= 32767
		jl	BadAtoi

		add	sp, 2		;Return the value in AX preserving
		push	ax		; the value in the H.O. word of EAX.
		pop	eax
		clc			;Carry clear means no error.
		ret

BadAtoi:	pop	eax
		stc			;Carry set means an error occured.
		ret
$Atoix		endp





; Atou-		Just like Atoi except this routine returns an unsigned value in AX.


		public	$atou
$atou		proc	far
		push	di
		call	$atoux
		pop	di
		ret
$atou		endp


; $AtouCS-	The address of a string follows in the code
;		stream.  Convert it to an integer and return
;		that integer in AX.

		public	$atouCS
$AtouCS		proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$atou

		pop	di
		pop	es
		pop	bp
		ret
$AtouCS		endp



; AtouStk-	Just like Atou except the pointer to the string is on the
;		stack rather than in the ES:DI register pair.
;		Pointer to string- NOS.
;		Pointer to location to store value - TOS.

		public	$atouStk
$AtouStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+10]
		call	$atoux
		les	di, [bp+6]
		mov	es:[di], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$AtouStk	endp


; atouTOS-	Ptr to string buffer on NOS.
;		Leaves result on TOS.

		public	$atouTOS
$atouTOS        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+6]
		call	$atoux
		
		mov	[bp+6], ax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	2
$atouTOS	endp







; Atoux-	Like Atou except this routine does not preserve the value of the
;		DI register.

		public	$atoux
$atoux		proc	far
		push	eax
		call	$atoulx
		jc	atouxDone

; The following instructions set the carry flag if EAX >= 65536
; (overflow for unsigned 16-bit values).

		cmp	eax, 10000h			;See if overflow occurs.
		cmc					; Note: carry set if below

atouxDone:	inc	sp				;Restore only H.O. word
		inc	sp				; of eax (note: using INC
		push	ax				; rather than ADD to preserve
		pop	eax				; the carry flag).
		ret
$atoux		endp







; Atol-		Returns a signed 32-bit integer in EAX.

		public	$atol
$atol		proc	far
		push	di
		call	$atolx
		pop	di
		ret
$atol		endp


; $AtolCS-	The address of a string follows in the code
;		stream.  Convert it to an integer and return
;		that integer in EAX.

		public	$atolCS
$AtolCS		proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$atol

		pop	di
		pop	es
		pop	bp
		ret
$AtolCS		endp




; AtolStk-	Just like Atol except the pointer to the string is on the
;		stack rather than in the ES:DI register pair.
;		TOS- Pointer where the result is to be stored.
;		NOS- Pointer to string.

		public	$atolStk
$AtolStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+10]
		call	$atol
		les	di, [bp+6]
		mov	es:[di], eax
		
		push	eax
		pop	di
		pop	es
		pop	bp
		ret	8
$AtolStk	endp



; atolTOS-	Ptr to string buffer on NOS.
;		Leaves result on TOS.

		public	$atolTOS
$atolTOS        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+6]
		call	$atolx
		
		mov	[bp+6], eax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret
$atolTOS	endp







; Atolx-	Converts the ASCII string that ES:DI points at to a signed
;		integer value and returns this value in EAX.  The 32-bit
;		counterpart to Atoi.

		public	$atolx
$atolx		proc	far

		call	SkipSpaces
		cmp	byte ptr es:[di], '-'
		jne	DoAtoL

; Handle negative numbers.

		inc	di				;Skip "-"

		call	DoConvert
		jc	WasError		;Check error return from DoConvert.
		test	eax, eax		;See if too big for signed value.
		js	WasError
		neg	eax			;Okay, negate result.
		clc
		ret
		
DoAtoL:		call	DoConvert
		jc	WasError
		test	eax, eax		;If sign bit is set, we have
		js	WasError		; an overflow condition.
		clc
		ret

WasError:	stc
		ret
$atolx		endp







; Atoul-	Just like Atol except this routine returns an unsigned value in EAX.


		public	$atoul
$atoul		proc	far
		push	di
		call	$atoulx
		pop	di
		ret
$atoul		endp


; $AtoulCS-	The address of a string follows in the code
;		stream.  Convert it to an integer and return
;		that integer in EAX.

		public	$atoulCS
$AtoulCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to string.
		add	word ptr [bp+2], 4	;Skip ptr to string.

		call	$atoi

		pop	di
		pop	es
		pop	bp
		ret
$AtoulCS	endp



; AtoulStk-	Just like Atoul except the pointer to the string is on the
;		stack rather than in the ES:DI register pair.

		public	$atoulStk
$AtoulStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+10]
		call	$atoul
		les	di, [bp+6]
		mov	es:[di], eax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret	8
$AtoulStk	endp



; atoulTOS-	Ptr to string buffer on NOS.
;		Leaves result on TOS.

		public	$atoulTOS
$atoulTOS       proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+6]
		call	$atoulx
		
		mov	[bp+6], eax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret
$atoulTOS	endp




; Atoulx-	Converts the string pointed at by ES:DI to an unsigned integer
;		value in EAX.  
 
		public	$atoulx
$atoulx		proc	far
		call	SkipSpaces
		call	DoConvert
		ret
$Atoulx		endp



; DoConvert-	Does the actual ASCII->unsigned integer conversion.

DoConvert	proc	near
		push	ecx
		push	ebx
		push	edx

		xor	ecx, ecx
		xor	eax, eax
		mov	ebx, 10

; Sneaky code!  XORing a value in the range '0'..'9' produces a value
; in the range 0..9 and transforms all other characters to values 10 and
; above.  This code sequence takes advantage of this fact.

		mov	al, es:[di]		;Check to see if the first
		xor	al, '0'			; character in the string
		cmp	al, 10			; is a valid decimal digit.
		jae	FinishUL		;Note: JAE = JNC
		
ConvertULp:	inc	di
		mov	cl, es:[di]
		cmp	cl, "_"			;Ignore "_" characters in the middle
		jne	NotUS			; of a string of digits.

		mov	cl, es:[di+1]		;Be sure a digit follows this "_"
		xor	cl, '0'			; character.
		cmp	cl, 10
		jb	ConvertULp		;Note: JB = JC.
		jmp	NumDone			;If char after "_" not in '0'-'9'.

NotUS:		xor	cl, '0'
		cmp	cl, 10			;If not "_", is it a digit?
		jae	NumDone			;JAE = JNC

		mul	ebx			;Multiply partial product by 10.
		add	eax, ecx		;Add in current digit.
		jc	NumDone			;Jump if error.

		test	edx, edx		;Check for integer overflow.
		jz	ConvertULp
		clc				;Will force the carry to be set.

FinishUL:	cmc
NumDone:	pop	edx
		pop	ebx
		pop	ecx
		ret

DoConvert	endp



; SkipSpaces-	Increments DI as long as ES:DI points at a space character.

SkipSpaces	proc	near
		dec	di
SkipSpcLp:	inc	di
		cmp	byte ptr es:[di], ' '
		je	SkipSpcLp
		ret
SkipSpaces	endp
ucrlib		ends
		end
