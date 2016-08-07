	page	66,132
;******************************** MKEY03.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
IS_LOWER - check if key returned by KEY_READ is lower case
;
; inputs:    AX = keycode returned by KEY_READ or AH=0, AL=ascii
; 
; output:    if CF = 1, keycode is not a character from a-z
;* * * * * * * * * * * * * *

	PUBLIC	IS_LOWER
IS_LOWER		PROC	FAR
    OR      AH,AH
    JNZ     isl_exit
    CMP     AL,'a'
    JB      isl_exit
    CMP     AL,'z'
    JA      isl_exit
    CLC
    RETF
isl_exit:
    STC
    RETF
IS_LOWER ENDP


LIBSEG	ENDS
	end
