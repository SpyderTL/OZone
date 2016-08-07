	page	66,132
;******************************* RANDOM6.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	random_seed:far
.list

init_flag6	db	0

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( RANDOM  )
RANDOM_WORD4 - generate random word value, method 4
   inputs:  none
   output:  ax = random value
* * * * * * * * * * * * * *


old_rand	dw	123,45		;
permutter	dw	0DE6DH,0278Dh	;


	public		RANDOM_WORD4
RANDOM_WORD4	proc	far
		apush	bx,cx,dx
		cmp	cs:init_flag6,0
		jne	cont6		;jmp if initialized
		call	rand_init
cont6:		mov	bx,permutter
		mov	cx,bx		
		mov	ax,permutter+2	
		mul	old_rand	
		xchg	ax,bx		
		mul	old_rand	
		add	bx,dx		
		xchg	ax,cx		
		mul	old_rand+2	
		add	ax,bx		
		mov	old_rand,cx	
		mov	old_rand+2,ax	;save random to permute next rand
		apop	dx,cx,bx
		retf
RANDOM_WORD4	endp

;---------------------------------
rand_init:	apush	ax,dx
		call	random_seed
		or	al,1		;make sure the dword seed is odd
		mov	old_rand,ax	;store the (odd) low word
		mov	old_rand+2,dx	;store high word of seed
		apop	ax,dx
		ret

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( RANDOM  )
RANDOM_WORD4_SCALED - Generates a random number within a specific range
  inputs:  ax =	max value +1 of random number desired
  output:  ax = random value
* * * * * * * * * * * * * *

	public		RANDOM_WORD4_SCALED
RANDOM_WORD4_SCALED	proc	far
		apush	dx,ax
		call	RANDOM_WORD4	;get a random number
		pop	bx
		test	bx,bx		;return within restricted range?
		jz	scale_end 	;  n: return 16-bit random number
		xor	dx,dx		;convert to dword for divide
		div	bx		;divide by the limit
		xchg	ax,dx		;return the remainder in AX
scale_end:	pop	dx
		retf
RANDOM_WORD4_SCALED	endp

LIBSEG	ENDS
;;	end
