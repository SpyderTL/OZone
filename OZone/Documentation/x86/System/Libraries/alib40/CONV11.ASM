	page	66,132
;******************************** CONV11.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
;DEC_STR2_TO_WORD -  convert unsigned ascii string to binary word
;
; inputs  ds:si = string ptr
;            cx = string length
; 
; output  bx = binary value
;	   si = updated to point at end of value
;	   al = zero if success
;* * * * * * * * * * * * * *

	extrn	ten:word
	public	DEC_STR2_TO_WORD
DEC_STR2_TO_WORD	proc	far
	push	dx
	cld
	mov	bx,0       		;set running sum = 0
;
; remove blanks in front of number
;
ab3:	lodsb
	jcxz	ab2_done
	dec	cx
	cmp	al,' '
	je	ab3			;remove leading spaces

ab4:	sub	al,'0'
	js	ab2_err			;jmp if error, not number
	cmp	al,9
	ja	ab2_err 		;jmp if error, not number

	sub	ah,ah
	push	ax			;save current char

	mov	ax,bx			;get running sum
	mul	cs:ten
	pop	dx			;get current char
	add	ax,dx
	mov	bx,ax			;save running sum
	jcxz	ab2_done
	lodsb
	dec	cx
	jmp	ab4			;loop till done
	
ab2_done:
	xor	al,al
ab2_err:	
	pop	dx
	RETF
DEC_STR2_TO_WORD	endp
	

LIBSEG	ENDS
	end
