	page	66,132
;******************************* RANDOM9.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( RANDOM  )
SCALE_WORD - scale a word value to be within specified range
;  inputs:  bx = low value of range
;           bp = high value of range
;           ax = number to scale
;  output:  ax = scaled number
;
;  note:  The number is scaled using the formula
;
;          input value              x
;          ----------- =  -----------------------
;           0ffffh        (high range - low range)
;
;           scaled number = x + low range
;
;   note:  parameters are not checked for errors and must be correct.
;  
* * * * * * * * * * * * * *


	public	SCALE_WORD
SCALE_WORD	proc	far
	apush	cx,dx
	mov	cx,bp
	sub	cx,bx		;compute range delta
	mul	cx		;(input value) * (delta)
	mov	ax,dx
      	add	ax,bx		;result + low range = scaled number
      	apop	dx,cx
	retf	
SCALE_WORD	endp

LIBSEG	ENDS
;;	end
