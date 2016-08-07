		include	char.a

		echo	IsALNum 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsAlNum-
;		Checks a character to see if it is alphanumeric.
;		Returns the status in the zero flag.
;		ZF=1 if character is in the set 
;			{'0'..'9', 'A'..'Z', 'a'..'z'}
;		ZF=0 if the character is not in this set.
;	
; 		Checks the character passed in the AL register.


		public	$IsAlNum
$IsAlNum	proc	far

		cmp	al, '0'		;See if in the range '0'..'9'.
		jb	NotAN
		cmp	al, '9'
		jbe	IsAN

		push	ax
		or	al, 20h		;Convert UC -> LC
		sub	al, 'a'		;Convert 'a'..'z' -> 0..25
		cmp	al, 'z'-'a'	;Is alpha if 25 or less.
		pop	ax
		jnbe	NotAN

; Down here, we've got an alphanumeric character.  Set the
; zero flag and return to the caller.

IsAN:		cmp	al, al

; If we branch down to this point, then the character is *not*
; an alphanumeric character.  Furthermore, you will notice that
; the zero flag is always clear if we branch to this point.

NotAN:		ret
$IsAlNum	endp
ucrlib		ends
		end
