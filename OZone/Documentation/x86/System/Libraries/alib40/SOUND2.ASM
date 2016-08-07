	page	66,132
;******************************** SOUND2.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	 make_sound:far
.list


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SOUND  )
ONE_BEEP - beep once at 200hz for fraction of a second
;
; inputs: none
; output: none
;* * * * * * * * * * * * * *

	public	one_beep
one_beep	proc	far
	apush	ax,bx,dx
	mov	bx,200			;frequency
	mov	dx,2			;lenght = two timer ticks
	call	make_sound
	apop	dx,bx,ax
	retf
one_beep	endp

LIBSEG	ENDS
	end
