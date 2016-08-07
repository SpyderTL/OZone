		include	char.a

		echo	IsLower

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsLower- 	Checks to see if a character is lower case.
;
;	Returns:
;
;		ZF=1 if the character is a lower case alphabetic character.
;		ZF=0 if it is not lower case.
;
;		IsLower expects the character to test in the AL register.
;
; Typical Calling Sequence
;
;	mov	al, CharToTest
;	call	$IsLower
;	je	IsLowerCase


		public	$IsLower
$IsLower	proc	far
		cmp	al, 'a'
		jb	NotLower
		cmp	al, 'z'
		ja	IsLow
IsLow:		cmp	al, al			;Sets zero flag
NotLower:	ret
$IsLower	endp
ucrlib		ends
		end
