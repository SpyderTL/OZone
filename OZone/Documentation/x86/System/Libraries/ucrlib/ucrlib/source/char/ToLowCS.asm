		include	char.a

		echo	ToLowerCS

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing



; ToLowerCS-
;
;	Converts upper case ASCII characters to lower case.
;	If the character is not an upper case character, this
;	routine leaves it unchanged.
;
;	A far pointer to the character to convert follows in
;	the code stream.
;
; Typical Calling Sequence:
;
;	call	$ToLowerCS
;	dword	CharToConvert


		public	$ToLowerCS
$ToLowerCS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		add	word ptr [bp+2], 4	;Skip ptr to char.
		lds	si, [si]		;Get ptr to char.
		mov	al, [si]		;Get the char.

		cmp	al, 'A'			;See if it's an upper
		jb	NotUpper		; case character.
		cmp	al, 'Z'
		ja	NotUpper
		and	al, 5fh			;Convert UC -> lc.
NotUpper:	mov	[si], al		;Store the character.

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$ToLowerCS	endp
ucrlib		ends
		end
