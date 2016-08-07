		include	char.a

		echo	IsAlphaCS

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsAlphaCS- 	Checks to see if a character is alphabetic.
;
;	Returns:
;
;		ZF = 1 if the character is alphabetic.
;		ZF = 0 if the character is not alphabetic.
;
;		This routine expects a pointer to a character
;		variable.  The pointer must immediately follow
;		the call in the code stream.
;
; Typical Calling Sequence:
;
;	call	$IsAlphaCS
;	dword	CharToTest



		public	$IsAlphaCS
$IsAlphaCS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		add	word ptr [bp+2], 4	;Skip ptr to char.
		lds	si, [si]		;Get ptr to char.
		mov	al, [si]		;Get the char.

		or	al, 20h			;maps UC -> LC.
		sub	al, 'a'			;maps 'a'..'z' -> 0..25.
		cmp	al, 'z'-'a'		;If al > 25 then it's not alpha.
		ja	NotAlpha

; Note: If the code above branches to "NotAlpha" then the zero flag
; is guaranteed to be clear and we don't have to do anything about it.
; If we fall through to "IsAl" then we have to explicitly set the
; zero flag.

IsAl:		cmp	al, al		;Sets zero flag
NotAlpha:	
		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$IsAlphaCS	endp
ucrlib		ends
		end
