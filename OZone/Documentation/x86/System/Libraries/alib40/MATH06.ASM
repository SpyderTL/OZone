	PAGE	66,132
;******************************** MATH06.ASM *********************************
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing
;----------------------------------------------------------------------------
	include	mac.inc

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; BLOCK_ADD -   Add two values in memory
;  inputs:  ds:si = pointer to value 1
;           es:di = pointer to value 2
;              cx = length of values
;  output:  es:di = pointer to result
;
; note: values are stored low byte to high byte.  Thus, initially
;       -si- and -di- will point at the least significant byte.
;
;* * * * * * * * * * * * * *


        public  BLOCK_ADD
BLOCK_ADD   proc    far
        apush    ax,cx,si,di 
        clc                       
add1:   lodsb                       
        adc     byte ptr es:[di],al  
        inc     di
        loop    add1                 
        apop     di,si,cx,ax
        retf                
BLOCK_ADD   endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; BLOCK_NEGATE - negate block in memory
;  inputs:  ds:si = pointer to value
;              cx = lenght of value in bytes
;  output:  ds:si = pointer to negated value
;* * * * * * * * * * * * * *


        public  BLOCK_NEGATE
BLOCK_NEGATE   proc    far
	cld
	apush	si,di,cx,cx
	mov	di,si
neg1:   not     byte ptr [si] 
        inc     si            
        loop    neg1          
        pop     cx           
        mov     si,di        
        stc                  
neg2:   adc     byte ptr [si],0 
        inc     si              
        loop    neg2            
	apop	cx,si,di
        retf
BLOCK_NEGATE   endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; BLOCK_SUBTRACT - subtract two data blocks in memory
;   inputs:  ds:si = pointer to value 1
;            es:di = pointer to value 2
;               cx = lenght of values in bytes
;   output:  es:di = pointer to value2 - value1
;
;* * * * * * * * * * * * * *


        public  BLOCK_SUBTRACT
BLOCK_SUBTRACT   proc    far
	cld
	apush	ax,cx,si,di
        clc                        
sub1:   lodsb                      
        sbb     byte ptr es:[di],al
        inc     di
        loop    sub1               
	apop	di,si,cx,ax
        retf
BLOCK_SUBTRACT   endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; BLOCK_DIVIDE - divide two variable blocks in memory
;  inputs:  ds/es:si = address of value 1
;           ds/es:di = address of value 2
;              cx = length of value 1 in bytes, value 2 length = (cx * 2)
;  output:  ds/es:di = result
;           ds/es:si = remainder
;
;* * * * * * * * * * * * * *


        public  BLOCK_DIVIDE
BLOCK_DIVIDE   proc    far
	cld
	apush	ax,bx,cx,dx,si,di,bp
        mov     dx,cx           
        mov     bp,cx
        mov	cl,3
        shl	bp,cl
        clc                     
div1:   push    di                
        mov     cx,dx           
div2:   rcl     word ptr [di],1
	add	di,2
        loop    div2            
        pop     di              
        jnc     div5            
div3:   apush    si,di                
        add     di,dx           
        mov     cx,dx           
        clc                     
div4:   lodsb
        sbb     [di],al         
        inc     di
        loop    div4
	apop	di,si
        dec     bp              
        stc                     
        jnz     div1            
        jmp     div7            

div5:   apush    si,di
        add     di,dx           
        mov     cx,dx           
        clc                     
div6:   lodsb
        sbb     al,[si]
        inc     di
        loop    div6
	apop	di,si
        jnc     div3            
        clc                     
        dec     bp              
        jnz     div1            
div7:   mov     cx,dx             
div8:   rcl     byte ptr [di],1   
        inc     di             
        loop    div8         
        xchg    si,di           
        mov     cx,dx
        rep     movsb
	apop	bp,di,si,dx,cx,bx,ax
        retf
BLOCK_DIVIDE   endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MATH   )
; BLOCK_MULTIPLY - multiply of two block in memory
;   inputs:  ds/es:si = pointer to value 1
;            es/es:di = pointer to value 2
;               cx = length of values
;   output:  es:di = pointer to result, length of (cx * 2) 
;
;* * * * * * * * * * * * * *

         public  BLOCK_MULTIPLY
BLOCK_MULTIPLY   proc    far
	 apush	ax,bx,cx,dx,bp,di
	 cld
         mov     dx,cx  
         add     di,cx  
         mov     bp,di  
         sub     al,al  
         rep     stosb  
         pop     di     
         mov     cx,dx  
         shl     cx,1
         shl     cx,1
         shl     cx,1
         inc     cx
         clc            
bmul_1:  pushf            
         mov     bx,dx  
         shl     bx,1
         dec     bx
         popf           
bmul_2:  rcr     byte ptr es:[di+bx],1
         dec     bx                 
         jns     bmul_2              
         jnc     bmul_4              
         xchg    bp,di              
         push    cx                 
         mov     cx,dx              
         xor     bx,bx              
bmul_3:  mov     al,[si+bx]           
         adc     es:[di+bx],al      
         inc     bx                      
         loop    bmul_3
         pop     cx                 
         xchg    bp,di              
bmul_4:  dec	 cx
	 jnz	 bmul_1               
	 apop    bp,dx,cx,bx,ax
         retf
BLOCK_MULTIPLY   endp

LIBSEG	ENDS
;;	end
