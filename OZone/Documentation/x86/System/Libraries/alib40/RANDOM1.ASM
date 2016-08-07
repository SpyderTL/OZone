	page	66,132
;******************************* RANDOM1.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	random_seed:far
	extrn	scale_word:far
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( RANDOM  )
random_word1 - generate random word value, using method 1
;
;  inputs: bx = minimum value of random range
;          bp = maximum value of random range
;          
;  output: ax = random number
;          all registers are restored except for -ax-
* * * * * * * * * * * * * *

seed	dw	-1

	public	random_word1
random_word1	proc	far
	apush	dx,cx
	mov	ax,cs:seed
	cmp	ax,-1			;check if first entry
	jne	do_rand			; jmp if not first entry
;
; initialize the random seed
;
	call	random_seed

do_rand:mov	cx,1255			;get constant multiplier
	mul	cx
	add	ax,6173			;add constant adjustment factor
	adc	dx,0
	mov	cx,29282		;mod value for ranging
	div	cx
	mov	cs:seed,dx		;store new seed
;
; now convert number to desired range
;
	mov	ax,dx
	call	scale_word
	
	apop	cx,dx
	retf
	
random_word1	endp

LIBSEG	ENDS
;;	end
