		include	char.a

		echo	IsLowerTOS

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsLower- 	Checks to see if a character is lower case.
;
;	Returns:
;
;		ZF=1 if the character is a lower case alphabetic character.
;		ZF=0 if it is not lower case.
;
;		This routine expects the character to test in the L.O. byte
;		of the word appearing on TOS.
;
; Typical Calling Sequence
;
;	push	word ptr CharToTest	;Ignores H.O. byte
;	call	$IsLowerTOS
;	je	IsLowerCase
;
;	push	bx
;	call	$IsLowerTOS
;	je	AnotherLC



		public	$IsLowerTOS
$IsLowerTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax

		mov	al, [bp+6]		;Get the char.
		cmp	al, 'a'			;See if it is
		jb	NotLower		; lowercase.
		cmp	al, 'z'
		ja	IsLow
IsLow:		cmp	al, al			;Sets zero flag if lower case.
NotLower:					;ZF automatically clear if
		pop	ax			; not lower case.
		pop	bp
		ret	2			;Remove parameter from stack.
$IsLowerTOS	endp
ucrlib		ends
		end
