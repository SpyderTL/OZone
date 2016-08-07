	PAGE	66,132
;******************************** MATH05.ASM *********************************
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing
;----------------------------------------------------------------------------
	include	mac.inc
	

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; DWORD_COMPARE - unsigned 32 bit number compare
;  inputs  ax,bx = first number
;          cx,dx = second number
;  outputs  zf (zero flag) = 1 if equal
;           if 1 greater than 2  zf=0 and carry=0
;           if 1 less than 2     zf=0 and carry=1
;           registers are unchanged
;
;* * * * * * * * * * * * * *

	public	DWORD_COMPARE
DWORD_COMPARE	proc	far
	cmp	ax,cx
	jnz	comp32_end
	cmp	bx,dx
comp32_end:
	retf
DWORD_COMPARE	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; QUAD_DIVIDE - divide quad value by dword
;   inputs:  dx,cx,bx,ax = divident
;                  si,di = divisor
;   output:  dx,ax = quotient
;            cx,bx = remainder
;
;* * * * * * * * * * * * * *

	public	QUAD_DIVIDE
QUAD_DIVIDE    proc    far
        apush   bp,si,di    
        mov     bp,cx       
        mov     cx,32       
        clc                 

qdiv1:  rcl     ax,1        
        rcl     bx,1
        rcl     bp,1
        rcl     dx,1
        jnc     qdiv3       

qdiv2:  sub     bp,di       
        sbb     dx,si
        stc                 
        loop    qdiv1       
        jmp     qdiv5

qdiv3:  cmp     dx,si      
        jc      qdiv4      
        jne     qdiv2      
        cmp     bp,di
        jnc     qdiv2      

qdiv4:  clc                
        loop    qdiv1      

qdiv5:  rcl     ax,1       
        rcl     bx,1

        mov     cx,bp
        xchg    dx,bx      
        xchg    cx,bx      

        apop   di,si,bp    
        retf               
QUAD_DIVIDE    endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; QUAD_MULTIPLY1 - multiply two dwords
;   inputs: dx,ax = value 1
;           cx,bx = value 2
;   output: dx,cx,bx,ax = result
;
;* * * * * * * * * * * * * *



temp0      dw	0
temp1      dw	0
temp2      dw	0
temp3      dw	0

	public	QUAD_MULTIPLY1
QUAD_MULTIPLY1    proc    far
	apush	si,di

        mov     di,dx    
        mov     si,ax

        mul     bx       
        mov     cs:temp0,ax
        mov     cs:temp1,dx

        mov     ax,di    
        mul     cx
        mov     cs:temp2,ax
        mov     cs:temp3,dx

        mov     ax,di        
        mul     bx
        add     cs:temp1,ax     
        adc     cs:temp2,dx
        adc     cs:temp3,0

        mov     ax,si        
        mul     cx
        add     cs:temp1,ax     
        adc     cs:temp2,dx
        adc     cs:temp3,0
        mov	ax,cs:temp0
        mov	bx,cs:temp1
        mov	cx,cs:temp2
        mov	dx,cs:temp3
        apop	di,si
        retf                 
QUAD_MULTIPLY1    endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; QUAD_MULTIPLY2 - multiply two 32 bit unsigned numbers
;  inputs - cx,bx = value 1
;           dx,ax = value 2
;  outputs - product in dx,cx,bx,ax (high to low)
;
;* * * * * * * * * * * * * *

quad_struc  struc
 high_value1		dw	?
 low_value1		dw	?
 high_result1		dw	?
 low_result1		dw	?
 high_result2		dw	?
 low_result2		dw	?
 high_result3		dw	?
 low_result3		dw	?
 high_result4		dw	?
 low_result4		dw	?
quad_struc	ends

	public	QUAD_MULTIPLY2
QUAD_MULTIPLY2	proc	far
	push	bp
	sub	sp,size quad_struc
	mov	bp,sp
	mov	[bp.high_value1],dx	
	mov	[bp.low_value1],ax	
	mul	bx			
	mov	[bp.high_result1],dx	
	mov	[bp.low_result1],ax	
	mov	ax,[bp.high_value1]	
	mul	bx			
	mov	[bp.high_result2],dx	
	mov	[bp.low_result2],ax	
	mov	ax,[bp.low_value1]	
	mul	cx			
	mov	[bp.high_result3],dx	
	mov	[bp.low_result3],ax	
	mov	ax,[bp.high_value1]	
	mul	cx			
	mov	[bp.high_result4],dx	
	mov	[bp.low_result4],ax	
;
; combine the intermediate results
;
	mov	ax,[bp.low_result1]	
	mov	bx,[bp.high_result1]	
	add	bx,[bp.low_result2]
	adc	[bp.high_result2],0
	add	bx,[bp.low_result3]
	add	cx,[bp.high_result2]
	adc	cx,[bp.high_result3]
	adc	[bp.high_result4],0
	add	cx,[bp.low_result4]
	mov	dx,[bp.high_result4]
	adc	dx,0

	add	sp,size quad_struc
	pop	bp
	retf
QUAD_MULTIPLY2	endp

LIBSEG	ENDS
;;	end
