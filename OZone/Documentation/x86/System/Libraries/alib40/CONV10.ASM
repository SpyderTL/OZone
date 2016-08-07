	page	66,132
;******************************** CONV10.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
;DEC_STR1_TO_WORD -  convert unsigned ascii string to binary word
;
; inputs  ds:si points	at string ending with zero
; 
; output  bx = binary value
;	   si = updated to point at end of value
;	   al = 0 if success
;* * * * * * * * * * * * * *

	extrn	ten:word
	public	DEC_STR1_TO_WORD
DEC_STR1_TO_WORD	proc	far
	push	dx
	cld
	mov	bx,0       		;set running sum = 0
;
; remove blanks in front of number
;
ab1:	lodsb
	cmp	al,' '
	je	ab1			;remove leading spaces

ab2:	or	al,al
	jz	ab_done			;jmp if done, end of string
	sub	al,'0'
	js	ab_done			;jmp if error, not number
	cmp	al,9
	ja	ab_done			;jmp if error, not number

	sub	ah,ah
	push	ax			;save current char

	mov	ax,bx			;get running sum
	mul	cs:ten
	pop	dx			;get current char
	add	ax,dx
	mov	bx,ax			;save running sum
	lodsb
	jmp	ab2			;loop till done
	
ab_done:
	pop	dx
	RETF
DEC_STR1_TO_WORD ENDP

LIBSEG	ENDS
	end
