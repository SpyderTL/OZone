		include	char.a

		echo	IsUpperSTK

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing



; IsUpperSTK- 	Checks to see if a character is upper case.
;
;	Returns:
;
;		ZF=1 if the character is upper case.
;		ZF=0 if the character is not lower case.
;
;		A far pointer to the character appears on the TOS.
;
;
; Typical Calling Sequence
;
;	pshadrs	CharToTest
;	call	$IsUpperSTK
;	je	IsAnUpperCase



		public	$IsUpperStk
$IsUpperStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]		;Get ptr to char
		mov	al, [si]		;Get the char.

		cmp	al, 'A'			;Check to see if this is UC.
		jb	NotUpper		;Note that if we branch to
		cmp	al, 'Z'			; the NotUpper label, the zero
		ja	NotUpper		; flag is automatically cleared.
IsUp:		cmp	al, al			;Sets zero flag
NotUpper:
		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4			;Remove pointer from stack.
$IsUpperStk	endp
ucrlib		ends
		end
