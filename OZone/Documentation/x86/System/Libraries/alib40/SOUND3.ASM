	page	66,132
;******************************** SOUND3.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	sound_flag:byte
.list

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SOUND  )
make_sound - make sound for number of milliseconds.
;
; inputs:  bx = frequency in HZ
;          dx = timer ticks
; outputs: none
;
; note:  Each timer tick is about 1/5 of a second.
;* * * * * * * * * * * * * *

	public	make_sound
make_sound	proc	far
	apush	ax,bx,dx,es
	cmp	cs:sound_flag,0
	je	sound_exit		;jmp if sound is off
	push	dx
	xor	ax,ax
	mov	es,ax
	mov	ax,word ptr es:[46ch]
timer_wait_1:	
	cmp	ax,word ptr es:[46ch]
	je	timer_wait_1

	mov	al,10110110b
	out	43h,al
	mov	dx,12h
	mov	ax,2870h
	cmp	bx,37
	jb	sound_exit
	div	bx

	out	42h,al
	mov	al,ah
	out	42h,al

	in	al,61h
	or	al,3
	out	61h,al
;
; delay
;
	pop	dx	
timer_wait_2:
	mov	ax,word ptr es:[46ch]
timer_wait_3:
	cmp	ax,word ptr es:[46ch]
	je	timer_wait_3
	dec	dx
	jnz	timer_wait_2

	in	al,61h
	and	al,0fch
	out	61h,al
sound_exit:
	apop	es,dx,bx,ax
	retf
make_sound	endp

LIBSEG	ENDS
	end
