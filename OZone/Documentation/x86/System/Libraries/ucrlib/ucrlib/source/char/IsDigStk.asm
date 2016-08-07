		include	char.a

		echo	IsDigitStk

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsDigitStk- 	Checks a character to see if it is a decimal digit.
;		A far pointer to the character to test appears on
;		the top of the stack.
;
;	On Return:
;
;		ZF=1 if this is a decimal digit character.
;		ZF=0 if it is not a digit.
;
;
;	Automatically removes the parameter from the stack.

		public	$IsDigitStk
$IsDigitStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]	;Fetch pointer to character.
		mov	al, [si]	;Fetch the character.

; Note that the following code guarantees that the zero flag is
; clear if the code *branches* to location NotDigit.
; We have to explicitly set the zero flag if we've got a digit.

		cmp	al, '0'		;See if it is numeric.
		jb	NotDigit
		cmp	al, '9'
		ja	NotDigit
		cmp	al, al		;Sets zero flag.
NotDigit:	
		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4		;Remove ptr from stack.
$IsDigitStk	endp
ucrlib		ends
		end
