	PAGE	66,132
;******************************** MATH02.ASM *********************************
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing
;----------------------------------------------------------------------------


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; dword_negate - negate dword in dx,ax
;  inputs:  dx,ax = number
;  optput:  dx,ax negated
;* * * * * * * * * * * * * *

	public	dword_negate
dword_negate	proc	far
       	not	dx
	neg	ax
	sbb	dx,-1
	retf
dword_negate	endp	

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; dword_divide - divide dword values
;  inputs: dx,ax divided by bx
;  output: dx,ax = result
;* * * * * * * * * * * * * *

	public	dword_divide
dword_divide	proc	far
     	push	cx
	xchg	cx,dx
	xchg	ax,cx
	sub	dx,dx
	div	bx
	xchg	cx,ax
	div	bx
	mov	dx,cx
	pop	cx
	retf
dword_divide	endp	

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; dword_add - add dword values
;  inputs:  dx,ax = value 1
;           cx,bx = value 2
;  output:  dx,ax = result
;           carry set if overflow
;* * * * * * * * * * * * * *

	public	dword_add
dword_add	proc	far
	add	ax,bx
	adc	dx,cx
	retf
dword_add	endp	

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; dword_sub - subtract dword values
;  inputs:  dx,ax = value 1
;           cx,bx = value 2
;  output:  dx,ax = dx,ax - cx,bx
;           carry set if overflow
;* * * * * * * * * * * * * *

	public	dword_sub
dword_sub	proc	far
	sub	ax,bx
	sbb	dx,cx
	retf
dword_sub	endp	

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; dword_mul - multiply dword values
;   inputs:  dx,ax = value 1
;            cx,bx = value 2
;   output:  dx,cx,bx,ax = result
;* * * * * * * * * * * * * *


v1	dw	0		;temp value 1
v2	dw	0		;temp value 2
v3	dw	0		;temp value 3
;v4	dw	0		;temp value 4 (in BP )

	public	dword_mul
dword_mul	proc	far
        push    si                      ; save registers
        push    di
        push    bp                      ; set up stack frame

        mov     di,dx                   ; save copy of argument 1
        mov     si,ax

        mul     bx                      ; arg1 low * arg2 low
        mov     cs:v1,ax
        mov     cs:v2,dx

        mov     ax,di                   ; arg1 high * arg2 high
        mul     cx
        mov     cs:v3,ax
        mov     bp,dx			;save v4

        mov     ax,di                   ; arg1 high * arg2 low
        mul     bx
        add     cs:v2,ax                   ; accumulate result
        adc     cs:v3,dx
        adc     bp,0

        mov     ax,si                   ; arg1 low * arg2 high
        mul     cx
        add     cs:v2,ax                   ; accumulate result
        adc     cs:v3,dx
        adc     bp,0
;
; load up return registers, dx,cx,bx,ax
;
	mov	dx,bp			;get v4
	mov	cx,cs:v3
	mov	bx,cs:v2
	mov	ax,cs:v1
	
        pop     bp                      ; restore registers
        pop     di
        pop     si
	retf
dword_mul	endp	

LIBSEG	ENDS
	end
