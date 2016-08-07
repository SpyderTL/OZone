		include	char.a

		echo	IsUpperCS

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing



; IsUpperCS- 	Checks to see if a character is upper case.
;
;	Returns:
;
;		ZF=1 if the character is upper case.
;		ZF=0 if the character is not lower case.
;
;		A pointer to the character to test follows in
;		the code stream.
;
;
; Typical Calling Sequence
;
;	call	$IsUpperCS
;	dword	CharToTest
;	je	IsAnUpperCase



		public	$IsUpperCS
$IsUpperCS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	al, [si]		;Get the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		cmp	al, 'A'			;Check to see if this is UC.
		jb	NotUpper		;Note that if we branch to
		cmp	al, 'Z'			; the NotUpper label, the zero
		ja	NotUpper		; flag is automatically cleared.
IsUp:		cmp	al, al			;Sets zero flag
NotUpper:
		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$IsUpperCS	endp
ucrlib		ends
		end
