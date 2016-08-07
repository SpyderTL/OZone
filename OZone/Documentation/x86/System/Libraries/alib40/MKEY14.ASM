	page	66,132
;******************************** MKEY14.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
MOVE_MOUSE - sets the mouse's position
;
; inputs:  dh = text mode row#
;	   dl = text mode column#
;	   
; output:  none
;* * * * * * * * * * * * * *

	PUBLIC	MOVE_MOUSE
MOVE_MOUSE	PROC	FAR
   APUSH   AX,CX,DX
   call    make_pixels
   mov	   ax,4
   int	   33h			;set mouse cx=column dx=row
   APOP    DX,CX,AX
   RETF
MOVE_MOUSE	ENDP
;---------------------------
; convert dx -- dl*8->cx  dh*8->dx
;
	public	make_pixels
make_pixels:
   MOV	   cx,dx		;put column in -cx-
   mov	   ch,0			;strip row
   shl	   cx,1			;convert column
   shl	   cx,1			;  to pixels
   shl	   cx,1			;    (column * 8)

   xchg    dh,dl		;move row# to -dl-
   mov	   dh,0			;strip column info
   shl	   dx,1			;convert row
   shl	   dx,1			;  to pixels
   shl	   dx,1			;    (column * 8)
   ret


LIBSEG	ENDS
	end
