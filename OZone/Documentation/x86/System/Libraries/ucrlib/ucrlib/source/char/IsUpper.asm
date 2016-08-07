		include	char.a

		echo	IsUpper

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing



; IsUpper- 	Checks to see if a character is upper case.
;
;	Returns:
;
;		ZF=1 if the character is upper case.
;		ZF=0 if the character is not lower case.
;
;		Tests the character passed in the AL register.
;
;
; Typical Calling Sequence
;
;	mov	al, CharToTest
;	call	$IsUpper
;	je	IsAnUpperCase



		public	$IsUpper
$IsUpper	proc	far
		cmp	al, 'A'			;Check to see if this is UC.
		jb	NotUpper		;Note that if we branch to
		cmp	al, 'Z'			; the NotUpper label, the zero
		ja	NotUpper		; flag is automatically cleared.
IsUp:		cmp	al, al			;Sets zero flag
NotUpper:	ret
$IsUpper	endp
ucrlib		ends
		end
