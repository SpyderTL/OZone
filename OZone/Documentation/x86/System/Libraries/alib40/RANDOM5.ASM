	page	66,132
;******************************* RANDOM5.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( RANDOM  )
RANDOM_WORD3 - generate random word value, using method 3
;
;  inputs:  AX = range of random numbers -1
;  output:  AX = random number
;         
* * * * * * * * * * * * * *


rand_seed	dd	?
scale_factor		dw	16

loop_count = 16
;----------------------------------

	public	RANDOM_WORD3
RANDOM_WORD3	proc	far
	mov	bx,word ptr [rand_seed]
	mov	ax,word ptr [rand_seed+2]
	mov	cx,loop_count
r3_lp:  mov	dl,bl
	test	ah,0EAh
	jpe	lp_tail
	xor dl,1       
lp_tail:shr	dl,1
	adc	bx,bx
	adc	ax,ax
	dec	cx
	jnz	r3_lp

	mov	word ptr [rand_seed],bx
	mov	word ptr [rand_seed+2],ax
  
	mov	cx,[scale_factor]
	xor	dx,dx
	cmp	cx,1
	jbe	rd_end
	div	cx
	mov	ax,bx
	div	cx
rd_end:	mov ax,dx
	retf
RANDOM_WORD3	endp

LIBSEG	ENDS
;;	end
