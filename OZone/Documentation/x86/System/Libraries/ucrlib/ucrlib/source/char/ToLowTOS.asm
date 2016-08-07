		include	char.a

		echo	ToLowerTOS

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing



; ToLowerTOS-
;
;	Converts upper case ASCII characters to lower case.
;	If the character is not an upper case character, this
;	routine leaves it unchanged.
;
;	The L.O. byte of the word on TOS contains the character
;	to convert.  On return, this routine leaves that word
;	(containing the converted character) on the TOS.
;
; Typical Calling Sequence:
;
;	push	word ptr CharToConvert	;Ignores H.O. byte
;	call	$ToLower
;	pop	ax
;	mov	ConvertedChar, al


		public	$ToLowerTOS
$ToLowerTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	al, [bp+6]	;Get the char to convert.
		cmp	al, 'A'		;See if it's an upper
		jb	NotUpper	; case character.
		cmp	al, 'Z'
		ja	NotUpper
		and	al, 5fh		;Convert UC -> lc.
NotUpper:	mov	[bp+6], al	;Store back onto TOS.

		pop	ax
		pop	bp
		ret
$ToLowerTOS	endp
ucrlib		ends
		end
