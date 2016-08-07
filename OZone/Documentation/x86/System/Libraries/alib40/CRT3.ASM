	page	66,132
;******************************** CRT3.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	INCLUDE  COMMON.INC
.list
;----------------------------------------------------------------------------
	EXTRN	REPEAT_PUT_CRT:FAR
	EXTRN	$VERTICAL_REPEAT_CHR:NEAR
	EXTRN	LIB_INFO:BYTE
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
TABULAR_DRAW - Subroutine to draw using a table   tabular_draw
;
;   inputs:    ah = color
;           ds:bx = table ptr
;                   table =    db repeat count (negative for columns)
;                              db char
;                              db column
;                              db row
;                       above blocks are repeated until ( dw -1) is found.
;
; output:  registers changed = ax,bx,cx,dx,si,di
;
; notes:  Each table entry can draw a line either horizontally or
;         vertically.
;* * * * * * * * * * * * * *


dtbl	struc
 dcnt	db	?
 dchar	db	?
 dcol	db	?
 drow	db	?
dtbl	ends
;-----------------------------
	PUBLIC	TABULAR_DRAW
TABULAR_DRAW	PROC	FAR
	mov	dx,word ptr ds:[bx.dcol]
	mov	al,[bx.dchar]
	sub	cx,cx
	mov	cl,[bx.dcnt]
	test	cl,80h
	jnz	tab_col		;jmp if column repeat
	call	repeat_put_crt
	jmp	td_term
tab_col:
	and	cl,7fh		;remove flag bit
	mov	si,cx
	push	bx
	sub	bx,bx
	mov	bl,lib_info.crt_columns
	mov	cx,1
	call	$vertical_repeat_chr
	pop	bx
td_term:	
	add	bx,size dtbl
	cmp	word ptr [bx],-1
	jne	tabular_draw
	retf
TABULAR_DRAW	ENDP


LIBSEG	ENDS
	end
