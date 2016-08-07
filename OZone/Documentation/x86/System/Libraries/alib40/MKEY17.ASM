	page	66,132
;******************************** MKEY17.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	box_shrink:far
	extrn	key_read:far
	extrn	key_decode:far
	extrn	make_sound:far
	extrn	is_alpha:far
	extrn	get_string:far
	extrn	DEC_STR_TO_WORD:far
	extrn	message:far
	extrn	posn_to_adr:near
	extrn	adr_to_posn:near
	extrn	$vertical_repeat_chr:near
	extrn	lib_info:byte
	extrn	msg_text_color:byte
	extrn	msg_hyper_color:byte
	extrn	bar_select_color:byte
	extrn	bar_text_color:byte
	extrn	key_flags:byte
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�
;---window__edit-- database

buffer_end	dw	0	;offset of last legal char

hr_text1	db	' This word can not be selected because it has one of'
		db	' the following problems: 1)word does no start with a'
		db	' space 2)word does not end with a space 3)illegal'
		db	' character appears in this word.',0

hr_text2	db	'What record number should be triggered here',0

hr_text3	db	'This is an existing hyper word.',0dh,0ah
		db	'Enter new record# or zero to delete this trigger',0

hr_text4	db	'Hyper record# out of range.  Legal range is 1-221',0

hr_buf		db	8 dup (0)			
hr_rec		db	0		;record # for hyper entry 1-221
dirty_flag	db	0		;set if changes made
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
WINDOW_EDIT - edit text within window
;
;  inputs:  bx = window frame size (bh-rows bl=columns)
;           dx = window position (dh=row dl=column)
;        ds:si = data for window
;           cx = size of data buffer (must be larger than window by 20%)
;           
;  outputs:	ah = -1 (abort key pressed)
;               al = last key press if normal exit
;               carry set = changes make to buffer
;              
;  processing:  1. display window data with cursor, then respond
;                  to edit keys:  ctrl-c  = abort
;                                 Enter   = break this line
;                                 ESC     = exit edit mode
;                                 right   = cursor right
;                                 left    = cursor left
;                                 up      = cursor up
;                                 down    = cursor down
;                                 home    = cursor to left edge
;                                 end     = cursor to right edge
;                                 del     = delete char. under cursor
;                                 back    = delete & move back
;                                 F1      = hyper word select
;
; note:  Normal ascii characters are entered into the buffer and
;        the buffer updated.  The state of INS key determines
;        if characters are inserted or overtype occurs.  Illegal
;        key cause a beep and are ignored.
;* * * * * * * * * * * * * *

	public	window_edit
window_edit	proc	far
	apush	bx,cx,dx,si,di,es	
	call	box_shrink		;compute

	dec	cx
	mov	cs:buffer_end,cx	;compute
	add	cs:buffer_end,si	;  end of buffer offset
	mov	di,si
	mov	cs:key_flags,0		;clear flags in key_decode
;
; bx=box size dx=box location  ds=buffer segment
;	
we_loop:
	call	window_cstring
	call	key_read
	apush	bx,si
	mov	si,offset decode_table
	call	key_decode
	mov	bp,bx			;get processing ptr
	apop	si,bx
	cmp	cx,-1
	jne	do_process
	jmp	can_not_do		;jmp if illegal key press
do_process:	
	mov	cs:cursor_buf_ptr,di
	jmp	bp			;go to correct processing
;
; remove cursor from box
;	
we_exit:push	ax
	add	dx,word ptr cs:cursor_column	;compute cursor location
	call	posn_to_adr
	mov	al,cs:msg_text_color
	inc	di
	mov	byte ptr es:[di],al	;remove cursor
	pop	ax
	apop	es,di,si,dx,cx,bx
	rcl	cs:dirty_flag,1		;set carry if changes were make
	retf		
	
window_edit	endp

;-----------------------------------------------------------------------------
; The following table is used by KEY_DECODE to scan for special keys
; and determine the processing needed.
;
DECODE_TABLE	LABEL	BYTE
	db	03h		;ascii code - control-c
	db	00h		;extended flag
	dw	abort_key	;

	db	0dh
	db	0
	dw	enter_key

	db	1bh
	db	0
	dw	escape_key

	db	4dh
	db	1
	dw	right_arrow_key

	db	4bh
	db	1
	dw	left_arrow_key

	db	48h
	db	1
	dw	up_arrow_key

	db	50h
	db	1
	dw	down_arrow_key
	
	db	47h
	db	1
	dw	home_key

	db	4fh
	db	1
	dw	end_key

	db	53h
	db	1
	dw	delete_key

	db	08h
	db	0
	dw	backspace_key

	db	49h			;PGDN
	db	1
	dw	page_key

	db	51h			;PGUP
	db	1
	dw	page_key

	db	52h
	db	1
	dw	we_loop			;ignore the insert key

	db	3bh
	db	1
	dw	hyper_request

	dw	-1		;end of table
	dw	normal_key	; last entry is normal key processing
	
;-----------------------------------------------------------------------------
;KEY_PROCESSING: process key press as decoded using DECODE_TABLE
;  inputs: al = ascii code
;          ah = extended flag or -1 if bad key (bad key handled previously)
;          DS:SI = buffer top
;          ds:di = cursor posn
;          bx=box size
;          dx=box location
;-----------------
abort_key:
	mov	ah,-1		;flag abort state
page_key:
	jmp	we_exit
;------------------
enter_key:
	mov	ah,cs:cursor_row
	inc	ah
	cmp	ah,bh			;check if curosr at bottom of window
	jne	enter_key2		;  jmp if cr/lf ok
;
; simulate a cr/lf by clearing to end of buffer
;
	push	di
	push	ds
	pop	es
	mov	al,0
ek_loop:	
	stosb
	cmp	di,cs:buffer_end
	jne	ek_loop
	call	insert_char
	pop	di
	jmp	we_loop
enter_key2:
	push	di
	call	insert_char
	pop	di
	inc	di
	mov	al,0ah
	call	insert_char
	jmp	we_loop
;------------------
escape_key:
	mov	ah,-1
	jmp	we_exit
;------------------
right_arrow_key:
	call	cursor_right
	jmp	we_loop
;------------------
left_arrow_key:
	call	cursor_left
	jmp	we_loop
;-----------------
up_arrow_key:
	cmp	cs:cursor_row,0
	je	can_not_do		;jmp if at top already

	mov	bp,cs:cursor_line_tbl
	sub	bp,size line_struc	;move up one line
	jmp	up_down_common
;-----------------
down_arrow_key:
	mov	ah,cs:cursor_row
	inc	ah
	cmp	ah,bh			;check if this is last line
	je	can_not_do		;  jmp if on last line
;
; check if the next line exists
;
	mov	bp,cs:cursor_line_tbl
	mov	ax,cs:[bp.line_start]	;get cursor line start
	add	bp,size line_struc	;move to previous entry
	cmp	ax,cs:[bp.line_end]
	je	can_not_do		;jmp if no next line avail
up_down_common:
	mov	di,cs:[bp.line_start]
	mov	al,cs:cursor_column
	mov	ah,0
	add	di,ax
uak_adjust:	
	cmp	di,cs:[bp.line_end]
	jbe	uak_exit		;jmp if new cursor posn ok
	dec	di
	jmp	uak_adjust
uak_exit:	
	jmp	we_loop
;-----------------
home_key:
	mov	di,si
	jmp	we_loop
;-----------------
end_key:
	mov	al,bh			;get rows in display
	dec	al
	mov	ah,(size line_struc)
	mul	ah
	add	ax,offset line_table
	mov	di,ax
	mov	di,cs:[di.line_end]
ek_done:jmp	we_loop
;-------------------
delete_key:
	cmp	byte ptr ds:[di],0	;check if char under cursor
	je	can_not_do		;jmp if no char here
	cmp	byte ptr ds:[di],0dh
	jne	dk_cont			;jmp if not a cr/lf
	call	fill_hole
dk_cont:	
	call	fill_hole
	jmp	we_loop
;
; move end of string left 1 to cover deleted char. Fill zero at end
;
fill_hole:
	apush	si,di
	mov	si,ds
	mov	es,si
	
	mov	si,di
	inc	si
	mov	cx,cs:buffer_end
	sub	cx,di
	inc	cx
	cld
	rep	movsb
	mov	byte ptr [di],0		;put zero at end
	mov	cs:dirty_flag,80h	;set changes make flag
	apop	di,si
	ret
;-------------------
backspace_key:
	cmp	di,si
	je	can_not_do		;jmp if at top left edge
	call	cursor_left
	jmp	delete_key

;-------------------
normal_key:
	push	es
	sub	cx,cx
	mov	es,cx
	test	byte ptr es:[417h],80h
	pop	es
	jnz	insert_mode
;
; keyboard is in overtype mode
;
	mov	byte ptr ds:[di],al	;store char
	mov	cs:dirty_flag,80h	;set changes make flag
	jmp	right_arrow_key
;
; keyboard is in insert mode
;
insert_mode:
	call	insert_char
	cmp	al,0dh
	jne	im_exit
	mov	al,0ah
	call	insert_char
	dec	di
im_exit:jmp	we_loop
;-------------------
;
; The F1 key was pressed, check if:
;   1. the cursor presently points at a hyper entry.
;   2. the cursor word is not a possible hyper entry.
;   3. if not 1 or 2 ask for record # and insert hyper
;
;  inputs: al = ascii code
;          ah = extended flag or -1 if bad key (bad key handled previously)
;          DS:SI = buffer top
;          ds:di = cursor posn
;          bx=box size
;          dx=box location
;
hyper_request:
	push	di
	mov	ah,0			;force normal char. state
	mov	al,byte ptr ds:[di]	;get char under the cursor
	call	is_alpha		;check if pointing at alpha
	jnc	hr_scan			; jmp if alpha
	cmp	byte ptr [di],'-'
	je	hr_scan
	jmp	hr_msg			;jmp if illegal hyper word
;
; scan the word to verify it starts and ends with a space
;	
hr_scan:
	inc	di
	mov	al,byte ptr [di]
	call	is_alpha
	jnc	hr_scan			;loop if normal alpha
	cmp	al,'-'
	je	hr_scan			;loop if legal char
	cmp	al,' '
	jne	hr_msg			;jmp if illegal hyper word
;
; now scan back to see if word starts with a space
;
hr_scan2:
	dec	di
	mov	al,byte ptr [di]
	call	is_alpha
	jnc	hr_scan2		;loop if normal alpha
	cmp	al,'-'
	je	hr_scan3		;loop if legal char
	cmp	byte ptr [di-1],1fh
	je	hr_hyper 		;jmp if existing hyper word
	cmp	al,' '
	jne	hr_msg			;jmp if illegal hyper word
;
; we have scanned this word and it is a possible hyper word, ask for record#
;
hr_scan3:
	inc	di
	push	si
	mov	si,offset hr_text2
	call	get_hyper_num		;get rec# to -ax- and to hr_rec
	pop	si
	cmp	ax,0
	je	hr_msg2			;jmp if illegal rec#
	cmp	ax,221
	ja	hr_msg2
;
; we now have the hyper record# in -ax- and also stored at hr_rec
;
	mov	al,1fh
	call	insert_char		;put trigger char in message
	mov	al,cs:hr_rec
	add	al,21h			;21h=record# 1
	call	insert_char
	pop	di
	add	di,2
	jmp	hr_exit2
;
; this word appears to be an existing hyper word, ask if delete or modify
;
hr_hyper:
	push	si
	mov	si,offset hr_text3
	call	get_hyper_num
	pop	si
	cmp	al,0
	jne	hr_modify
;
; delete this hyper trigger
;
hr_delete:
	dec	di
	call	fill_hole
	call	fill_hole
	pop	di
	sub	di,2
	jmp	hr_exit2
;
; modify this hyper trigger
;
hr_modify:
	cmp	ax,221
	ja	hr_msg2
	add	al,21h
	mov	byte ptr ds:[di],al	;stuff new hyper trigger
	mov	cs:dirty_flag,80h	;signal changes make
	jmp	hr_exit	
;
; the entered record# is out of range
;
hr_msg2:push	si
	mov	si,offset hr_text4
	call	hr_warning
	pop	si
	jmp	hr_exit
;
; this word can not be a hyper word because:
;         1. it does not start and end with a space
;         2. it contains an illegal alpha character
;
hr_msg:	push	si
	mov	si,offset hr_text1
	call	hr_warning
	pop	si
	
hr_exit:
	pop	di
hr_exit2:	
	jmp	we_loop	
;-------------------
can_not_do:
	apush	ax,bx,dx
	mov	dx,3		;duration
	mov	bx,0a0h		;frequency
	call	make_sound
	apop	dx,bx,ax
	jmp	we_loop
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�
; insert_char - place one key in buffer
;  inputs: al = ascii code
;          ah = extended flag or -1 if bad key (bad key handled previously)
;          DS:SI = buffer top
;          ds:di = cursor posn
;          bx=box size
;          dx=box location
;  outputs: di = updated cursor position
;
insert_char:
	apush	cx,si,di,es
	mov	cx,ds
	mov	es,cx
	
	mov	cx,cs:buffer_end
	sub	cx,di

	mov	di,cs:buffer_end
	mov	si,di
	dec	si
	jcxz	ik_done
	std
	rep	movsb
	cld
ik_done:
	apop	es,di,si,cx
	mov	byte ptr [di],al	;insert new key
	mov	cs:dirty_flag,80h	;signal changes made
	call	cursor_right
	ret
	  
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�
; cursor_right - move cursor right
;  inputs: al = ascii code
;          ah = extended flag or -1 if bad key (bad key handled previously)
;          DS:SI = buffer top
;          ds:di = cursor posn
;          bx=box size
;          dx=box location
;  outputs: di = updated cursor position
;
cursor_right:
	mov	al,bh			;get rows in display
	dec	al
	mov	ah,(size line_struc)
	mul	ah
	add	ax,offset line_table
	mov	bp,ax
;
; bp now points to last line_table entry for our window. check
; if cursor is at end
;
	cmp	bp,cs:cursor_line_tbl
	jne	cr_x				;jmp if not on last line
	mov	al,cs:cursor_column
	inc	al
	cmp	al,bl
	je	cr_exit				;jmp if at end of window
cr_x:	cmp	di,si
	jne	cr_2				;jmp if not at buffer start
	cmp	byte ptr [di],0
	je	cr_exit				;jmp if at buffer start & no data
	jmp	cr_1
cr_2:	cmp	byte ptr [di],0			;only allow cursor to stray
	je	cr_exit				; one position past valid data
	
cr_1:	cmp	byte ptr [di],0dh
	jne	cr_bump
	inc	di
cr_bump:
	inc	di	
;
; check if moving into a hyper word
;
	cmp	byte ptr [di],1fh
	jne	skip_hyper			;jmp if no hyper word
	add	di,2	
skip_hyper:	

cr_exit:ret	
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�
; cursor_left - move cursor right
;  inputs: al = ascii code
;          ah = extended flag or -1 if bad key (bad key handled previously)
;          DS:SI = buffer top
;          ds:di = cursor posn
;          bx=box size
;          dx=box location
;  outputs: di = updated cursor position
;
cursor_left:
	cmp	di,si
	je	cl_exit
	dec	di
	cmp	byte ptr [di],0dh
	je	single_skip
	cmp	byte ptr [di],0ah
	jne	cl_ckhyper
single_skip:
	dec	di	
cl_ckhyper:
        cmp     byte ptr [di-1],1fh
	jne	cl_exit
	mov	al,byte ptr [di]
	sub	di,2	
cl_exit:ret	
;-------------------------------------------------------------------------
; get_hyper_num - request hyper record number
;  inputs:  cs:si = message
;  output: ax = record number
;
get_hyper_num:	
	apush	bx,cx,dx,di,ds,es
	push	cs
	pop	ds
	mov	bx,0740h		;box size
	mov	dx,1008h		;box location
	mov	bp,msg_save_win+msg_nokey+msg_ram+msg_disp
	call	message
	mov	al,cs:bar_text_color
	mov	ah,cs:bar_select_color
	mov	bl,gs_numbers+gs_init+gs_key_wait+gs_close
	mov	dx,1416h		;location for data entry
	mov	di,offset hr_buf
	mov	cx,0303h		;length of window and buffer
	push	cs
	pop	es
	call	get_string
	mov	si,offset hr_buf
	call	DEC_STR_TO_WORD
;
; -al- now has record number, insert into message
;
	mov	hr_rec,al
	push	ax
	mov	bp,msg_restore_win+msg_nokey
	call	message
	pop	ax
	apop	es,ds,di,dx,cx,bx
	ret		
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�
; hr_warning  -  display a warning box
;  inputs:  cs:si = message ptr
;  outputs: none
;
hr_warning:
	apush	bx,cx,dx,di,ds,es
	mov	bx,0740h		;box size
	mov	dx,0f08h		;box location
	mov	bp,msg_save_win+msg_restore_win+msg_anykey+msg_disp+msg_ram
	push	cs
	pop	ds
	call	message
	apop	es,ds,di,dx,cx,bx
	ret
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
WINDOW_CSTRING - display text with hyper formating
;
; inputs:    DS:[SI] pointing to the string
;            ds:[di] points to cursor posn in buffer
;	      dx = starting row(dh)  starting column(dl)
;	      bx = box total rows(bh)  box total columns(bl)
;            AH = color attribute (must be msg_text_color)
;            
; outputs:   table line_table is prepared.
;            cursor information is updated.
;
; note:     WINDOW_CSTRING was written to be used by WINDOW_EDIT to
;           display in a window and handle hyper words.  It does word
;           wrap and handles cr/lf characters.  The window text is
;           assumed to be terminated with a null character.
;
;           Unused portions of the window are cleared.
;           
;           HYPER triggers are imbedded into the text as two bytes which are
;           encoded as follows: 
;                                first byte   1fh         <-character
;                                second byte  (record #)  <-binary value
;
;           HYPER words must begin and end with a space with the HYPER
;           trigger after the first space.  The EDREC utility program
;           is an easy way to create HYPER entires.
;           
;           The text must be in a buffer larger than the window to allow
;           for inserts.  It is possible for the text to overflow the
;           buffer slightly and not show on the display.
;           
;         The line_info table is built from text scan and is
;         available as output to callers.  Its intended use is
;         to speed processing of hyper trigger words.  The format
;         of the line_table is:
;
;         line_struc	struc
;          line_start	dw	?	;ptr to first char. of line
;          line_end	dw	?	;ptr to last char, 0=end of data 0d=cr/lf at end
;          				;                  n=wrap occured
;          chars		db	?	;number of chars (minus hyper triggers, cr/lf)
;          line_no	db	?	;line number in range 0-24
;         line_struc	ends
;
;         line_tbl_size	equ	25
;
;         line_table	label	byte
;         	line_struc<?,?,?,0>
;		line_struc<?,?,?,01>
;		line_struc<?,?,?,02>
;		line_struc<?,?,?,03>
;		line_struc<?,?,?,04>
;		line_struc<?,?,?,05>
;		line_struc<?,?,?,06>
;		line_struc<?,?,?,07>
;		line_struc<?,?,?,08>
;		line_struc<?,?,?,09>
;		line_struc<?,?,?,10>
;		line_struc<?,?,?,11>
;		line_struc<?,?,?,12>
;		line_struc<?,?,?,13>
;		line_struc<?,?,?,14>
;		line_struc<?,?,?,15>
;		line_struc<?,?,?,16>
;		line_struc<?,?,?,17>
;		line_struc<?,?,?,18>
;		line_struc<?,?,?,19>
;		line_struc<?,?,?,20>
;		line_struc<?,?,?,21>
;		line_struc<?,?,?,22>
;		line_struc<?,?,?,23>
;		line_struc<?,?,?,24>
;* * * * * * * * * * * * * *

; The line_info table is built from text scan and is available as output
; to callers
line_struc	struc
 line_start	dw	?	;ptr to first char. of line
 line_end	dw	?	;ptr to last char, 0=end of data 0d=cr/lf at end
 				;                  n=wrap occured
 chars		db	?	;number of chars (minus hyper triggers, cr/lf)
 line_no	db	?	;line number in range 0-24
line_struc	ends

line_tbl_size	equ	25

line_table	label	byte
	line_struc<?,?,?,0>
	line_struc<?,?,?,01>
	line_struc<?,?,?,02>
	line_struc<?,?,?,03>
	line_struc<?,?,?,04>
	line_struc<?,?,?,05>
	line_struc<?,?,?,06>
	line_struc<?,?,?,07>
	line_struc<?,?,?,08>
	line_struc<?,?,?,09>
	line_struc<?,?,?,10>
	line_struc<?,?,?,11>
	line_struc<?,?,?,12>
	line_struc<?,?,?,13>
	line_struc<?,?,?,14>
	line_struc<?,?,?,15>
	line_struc<?,?,?,16>
	line_struc<?,?,?,17>
	line_struc<?,?,?,18>
	line_struc<?,?,?,19>
	line_struc<?,?,?,20>
	line_struc<?,?,?,21>
	line_struc<?,?,?,22>
	line_struc<?,?,?,23>
	line_struc<?,?,?,24>
;
; cursor location information
;
cursor_buf_ptr	dw	?	;ptr into text
cursor_line_tbl	dw	?	;ptr to line_table entry
cursor_win_loc	label	word
cursor_column	db	?
cursor_row	db	?
;
; text processing variabales
;
win_lp_count	db	?	;loop count

;------------------------
	public	window_cstring
window_cstring	proc	far
	apush	ax,bx,cx,dx,si,di,bp,ds,es
	mov	cs:cursor_buf_ptr,di
	mov	cs:win_lp_count,0
	mov	bp,offset line_table		;init table ptr
	mov	es,cs:lib_info.crt_seg
;
	mov	cx,cs:cursor_buf_ptr
	mov	cs:show_line_cursor,cx		;setup cursor for show line
;
hs_10:	mov	cx,0				;set line length to zero
hs_13:	mov	cs:[bp.line_start],si		;save line start

hs_20:	mov	al,byte ptr [si]		;get next char
	cmp	al,0
	je	hs_31				;jmp if end of line
	cmp	al,0dh
	je	hs_31				;jmp if end of line
	cmp	al,0ah
	je	hs_31				;jmp if end of line
        cmp     al,1fh				;hyper trigger?
	jne	hs_21				;jmp if not hyperkey trigger
;
; we have found a hyper key entry, skip over it
;
	add	si,2
	jmp	hs_20
;
; we have found a normal text char, count it and check if at box edge
;
hs_21:	inc	cx				;count this char
	inc	si
	cmp	cl,bl				;check if at box right edge
	jne	hs_20				;jmp if still within box

	mov	cs:[bp.chars],cl		 ;save ending char. count
	mov	cs:[bp.line_end],si		;save line end ptr
;
; we have filled to right edge, check if possible wrap word at end
;
	cmp	byte ptr [si],0
	je	hs_24
	cmp	byte ptr [si],0dh
	je	hs_24
	cmp	byte ptr [si],' '
	jne	hs_22				;jmp if no wrap at end
	dec	si
	dec	cx
;
; we have filled to the right edge of the box, now scan back for word break
;
hs_22:  cmp     byte ptr [si-1],1fh
	jne	hs_23				;jmp if not hyper key
	sub	si,2				;skip over hyper key
	jmp	hs_22
hs_23:  cmp     byte ptr [si],' '
	je	hs_30				;jmp if char break found
	jcxz	hs_24				;jmp if no word breaks
	dec	si
	dec	cx
	jcxz	hs_23				;jmp if on last char.
	jmp	hs_22
;
; no word breaks were found, so display line as is
;
hs_24:	mov	cl,cs:[bp.chars]
	jmp	hs_32
;
; si =ptr to break pnt,	cx = length of line
; Check if word follows this space char or a single char.
;
hs_30:
	cmp	cl,bl				;check if at right edge
	je	hs_31				; jmp if at right edge
	inc	si
	inc	cx
hs_31:	mov	cs:[bp.line_end],si		;save line end
hs_32:	mov	si,cs:[bp.line_start]		;restore line start ptr
	mov	cs:[bp.chars],cl		;save length of line

hs_38:	call	posn_to_adr			;compute starting display offset
	call	show_line			;display line & fill to end
;
; check if last line ends with cr/lf which needs to be skipped
;
hs_50:	cmp	bl,cs:[bp.chars]		;check if at right edge
	je	hs_52				; skip cr/lf check if at edge
	mov	si,cs:[bp.line_end]
	cmp	byte ptr ds:[si],0dh
	jne	hs_52
	add	si,2				;skip over cr/lf
hs_52:	inc	dh				;move to next display line
;
; check if last line of box has been filled
;
	inc	cs:win_lp_count			;move to next row on display
	add	bp,size line_struc		;move to next table entry
	cmp	cs:win_lp_count,bh		;check if all rows displayed
	jne	hs_10				;loop till done
hs_EXIT:
	apop	es,ds,bp,di,si,dx,cx,bx,ax
	RET
window_cstring	endp	
;-----------------------------------------------------------------------------
; show_line - write hyper message block, fill to end of window, & cursor sim
;   inputs:  ds:si = string ptr
;	     es:di = display location
;            cs:bp = current line_table entry
;               cx = valid character count for line
;               dx = display address (save)
;               bx = window size (save)
;           show_line_cursor - set by caller, cleared if cursor match
;  output: ds:si = ptr to next line
;          es:di = ptr to right edge of window
;--------------------------------
hyper_flag	db	0	;0=normal text	1=hyper key word display active

cur_win_column	db	?
show_line_cursor dw	0	;cursor buffer ptr, set by caller, cleared here
;--------------------------------
show_line:
	mov	cs:cur_win_column,0
sl_lp:	jcxz	sl_fill			;jmp if null line or end of line
	mov	al,byte ptr ds:[si]	;get next char.
	cmp	al,1fh
	jne	sl_10			;jmp if not hyper trigger
	mov	cs:hyper_flag,1
	add	si,2			;!
	mov	al,byte ptr ds:[si]	;!
sl_10:	cmp	al,' '			;check if space (end of hyper mode)
	jne	sl_20			;  jmp if not space
	cmp	cs:hyper_flag,0
	je	sl_20			;jmp if not hyper end
	mov	cs:hyper_flag,0
	
sl_20:	mov	ah,cs:msg_text_color
	cmp	cs:hyper_flag,0		;check if hyper mode active
	je	sl_30			; jmp if no hyper active
	mov	ah,cs:msg_hyper_color
sl_30:	cmp	si,cs:show_line_cursor 	;check if cursor here
	jne	sl_40			; jmp if no cursor here
	call	cursor_set
	xor	ah,33h
sl_40:	stosw				;display char
	inc	si			;move to next char
	dec	cx
	inc	cs:cur_win_column
	jmp	sl_lp
;
; fill to the end of the window and check for cursor at start of fill
;  -si- points at next line start, or cr/lf, or 0 if blank line
;
sl_fill:cmp	cs:cur_win_column,bl	;check if at right edge
	je	sl_50			; jmp if at right edge
;
; check for special case of cursor beyond last char of line or null line
; with cursor.
;	
	cmp	byte ptr [si],0dh
	je	sl_42			;jmp if possible  cursor at end of line.
	cmp	byte ptr [si],0
	jne	sl_50			;jmp if no cursor on blank line
sl_42:	cmp	si,cs:show_line_cursor	;check if cursor at start of fill
	jne	sl_50			;jmp if no cursor here
	call	cursor_set
	mov	cs:show_line_cursor,0	;disable future cursor matches
	mov	al,' '
	mov	ah,cs:msg_hyper_color
	stosw
	inc	cs:cur_win_column
sl_50:	mov	ah,cs:msg_text_color
	mov	al,' '
sl_60:	mov	cl,bl			;get window size
	sub	cl,cs:cur_win_column
	rep	stosw
sl_70:	ret
;---------------------------------
cursor_set:
	push	ax
	mov	cs:cursor_line_tbl,bp
	mov	ah,cs:cur_win_column
	mov	cs:cursor_column,ah
	mov	ah,cs:[bp.line_no]
	mov	cs:cursor_row,ah
	pop	ax
	ret
;--------------------------------------------------------------------------

LIBSEG	ENDS
	end
