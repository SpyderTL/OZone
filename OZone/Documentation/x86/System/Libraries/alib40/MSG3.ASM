	page	66,132
;******************************** MSG3.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	message:far
	extrn	msg_text_color:byte
	extrn	err_asciiz:byte
	extrn	bar_hotkey_color:byte
	extrn	save_window:far
	extrn	restore_window:far
	extrn	draw_box:far
	extrn	key_read:far
	extrn	window_string:far
	extrn	box_shrink:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( MESSAGE )
QMESSAGE - Quick message display in box & wait for keypress (msg in file)
;
; inputs:     cx = record # to display.
; 
; output:  carry set if error reading file on disk. File must be in current
;          default directory.
;          
; note:    The display location, colors, and box size is calculated.
;          The message is obtained from the standard error file, See
;          ERROR_PRIME for selecting file to use.  The message is placed
;          in a box 10 rows long and 40 columns wide.  It waits for any
;          key before preceeding.
;* * * * * * * * * * * * * *

	public	qmessage
QMESSAGE	PROC	FAR
	apush	ax,bx,cx,dx,si,di,bp,ds,es
	mov	ax,cs
	mov	ds,ax
	mov	ah,msg_text_color
	mov	al,0			;separator of zero
	mov	bx,0a28h			;box is 10 lines long, 40 columns wide
	mov	dx,0814h		;box at row 8 column 20
	mov	si,offset err_asciiz	;get filename ptr
	mov	bp,msg_save_win+msg_restore_win+msg_anykey+msg_open+msg_close+msg_disp
	call	message
	apop	es,ds,bp,di,si,dx,cx,bx,ax
	retf	
QMESSAGE	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( MESSAGE )
QWARN - Quick message display in box & wait for keypress (msg in mem)
;
; inputs:  ds:si = pointer to message text, zero at end.
; 
; output:  none
; 
; note:    The display location, colors, and box size is calculated.
;* * * * * * * * * * * * * *

qsav_si	dw	0
qsav_ds	dw	0

	public	qwarn
QWARN	PROC	FAR
	apush	bx,cx,dx,si,di,ds,es
	mov	cs:qsav_ds,ds
	mov	bx,cs
	mov	ds,bx
	mov	es,bx

	mov	qsav_si,si
;
	mov	ah,byte ptr bar_hotkey_color
	mov	dx,0101h
	mov	bx,0630h
;
	call	save_window
	call	draw_box
	call	box_shrink
	push	es
	pop	ds
	mov	ah,byte ptr bar_hotkey_color
;
; display the error text inside the box
;
	push	ds
	mov	si,cs:qsav_si
	mov	ds,cs:qsav_ds
	call	window_string
	pop	ds
;
; check type of exit processing, and wait for key if necessary, then exit
;
error_key:
	call	KEY_READ			;get key press
	call	restore_window
	apop	es,ds,di,si,dx,cx,bx
	retf
QWARN	ENDP
;-----------------------------------------------------------------------------

LIBSEG	ENDS
	end
