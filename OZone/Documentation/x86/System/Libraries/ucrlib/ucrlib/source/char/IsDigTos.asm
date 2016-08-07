		include	char.a

		echo	IsDigitTOS

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsDigitTOS- 	Checks a character to see if it is a decimal digit.
;		The character to test appears in the L.O. byte of the
;		word on the TOS.
;
;	On Return:
;
;		ZF=1 if this is a decimal digit character.
;		ZF=0 if it is not a digit.
;
;
;	Automatically removes the parameter from the stack.

		public	$IsDigitTOS
$IsDigitTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	al, [bp+6]	;Fetch character to test.

; Note that the following code guarantees that the zero flag is
; clear if the code *branches* to location NotDigit.
; We have to explicitly set the zero flag if we've got a digit.

		cmp	al, '0'
		jb	NotDigit
		cmp	al, '9'
		ja	NotDigit
		cmp	al, al		;Sets zero flag.
NotDigit:	
		pop	ax
		pop	bp
		ret	2		;Remove word on TOS.
$IsDigitTOS	endp
ucrlib		ends
		end
