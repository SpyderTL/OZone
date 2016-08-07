	page	66,132
;******************************* RANDOM8.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( RANDOM  )
RANDOM_SEED - get low clock value for us as random number
;  inputs:  none
;  output:  ax = low value of clock
* * * * * * * * * * * * * *


	public	RANDOM_SEED
RANDOM_SEED	proc	far
	push	cx
	mov	cx,ds
	sub	ax,ax
	mov	ds,ax
	mov	ax,ds:[46ch]
	mov	ds,cx
	pop	cx
	retf	
RANDOM_SEED	endp

LIBSEG	ENDS
;;	end
