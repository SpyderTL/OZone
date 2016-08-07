		include	char.a

		echo	IsLowerCS

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsLower- 	Checks to see if a character is lower case.
;
;	Returns:
;
;		ZF=1 if the character is a lower case alphabetic character.
;		ZF=0 if it is not lower case.
;
;		A far pointer to the character to test follows the
;		call in the code stream.
;
; Typical Calling Sequence
;
;	call	$IsLower
;	dword	CharToTest
;	je	IsLowerCase


		public	$IsLowerCS
$IsLowerCS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	al, [si]		;Get the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		cmp	al, 'a'			;See if we have
		jb	NotLower		; a lower case
		cmp	al, 'z'			; character.
		ja	IsLow
IsLow:		cmp	al, al			;Sets zero flag if LC.
NotLower:					;ZF clear if not LC.
		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$IsLowerCS	endp
ucrlib		ends
		end
