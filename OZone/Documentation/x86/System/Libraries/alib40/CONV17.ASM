	page	66,132
;******************************** CONV03.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
;DEC_STR4_TO_DWORD -  convert signed ascii string to DWORD
;
; inputs  ds:si = string pointer
;            cx = length of string
; 
; output  bx,dx = binary value
;	   si = updated to point at end of value
;	   al = zero if success
;* * * * * * * * * * * * * *

str_sign	db	0

	extrn	dmul_10_plus:far
	public	DEC_STR4_TO_DWORD
DEC_STR4_TO_DWORD	proc	far
	mov	bx,0
	mov	cs:str_sign,0
sb6:	lodsb
	dec	cx
	jcxz	sb8_done2
	cmp	al,' '
	je	sb6			;remove leading spaces
	cmp	al,'+'
	je	sb17			;jmp if sign found
	cmp	al,'-'
	jne	sb18
	mov	cs:str_sign,1		;set sign negative

	xor	ah,ah       		;
	xor	dx,dx			;running sum = 0
	xor	bx,bx			;running sum = 0
;
; remove blanks in front of number
;
sb17:	lodsb
	dec	cx
	jcxz	sb8_done
sb18:	sub	al,'0'
	js	sb8_done		;jmp if error, not number
	cmp	al,9
	ja	sb8_done		;jmp if error, not number

	call	dmul_10_plus		;compute (dx,ax) * 10 + bx
	jnc	sb17			;jmp if no errors

sb8_done:
	cmp	str_sign,0		;is result +
	je	sb8_done2		;jmp if + number
	not	dx
	neg	ax
	sbb	dx,-1
sb8_done2:	

	retf		
DEC_STR4_TO_DWORD	endp

LIBSEG	ENDS
	end
