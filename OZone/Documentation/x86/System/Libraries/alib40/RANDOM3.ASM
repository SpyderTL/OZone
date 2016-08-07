	page	66,132
;******************************* RANDOM3.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	random_seed:far
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( RAMDOM  )
random_byte1 - generate random number
;  inputs:   none
;  output:   al = random number
* * * * * * * * * * * * * *


	PUBLIC random_byte1
random_byte1	proc	FAR
	cmp	cs:init_flag,0
	jne	continue
	call	init_buffer
continue:
	xor	ax,ax
	xor	bx,bx
	mov	bl,ref1
	mov	al,[permute_buffer+bx]
	dec	bl
	jnz	fwd1
	or	bl,62h	
fwd1:	mov	ref1,bl
	mov	bl,ref2
	add	al,[permute_buffer+bx]
	mov	[permute_buffer + bx],al
	dec	bl
	jnz	fwd2
	or	bl,62h
fwd2:	mov	ref2,bl
	mov	bl,ref3
	mov	al,[permute_buffer +bx]
	dec	bl
	jnz	fwd3
	or	bl,61h
fwd3:	mov	ref3,bl
	mov	bl,ref4
	add	al,[permute_buffer + bx]
	dec	bl
	jnz	fwd4
	or	bl,61h
fwd4:	mov	ref4,bl
	retf
random_byte1 endp
;--------------------------------
permute_buffer     DB	96 DUP (?)			 ;permute buffer
ref1          DB	62h
ref2          DB 0bh
ref3          DB 61h
ref4          DB 22h

init_flag	db	0

;---------------------------------------

	PUBLIC init_buffer
init_buffer proc FAR  ;Load array values
	mov	cx,98		;size of buffer
	mov	cs:init_flag,1
	call	random_seed
loop1:	xor	bx,bx
	mov	bl,[cs:ref1]
	mov	[cs:permute_buffer+bx],al
	dec	cs:ref1
	jnz	skip
	or	cs:ref1,062h
Skip:	loop	loop1			;loop 98 times
	ret
init_buffer endp

LIBSEG	ENDS
;;	end
