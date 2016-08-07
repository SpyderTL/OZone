		include	char.a

		echo	ToLower

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing



; ToLower-
;
;	Converts upper case ASCII characters to lower case.
;	If the character is not an upper case character, this
;	routine leaves it unchanged.
;
;	AL contains the character to convert to lower case.
;	It returns the converted character in AL.
;
; Typical Calling Sequence:
;
;	mov	al, CharToConvert
;	call	$ToLower
;	mov	ConvertedChar, al


		public	$ToLower
$ToLower	proc	far
		cmp	al, 'A'			;See if it's an upper
		jb	NotUpper		; case character.
		cmp	al, 'Z'
		ja	NotUpper
		and	al, 5fh			;Convert UC -> lc.
NotUpper:	ret
$ToLower	endp
ucrlib		ends
		end
