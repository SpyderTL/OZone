	page	66,132
;******************************** MKEY13.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	key_if_ready:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
KEY_OR_MOUSE - waits for first keypress or mouse button click
;
; inputs:    none
;
; output:    AX = keycode, BX = mouse button
;
; note:  If a keycode is found it is returned and the mouse status
;        is not checked.
;* * * * * * * * * * * * * *

	PUBLIC	KEY_OR_MOUSE
KEY_OR_MOUSE	PROC	FAR
   CALL    KEY_IF_READY		;return ax=0(none) 1(key waiting)
   XOR     BX,BX
   OR      AX,AX
   JNZ     KOM_EXIT		;jmp if key waiting
   MOV     AX,0003
   PUSH    CX
   PUSH    DX
   XOR     BX,BX
   INT     33h		;returns cx=column dx=row bx=button pressed (left=0001)
   POP     DX
   POP     CX
   AND     BX,+07
   JZ      KEY_OR_MOUSE		;jmp if no mouse clicks
   XOR     AX,AX
KOM_EXIT:
   RETF
KEY_OR_MOUSE	ENDP

LIBSEG	ENDS
	end
