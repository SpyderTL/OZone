	page	66,132
;******************************** MKEY02.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
IS_DIGIT - check if key returned by KEY_READ is the ASCII from 0-9
;
; inputs:    AX = keycode returned by KEY_READ or AH=0, AL=ascii
; 
; output:    if CF = 0, keycode is a character from 0-9
;            if CF = 1, keycode is not a character from 0-9
;* * * * * * * * * * * * * *

	PUBLIC	IS_DIGIT
IS_DIGIT		PROC	FAR
    OR      AH,AH
    JNZ     ID_NOT
    CMP     AL,'0'
    JB      ID_NOT
    CMP     AL,'9'
    JA      ID_NOT
    CLC
    JMP     ID_EXIT
ID_NOT:
    STC
ID_EXIT:            
    RETF
IS_DIGIT ENDP

LIBSEG	ENDS
	end
