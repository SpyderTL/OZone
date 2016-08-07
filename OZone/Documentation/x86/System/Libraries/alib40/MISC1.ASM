	PAGE	66,132
;******************************** MISC1.ASM  *********************************
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing
;----------------------------------------------------------------------------


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC   )
; bit_count - count the number of bits in -al-
;  inputs:  al = input value
;  output:  ah = count of number of bits set in -al-
;           
;* * * * * * * * * * * * * *

	public	bit_count
bit_count	proc	far
		xor	ah,ah
bit_loop:	rol	al,1
		adc	ah,20h
		jnc	bit_loop
		retf
bit_count	endp

LIBSEG	ENDS
	end
