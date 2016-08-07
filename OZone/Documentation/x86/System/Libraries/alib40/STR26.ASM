	page	66,132
;******************************** STR26.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	strlen1:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_REMOVE - remove all occurances of a character from string.
;
; inputs:    DS:[SI] = string address
;            AL = character to remove from the string
;            
; output:    CX = string length
;* * * * * * * * * * * * * *

	PUBLIC	STR_REMOVE
STR_REMOVE	PROC	FAR
    call    strlen1
    APUSH   BX,DX,SI,DI,ES
    CLD
    MOV     DX,CX
    PUSH    DS
    POP     ES
    MOV     DI,SI
srm_lp:    
    REPNZ   SCASB
    JNZ     srm_exit
    DEC     DX
    MOV     SI,DI
    DEC     DI
    MOV     BX,DI
    PUSH    CX
    INC     CX
    REPZ    MOVSB
    POP     CX
    JCXZ    srm_exit
    MOV     DI,BX
    JMP     srm_lp
srm_exit:    
    MOV     CX,DX
    APOP    ES,SI,DI,DX,BX
    RETF
STR_REMOVE	ENDP

LIBSEG	ENDS
	end
