		include	char.a

		echo	IsUpperTOS

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing



; IsUpperTOS- 	Checks to see if a character is upper case.
;
;	Returns:
;
;		ZF=1 if the character is upper case.
;		ZF=0 if the character is not lower case.
;
;		Tests the character passed in the L.O. byte of the
;		word pushed on the stack before the call.
;
;
; Typical Calling Sequence
;
;	push	word ptr CharToTest	;Ignores H.O. byte
;	call	$IsUpperTOS
;	je	IsAnUpperCase




		public	$IsUpperTOS
$IsUpperTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	al, [bp+6]		;Get the char.

		cmp	al, 'A'			;Check to see if this is UC.
		jb	NotUpper		;Note that if we branch to
		cmp	al, 'Z'			; the NotUpper label, the zero
		ja	NotUpper		; flag is automatically cleared.
IsUp:		cmp	al, al			;Sets zero flag
NotUpper:
		pop	ax
		pop	bp
		ret	2			;Remove parameter from stack.
$IsUpperTOS	endp
ucrlib		ends
		end
