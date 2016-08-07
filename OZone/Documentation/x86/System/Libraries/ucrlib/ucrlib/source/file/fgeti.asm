		.386
		option	segment:use16, proc:private

		include	conv.a
		include	file.a
		include excepts.a
		include	stdin.a

		echo	fgeti, fgetu, fgetl, fgetul, fgeth, fgetw, fgetlh
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing

byp             textequ <byte ptr>
wp		textequ	<word ptr>

TermChar	byte	?

; LastChar-	Holds the last character read so we can check for underscores
;		appearing as the last character of a number.

LastChar	byte	?



; getw-		Reads a 16-bit hexadecimal value from the standard (buffered)
;		input device and returns the corresponding value in AX.  
;		Raises a $Conversion error if the string contains
;		illegal characters.  Note: This routine skips all leading 
;		whitespace and successfully stops on whitespace or a comma.
;		It will remove a single comma from the standard input if the
;		value terminates on a comma.
;
;		This routine will raise the $Overflow exception if the value
;		is larger than 0FFFFh.
;
;		This routine only raises an exception if exceptions are enabled.
;		If exceptions are not enabled, this routine returns the error
;		status in the carry flag (C=1 denotes conversion or overflow
;		error).
;
; FGetwStk-	Pointer to file variable is on the top of stack.
; FGetwCS-	Pointer to file variable follows in the code stream.

		public	$fGetwStk
$FGetwStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]	;Get ptr to file variable.
		call	$fgetw

		pop	si
		pop	fs
		pop	bp
		ret	4
$FGetwStk	endp

		public	$fGetwCS
$fgetwCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fgetw

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fgetwCS	endp



		public	$fGetw
$fgetw		proc	far
		push	di
		push	eax
		call	$fgethl
		jc	Overflow
		test	eax, 0FFFF0000h
		jnz	Overflow
		add	sp, 2
		push	ax
		pop	eax
		pop	di
		clc
		ret

Overflow:	GetXEnabled
		cmp	ax, 0
		je	ReturnErr
		mov	ax, $Overflow
		call	$Raise

ReturnErr:	pop	eax
		pop	di
		stc
		ret
$fgetw		endp




; FGeth-	Like FGetw above except it only reads an eight bit value.
;		Pointer to file variable is in FS:SI.
;
; FGethStk-	Pointer to file variable is on the top of stack.
; FGethCS-	Pointer to file variable follows in the code stream.

		public	$fGethStk
$FGethStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]	;Get ptr to file variable.
		call	$fgeth

		pop	si
		pop	fs
		pop	bp
		ret	4
$FGethStk	endp

		public	$fGethCS
$fgethCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fgeth

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fgethCS	endp



		public	$fGeth
$fgeth		proc	far
		push	di
		push	bx
		push	eax
		call	$fgethl
		jc	Overflow
		test	eax, 0FFFFFF00h
		jnz	Overflow
		
		pop	bx		;Retrieve original AH value.
		mov	ah, bh		;Restore AH value.
		push	ax		;Push new value.
		pop	eax		;Restore EAX+AH+new value.
		pop	bx
		pop	di
		clc
		ret

Overflow:	call	$GetXEnabled
		cmp	ax, 0
		je	ReturnErr
		mov	ax, $Overflow
		call	$Raise

ReturnErr:	pop	eax
		pop	bx
		pop	di
		stc
		ret
$fgeth		endp







; FGethl-	Reads a "long hexadecimal" value from a file and
;		returns this value in EAX.  FS:DI points at the file var.
;
;		Raises a $Conversion error if the string contains
;		illegal characters.  Note: This routine skips all leading 
;		whitespace and successfully stops on whitespace or a comma.
;		It will remove a single comma from the standard input if the
;		value terminates on a comma.
;
;		This routine will raise the $Overflow exception if the value
;		is larger than 0FFFFFFFFh.
;
;		This routine only raises an exception if exceptions are enabled.
;		If exceptions are not enabled, this routine returns the error
;		status in the carry flag (C=1 denotes conversion or overflow
;		error).
;
;		This routine allows the user to put underscores in the middle
;		of a string of hexadecimal digits (to use as a separator much
;		like commas in a standard numeric value).
;
; FGethlStk-	Pointer to file variable is on the top of stack.
; FGetwhlCS-	Pointer to file variable follows in the code stream.

		public	$fGethlStk
$FGethlStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]	;Get ptr to file variable.
		call	$fgethl

		pop	si
		pop	fs
		pop	bp
		ret	4
$FGethlStk	endp


		public	$fGethlCS
$fgethlCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fgethl

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fgethlCS	endp



		public	$fGethl
$FGethl		proc	far
		push	ecx
		xor	ecx, ecx

		call	$GetTermCh
		mov	TermChar, al

		call	SkipSpaces		;Skip any leading spaces.

		call	$fgetc
		call	IsItHex			;We must have at least one hex
		jc	BadX			; digit, test for that here.

CnvrtLp:	shl	ecx, 4			;Merge current digit into value.
		or	cl, al

CnvrtLp2:      	call	$fgetc
		mov	LastChar, al
		cmp	al, "_"			;Allow underscores in the
		je	CnvrtLp2		; middle of a number.

		call	IsItHex			;If a hex digit, convert,
		jc	Done			; else we're done.

GotDigit2:	test	ecx, 0f0000000h		;See if overflow will occur
		jz	CnvrtLp			; when we shift by 4 bits.

		call	$GetxEnabled		;Overflow has just occured,
		cmp	ax, 0			; see if exceptions are
		je	ReturnErr		; enabled
		mov	ax, $Overflow
		call	$Raise

Done:		mov	al, LastChar

		cmp	al, "_"			;Don't allow "_" at the end
		je	BadX			; of a number.

		cmp	al, TermChar		;Check for allowable termination
		je	GoodX			; character.

		cmp	al, ","			;Go ahead an allow a comma
		je	GoodX			; at the end of a hex value.

		cmp	al, " "			;Allow any white space characters
		ja	BadX			; at the end of a hex value.

GoodX:		clc
		mov	eax, ecx
		pop	ecx
		ret

; Drop down here if we get a bad hexadecimal character.

BadX:		call	$GetXEnabled
		cmp	ax, 0
		je	ReturnErr
		mov	ax, $Conversion
		call	$Raise

ReturnErr:	stc
		pop	ecx
		ret

$FGethl		endp



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
		or	al, 20h			;Convert l.c. -> U.C. (after xor).
		add	al, 89h			;0Ah..0Fh -> 0FAh..0FFh.
		cmp	al, 0fah
		jb	GotDigit		;Skip if not a digit (C=1).
		and	al, 0Fh			;Convert to 0A..0F (Clears C).
GotDigit:	ret
IsItHex		endp






; FGetI-Reads a signed integer value from a file and returns 
;	this integer in the AX register.  FS:SI points at the
;	file variable.
;
;	Raises a $Conversion error if the string contains
;	illegal characters.  Note: This routine skips all leading 
;	whitespace and successfully stops on whitespace or a comma.
;	It will remove a single comma from the standard input if the
;	value terminates on a comma.
;
;	This routine will raise the $Overflow exception if the value
;	is larger than 32767.
;
;	This routine only raises an exception if exceptions are enabled.
;	If exceptions are not enabled, this routine returns the error
;	status in the carry flag (C=1 denotes conversion or overflow
;	error).
;
;	This routine allows the user to put underscores in the middle
;	of a string of decimal digits (to use as a separator much
;	like commas in a standard numeric value).
;
; FGetiStk-	Pointer to file variable is on the top of stack.
; FGetiCS-	Pointer to file variable follows in the code stream.

		public	$fGetiStk
$FGetiStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]	;Get ptr to file variable.
		call	$fgeti

		pop	si
		pop	fs
		pop	bp
		ret	4
$FGetiStk	endp

		public	$fGetiCS
$fgetiCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fgeti

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fgetiCS	endp



		public	$fGeti
$fgeti		proc	far
		push	eax

		call	$fgetl
		jc	Badgeti		;Getl return an error?

		cmp	eax, 32768	;See if the input value is
		jge	GetiOvfl	; within the appropriate range:
		cmp	eax, -32768	; -32768 <= eax <= 32767
		jl	GetiOvfl

		add	sp, 2		;Return the value in AX preserving
		push	ax		; the value in the H.O. word of EAX.
		pop	eax
		clc			;Carry clear means no error.
		ret

; If an overflow occurs, raise the $Overflow exception if exceptions are
; enabled.

GetiOvfl:	call	$GetXEnabled
		cmp	ax, 0
		je	BadGeti
		mov	ax, $Overflow
		call	$Raise

; If GETL just returned an error (meaning exceptions are off) or we had
; an overflow but exceptions are off, drop down here and return the
; carry flag set.

BadGeti:	pop	eax
		stc			;Carry set means an error occured.
		ret
$FGeti		endp





; fgetu-	Just like fgeti except this routine returns an unsigned value in AX.
;		Pointer to file variable is in FS:SI.
;
; FGetuStk-	Pointer to file variable is on the top of stack.
; FGetuCS-	Pointer to file variable follows in the code stream.

		public	$fGetuStk
$FGetuStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]	;Get ptr to file variable.
		call	$fgetu

		pop	si
		pop	fs
		pop	bp
		ret	4
$FGetuStk	endp

		public	$fGetuCS
$fgetuCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fgetu

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fgetuCS	endp



		public	$fGetu
$fgetu		proc	far
		push	eax
		call	$fgetul
		jc	getuDone

; The following instructions set the carry flag if EAX >= 65536
; (overflow for unsigned 16-bit values).

		cmp	eax, 10000h			;See if overflow occurs.
		cmc					;Carry set if below,
		jnc	getuDone			; we want carry clear.

; If overflow occured, see if exceptions are enabled.  If they are, raise
; an overflow exception.

		call	$GetXEnabled
		cmp	ax, 0	
		je	getuErr
		mov	ax, $Overflow
		call	$Raise

getuErr:	stc
getuDone:	inc	sp				;Restore only H.O. word
		inc	sp				; of eax (note: using INC
		push	ax				; rather than ADD to preserve
		pop	eax				; the carry flag).
		ret
$fgetu		endp







; fgetl-	Reads a signed 32-bit integer and returns it in EAX.
;		Pointer to file variable is in FS:SI
;
; FGetlStk-	Pointer to file variable is on the top of stack.
; FGetlCS-	Pointer to file variable follows in the code stream.

		public	$fGetlStk
$FGetlStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]	;Get ptr to file variable.
		call	$fgetl

		pop	si
		pop	fs
		pop	bp
		ret	4
$FGetlStk	endp

		public	$fGetlCS
$fgetlCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fgetl

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fgetlCS	endp



		public	$fGetl
$fgetl		proc	far

		call	SkipSpaces

; Check for a minus sign.

		call	$fpeekc
		cmp	al, '-'
		jne	DoGetL
		call	$fgetc			;Remove "-" from buffer.

; Handle negative numbers.

		call	DoConvert
		jc	WasError		;Check error return from DoConvert.
		cmp	eax, 80000000h		;See if too big for signed value.
		ja	Overflow
		neg	eax			;Okay, negate result.
		clc
		ret
		
DoGetL:		call	DoConvert
		jc	WasError
		test	eax, eax		;If sign bit is set, we have
		js	Overflow		; an overflow condition.
		clc
		ret

; If an overflow error occured, see if we can raise an exception.

Overflow:	call	$GetXEnabled
		cmp	ax, 0
		je	WasError
		mov	ax, $Overflow
		call	$Raise

; If exceptions are not active, just return the error status
; in the carry flag.

WasError:	stc
		ret
$FGetl		endp







; Getul-	Just like getl except this routine returns an unsigned value in EAX.
;		Pointer to file variable is in FS:SI
;
; FGetulStk-	Pointer to file variable is on the top of stack.
; FGetulCS-	Pointer to file variable follows in the code stream.

		public	$fGetulStk
$FGetulStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]	;Get ptr to file variable.
		call	$fgetul

		pop	si
		pop	fs
		pop	bp
		ret	4
$FGetulStk	endp

		public	$fGetulCS
$fgetulCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, es:[di]	;Get ptr to fv.
		call	$fgetul

		add	wp [bp+2], 4	;Skip over parameter.

		pop	si
		pop	fs
		pop	bp
		ret
$fgetulCS	endp



		public	$fGetul
$fgetul		proc	far
		call	SkipSpaces
		call	DoConvert
		ret
$fGetul		endp



; DoConvert-	Does the actual ASCII->unsigned integer conversion.
;		FS:SI must point at a file variable.

DoConvert	proc	near
		push	ecx
		push	ebx
		push	edx

		call	$GetTermCh
		mov	TermChar, al
		xor	ecx, ecx
		xor	eax, eax
		mov	ebx, 10


; Read the first character and make sure we don't hit EOF, have a file
; I/O error, and we need to make sure it is a decimal digit too.
; Note: no need to try to raise an exception on EOF or File I/O error.
; If these exceptions occured and exceptions were active, GETC would
; have raised these exceptions.

		call	$fgetc
		jc	ConvertErr	;If file I/O error

; Sneaky code!  XORing a value in the range '0'..'9' produces a value
; in the range 0..9 and transforms all other characters to values 10 and
; above.  This code sequence takes advantage of this fact.

		xor	al, '0'
		cmp	al, 10
		jae	IllegalChars

		mov	cl, al			;ECX = value of first digit.
		
ConvertULp:	call	$fgetc			;Read the next character
		jc	ConvertErr		;Bail if GETC returns an error.

		mov	LastChar, al		;Save for "_" check.
		cmp	al, "_"			;If "_", ignore this character.
		je	ConvertULp

		mov	ah, 0			;AH=1 (no EOF) at this point.
		xor	al, '0'
		cmp	al, 10			;If not "_", is it a digit?
		jae	NumDone			;JAE = JNC

; We are about to multiply the value in ECX by 10.  Make sure we can do this
; and not have an arithmetic overflow.

		cmp	ecx, 429496729		;2**32/10
		ja	Overflow

		xchg	eax, ecx
		mul	ebx			;Multiply partial product by 10.
		add	eax, ecx		;Add in current digit.
		xchg	eax, ecx
		jnc	ConvertULp

; Come down here if overflow occurs.

OverFlow:	call	$GetXEnabled
		cmp	ax, 0
		je	ConvertErr
		mov	ax, $Overflow
		call	$Raise

; Come down here if there is a conversion error.

IllegalChars:	call	$GetXEnabled
		cmp	ax, 0
		je	ConvertErr
		mov	ax, $Conversion
		call	$Raise


; ConvertErr- 	Exceptions are off and an error occured.  just return
;		with the carry flag set.

ConvertErr:	stc
		pop	edx
		pop	ebx
		pop	ecx
		ret

; Okay, everything was fine up until we encountered a character that
; was not a decimal digit or an "_" character.  Make sure we've ended
; on a legal whitespace character or a comma and that the last character
; in the number was not an underscore.

NumDone:	xor	al, '0'			;Make the following code readable.
		cmp	al, ' '			;Check for whitespace
		jbe	NumOkay

		cmp	al, TermChar		;See if a legal termination
		je	NumOkay			; character.

		cmp	al, ','
		jne	IllegalChars

NumOkay:	mov	eax, ecx		;Return the value in EAX.
		pop	edx
		pop	ebx
		pop	ecx
		clc
		ret
DoConvert	endp



; SkipSpaces-	Skips all spaces in the file specified by FS:SI.


SkipSpaces	proc	near
		jmp	EnterLp
SkipSpcLp:	call	$fgetc
EnterLp:	call	$fpeekc
		cmp	al, ' '
		je	SkipSpcLp
		ret
SkipSpaces	endp

$segSTDIO	ends
		end
