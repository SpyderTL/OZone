		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	Strchr, StrchrStk
	

$SegStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; strcmp -	Compares two strings.
;
; inputs:
;		es:di -	First string  (The string to compare)
;		fs:si -	Second string (The string to compare against)
; 
;		e.g., "if (es:di < dx:si) then ..."
; returns: 
;
;		cx- index into strings where they differ (points at the
;		zero byte if the two strings are equal).
; 
;		Condition codes set according to the string comparison.
;		You should use the unsigned branches (ja, jb, je, etc.)
;		after calling this routine.
;
; Strcmpcsi -	Second string is passed in the code stream.
;
; StrcmpStk -	The addresses of both strings are passed on the stack.


$strcmp		proc	far
		push	es
		push	ds
		push	bx
		push	ax
		push	si
		push	di
;
; Swap pointers so they're more convenient for the LODSB/SCASB instrs.
;
		xchg	si, di
		push	es
		pop	ds
		push	fs
		pop	es

		xor	bx, bx		;Set initial index to zero.
;
; In order to preserve the direction flag across this call, we have to
; test whether or not it is set here and execute two completely separate
; pieces of code (so we know which state to exit in.  Unfortunately, we
; cannot use pushf to preserve this flag since we need to return status
; info in the other flags.
;
		pushf
		pop	ax
		test	ah, 4		;Test direction bit.
		jnz	DirIsSet
sclp:		lodsb
		scasb
		jne	scNE		;If strings are <>, quit.
		inc	bx	        ;Increment index into strs.
		cmp	al, 0		;Check for end of strings.
		jne	sclp
		pushf
		dec	bx
		popf
;
scNE:		pop	di
		pop	si
		mov	cx, bx
		pop	ax
		pop	bx
		pop	ds
		pop	es
		ret			;Return with direction flag clear.
;
;
DirIsSet:	lodsb
		scasb
		jne	scNE2		 ;If strings are <>, quit.
		inc	bx
		cmp	al, 0		 ;Check for end of strings.
		jne	DirIsSet
		pushf
		dec	bx
		popf
;
scNE2:		pop	di
		pop	si
		mov	cx, bx
		pop	ax
		pop	bx
		pop	ds
		pop	es
		std			;Return with direction flag set.
                ret
$strcmp		endp


$strcmpcsi	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	ds
		push	cx
		push	si
		push	di
		mov	ax, es
		mov	ds, ax
		mov	si, di
		les	di, [bp+2]
;
; In order to preserve the direction flag across this call, we have to
; test whether or not it is set here and execute two completely separate
; pieces of code (so we know which state to exit in.  Unfortunately, we
; cannot use pushf to preserve this flag since we need to return status
; info in the other flags.
;
		pushf
		pop	ax
		test	ah, 4		;Test direction bit.
		jnz	DirIsSet
;
; Compute the length of the string following the CALL instruction:
;
		cld
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
		xchg	di, 2[bp]	;Save as new return address.
		neg	cx
		dec	cx		;Length of string.
		mov	ax, cx
        repe	cmpsb			;Compare the two strings.
;
		pushf
		sub	ax, cx
		dec	ax
                popf
		pop	di
		pop	si
		pop	cx
		pop	ds
		pop	es
		pop	bp
		ret			;Return with direction flag clear.
;
;
DirIsSet:	cld
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
		xchg	di, 2[bp]	;Save as new return address.
		neg	cx
		dec	cx		;Length of string.
		mov	ax, cx
        repe	cmpsb			;Compare the two strings.
;
		pushf
		sub	ax, cx
		dec	ax
		popf
		pop	di
		pop	si
		pop	cx
		pop	ds
		pop	es
		pop	bp
		std
		ret			;Return with direction flag set.
$strcmpcsi	endp


$StrcmpStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	si
		push	di

		les	di, [bp+6]
		lfs	si, [bp+10]
		call	$Strcmp

		pop	di
		pop	si
		pop	fs
		pop	es
		pop	bp
		ret	8
$StrcmpStk	endp


$SegStrings	ends
		end
