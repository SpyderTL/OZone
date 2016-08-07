	page	66,132
;******************************* RANDOM4.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	random_seed:far
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( RANDOM  )
RANDOM_DWORD1 - generate random dword value
;
;  inputs:  none
;  output:  dx,ax = random value
;         
* * * * * * * * * * * * * *


prev_rand	dd	?		;previous random, used as seed
rand_delta	dw	?		;delta lo-hi randow words
init_flag4	db	0		;set to 1 if initialized

permute1	EQU	0B303h
permute2	EQU	02D8Dh

;------------------------------
	PUBLIC	RANDOM_DWORD1
RANDOM_DWORD1	PROC	NEAR
	cmp	cs:init_flag4,0
	jne	cont4
	call	rw3_init
cont4:	apush	si,di
	xor	di,di
	mov	ax,permute1
	mul	WORD PTR [prev_rand]
	mov	si,ax		
	mov	bx,dx
	add	bx,ax		
	mov	cx,dx

	mov	ax,permute2
	mul	WORD PTR [prev_rand+2]
	add	bx,ax			
	adc	cx,dx
	adc	di,0
	add	cx,ax			
	adc	di,dx

	mov	ax,permute2-permute1	
	mul	WORD PTR [rand_delta]	
	add	bx,ax			
	adc	cx,dx
	adc	di,0

	shl	bx,1
	rcl	cx,1
	rcl	di,1			
	shr	bx,1			

	add	si,cx			
	adc	bx,di			

	mov	WORD PTR [prev_rand+2],bx		;save random number
	mov	WORD PTR [prev_rand],si		;  as seed for next entry
	mov	ax,si				;pass back result in DX:AX
	mov	dx,bx
	sub	si,bx
	mov	WORD PTR [rand_delta],si
	apop	di,si
	retf
RANDOM_DWORD1	ENDP
;----------------------------------------
rw3_init	PROC	NEAR
PUBLIC	rw3_init
	call	random_seed
	mov	dx,ax
	rol	dx,1
	mov	WORD PTR [prev_rand],ax
	mov	WORD PTR [prev_rand+2],dx
	sub	ax,dx
	mov	WORD PTR [rand_delta],dx
	mov	cs:init_flag4,1
	ret
rw3_init	ENDP

LIBSEG	ENDS
;;	end
