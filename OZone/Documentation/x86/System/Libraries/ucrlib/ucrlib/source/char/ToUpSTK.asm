		include	char.a

		echo	ToUpperStk 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing




; ToUpperStk-
;
;	Converts lower case ASCII characters to upper case.
;	If the character is not a lower case character, this
;	routine leaves it unchanged.
;
;	The TOS contains a far pointer to a character.  This
;	routine converts that character (if necessary) and stores
;	the result back to its original location.
;
; Typical Calling Sequence:
;
;	pshadrs	CharToConvert
;	call	$ToUpperStk


		public	$ToUpperStk
$ToUpperStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]	;Get pointer to character.
		mov	al, [si]	;Fetch the char to convert.
		cmp	al, 'a'		;See if we've got a
		jb	NotLower	; lower case character
		cmp	al, 'z'		; to convert.
		ja	NotLower
		and	al, 5fh		;Convert lc -> UC.
NotLower:
		mov	[si], al	;Store result.

		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4		;Remove ptr from stack.
$ToUpperStk	endp
ucrlib		ends
		end
