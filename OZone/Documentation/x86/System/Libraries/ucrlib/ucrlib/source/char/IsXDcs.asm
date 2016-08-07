		include	char.a

		echo	IsXDigitCS 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsxDigitCS- 	Checks a character to see if it is a hex digit 
;			{'0'..'9', 'A'..'F', 'a'..'f'}.
;
;		A far pointer to the character to test follows
;		the call in the code stream.
;
;	Returns:
;
;		ZF=1 if it is a hexadecimal character.
;		ZF=0 if it is not a hex character.
;
; Typical Calling Sequence:
;
;	call	$IsxDigitCS
;	dword	CharToTest
;	je	IsHexChar



		public	$IsXDigitCS
$IsXDigitCS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	al, [si]		;Get the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		sub	al, '0'		;'0'..'9' -> 0..9
		cmp	al, 9
		jbe	IsX

		and	al, 0dfh	;lc -> UC.
		sub	al, 'A'-'0'	;'A'..'Z' -> 0..25
		cmp	al, 'Z'-'0'
		ja	NotX

; If we branch or fall through to "IsX" then we have no idea
; what the state of the zero flag is.  We must explicitly set
; it.  However, if we branch to "NotX" then we know that the
; zero flag is clear.

IsX:		cmp	al, al		;Sets zero flag
NotX:	
		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$IsXDigitCS	endp
ucrlib		ends
		end
