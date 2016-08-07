	page	66,132
;******************************** CONV25.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
DEC_STR_TO_WORD -  convert unsigned ascii string to binary word
;
; inputs  ds:si points	at string ending with "space" or "return"
; 
; output  ax = binary value
;	   si = updated to point at end of value
;	   carry set if	error
;* * * * * * * * * * * * * *

ab_low	dw	0

	PUBLIC	DEC_STR_TO_WORD
DEC_STR_TO_WORD		PROC	FAR
	push	di
	push	bx
	mov	cs:ab_low,0			;  accumulators
;
; remove blanks in front of number
;
	mov	bx,10			;base 10?
ab1:	cmp	byte ptr [si],' '
	jne	ab2			;jmp if not preceeding space
nxt_flush:
	inc	si
	jmp	ab1
;
; conversion loop
;	
ab_loop:
	inc	si			;move	to next	char
ab2:	mov	al,[si]
;
; convert key to binary
;
key21:	cmp	al,0dh
	je	ab_done
	cmp	al,' '
	je	ab_done
	cmp	al,09
	je	ab_done
	cmp	al,'/'
	je	ab_done
	cmp	al,0
	je	ab_done
key22:	cmp	al,'0'
	jl	ab_err			;skip non numeric key
	cmp	al,'9'
	jle	decimal			;jump if	decimal	value
;
; we have a hex	number or bad value.
;
	jmp	ab_err			;	jmp if wrong base
decimal:
	sub	al,'0'			;convert to number
got_binary_key:
	sub	ah,ah
	push	ax			;save key
;
; multiply sum by current base
;
	mov	ax,cs:ab_low
	mov	dx,0
	mul	bx
;
; add latest character to sum
;
	pop	di
	add	ax,di			;add to sum
	mov	di,0
	adc	dx,di			;add carry
;
	mov	cs:ab_low,ax
	jmp	ab_loop
ab_err:
	stc
	jmp	ab_exit
ab_done:
	mov	ax,cs:ab_low
	clc
ab_exit:
	pop	bx
	pop	di
	RETF
DEC_STR_TO_WORD ENDP

LIBSEG	ENDS
	end
