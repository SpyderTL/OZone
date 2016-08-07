	page	66,132
;******************************** CONV03.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
DWORD_TO_DEC_STR - convert a long integer value to an ASCIIZ string
;
; inputs:    DS:[SI] - pointing to a buffer space
;            DX:AX = long integer value
;            DWORD_TO_DEC_STR requires a 12-byte (or greater) buffer
;            
; output:    ASCIIZ string at DS:[SI]; numerals are right-justified
;* * * * * * * * * * * * * *

	PUBLIC	DWORD_TO_DEC_STR
DWORD_TO_DEC_STR	PROC	FAR
    APUSH   AX,BX,CX,DX,DI,SI,ES,DS
    POP     ES
    MOV     DI,SI
    CLD
    MOV     BX,AX
    MOV     CX,000Bh
    MOV     AL,20h    ; ' '
    REPZ    STOSB
    MOV     ES:[DI],CL
    MOV     AX,BX
    MOV     SI,000Ah
    OR      DX,DX
    PUSHF
    JNS     lts_cont		;jmp if positive
    NOT     AX
    NOT     DX
    ADD     AX,0001
    ADC     DX,+00
lts_cont:    
    MOV     CX,AX
    MOV     AX,DX
    XOR     DX,DX
    DIV     SI
    MOV     BX,AX
    MOV     AX,CX
    DIV     SI
    XCHG    DX,BX
    ADD     BL,30h    ; '0'
    DEC     DI
    MOV     ES:[DI],BL
    MOV     BX,AX
    OR      BX,DX
    JNZ     lts_cont
    DEC     DI
    MOV     AL,20h    ; ' '
    POPF
    JNS     lts_exit
    MOV     AL,2Dh    ; '-'
lts_exit:    
    STOSB
    APOP    ES,SI,DI,DX,CX,BX,AX
    RETF
DWORD_TO_DEC_STR ENDP

LIBSEG	ENDS
	end
