	page	66,132
;******************************** STR21.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	strlen1:far
	EXTRN	STRLEN2:FAR
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_CENTER - centers string1 in a string2
;
; inputs:    ES:[DI] = address of string2
;            DS:[SI] = address of string1
;            
; output:    CF = 0 if no error
;            CF = 1 if string was truncated to fit in the field
;
; Note:  The length of string2 is determined, then string2 is cleared
;        to all spaces.  String1 is then centered within string2.
;        Both strings must be null terminated.
;* * * * * * * * * * * * * *

	PUBLIC	STR_CENTER
STR_CENTER	PROC	FAR
    APUSH   AX,CX,DX,DI,SI
    CLD
    PUSH    ES
    PUSH    DS
    POP     ES
;;    MOV     BX,DI
    CALL    strlen2
    MOV     DX,CX
    POP     ES
    JCXZ    stc_8
    MOV     AL,20h    ; ' '
    REPZ    STOSB
    SUB     DI,DX
;;    MOV     BX,SI
    CALL    strlen1
    SUB     DX,CX
    JNS     stc_2
    ADD     CX,DX
    JMP     stc_6
stc_2:    
    SHR     DX,1
    ADD     DI,DX
stc_6:    
    REPZ    MOVSB
stc_8:    
    OR      DX,DX
    JNS     stc_10
    STC
    JMP     stc_12
stc_10:    
    CLC
stc_12:    
    APOP    SI,DI,DX,CX,AX
    RETF
STR_CENTER	ENDP

LIBSEG	ENDS
	end
