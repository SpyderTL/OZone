		include	char.a

		echo	ToLowerStk

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing



; ToLowerStk-
;
;	Converts upper case ASCII characters to lower case.
;	If the character is not an upper case character, this
;	routine leaves it unchanged.
;
;	The TOS contains a far pointer to the character to convert.
;	This code fetches that character, converts it to lower case
;	(if applicable) and then stores the character back to its
;	original location.
;
;	This routine removes the pointer from the stack upon returning.
;
; Typical Calling Sequence:
;
;	lesi	CharToConvert
;	call	$ToLowerStk


		public	$ToLowerStk
$ToLowerStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]	;Get ptr to the character.
		mov	al, [si]	;Fetch the character.
		cmp	al, 'A'		;See if it's an upper
		jb	NotUpper	; case character.
		cmp	al, 'Z'
		ja	NotUpper
		and	al, 5fh		;Convert UC -> lc.
NotUpper:	mov	[si], al	;Store result.

		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4		;Remove ptr from stack.
$ToLowerStk	endp
ucrlib		ends
		end
