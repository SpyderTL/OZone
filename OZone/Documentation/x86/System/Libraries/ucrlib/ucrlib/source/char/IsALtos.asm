		include	char.a

		echo	IsAlphaTOS 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsAlphaTOS- 	Checks to see if a character is alphabetic.
;
;	Returns:
;
;		ZF = 1 if the character is alphabetic.
;		ZF = 0 if the character is not alphabetic.
;
;		This routine tests the character value passed in the
;		L.O. byte of the word on the TOS.
;
;		This function automatically removes the parameter from
;		the stack for the caller.
;
; Typical Calling Sequence:
;
;	push	word ptr CharToTest	;Ignores H.O. byte
;	call	$IsAlphaTOS
;
;	 .
;	 .
;	 .
;
;	push	bx
;	call	$IsAlphaTOS

		public	$IsAlphaTOS
$IsAlphaTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	al, [bp+6]	;Get the char.

		or	al, 20h		;maps UC -> LC.
		sub	al, 'a'		;maps 'a'..'z' -> 0..25.
		cmp	al, 'z'-'a'	;If al > 25 then it's not alpha.
		ja	NotAlpha

; Note: If the code above branches to "NotAlpha" then the zero flag
; is guaranteed to be clear and we don't have to do anything about it.
; If we fall through to "IsAl" then we have to explicitly set the
; zero flag.

IsAl:		cmp	al, al		;Sets zero flag
NotAlpha:	
		pop	ax
		pop	bp
		ret	2		;Remove parameter from stack.
$IsAlphaTOS	endp
ucrlib		ends
		end
