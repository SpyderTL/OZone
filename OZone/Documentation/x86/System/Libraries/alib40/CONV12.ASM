	page	66,132
;******************************** CONV12.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
;DEC_STR3_TO_WORD -  convert signed asciiz string to binary word
;
; inputs  ds:si points	at string ending with zero
; 
; output  bx = binary value
;	   si = updated to point at end of value
;	   al = zero if success
;* * * * * * * * * * * * * *

str_sign	db	0

	extrn	ten:word
	public	DEC_STR3_TO_WORD
DEC_STR3_TO_WORD	proc	far
	push	dx
	cld
	mov	bx,0
	mov	cs:str_sign,0
ab5:	lodsb
	cmp	al,' '
	je	ab5			;remove leading spaces
	cmp	al,'+'
	je	ab6			;jmp if sign found
	cmp	al,'-'
	jne	ab7
	mov	cs:str_sign,1		;set sign negative
ab6:	lodsb				;get next char

ab7:	or	al,al
	jz	ab3_done
	sub	al,'0'
	js	ab3_done		;jmp if error, not number
	cmp	al,9
	ja	ab3_done		;jmp if error, not number

	sub	ah,ah
	push	ax			;save current char

	mov	ax,bx			;get running sum
	mul	cs:ten
	pop	dx			;get current char
	add	ax,dx
	mov	bx,ax			;save running sum
	lodsb
	jmp	ab7			;loop till done

ab3_done:
	cmp	str_sign,0		;is result +
	je	ab3_done2		;jmp if + number
	neg	bx
ab3_done2:	
	pop	dx
	retf		
		
DEC_STR3_TO_WORD	endp

LIBSEG	ENDS
	end
	
