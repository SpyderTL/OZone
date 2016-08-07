	page	66,132
;******************************** STR22.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	strlen1:far
	extrn	strlen2:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_LEFT - left-justifies string1 in string2
;
; inputs:    ES:[DI] = address of string2
;            DS:[SI] = address of string1
;            
; output:    CF = 0 if no error
;            CF = 1 if string was truncated to fit in the field
;
; note:  string2 is first filled with spaces, then string1 is moved
;        into string2.  Both strings must be null terminated.         
;* * * * * * * * * * * * * *

	PUBLIC	STR_LEFT
STR_LEFT	PROC	FAR
    APUSH   AX,CX,DX,DI,SI
    CLD
    PUSH    ES
    PUSH    DS
    POP     ES
;;    MOV     BX,DI
    CALL    strlen2
    MOV     DX,CX
    POP     ES
    JCXZ    slt_7
    MOV     AL,20h    ; ' '
    REPZ    STOSB
    SUB     DI,DX
;;    MOV     BX,SI
    CALL    strlen1
    CMP     CX,DX
    JBE     slt_5
    MOV     CX,DX
    MOV     DX,0FFFFh
slt_5:    
    REPZ    MOVSB
slt_7:
    OR      DX,DX
    JNS     slt_F
    STC
    JMP     slt_exit
slt_F:    
    CLC
slt_exit:    
    APOP    SI,DI,DX,CX,AX
    RETF
STR_LEFT	ENDP

LIBSEG	ENDS
	end
