	page	66,132
;******************************* RANDOM7.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( RANDOM  )
RANDOM_WORD5 - generate random word value, method 5
;  inputs:  none
;  output:  ax = random value
;         
* * * * * * * * * * * * * *


	public	RANDOM_WORD5
RANDOM_WORD5	proc	far
	push	dx
	mov	ax,r_seed[bp]
	mul	r_multipler[bp]
	add	ax,r_increment[bp]
	adc	dx,0
	div	r_permute1[bp]
	xchg	ax,dx
	mov	r_seed[bp],ax
	pop	dx
	retf
RANDOM_WORD5	endp


r_seed		dw	0		; random number seed
r_permute1	dw	0FFEFh		;  modulus	2^16-17
r_multipler	dw	0FFD9h		;  multiplier	2^16-39
r_increment	dw	0FFFFh		;  increment	-1

LIBSEG	ENDS
;;	end
