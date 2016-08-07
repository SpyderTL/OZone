	page	66,132
;******************************** STR27.ASM  *********************************

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
STR_CHAR_DEL - deletes a character from a string
;
; inputs:    DS:[SI] points to string
;            AX = offset from DS:[BX] to character to delete
;            
; output:    CX = string length
;* * * * * * * * * * * * * *

	PUBLIC	STR_CHAR_DEL
STR_CHAR_DEL	PROC	FAR
	call	strlen1
STR_CHAR_DEL	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_CHAR_DELC - deletes a character from a string of n-length
;
; inputs:    DS:[SI] pointing to an ASCIIZ string
;            CX = current string length
;            AX = offset from DS:[BX] to character to delete
;            
; output:    CX = string length
;* * * * * * * * * * * * * *

	PUBLIC	STR_CHAR_DELC
STR_CHAR_DELC	PROC	FAR
    CLD
    CMP     AX,CX
    JAE     scd_exit
    APUSH   DI,SI,ES
    MOV     DI,SI
    PUSH    DS
    POP     ES
    ADD     DI,AX
    MOV     SI,DI
    INC     SI
    PUSH    CX
    SUB     CX,AX
    REPZ    MOVSB
    POP     CX
    DEC     CX
    APOP    ES,SI,DI
scd_exit:
    RETF
STR_CHAR_DELC ENDP

LIBSEG	ENDS
	end
