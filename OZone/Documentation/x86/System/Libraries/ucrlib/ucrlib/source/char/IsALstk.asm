		include	char.a

		echo	IsAlphaStk 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsAlphaStk- 	Checks to see if a character is alphabetic.
;
;	Returns:
;
;		ZF = 1 if the character is alphabetic.
;		ZF = 0 if the character is not alphabetic.
;
;		This routine expects the (far) address of a character
;		variable on the TOS.  It fetches and tests that character
;		to see if it is alphabetic.  On return, this procedure
;		removes the pointer from the stack.
;
; Typical Calling Sequence:
;
;	pshadrs	CharToTest
;	call	$IsAlphaStk




		public	$IsAlphaStk
$IsAlphaStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]	;Get ptr to char
		mov	al, [si]	;Get the char.

		or	al, 20h		;maps UC -> LC.
		sub	al, 'a'		;maps 'a'..'z' -> 0..25.
		cmp	al, 'z'-'a'	;If al > 25 then it's not alpha.
		ja	NotAlpha

; Note: If the code above branches to "NotAlpha" then the zero flag
; is guaranteed to be clear and we don't have to do anything about it.
; If we fall through to "IsAl" then we have to explicitly set the
; zero flag.

IsAl:		cmp	al, al		;Sets zero flag
NotAlpha:	pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4		;Remove pointer from stk on return.
$IsAlphaStk	endp
ucrlib		ends
		end
