	page	66,132
;******************************** MKEY15.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	make_pixels:near
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
BOX_THE_MOUSE - limits mouse's range of motion
;
; inputs:    dx = box upper left corner (dh=row, dl=column)
;	     bx = box size (bh = number of rows,  bl = number of columns)
;
; output:   none
;* * * * * * * * * * * * * *

	PUBLIC	BOX_THE_MOUSE
BOX_THE_MOUSE	PROC	FAR
	apush	ax,bx,cx,dx
	call	make_pixels	;dx -> cx=left column  dx=top row
	mov	dx,bx
	mov	bx,cx		   ;save left column
	call	make_pixels	;dx -> cx=columns*8   dx=rows*8
;
; bx=left column  cx=columns*8
; stack=top row   dx=rows*8
;
	xchg	cx,bx		;cx=left column  bx=columns*8
	xchg	bx,dx		;dx=columns*8	 bx=rows*8
;
; cx = left column    bx=rows*8
; dx = columns * 8    stack=top row
;
	add	dx,cx		;compute right column
	mov	ax,7
	int	33h		;set left column(cx)  right column(dx)

	apop	dx,cx,bx,ax
	retf
BOX_THE_MOUSE	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
MOUSE_CURSOR_ON - Enable the mouse cursor display
;
; inputs:  none
; output:  none
;* * * * * * * * * * * * * *

	PUBLIC	MOUSE_CURSOR_ON
MOUSE_CURSOR_ON	PROC	FAR
   PUSH    AX
   MOV     AX,0001
   INT     33h
   POP     AX
   RETF
MOUSE_CURSOR_ON	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
MOUSE_CURSOR_OFF - Disable the mouse cursor display
;
; inputs:  none
; output:  none
;* * * * * * * * * * * * * *

	PUBLIC	MOUSE_CURSOR_OFF
MOUSE_CURSOR_OFF	PROC	FAR
   PUSH    AX
   MOV     AX,0002
   INT     33h
   POP     AX
   RETF
MOUSE_CURSOR_OFF	ENDP

LIBSEG	ENDS
	end
