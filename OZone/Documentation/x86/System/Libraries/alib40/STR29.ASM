	page	66,132
;******************************** STR29.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_SWAP - swaps portions of two strings
;
; inputs:    DS:[SI] points to string1
;            ES:[DI] points to string2
;            CX = number of bytes to swap
;            
; output:    nothing
;* * * * * * * * * * * * * *

	PUBLIC	STR_SWAP
STR_SWAP	PROC	FAR
    CLD
    APUSH   AX,CX,DI,SI
    cld
    jcxz    ssw_exit		;jmp if null swap
ssw_lp:
    lodsb
    xchg    byte ptr es:[di],al
    mov     byte ptr ds:[si-1],al
    inc     di
    loop    ssw_lp
ssw_exit:    
    APOP    SI,DI,CX,AX
    RETF
STR_SWAP	ENDP

LIBSEG	ENDS
	end
