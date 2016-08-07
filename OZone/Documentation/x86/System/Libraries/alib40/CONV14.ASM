	page	66,132
;******************************** CONV14.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
;DEC_STR1_TO_DWORD -  convert unsigned ascii string to binary DWORD
;
; inputs  ds:si points	at string ending with zero
;         direction flag = CLD state
; 
; output  bx,dx = binary value
;	   si = updated to point at end of value
;	   al = 0 if success
;* * * * * * * * * * * * * *

	extrn	DMUL_10_PLUS:FAR
	public	DEC_STR1_TO_DWORD
DEC_STR1_TO_DWORD	proc	far
	xor	ah,ah       		;
	xor	dx,dx			;running sum = 0
	xor	bx,bx			;running sum = 0
;
; remove blanks in front of number
;
sb11:	lodsb
	cmp	al,' '
	je	sb11			;remove leading spaces

sb12:	or	al,al
	jz	sb5_done		;jmp if done, end of string
	sub	al,'0'
	js	sb5_done		;jmp if error, not number
	cmp	al,9
	ja	sb5_done		;jmp if error, not number

	call	dmul_10_plus		;compute (dx,ax) * 10 + bx
	jnc	sb11			;jmp if no errors
sb5_done:
	RETF
DEC_STR1_TO_DWORD ENDP

LIBSEG	ENDS
	end
