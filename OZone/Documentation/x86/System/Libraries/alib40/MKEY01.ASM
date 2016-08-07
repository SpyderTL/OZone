	page	66,132
;******************************** MKEY01.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
IS_ALPHA - check if key returned by KEY_READ is a letter from A-Z or a-z.
;
; inputs:    AX = keycode returned by KEY_READ or AH=0, AL=ascii
; 
; output:    if CF = 0, keycode is a character from A-Z or a-z
;            if CF = 1, keycode is not a character from A-Z or a-z
;* * * * * * * * * * * * * *

	PUBLIC	IS_ALPHA
IS_ALPHA		PROC	FAR
	or	ah,ah
	jnz	ia_not		;jmp if not alpha
	cmp	al,'A'
	jb	ia_not		;jmp if not alpha
	cmp	al,'Z'
	jbe	ia_yes		;jmp if alpha
	cmp	al,'a'
	jb	ia_not		;jmp if not alpha
	cmp	al,'z'
	ja	ia_not		;jmp if not alpha
ia_yes:	clc
	jmp	ia_exit
ia_not:	stc
ia_exit:retf	
IS_ALPHA ENDP

LIBSEG	ENDS
	end
