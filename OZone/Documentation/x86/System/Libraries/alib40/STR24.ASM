	page	66,132
;******************************** STR24.ASM  *********************************

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
STR_CLEANL - remove leading blanks from an ASCIIZ string
;
; inputs:    DS:[SI] pointing to string
; 
; output:    CX = string length
;* * * * * * * * * * * * * *

	PUBLIC	STR_CLEANL
STR_CLEANL	PROC	FAR
    APUSH   AX,BX,DI,SI
    CLD
    PUSH    ES
    CALL    strlen1
    PUSH    DS
    POP     ES
    MOV     DI,SI
;;  MOV     SI,BX
    MOV     BX,CX
    JCXZ    scr_exit
    MOV     AL,20h    ; ' '
    REPZ    SCASB
    JZ      scr_exit
    INC     CX
    MOV     BX,CX
    DEC     DI
    XCHG    SI,DI
    INC     CX
    REPZ    MOVSB
scr_exit:    
    MOV     CX,BX
    POP     ES
    APOP    SI,DI,BX,AX
    RETF
STR_CLEANL	ENDP

LIBSEG	ENDS
	end
