		include	char.a

		echo	ToUpper 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing




; ToUpper-
;
;	Converts lower case ASCII characters to upper case.
;	If the character is not a lower case character, this
;	routine leaves it unchanged.
;
;	The AL register contains the character to convert to upper case.
;	This function returns the converted character in AL.
;
; Typical Calling Sequence:
;
;	mov	al, CharToConvert
;	call	$ToUpper
;	mov	ConvertedChar, al


		public	$ToUpper
$ToUpper	proc	far
		cmp	al, 'a'			;See if we've got a
		jb	NotLower		; lower case character
		cmp	al, 'z'			; to convert.
		ja	NotLower
		and	al, 05fh		;Convert lc -> UC.
NotLower:	ret
$ToUpper	endp
ucrlib		ends
		end
