		include	char.a

		echo	IsALNumTOS 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsAlNumTOS-
;		Checks a character to see if it is alphanumeric.
;		Returns the status in the zero flag.
;		ZF=1 if character is in the set 
;			{'0'..'9', 'A'..'Z', 'a'..'z'}
;		ZF=0 if the character is not in this set.
;	
; 		The character to check is in the L.O. byte of the
;		word passed as a parameter on the TOS.  On return,
;		this function pops that parameter off the stack.
;
; Typical Calling Sequence:
;
;		push	word ptr CharToTest	;Ignores H.O. byte
;		call	$IsAlNumTOS
;		je	IsAlphaNumeric
;
;
;		push	bx
;		call	$IsAlNumTOS
;		jne	BXNotAN
 

		public	$IsAlNumTOS
$IsAlNumTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	al, [bp+6]	;Get the character to test.

		cmp	al, '0'		;See if in the range '0'..'9'.
		jb	NotAN
		cmp	al, '9'
		jbe	IsAN

		or	al, 20h		;Convert UC -> LC
		sub	al, 'a'		;Convert 'a'..'z' -> 0..25
		cmp	al, 'z'-'a'	;Is alpha if 25 or less.
		jnbe	NotAN

; Note: if the code above branches to "NotAN" the zero flag is
; guaranteed to be clear.  But if we branch (or fall through) to
; IsAN, we must explicitly set the zero flag.

IsAN:		cmp	al, al
NotAN:		pop	ax
		pop	bp
		ret	2		;Remove parameter from stack.
$IsAlNumTOS	endp
ucrlib		ends
		end
