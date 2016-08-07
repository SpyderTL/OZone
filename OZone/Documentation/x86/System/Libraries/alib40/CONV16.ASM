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
;DEC_STR3_TO_DWORD -  convert signed asciiz string to binary DWORD
;
; inputs  ds:si points	at string ending with zero
; 
; output  bx,dx = binary value
;	   si = updated to point at end of value
;	   al = zero if success
;* * * * * * * * * * * * * *

str_sign	db	0

	extrn	dmul_10_plus:far
	public	DEC_STR3_TO_DWORD
DEC_STR3_TO_DWORD	proc	far
	mov	bx,0
	mov	cs:str_sign,0
sb5:	lodsb
	cmp	al,' '
	je	sb5			;remove leading spaces
	cmp	al,'+'
	je	sb15			;jmp if sign found
	cmp	al,'-'
	jne	sb16
	mov	cs:str_sign,1		;set sign negative

	xor	ah,ah       		;
	xor	dx,dx			;running sum = 0
	xor	bx,bx			;running sum = 0
;
; remove blanks in front of number
;
sb15:	lodsb

sb16:	or	al,al
	jz	sb7_done		;jmp if done, end of string
	sub	al,'0'
	js	sb7_done		;jmp if error, not number
	cmp	al,9
	ja	sb7_done		;jmp if error, not number

	call	dmul_10_plus		;compute (dx,ax) * 10 + bx
	jnc	sb15			;jmp if no errors

sb7_done:
	cmp	str_sign,0		;is result +
	je	sb7_done2		;jmp if + number
	not	dx
	neg	ax
	sbb	dx,-1
sb7_done2:	
	retf		
		
DEC_STR3_TO_DWORD	endp
	

LIBSEG	ENDS
	end
