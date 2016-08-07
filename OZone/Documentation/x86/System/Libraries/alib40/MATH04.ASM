	PAGE	66,132
;******************************** MATH04.ASM *********************************
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing
;----------------------------------------------------------------------------


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; word_sqroot - square root (word)
;  input:  ax = radicand
;  output: dl = root
;          ax = remainder
;
;* * * * * * * * * * * * * *

	public	word_sqroot
word_sqroot	proc	far
root:	xor	dx,dx
	mov	bx,4000h
	mov	cx,8
rt1:	sub	ax,dx
	sub	ax,bx
	js	rt_negative
	shr	dx,1
	or	dx,bx
	jmp	loop_tail
rt_negative:
	add	ax,dx
	add	ax,bx
	shr	dx,1
loop_tail:
     	shr	bx,1
	shr	bx,1
	loop	rt1
	retf
word_sqroot	endp	

LIBSEG	ENDS
	end
