	page	66,132
;******************************** MKEY04.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
IS_UPPER - check if key returned by KEY_READ is upper case
;
; inputs:    AX = keycode returned by KEY_READ or AH=0, AL=ascii
;
; output:   if CF = 1, keycode is not a character from A-Z
;* * * * * * * * * * * * * *

	PUBLIC	IS_UPPER
IS_UPPER		PROC	FAR
    or	    ah,ah
    JNZ     isu_exit
    CMP     AL,41h    ; 'A'
    JB      isu_exit
    CMP     AL,5Ah    ; 'Z'
    JA      isu_exit
    CLC
    RETF
isu_exit:
    STC
    RETF
IS_UPPER ENDP

LIBSEG	ENDS
	end
