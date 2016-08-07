		.386
		option	segment:use16, proc:private

		include	strings.a

                echo    StrChr, StrChrStk
	

$SegStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; StrChr -      Returns the position of a single character in a string.
;
; inputs:
;		al- character to search for.
;		es:di- address of string.
;
; returns: 
;		cx- position of character in string (if present).
;		carry=0 if character found.
;		carry=1 if character is not present in string.
;
; StrChrStk -   Address of string to search is passed on the stack.


$StrChr         proc    far
		pushf
		push	ds
		push	si
		push	ax
		cld

		mov	si, es		;Setup ds:si to use LODSB
		mov	ds, si
		mov	si, di

		mov	ah, al		;ah=char to search for.
StrChrlp:       lodsb
		cmp	al, ah
		jz	FndChr
		cmp	al, 0
                jne     StrChrlp

		xor	cx, cx
		pop	ax
		pop	si
		pop	ds
		popf
		stc
		ret

FndChr:		pop	ax
		mov	cx, si
		sub	cx, di
		dec	cx
		pop	si
		pop	ds
		popf
		clc
		ret
$StrChr endp


$StrChrStk      proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+6]
                call    $StrChr

		pop	di
		pop	es
		ret	4
$StrChrStk      endp


$SegStrings	ends
		end
