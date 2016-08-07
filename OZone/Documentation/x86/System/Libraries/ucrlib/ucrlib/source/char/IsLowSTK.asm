		include	char.a

		echo	IsLowerStk

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsLower- 	Checks to see if a character is lower case.
;
;	Returns:
;
;		ZF=1 if the character is a lower case alphabetic character.
;		ZF=0 if it is not lower case.
;
;		This routine expects a pointer to the character to test
;		on the top of the stack.
;
; Typical Calling Sequence
;
;	pshadrs	CharToTest
;	call	$IsLowerStk
;	je	IsLowerCase



		public	$IsLowerStk
$IsLowerStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]		;Get ptr to char
		mov	al, [si]		;Get the char.

		cmp	al, 'a'			;See if the character
		jb	NotLower		; is lower case.
		cmp	al, 'z'
		ja	IsLow
IsLow:		cmp	al, al			;Sets zero flag
NotLower:					;If LC, zero flag is clear
		pop	ax			; by default.
		pop	si
		pop	ds
		pop	bp
		ret	4			;Remove ptr from stack.
$IsLowerStk	endp
ucrlib		ends
		end
