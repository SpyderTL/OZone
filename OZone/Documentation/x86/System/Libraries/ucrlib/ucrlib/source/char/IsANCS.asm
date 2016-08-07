		include	char.a

		echo	IsALNumCS

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsAlNumCS-
;		Checks a character to see if it is alphanumeric.
;		Returns the status in the zero flag.
;		ZF=1 if character is in the set 
;			{'0'..'9', 'A'..'Z', 'a'..'z'}
;		ZF=0 if the character is not in this set.
;	
;		Far pointer to character to test follows call.
;
;
; Typical Calling Sequence:
;
;		call	$IsAlNumCS
;		dword	CharToTest



		public	$IsAlNumCS
$IsAlNumCS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		add	word ptr [bp+2], 4	;Skip ptr to char on return.
		lds	si, [si]		;Get ptr to char.
		mov	al, [si]		;Get the char.

		cmp	al, '0'			;See if in the range '0'..'9'.
		jb	NotAN
		cmp	al, '9'
		jbe	IsAN

		or	al, 20h			;Convert UC -> LC
		sub	al, 'a'			;Convert 'a'..'z' -> 0..25
		cmp	al, 'z'-'a'		;Is alpha if 25 or less.
		jnbe	NotAN

IsAN:		cmp	al, al
NotAN:		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$IsAlNumCS	endp
ucrlib		ends
		end
