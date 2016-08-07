	page	66,132
;******************************** MKEY18.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
IS_TEXT - check if key returned by KEY_READ is 20H-7EH or tab
;
; inputs:    AX = keycode returned by KEY_READ or AH=0, AL=ascii
; 
; output:    if CF = 0, keycode is text
;            if CF = 1, keycode is not text
;* * * * * * * * * * * * * *

	PUBLIC	IS_TEXT
IS_TEXT		PROC	FAR
	or	ah,ah
	jnz	ia_not		;jmp if not TEXT
	cmp	al,9		;check if tab
	je	ia_yes		;jmp if tab
	cmp	al,' '
	jb	ia_not		;jmp if not text
	cmp	al,7eh
	ja	ia_not		;jmp if not TEXT
ia_yes:	clc
	jmp	ia_exit
ia_not:	stc
ia_exit:retf	
IS_TEXT ENDP

LIBSEG	ENDS
	end
