	page	66,132
;******************************** MKEY05.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
TO_UPPER - converts ascii character to upper case
;
; inputs:    AX = keycode returned by KEY_READ or AH=0, AL=ascii
; 
; output:    AL = upper case ascii
;* * * * * * * * * * * * * *

	PUBLIC	TO_UPPER
TO_UPPER		PROC	FAR
    OR      AH,AH
    JNZ     tou_exit
    CMP     AL,61h    ; 'a'
    JB      tou_exit
    CMP     AL,7Ah    ; 'z'
    JA      tou_exit
    AND     AL,0DFh
tou_exit:
    RETF
TO_UPPER ENDP

LIBSEG	ENDS
	end
