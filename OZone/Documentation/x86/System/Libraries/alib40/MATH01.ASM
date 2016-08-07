	PAGE	66,132
;******************************** MATH01.ASM *********************************
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing
;----------------------------------------------------------------------------


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; dmul_10_plus - multiply times ten and add update value
;  inputs:  dx,bx = current sum
;              ax = update value to add to new sum
;  output:  dx,bx = result of (dx,bx) * (10) + ax
;           carry set if overflow
;* * * * * * * * * * * * * *

	public	dmul_10_plus
dmul_10_plus	proc	far
	push	cx

	shl	bx,1
	rcl	dx,1		;sum * 2 -> dx,bx
	push	dx
	push	bx

	shl	bx,1
	rcl	dx,1		;dx,bx = sum * 4
	shl	bx,1
	rcl	dx,1		;dx,bx = sum * 8

	pop	cx		;get low word of (sum * 2)
	add	bx,cx
	pop	cx		;get high word of (sum * 2)
	adc	dx,cx		;dx,bx = sum * 10
	jc	dmul_err	;jmp if overflow

	add	bx,ax		;add in ax
	adc	dx,0
dmul_err:
	pop	cx
	retf
dmul_10_plus	endp	

LIBSEG	ENDS
	end
