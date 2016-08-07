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
;DEC_STR2_TO_DWORD -  convert unsigned ascii string to binary DWORD
;
; inputs  ds:si = string ptr
;            cx = string length
; 
; output  bx,dx = binary value
;	   si = updated to point at end of value
;	   al = zero if success
;* * * * * * * * * * * * * *

	extrn	dmul_10_plus:far
	public	DEC_STR2_TO_DWORD
DEC_STR2_TO_DWORD	proc	far
	xor	ah,ah       		;
	xor	dx,dx			;running sum = 0
	xor	bx,bx			;running sum = 0
;
; remove blanks in front of number
;
sb13:	lodsb
	dec	cx
	cmp	al,' '
	je	sb13			;remove leading spaces

sb14:	sub	al,'0'
	js	sb6_done		;jmp if error, not number
	cmp	al,9
	ja	sb6_done		;jmp if error, not number

	call	dmul_10_plus		;compute (dx,ax) * 10 + bx
	jcxz	sb6_done		;jmp if done
	jnc	sb13			;jmp if no errors
sb6_done:
	RETF
DEC_STR2_TO_DWORD	endp

LIBSEG	ENDS
	end
