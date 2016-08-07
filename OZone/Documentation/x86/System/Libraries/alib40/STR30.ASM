	page	66,132
;******************************** STR30.ASM  *********************************

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
STR_SET - sets all bytes of string to a specified character
;
; inputs:    DS:[SI] pointing to a string
;            AL = character
;            
; output:    none
;* * * * * * * * * * * * * *

	PUBLIC	STR_SET
STR_SET	PROC	FAR
	call	strlen1
STR_SET	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_SETC - sets n bytes of string to a specified character
;
; inputs:    DS:[SI] points to string
;            AL = character
;            CX = number of bytes to set
;            
; output:    none
;* * * * * * * * * * * * * *

	PUBLIC	STR_SETC
STR_SETC	PROC	FAR
    CLD
    APUSH   CX,DI,ES
    MOV     DI,DS
    MOV     ES,DI
    MOV     DI,SI
    REPZ    STOSB
    APOP    ES,DI,CX
    RETF
STR_SETC ENDP

LIBSEG	ENDS
	end
