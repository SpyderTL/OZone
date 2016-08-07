	page	66,132
;******************************** CONV24.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
DEC_STRZ_TO_DWORD - convert numeric asciiz string to double word value
;
;inputs:  ds:si = string ptr (string ends with zero)
;
;output:  if no carry, dx,ax = number (ax is low word)
;         if carry, error occured
;* * * * * * * * * * * * * *

;-------------------------
str_sign   	db	0		;0=positive 1=neg
;-------------------------
	public	DEC_STRZ_TO_DWORD
DEC_STRZ_TO_DWORD	PROC	FAR
	mov	cx,07fffh
DEC_STRZ_TO_DWORD	ENDP	
;
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
DEC_STR_TO_DWORD - convert string to double word
;
;inputs:  ds:si = string ptr
;            cx = string length
;            
;output:  if no carry, dx,ax = number (ax is low word)
;         if carry, error occured
;* * * * * * * * * * * * * *

	public	DEC_STR_TO_DWORD
DEC_STR_TO_DWORD	PROC	FAR
	apush	cx,si,di
	mov	cs:str_sign,0
	XOR	DX,DX		  
	XOR	DI,DI
	jcxz	sl_illegal
;
; remove any spaces or tabs on front end
;	
sl_lp1:	LODSB
	dec	cx
	cmp	al,' '
	jne	sl_ck_sign			;jmp if not space
	jcxz	sl_illegal
	jmp	sl_lp1
	
sl_ck_sign:
        CMP     AL,2Bh    ; '+'   
	JZ	sl_next_chr		  
        CMP     AL,2Dh    ; '-'   
	JNZ	sl_end_ck	  
	mov	cs:str_sign,1			;set negative number flag
sl_next_chr:
	LODSB
;
; check for end of string by looking for a non numeric character
;	
sl_end_ck:
	cmp	al,0dh
	je	sl_end_fnd
	cmp	al,' '
	je	sl_end_fnd
	cmp	al,09h
	je	sl_end_fnd
	cmp	al,0
	je	sl_end_fnd
        CMP     AL,30h    ; '0'   
	JB	sl_illegal		  
        CMP     AL,39h    ; '9'   
	JA	sl_illegal		  
;
; convert char. to decimal
;	
	AND	AX,000Fh
	XCHG	AX,DI
;
; dx:ax = sum so far,  di=addition value  operation = dx:ax * 10 + di -> sum
;
	shl	ax,1			;sum
	rcl	dx,1			;  * 2 -> sum
	apush	dx,ax

	shl	ax,1
	rcl	dx,1			;dx,ax = sum * 4

	shl	ax,1
	rcl	dx,1			;dx,ax = sum * 8

	pop	bx
	add	ax,bx			;low(sum*8) + low(sum*2)
	pop	bx
	adc	dx,bx			;hi(sum*8) + hi(sum*2) = sum*10

	XCHG	AX,DI
	
	ADD	DI,AX		  
	ADC	DX,+00		  
	JS	sl_illegal			;jmp if overflow
	DEC	CX				;terminate loop when cx-> -1
	jns	sl_next_chr			;loop till done
	
sl_end_fnd:
	MOV	AX,DI		  
	cmp	cs:str_sign,0
	je	sl_exit2		;jmp if positive (carry clear)
;
; make number negative
;
	not	dx
	neg	ax
	sbb	dx,-1
sl_exit2:	
	clc	
	jmp	sl_exit			  
sl_illegal:
	stc
sl_exit:
	APOP	DI,SI,CX
	RETF			  
DEC_STR_TO_DWORD	ENDP

LIBSEG	ENDS
	end
