	page	66,132
;******************************** MKEY06.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
TO_LOWER - converts ascii character lower case
;
; inputs:    AX = keycode returned by KEY_READ or AH=0, AL=ascii
; 
; output:    AL = lower case ascii
;* * * * * * * * * * * * * *

	PUBLIC	TO_LOWER
TO_LOWER		PROC	FAR
    or	    ah,ah
    JNZ     tol_exit
    CMP     AL,41h    ; 'A'
    JB      tol_exit
    CMP     AL,5Ah    ; 'Z'
    JA      tol_exit
    OR      AL,20h    ; ' '
tol_exit:
    RETF
TO_LOWER ENDP

LIBSEG	ENDS
	end
