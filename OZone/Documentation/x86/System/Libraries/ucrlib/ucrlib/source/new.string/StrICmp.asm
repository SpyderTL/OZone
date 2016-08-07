		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrICmp, StrICmpcsi
	

$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; stricmp -	Compares two strings, ignoring differences in case.
;
; inputs:
;		es:di-	First string (The string to compare)
;		fs:si-	Second string (The string to compare against)
;
;		e.g. "if (es:di < dx:si) then ..."
; returns: 
;		cx - index into strings where they differ (points at the
;		zero byte if the two strings are equal).
; 
;		Condition codes set according to the string comparison.
;		You should use the unsigned branches (ja, jb, je, etc.)
;		after calling this routine.
;
; StrICmpcsi -	Second string is passed in the code stream.
;
; StrICmpStk -	The addresses of both strings are passed on the stack.


$StrICmp	proc	far
		push	es
		push	ds
		push	bx
		push	ax
		push	si
		push	di

		xchg	di, si
		push	es
		pop	ds
		push	fs
		pop	es

		xor	cx, cx		;Set initial index to zero.
		lea	bx, stdgrp:$uprtbl

; In order to preserve the direction flag across this call, we have to
; test whether or not it is set here and execute two completely separate
; pieces of code (so we know which state to exit in.  Unfortunately, we
; cannot use pushf to preserve this flag since we need to return status
; info in the other flags.

		pushf
		pop	ax
		test	ah, 4		;Test direction bit.
		jnz	DirIsSet
sclp:		lodsb
		xlat	StdGrp:$uprtbl
		mov	ah, al
		mov	al, es:[di]
		xlat	StdGrp:$uprtbl
		cmp	ah, al
		jne	scNE		;If strings are <>, quit.
		inc	cx	        ;Increment index into strs.
		inc	di		;Incrment str2 ptr.
		cmp	al, 0		;Check for end of strings.
		jne	sclp
		pushf
		dec	cx
		popf

scNE:		pop	di
		pop	si
		pop	ax
		pop	bx
		pop	ds
		pop	es
		ret			;Return with direction flag clear.

DirIsSet:	lodsb
		xlat	StdGrp:$uprtbl
		mov	ah, al
		mov	al, es:[di]
		xlat	StdGrp:$uprtbl
		cmp	ah, al
		jne	scNE2		 ;If strings are <>, quit.
		inc	cx
		inc	di
		cmp	al, 0		 ;Check for end of strings.
		jne	DirIsSet
		pushf
		dec	cx
		popf

scNE2:		pop	di
		pop	si
		pop	ax
		pop	bx
		pop	ds
		pop	es
		std			;Return with direction flag set.
                ret
$StrICmp	endp


$StrICmpcsi	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	ds
		push	ax
		push	bx
		push	si
		push	di
		mov	ax, es
		mov	ds, ax
		mov	si, di

		les	di, [bp+2]
		lea	bx, stdgrp:$uprtbl

; In order to preserve the direction flag across this call, we have to
; test whether or not it is set here and execute two completely separate
; pieces of code (so we know which state to exit in.  Unfortunately, we
; cannot use pushf to preserve this flag since we need to return status
; info in the other flags.

		pushf
		pop	ax
		test	ah, 4		;Test direction bit.
		jnz	DirIsSet

; Compute the length of the string following the CALL instruction:

		cld
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
		xchg	di, [bp+2]	;Save as new return address.

		xor	cx, cx		;Set char index to zero.
sclp:		lodsb
		xlat	StdGrp:$uprtbl
		mov	ah, al
		mov	al, es:[di]
		xlat	StdGrp:$uprtbl
		cmp	ah, al
		jne	scNE		;If strings are <>, quit.
		inc	cx	        ;Increment index into strs.
		inc	di		;Increment str2 ptr.
		cmp	al, 0		;Check for end of strings.
		jne	sclp
		pushf
		dec	cx
		popf

scNE:		pop	di
		pop	si
		pop	bx
		pop	ax
		pop	ds
		pop	es
		pop	bp
		ret			;Return with direction flag clear.


DirIsSet:	cld
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
		xchg	di, [bp+2]	;Save as new return address.

		xor	cx, cx		;Set char index to zero.
sclp2:		lodsb
		xlat	StdGrp:$uprtbl
		mov	ah, al
		mov	al, es:[di]
		xlat	StdGrp:$uprtbl
		cmp	ah, al		
		jne	scNE2		;If strings are <>, quit.
		inc	cx	        ;Increment index into strs.
		inc	di		;Incrment str2 ptr.
		cmp	al, 0		;Check for end of strings.
		jne	sclp2
		pushf
		dec	cx
		popf

scNE2:		mov	ax, cx
		pop	di
		pop	si
		pop	bx
		pop	ax
		pop	ds
		pop	es
		pop	bp
		std
		ret			;Return with direction flag set.
$StrICmpcsi	endp


$StrICmpStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	si
		push	di

		les	di, [bp+6]
		lfs	si, [bp+10]
		call	$StrICmp

		pop	di
		pop	si
		pop	fs
		pop	es
		pop	bp
		ret	8
$StrICmpStk	endp


stdlib		ends
		end
