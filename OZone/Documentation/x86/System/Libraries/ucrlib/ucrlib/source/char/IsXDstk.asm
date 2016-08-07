		include	char.a

		echo	IsXDigitStk 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsxDigitStk- 	Checks a character to see if it is a hex digit 
;			{'0'..'9', 'A'..'F', 'a'..'f'}.
;
;		A far pointer to the character to test appears on
;		the top of the stack.
;
;	Returns:
;
;		ZF=1 if it is a hexadecimal character.
;		ZF=0 if it is not a hex character.
;
; Typical Calling Sequence:
;
;	pshadrs	CharToTest
;	call	$IsxDigitStk
;	je	IsHexChar


		public	$IsXDigitStk
$IsXDigitStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]
		mov	al, [si]

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
		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4
$IsXDigitStk	endp
ucrlib		ends
		end
