	page	66,132
;******************************** CONV13.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
;DEC_STR4_TO_WORD -  convert signed ascii string to binary word
;
; inputs  ds:si = string pointer
;            cx = length of string
; 
; output  bx = binary value
;	   si = updated to point at end of value
;	   al = zero if success
;* * * * * * * * * * * * * *

str_sign	db	0
	extrn	ten:word
	public	DEC_STR4_TO_WORD
DEC_STR4_TO_WORD	proc	far
	push	dx
	cld
	mov	bx,0
	mov	cs:str_sign,0
ab8:	jcxz	ab4_done
	lodsb
	dec	cx
	cmp	al,' '
	je	ab8			;remove leading spaces
	cmp	al,'+'
	je	ab9			;jmp if sign found
	cmp	al,'-'
	jne	ab10
	mov	cs:str_sign,1		;set sign negative
ab9:	jcxz	ab4_done
	lodsb				;get next char
	dec	cx

ab10:	sub	al,'0'
	js	ab4_err 		;jmp if error, not number
	cmp	al,9
	ja	ab4_err 		;jmp if error, not number

	sub	ah,ah
	push	ax			;save current char

	mov	ax,bx			;get running sum
	mul	cs:ten
	pop	dx			;get current char
	add	ax,dx
	mov	bx,ax			;save running sum
	jcxz	ab4_done
	lodsb
	dec	cx
	jmp	ab10			;loop till done

ab4_done:
	cmp	str_sign,0		;is result +
	je	ab4_done2		;jmp if + number
	neg	bx
ab4_done2:	
	sub	al,al
ab4_err:	
	pop	dx
	retf		
DEC_STR4_TO_WORD	endp

LIBSEG	ENDS
	end
