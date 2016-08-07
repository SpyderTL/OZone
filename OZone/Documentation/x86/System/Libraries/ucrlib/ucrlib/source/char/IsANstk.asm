		include	char.a

		echo	IsALNum 

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsAlNumStk-
;		Checks a character to see if it is alphanumeric.
;		Returns the status in the zero flag.
;		ZF=1 if character is in the set 
;			{'0'..'9', 'A'..'Z', 'a'..'z'}
;		ZF=0 if the character is not in this set.
;	
;		Far pointer to character is on the TOS.
;		Code removes the pointer upon return.
;
; Typical Calling Sequence:
;
;		pshadrs	CharToTest
;		call	$IsAlNumStk



		public	$IsAlNum
		public	$IsAlNumStk
$IsAlNumStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]	;Get the ptr to the char.
		mov	al, [si]	;Fetch the char.

		cmp	al, '0'		;See if in the range '0'..'9'.
		jb	NotAN
		cmp	al, '9'
		jbe	IsAN

		or	al, 20h		;Convert UC -> LC
		sub	al, 'a'		;Convert 'a'..'z' -> 0..25
		cmp	al, 'z'-'a'	;Is alpha if 25 or less.
		jnbe	NotAN

; Note: If the code above branches the "NotAN" the zero flag is
; guaranteed to be clear.  But if it branches or falls through
; to "IsAN" we have to explicitly set the zero flag.

IsAN:		cmp	al, al
NotAN:		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4		;Removes ptr from the stack.
$IsAlNumStk	endp
ucrlib		ends
		end
