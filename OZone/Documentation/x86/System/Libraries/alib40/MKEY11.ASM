	page	66,132
;******************************** MKEY11.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	key_check:far
	extrn	key_read:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
KEY_IF_READY - get next key waiting from keyboard
;
; inputs:    none
; 
; output:    AX = 0 if no key waiting
;            AX = keycode
;* * * * * * * * * * * * * *

	PUBLIC	KEY_IF_READY
KEY_IF_READY	PROC	FAR
    CALL    KEY_CHECK		;returns 0=no key  1=KEY WAITING
    OR      AL,AL
    JZ      kir_exit
    JMP     KEY_READ		;returns al=key  ah=0(normal key) 1(extended)
kir_exit:
    RETF
KEY_IF_READY	ENDP

LIBSEG	ENDS
	end
