		include	char.a

		echo	ToUpperCS 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing




; ToUpperCS-
;
;	Converts lower case ASCII characters to upper case.
;	If the character is not a lower case character, this
;	routine leaves it unchanged.
;
;	A far pointer to the character to convert follows the
;	call in the code stream.  This routine fetches that
;	character, converts it (if necessary), and stores the
;	character back to that location.
;
; Typical Calling Sequence:
;
;	call	$ToUpperCS
;	dword	CharToConvert


		public	$ToUpperCS
$ToUpperCS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	al, [si]		;Get the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		cmp	al, 'a'			;See if we've got a
		jb	NotLower		; lower case character
		cmp	al, 'z'			; to convert.
		ja	NotLower
		and	al, 5fh			;Convert lc -> UC.
NotLower:
		mov	[si], al		;Store the character.

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$ToUpperCS	endp
ucrlib		ends
		end
