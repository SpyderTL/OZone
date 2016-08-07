	page	66,132
;********************************  CRT5.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	INCLUDE  COMMON.INC
.list
;----------------------------------------------------------------------------
;----------------------------------------------------------------------------
	EXTRN	$PUT_CRT_CHR:NEAR
	EXTRN	$REPEAT_PUT_CRT:NEAR
	EXTRN	POSN_TO_ADR:NEAR
	EXTRN	ADR_TO_POSN:NEAR
	EXTRN	$PUT_CRT_BLK:NEAR
	EXTRN	$VERTICAL_REPEAT_CHR:NEAR
	EXTRN	LIB_INFO:BYTE
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
CLEAR_WINDOW - fill area of screen
;
; inputs:    dx = window position dh=row  dl=column
;            bx = window size	bh=rows in window  bl=columns in window
;            AH = color attribute
;            AL = fill character
;            
;  output:   nothing
;
;  notes:  The dx,bx registers define a box on the screen in standard
;          library format (see DRAW_BOX).
;* * * * * * * * * * * * * *

	PUBLIC	clear_window
clear_window	PROC	FAR
	apush	ax,bx,cx,dx,si,es
	call	box_shrink
	call	posn_to_adr
	sub	cx,cx
	mov	cl,bl			;cx=columns in box

	xchg	bh,bl
	mov	bh,0
	mov	si,bx			;number of rows in box

	mov	bl,lib_info.crt_columns
	shl	bx,1
	mov	es,lib_info.crt_seg
;
; ax = char   es:di=display ptr   bx=next row bump  cx=repeat count  si=row cnt
;
	call	$vertical_repeat_chr
	apop	es,si,dx,cx,bx,ax
	retf
clear_window	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
DRAW_BOX -  draw a box on screen
;
; inputs:    dx = box address	dh=row	dl=column
;	     bx = box size   dh=rows in box  dl=columns in box
;            AH = color attribute
;	     AL = box frame type  0=single line
;		                  1=double line
; output: none
;
; notes:  The center of the box is cleared as it is drawn.
;         Box parameters are not checked for illegal sizes so beware.
;* * * * * * * * * * * * * *

;-----------------------
box_table0	db	'ÚÄ¿³ ³ÀÄÙ'
box_table1	db	'ÉÍ»º ºÈÍ¼'
;-----------------------
	PUBLIC	DRAW_BOX
DRAW_BOX	PROC	FAR
	apush	ax,bx,cx,dx,si,di,ds,es
	push	cs
	pop	ds
	mov	es,cs:lib_info.crt_seg
	mov	si,offset box_table0
	cmp	al,0
	je	db_01			;jmp if single line box
	mov	si,offset box_table1
db_01:	call	$box_line
	add	si,3			;move to next char
db_02:	add	dh,1			;move to next line
	call	$box_line
	dec	bh
	cmp	bh,1
	jne	db_02			;loop till box center done

	add	si,3
	call	$box_line		;display last line of box
	apop	es,ds,di,si,dx,cx,bx,ax
	retf
		
DRAW_BOX	ENDP
;---------------------
; display one line of box using 3 frame characters stored at ds:si
;
; inputs:  ds:si = pointer to 3 box frame characters
;             ah = color
;             dx = crt address
;             bl = columns in box center
;             es = display seg
;
$box_line:
	push	si
	call	posn_to_adr
	lodsb				;get box char for left column
	call	$put_crt_chr		;display left column char
	lodsb
	sub	cx,cx
	mov	cl,bl			;get column count
	sub	cl,2
	call	$repeat_put_crt
	lodsb
	call	$put_crt_chr
	pop	si
	ret
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
WINDOW_STRING -  display string in window.
;
; inputs: DS:[SI] = pointer to the string
;	       dx = starting row(dh)  starting column(dl)
;	       bx = box total rows(bh)  box total columns(bl)
;              AH = color attribute
;              
; outputs:   none
;
; notes:  String must be terminated with null character.
;         Strings will wrap if cr/lf is found or edge of box is encountered.
;         Any area to right of string is cleared up to edge of box.
;         String which wrap will try not to split words.
;* * * * * * * * * * * * * *

;---------------------------
ws_str_ptr	dw	0
ws_wscan_cx	dw	0			;scan for word break cx save
ws_lp_cnt	db	0
;---------------------------
	PUBLIC	WINDOW_STRING
WINDOW_STRING	PROC	FAR
	apush	ax,bx,cx,dx,si,di,bp,ds,es
	mov	es,cs:lib_info.crt_seg
	mov	cs:ws_lp_cnt,bh
;
; skip over any cr/lf characters at start of this line
;
ws_10:	mov	cx,0				;set line length to zero
ws_10a: cmp	byte ptr [si],0
	jne	ws_11				;jmp if not at end of string
	call	posn_to_adr
	jmp	ws_40				;go fill line with blanks
ws_11:	cmp	byte ptr [si],0dh
	je	ws_12				;jmp if carriage-return found
	cmp	byte ptr [si],0ah
	jne	ws_13				;jmp if no cr/lf chars found
ws_12:	inc	si
	jmp	ws_10a
;
; the first character of string has been found, not cr/lf/zero, find line len
;
ws_13:	mov	cs:ws_str_ptr,si		;save si

ws_20:	cmp	byte ptr [si],0
	je	ws_30				;jmp if end of line
	cmp	byte ptr [si],0dh
	je	ws_30				;jmp if end of line
	cmp	byte ptr [si],0ah
	je	ws_30				;jmp if end of line
	inc	cx				;count this char
	inc	si
	cmp	cl,bl				;check if at box right edge
	jne	ws_20				;jmp if still within box
;
; we have filled to the right edge of the box, now scan back for word break
;
	mov	cs:ws_wscan_cx,cx		 ;save ending char. count
ws_22:	dec	si
        cmp     byte ptr [si],' '
	je	ws_30				;jmp if char break found
	loop	ws_22
;
; no word breaks were found, so display line as is
;
	mov	cx,cs:ws_wscan_cx
;
; si =ptr to line end,	cx = length of line
;
ws_30:	mov	si,cs:ws_str_ptr		 ;restore line start ptr
	mov	cs:ws_wscan_cx,cx
	call	posn_to_adr			;compute starting display offset
	call	$put_crt_blk
;
; now check if we need to fill to end of box with blanks
;
	mov	cx,cs:ws_wscan_cx		;restore -cx-
ws_40:	sub	cl,bl				;display count - box size
	neg	cl
	jz	ws_50				;jmp if no fill needed
;
; clear remainder of this line on display
;
	push	si
	mov	si,1
        mov     al,' '
	call	$vertical_repeat_chr
	pop	si
;
; check if last line of box has been filled
;
ws_50:	inc	dh				;move to next row on display
	dec	cs:ws_lp_cnt			;decrement row count
	jnz	ws_10				;loop till done

WS_EXIT:
	apop	es,ds,bp,di,si,dx,cx,bx,ax
	RETF
WINDOW_STRING	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
BOX_RIGHT - move box parameters right
;
; inputs:  dx = box display address,  dh=row  dl=column
;          bx = box size,  bh=rows in box  bl=columns in box
;          
; output:  dx = box row (dh) and box column (dl) moved one position
;          bx = box size, number of rows (bh), number of columns (bl)
;* * * * * * * * * * * * * *

	public	box_right
box_right	proc	far
	inc	dl
	cmp	dl,lib_info.crt_columns
	je	box_left			;jmp if too far to right
	retf
box_right	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
BOX_LEFT -  move box parameters left
;
; inputs:  dx = box display address,  dh=row  dl=column
;          bx = box size,  bh=rows in box  bl=columns in box
;          
; output:  dx = box row (dh) and box column (dl) moved one position
;          bx = box size, number of rows (bh), number of columns (bl)
;* * * * * * * * * * * * * *

	public	box_left
box_left	proc	far
	dec	dl
	cmp	dl,-1
	je	box_right			;jmp if too far to left
	retf
box_left	endp
comment  
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
BOX_UP - move box parameters up one position
;
; inputs:  dx = box display address,  dh=row  dl=column
;          bx = box size,  bh=rows in box  bl=columns in box
;          
; output:  dx = box row (dh) and box column (dl) moved one position
;          bx = box size, number of rows (bh), number of columns (bl)
;* * * * * * * * * * * * * *

	public	box_up
box_up		proc	far
	dec	dh
	cmp	dh,-1
	je	box_down			;jmp if too high
	retf
box_up		endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
BOX_DOWN - move box parameters down one position
;
; inputs:  dx = box display address,  dh=row  dl=column
;          bx = box size,  bh=rows in box  bl=columns in box
;          
; output:  dx = box row (dh) and box column (dl) moved one position
;          bx = box size, number of rows (bh), number of columns (bl)
;* * * * * * * * * * * * * *

	public	box_down
box_down	proc	far
	inc	dh
	cmp	dh,lib_info.crt_rows
	je	box_up				;jmp if too low
	retf
box_down	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
BOX_EXPAND - expand box one position in all directions
;
; inputs:  dx = box display address,  dh=row  dl=column
;          bx = box size,  bh=rows in box  bl=columns in box
;          
; output:  if no carry
;          dx = box row (dh) and box column (dl) moved one position
;          bx = box size, number of rows (bh), number of columns (bl)
;          if carry, then error occured and data invalid
;* * * * * * * * * * * * * *

	public	box_expand
box_expand	proc	far
	dec	dh				;upper left corner up 1
	cmp	dh,-1
	je	be_code_err

	dec	dl				;upper left corner left 1
	cmp	dl,-1
	je	be_code_err

	add	bh,2				;rows in box +2
	add	bh,dh
	cmp	bh,lib_info.crt_rows
	jae	be_code_err
	sub	bh,dh				;restore correct row count

	add	bl,2				;columns in box +2
	add	bl,dl
	cmp	bl,lib_info.crt_columns
	jae	be_code_err
	sub	bl,dl
	clc
	jmp	be_exit

be_code_err:
	stc
be_exit:
	retf
box_expand	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
BOX_SHRINK - shrink box parameters one position in all directions
;
; inputs:  dx = box display address,  dh=row  dl=column
;          bx = box size,  bh=rows in box  bl=columns in box
;          
; output:  if no carry
;          dx = box row (dh) and box column (dl) moved one position
;          bx = box size, number of rows (bh), number of columns (bl)
;          if carry, error occured, data invalid
;* * * * * * * * * * * * * *

	public	box_shrink
box_shrink	proc	far
	inc	dh
	cmp	dh,lib_info.crt_rows
	jae	bs_code_err

	inc	dl
	cmp	dl,lib_info.crt_columns
	jae	bs_code_err

	cmp	bh,2
	jbe	bs_code_err
	sub	bh,2				;rows in box

	sub	bl,2				;columns in box
	cmp	bl,2
	ja	bs_exit
bs_code_err:
	stc
	jmp	bs_exit1
bs_exit:
	clc
bs_exit1:
	retf
box_shrink	endp


LIBSEG	ENDS
	end
