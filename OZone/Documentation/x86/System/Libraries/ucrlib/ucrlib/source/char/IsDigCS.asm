		include	char.a

		echo	IsDigitCS

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsDigitCS- 	Checks a character to see if it is a decimal digit.
;		Far pointer to character immediately follows the
;		call in the code stream.
;
;	On Return:
;
;		ZF=1 if this is a decimal digit character.
;		ZF=0 if it is not a digit.
;
;
;	Automatically skips over the far address in the code stream.


		public	$IsDigitCS
$IsDigitCS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		add	word ptr [bp+2], 4	;Skip ptr to char.
		lds	si, [si]		;Get ptr to char.
		mov	al, [si]		;Get the char.

; Note that the following code guarantees that the zero flag is
; clear if the code *branches* to location NotDigit.
; We have to explicitly set the zero flag if we've got a digit.

		cmp	al, '0'			;See if it's a digit.
		jb	NotDigit
		cmp	al, '9'
		ja	NotDigit
		cmp	al, al			;Sets zero flag.
NotDigit:	

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$IsDigitCS	endp
ucrlib		ends
		end
