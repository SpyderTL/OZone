	page	66,132
;******************************** STR23.ASM  *********************************

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
STR_RIGHT - right-justifies a string1 in string2
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

	PUBLIC	STR_RIGHT
STR_RIGHT	PROC	FAR
    APUSH   AX,CX,DX,DI,SI
    CLD
    PUSH    ES
    PUSH    DS
    POP     ES
;;    MOV     BX,DI
    CALL    strlen2
    MOV     DX,CX
    POP     ES
    JCXZ    src_2
    MOV     AL,20h    ; ' '
    REPZ    STOSB
;;    MOV     BX,SI
    CALL    strlen1
    SUB     DI,CX
    SUB     DX,CX
    JNS     src_0
    SUB     DI,DX
    ADD     CX,DX
src_0:    
    REPZ    MOVSB
src_2:    
    OR      DX,DX
    JNS     src_A
    STC
    JMP     src_exit
src_A:    
    CLC
src_exit:    
    APOP    SI,DI,DX,CX,AX
    RETF
STR_RIGHT	ENDP

LIBSEG	ENDS
	end
