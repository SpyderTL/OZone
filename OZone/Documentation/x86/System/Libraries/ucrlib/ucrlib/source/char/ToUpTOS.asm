		include	char.a

		echo	ToUpperTOS 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing




; ToUpperTOS-
;
;	Converts lower case ASCII characters to upper case.
;	If the character is not a lower case character, this
;	routine leaves it unchanged.
;
;	The L.O. byte of the TOS contains the character to convert.
;	This routine converts it to upper case (if necessary) and then
;	leaves the result on the TOS upon return.
;
; Typical Calling Sequence:
;
;	push	word ptr CharToConvert	;Ignores H.O. byte
;	call	$ToUpperTOS
;	pop	ax
;	mov	ConvertedChar, al


		public	$ToUpperTOS
		public	$ToUpperTOS
$ToUpperTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	al, [bp+6]	;Get char to convert from stack.

		cmp	al, 'a'		;See if we've got a
		jb	NotLower	; lower case character
		cmp	al, 'z'		; to convert.
		ja	NotLower
		and	al, 5fh		;Convert lc -> UC.
NotLower:
		mov	[bp+6], al	;Save result back on TOS.

		pop	ax
		pop	bp
		ret
$ToUpperTOS	endp
ucrlib		ends
		end
