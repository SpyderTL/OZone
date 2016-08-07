	page	66,132
;******************************** MKEY07.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;-----------------------------------------
	PUBLIC	CAPS_ON,NUMLOCK_ON,SCROLL_ON,INSERT_OFF
	PUBLIC	CAPS_OFF,NUMLOCK_OFF,SCROLL_OFF
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
CAPS_ON - Turn the keyboard CAPS LOCK key on
;
; inputs:  none
; output:  none
;* * * * * * * * * * * * * *

CAPS_ON	PROC	FAR
    push    ax
    MOV     AX,40FFh
    JMP     keyboard_set
CAPS_ON	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
NUMLOCK_ON - Turn the keyboard NUM LOCK key on
;
; inputs:  none
; output:  none
;* * * * * * * * * * * * * *


NUMLOCK_ON	PROC	FAR
    push    ax
    MOV     AX,20FFh
    JMP     keyboard_set
NUMLOCK_ON	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
SCROLL_ON - Turn the keyboard SCROLL LOCK key on
;
; inputs: none
; output: none
;* * * * * * * * * * * * * *


SCROLL_ON	PROC	FAR
    push    ax
    MOV     AX,10FFh
    JMP     keyboard_set
SCROLL_ON	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
INSERT_OFF - Turn the keyboard INS key off
;
; inputs: none
; output: none
;* * * * * * * * * * * * * *


INSERT_OFF	PROC	FAR
    push    ax
    MOV     AX,007Fh
    JMP     keyboard_set
INSERT_OFF	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
CAPS_OFF - Turn the keyboard CAPS LOCK key off
;
; inputs: none
; output: none
;* * * * * * * * * * * * * *


CAPS_OFF		PROC	FAR
    push    ax
    MOV     AX,00BFh
    JMP     keyboard_set
CAPS_OFF ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
NUMLOCK_OFF - Turn the keyboard NUM LOCK key off
;
; inputs: none
; output: none
;* * * * * * * * * * * * * *


NUMLOCK_OFF	PROC	FAR
    push    ax
    MOV     AX,00DFh
    JMP     keyboard_set
NUMLOCK_OFF	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
SCROLL_OFF - Turn the keyboard SCROLL LOCK key off
;
; inputs: none
; output: none
;* * * * * * * * * * * * * *


SCROLL_OFF	PROC	FAR
    push    ax
    MOV     AX,00EFh
keyboard_set:
    apush   bx,es
    XOR     BX,BX
    MOV     ES,BX
    OR      BYTE PTR ES:[417h],AH
    AND     BYTE PTR ES:[417h],AL
    apop    es,bx
    pop	    ax
    RETF
SCROLL_OFF	ENDP

LIBSEG	ENDS
	end
