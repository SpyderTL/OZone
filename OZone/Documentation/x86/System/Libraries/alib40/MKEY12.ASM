	page	66,132
;******************************** MKEY12.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	move_mouse:far
	extrn	box_the_mouse:far
	extrn	lib_info:byte
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
SETUP_MOUSE -  initializes mouse driver if mouse present
;
; inputs:    none
; 
; output:    no carry - mouse is initialized
;               carry - mouse was not found
;* * * * * * * * * * * * * *

	PUBLIC	SETUP_MOUSE
SETUP_MOUSE	PROC	FAR
    APUSH   BX,CX,DX,ES
    XOR     AX,AX
    INT     33h			;reset mouse & get status
    AND     AX,BX
    JZ	    mi_no_mouse		;jmp if no mouse installed
    MOV     cs:lib_info.mouse_present,al
;
; position mouse cursor to left edge
;
	mov	dx,0101h
	call	move_mouse
;
; set range of mouse movement
;
	mov	dx,0000h	;upper left corner of box (row/col)
	mov	bx,184fh	;box size 24 rows, 79 columns
	call	box_the_mouse
	clc
	jmp	mi_exit		    
mi_no_mouse:
    stc    
mi_exit:
    APOP    ES,DX,CX,BX
    RETF
SETUP_MOUSE	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
MOUSE_PARMS - determine mouse position & buttons pressed
;
; inputs:    none
; 
; output:    if ZF = 1, no buttons are pressed
;            if ZF = 0, BX = button code
;             BX bit 0 if set = left button is down
;             BX bit 1 if set = right button is down
;             BX bit 2 if set = center button is down
;            CX = horizontal (x) coordinate
;            DX = vertical (y) coordinate
;            
; Note that mouse positions are expressed as a pixel location
;* * * * * * * * * * * * * *

	PUBLIC	MOUSE_PARMS
MOUSE_PARMS	PROC	FAR
   PUSH    AX
   PUSH    ES
   MOV     AX,0003		;return mouse status
   INT     33h			;return cx=column dx=row bx=button (left=0001)
   AND     BX,+07
   XOR     AX,AX
   MOV     ES,AX
   MOV     AL,BYTE PTR ES:[0449h]	;get current video mode
   CMP     AL,04
   JB      X_0034			;
   CMP     AL,05
   JA      X_0034
   SHR     CX,1				;adjust row if crt mode 5
X_0034:
   POP     ES
   POP     AX
   RETF
MOUSE_PARMS	ENDP

LIBSEG	ENDS
	end
