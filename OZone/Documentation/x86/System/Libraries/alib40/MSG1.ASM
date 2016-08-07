	page	66,132
;******************************** MSG1.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	draw_box:far
	extrn	dbase_read:far
	extrn	window_string:far
	extrn	yes_or_no:far
	extrn	key_or_mouse:far
	extrn	random_word2:far
	extrn	dbase_init:far
	extrn	dbase_close:far
	extrn	save_window:far
	extrn	restore_window:far
	extrn	box_shrink:far
	extrn	MENU_SYSTEM:far
	extrn	posn_to_adr:near
	extrn	adr_to_posn:near
	extrn	$vertical_repeat_chr:near
	extrn	lib_info:byte
	extrn	msg_text_color:byte
	extrn	msg_hyper_color:byte
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( MESSAGE )
message - boxed message display
;
; inputs:
;            bh = rows in box         (if flag msg_disp)
;            bl = columns in box      (if flag msg_disp)
;            cx = record #            (if flag msg_disp & not msg_rand)
;            dx = box upper left loc  (if flag msg_disp)
;         ds:si = ptr to file name    (if flag msg_open and not msg_ram)
;         ds:si = ptr to msg text     (if flag msg_ram and msg_open)
;            bp = flags, see equates
;            es = file selector       (if not flag msg_open)
;
; outputs:   no carry
;              es = file selector  (if no msg_close flag)
;              al = yes/no response (if msg_yesno flag was set)
;            carry
;	       ax = error code	  xx02 = code error, flag bits in -bp- wrong
;				  xx03 = disk read error
;				    10(decimal) = open error or file not found
;
; note:   This function displays a boxed message in various
;         formats.  All messages are found in memory or a file
;         which uses the database format for variable length ascii
;         records.  A specific message is selected by record #
;         using the database library routines.
;
;         The Hyper text mode uses a special file which is
;         formated with records compatable with the database
;         variable lenght record format.  Each record is
;         terminated with a zero.  The record can contain hyper
;         triggers to point to other topics(records).  The hyper
;         triggers consist of the following:
;
;          byte 0    space  <- the trigger word must start with a space
;          byte 1    1fh    <- the special character signals start of hyper
;          byte 2     n     <- binary number which is record# 1-255
;          byte 3+   ...    <- string which is to be highlighted trigger word
;          byte n    space  <- trigger word is ended with a space
;* * * * * * * * * * * * * *

;-------------------------------
msg_flags	dw	0	;flags (see equates)
temp_mloc	dw	0	;display location for message
temp_box_size	dw	0	;box rows/columns

rand_pkt	dw	0	;seed1
		dw	0	;seed2
		dw	007fh	;mask
		db	1	;method 1 or 2

msg_offset	dw	0	;the message pointer, or filename text
msg_segment	dw	0

message_fname	db	40 dup (0)

msg_rec_no	dw	0	;record#
msg_dbase_sel	dw	0	;dbase selector
;-------------------------------
; hyper menu (top menu bar)
;
hyper_menu	label	byte
	db	0			;m_flag
	db	0			;top row
	db	0			;left column
	db	1			;total rows
plug_c	db	76			;total columns
	db	4			;menu options
	dw	0			;main selection
	dw	0			;sub selection
; hyper option #0 -PREVIOUS-
	db	0			;e_count
	db	0			;e_sub_length
	db	25			;e_hot_key (alt-t)
	db	14			;e_length
	dw	hyper_opt0_text		;e_text_ptr
	dw	hyper_previous 		;e_process
	db	1			;e_column
hplug1	db	0			;e_row
; hyper option #1 -FWD-BROWSE-
	db	0			;e_count
	db	0			;e_sub_length
	db	33			;e_hot_key (alt-a)
	db	10			;e_length
	dw	hyper_opt1_text		;e_text_ptr
	dw	hyper_fwd		;e_process
	db	8			;e_column
hplug2	db	0			;e_row
; hyper option #2 -BAK-BROWSE-
	db	0			;e_count
	db	0			;e_sub_length
	db	48			;e_hot_key (alt-b)
	db	10			;e_length
	dw	hyper_opt2_text		;e_text_ptr
	dw	hyper_bak		;e_process
	db	15			;e_column
hplug3	db	0			;e_row
; hyper option #3 -EXIT-HYPER-
	db	0			;e_count
	db	0			;e_sub_length
	db	18			;e_hot_key (alt-b)
	db	10			;e_length
	dw	hyper_opt3_text		;e_text_ptr
	dw	hyper_exit		;e_process
	db	22			;e_column
hplug4	db	0			;e_row
; hyper option end, dummy option
	db	0			;e_count
	db	0			;e_sub_length
	db	00			;e_hot_key (alt-b)
	db	0			;e_length
	dw	0             		;e_text_ptr
	dw	0			;e_process
	db	0			;e_column
	db	0			;e_row

hyper_opt0_text     db 'Previous-topic',0
hyper_opt1_text     db 'Fwd-browse',0
hyper_opt2_text     db 'Bak-browse',0
hyper_opt3_text     db 'Exit-hyper',0
hyper_opt4_text     label	byte	;dummy for menu placement calc

;-------------------------------
	public	message
message		proc	far
	apush	bx,cx,dx,si,di,ds,es
	cld
	mov	cs:msg_flags,bp
	mov	word ptr cs:msg_rec_no,cx	;save record#
	mov	cs:temp_mloc,dx			;save display location
	mov	cs:temp_box_size,bx		;save box rows & colums
	mov	byte ptr cs:plug_c,bl		;save total columns in window
	mov	cs:msg_dbase_sel,es
	mov	cs:msg_offset,si		;save message offset
	mov	cs:msg_segment,ds		;save message segemnt
	
	inc	dh
	mov	cs:hplug1,dh			;set hyper menu bar column
	mov	cs:hplug2,dh
	mov	cs:hplug3,dh
	mov	cs:hplug4,dh

	inc	dl
	mov	cs:hplug1-1,dl
	add	dl,(offset hyper_opt1_text - hyper_opt0_text)+2
	mov	cs:hplug2-1,dl
	add	dl,(offset hyper_opt2_text - hyper_opt1_text)+2
	mov	cs:hplug3-1,dl
	add	dl,(offset hyper_opt3_text - hyper_opt2_text)+2
	mov	cs:hplug4-1,dl
;
; move message file name to local storage
;
	push	cs
	pop	es
	mov	di,offset message_fname
	mov	cx,40
	rep	movsb				;move filename asciiz here

	push	cs
	pop	ds
;
; check if the database needs to be opened.
;	
msg_1:	test	msg_flags,msg_open
	jz	msg_2			;jmp if dbase already open
;
; open the database (message file)
;
	mov	dx,offset message_fname ;get file name
	call	dbase_init
	mov	msg_dbase_sel,bx	;save dbase selector
	cmp	al,0			;check for errors
	jne	msg_err1		;jmp if error opening database
;
; check if window area save is needed
;
msg_2:	test	msg_flags,msg_save_win
	jz	msg_3			;jmp if no window save needed
	mov	bx,temp_box_size	;get box rows/columns
	mov	dx,temp_mloc		;get box location
	call	save_window		;save area of screen
;
; draw the message box
;
msg_3:	test	msg_flags,msg_disp
	jz	msg_4			;jmp if no display needed
	mov	bx,temp_box_size	;get box rows/columns
	mov	dx,temp_mloc		;get box location
	mov	al,0			;single line box
	mov	ah,msg_text_color	;get box color
	call	draw_box
;
; check if message is in memory or on disk
;
	test	cs:msg_flags,msg_ram
	jz	hyper_entry		;jmp if message on disk
	mov	si,cs:msg_offset
	mov	es,cs:msg_segment
	jmp	msg_shrink
;
; read the message from disk
;
hyper_entry:
	mov	es,msg_dbase_sel	;get dbase selector
	mov	dx,msg_rec_no		;get record#
	call	dbase_read		;returns es:si=msg ptr  cx=msg len
	cmp	al,0			;check for error
	je	msg_shrink		;jmp if read ok
	mov	msg_rec_no,1		;force record# 1 and retry
	mov	dx,1
	call	dbase_read
	cmp	al,0
	jne	msg_err2		;jmp if error
;
; shrink the box
;
msg_shrink:
	mov	bx,temp_box_size	;get box rows/columns
	mov	dx,temp_mloc		;get box location
	call	box_shrink		;adjust box for text fill
	mov	ah,cs:msg_text_color
	push	ds			;move
	push	es			;  -es- to
	pop	ds			;   -ds-
;
; check type of box display
;
	test	msg_flags,msg_hyper	;check if hyper display
	jnz	hyper_msg		;jmp if hyper display
;
; normal message, fill the box with text, es:si=msg  cx=len  bx=box siz dx=loc
;
	call	window_string		;ds:si=string dx=loc bx=box size ah=color
	pop	ds			;restore -ds-
	jmp	msg_4			;skip over hyper display
;
; hyper format message display
;
hyper_msg:
	inc	dh			;move down one row past menu bar
	dec	bh			;decrement number of rows avail.
	call	hyper_display		;returns hyper_table ptr (di)
	pop	ds
;
; check type of key processing
;
msg_4:	test	cs:msg_flags,msg_nokey
	jnz	msg_8			;jmp if no key wait
	test	cs:msg_flags,msg_anykey
	jz	msg_5			;jmp if not wait for any key
;
; wait for any key option selected
;
	call	KEY_OR_MOUSE		;get next key or click
	jmp	msg_8	
;
; check if yes/no response needed
;
msg_5:	test	cs:msg_flags,msg_yesno
	jz	msg_6			;jmp if not yes/no wait
	mov	al,0			;normal yes/no ignore bad keys
	call	yes_or_no
	jmp	msg_8			;continue
;
; check if this is hyper key wait
;
msg_6:	test	cs:msg_flags,msg_hyper
	jz	msg_err3
;
; this is a wait for hyper key, put up a menu bar at top of hyper box
;
msg_7:	mov	bx,offset hyper_menu	;ds:bx = menu table ptr
	mov	dx,cs:temp_mloc
	mov	word ptr ds:[bx.m_left_column],dx ;store message location
	mov	dx,cs:temp_box_size
	mov	word ptr ds:[bx.m_columns],dx
	sub	[bx.m_columns],2
	add	[bx.m_left_column],1
	add	[bx.m_top_row],1
	mov	ah,bar_display+return_bad_key	;show menu & return unknown keys
	call	MENU_SYSTEM
	add	[bx.m_columns],2
	sub	[bx.m_left_column],1
	sub	[bx.m_top_row],1
;
; decode last key press
;
	cmp	cl,1			;check if process hit
	jne	hyper_1			;  jmp if not process
	jmp	ax			;go to process
hyper_1:
	cmp	cl,4			;check if abort key
	je	msg_8			;  jmp if abort key

	cmp	ax,0151h
	je	hyper_fwd
	cmp	ax,0149h
	je	hyper_bak
;
; check if a hyper trigger occured.  cs:di = ptr to hyper table
;				     if cl=2  ax=unknown key, dx=cursor loc
;				     if cl=3  dx=click row/col
;
; legal keys are <Enter> if over hyper trigger.
;                <click> if over hyper trigger.
;
htrigger_scan:	
	cmp	cs:[di.hrec_no],0	;check if end of list
	je	msg_7			; jmp if this is not hyper trigger
	cmp	dh,[di.hrow]
	jne	nxt_hyper
	cmp	dl,[di.hleft_col]
	jb	nxt_hyper		;jmp if not this hyper
	cmp	dl,[di.hright_col]
	jb	new_hyper_rec		;jmp if hyper hit
nxt_hyper:
	add	di,size hyper_struc
	jmp	htrigger_scan
new_hyper_rec:
	mov	dx,msg_rec_no
	call	hyper_push		;save origional location
	mov	dl,[di.hrec_no]
	mov	dh,0
hyper_entry2:	
	mov	cs:msg_rec_no,dx
	jmp	hyper_entry		;go display new record#
;
; display the previous topic
;
hyper_previous:
	call	hyper_pop
	cmp	dx,0			;check if stack empty
	jne	hyper_entry2		;jmp if previous item exists
	jmp	msg_7			;jmp if there is no previous topic
;
; move forward in message file
;
hyper_fwd:
	mov	dx,cs:msg_rec_no
	inc	dx
	jmp	hyper_entry2
;
; move backwards in message file
;
hyper_bak:
	mov	dx,cs:msg_rec_no
	cmp	dx,1
	je	msg_7			;jmp if can't go back
	dec	dx
	jmp	hyper_entry2
;
; quit/exit hyper dislay
;
hyper_exit:
	mov	cs:hyper_stack_ptr,offset hyper_stack
	jmp	msg_8
;
; check if window restore necessary
;	
msg_8:	test	cs:msg_flags,msg_restore_win
	jz	msg_9			;jmp if no window restore
;
; restore the origional display
;
	call	restore_window
;
; check if dbase(file) is to be left open
;
msg_9:	test	cs:msg_flags,msg_close
	jz	msg_exit		;jmp if dbase is to be left open
;
; close the database
;
	call	dbase_close
	clc
	jmp	msg_exit
;
msg_err1:
	mov	ah,fatal_error+error_text
	mov	al,10				;file open error
	mov	bp,offset message_fname
	jmp	msg_err

msg_err2:
	mov	ah,fatal_error+error_text
	mov	al,3				;file read error
	mov	bp,offset message_fname
	jmp	msg_err
;
; keyboard handling flags not set correctly
;
msg_err3:				
	mov	ah,fatal_error
	mov	al,2

msg_err:
	stc
;
msg_exit:
	apop	es,ds,di,si,dx,cx,bx
	retf
message		endp	              
;         
;-----------------------------------------------------------------------------
; hyper_display - display test with hyper formating
;            print ASCIIZ string directly to the video buffer in a
;            window of screen, with word wrap.  String must be terminated
;            by a NUL character. WINDOW_STRING clears any portion of the window
;            not occupied by the string.
;	     cr/lf characters cause a new line within the window.
;            HYPER triggers are imbedded into the text as two bytes which are
;            encoded as follows: 
;                                 first byte   1fh         <-character
;                                 second byte  (record #)  <-binary value
;
;Call with:   DS:[SI] pointing to the string
;	      dx = starting row(dh)  starting column(dl)
;	      bx = box total rows(bh)  box total columns(bl)
;             AH = color attribute (must be msg_text_color)
;  outputs: cs:di points at the hyper_table, end of table has rec# of zero
;
;--------------------------
; The hyper table is used to identify all hyper triggers within the text
hyper_struc	struc
 hrec_no	db	?		;set to zero if end of table
 hrow		db	?		;trigger row
 hleft_col	db	?		;trigger left column (start of range)
 hright_col	db	?		;trigger right column (end of range)
hyper_struc	ends

hyper_tbl_size	equ	20

hyper_table	db	 (hyper_tbl_size)*(size hyper_struc) dup (0)

hyper_table_ptr dw	0	;pointer to next hyper_table append point

hs_str_ptr	dw	0
hs_wscan_cx	dw	0			;scan for word break cx save
hs_lp_cnt	db	0
;------------------------
	public	hyper_display
hyper_display:
	apush	ax,bx,cx,dx,si,bp,ds,es
	mov	cs:hyper_table_ptr,offset hyper_table
	mov	es,cs:lib_info.crt_seg
	mov	cs:hs_lp_cnt,bh
;
; skip over any cr/lf characters at start of this line
;
hs_10:	mov	cx,0				;set line length to zero
hs_10a: cmp	byte ptr [si],0
	jne	hs_13				;jmp if not at end of string
	call	posn_to_adr
	jmp	hs_40				;go fill line with blanks
;
; the first character of string has been found, not cr/lf/zero, find line len
;
hs_13:	mov     cs:hs_str_ptr,si	      ;save si

hs_20:	cmp	byte ptr [si],0
	je	hs_30				;jmp if end of line
	cmp	byte ptr [si],0dh
	je	hs_30				;jmp if end of line
	cmp	byte ptr [si],0ah
	je	hs_30				;jmp if end of line
        cmp     byte ptr [si],1fh
	jne	hs_21				;jmp if not hyperkey trigger
;
; we have found a hyper key entry, skip over it
;
	add	si,2
	jmp	hs_20
;
; we have found a normal text char, count it and check if at box edge
;
hs_21:
	inc	cx				;count this char
	inc	si
	cmp	cl,bl				;check if at box right edge
	jne	hs_20				;jmp if still within box
;
; we have filled to the right edge of the box, now scan back for word break
;
	mov	cs:hs_wscan_cx,cx		 ;save ending char. count
hs_22:  cmp     byte ptr [si-1],1fh
	jne	hs_23				;jmp if not hyper key
	sub	si,2				;skip over hyper key
	jmp	hs_22
hs_23:	dec	si
        cmp     byte ptr [si],' '
	je	hs_30				;jmp if char break found
	loop	hs_22
;
; no word breaks were found, so display line as is
;
	mov	cx,cs:hs_wscan_cx
;
; si =ptr to line end,	cx = length of line
;
hs_30:	mov	si,cs:hs_str_ptr		 ;restore line start ptr
	mov	cs:hs_wscan_cx,cx
	call	posn_to_adr			;compute starting display offset
	jcxz	hs_40
	call	$put_hyper_crt
;
; now check if we need to fill to end of box with blanks
;
	mov	cx,cs:hs_wscan_cx		;restore -cx-
hs_40:	sub	cl,bl				;display count - box size
	neg	cl
	jz	hs_50				;jmp if no fill needed
;
; clear remainder of this line on display
;
	push	si
	mov	si,1
        mov     al,' '
	call	$vertical_repeat_chr
	pop	si
;
; check if last line ends with crlf which needs to be skipped
;
hs_50:	cmp	byte ptr [si],0dh
	jne	hs_52				;jmp if no cr/lf
	add	si,2
		
;
; check if last line of box has been filled
;
hs_52:	inc	dh				;move to next row on display
	dec	cs:hs_lp_cnt			;decrement row count
	jnz	hs_10				;loop till done

hs_EXIT:
	apop	es,ds,bp,si,dx,cx,bx,ax
	mov	di,offset hyper_table
	RET
;-----------------------------------------------------------------------------
; $put_hyper_crt - write hyper message block (line) and update hyper_table
;   inputs:  ds:si = string ptr
;	     es:di = display location
;		ah = display color (must be msg_text_color)
;--------------------------------
put_hyper_flag	db	0	;0=normal text	1=hyper key word display active
;--------------------------------
$put_hyper_crt:
	apush	bx,dx
	mov	bx,cs:hyper_table_ptr
phc_lp: lodsb				;get display char
	or	al,al
	jz	phc_end			;jmp if end of message
        cmp     al,1fh
	jne	phc_1			;jmp if not hyper trigger
;
; we have found a hyper trigger, add entry to table and highlight entry
;
	mov	cs:put_hyper_flag,1	;enable hyper mode
	call	adr_to_posn
	mov	cs:[bx.hrow],dh		;save current row
	mov	cs:[bx.hleft_col],dl	;save current column
	lodsb				;get record#
	sub	al,21h
	mov	cs:[bx.hrec_no],al	;save hyper record#
	mov	ah,cs:msg_hyper_color	;change to hyper color
	jmp	phc_lp

phc_1:	cmp	cs:put_hyper_flag,0	;check if hyper key word display
	je	phc_2			; jmp if normal text being displayed
        cmp     al,' '                  ;check if end of hyper key word
	jne	phc_2			; jmp if not end yet
	mov	ah,cs:msg_text_color	;change color back to normal
	mov	cs:put_hyper_flag,0	;disable hyper color
	call	adr_to_posn
	mov	cs:[bx.hright_col],dl	;save end location of hyper keyword
	add	bx,size hyper_struc	;move to next structure loc
phc_2:	stosw				;write data to crt
	loop	phc_lp			;loop till done
phc_end:mov	cs:hyper_table_ptr,bx
	mov	cs:[bx.hrec_no],0	;terminate table for now
	apop	dx,bx
	ret

;-----------------------------------------------------------------------------
; hyper_push - push record number on the stack
;   inputs:  dx = record#
;   outputs: none
;
;------------------------
hyper_stack_size	equ	20
hyper_stack	dw	hyper_stack_size dup (0)
hyper_stack_end	label	byte
hyper_stack_ptr	dw	hyper_stack
;------------------------
hyper_push:
	push	bx
	mov	bx,cs:hyper_stack_ptr
	cmp	bx,offset hyper_stack_end
	je	hpush_exit			;jmp if stack full
	mov	word ptr cs:[bx],dx
	add	cs:hyper_stack_ptr,2
hpush_exit:
	pop	bx
	ret
;-----------------------------------------------------------------------------
; hyper_pop - return last stack push
;  inputs: none
;  output: dx = last record# or zero if stack empty
;
hyper_pop:
	push	bx
	mov	bx,cs:hyper_stack_ptr
	cmp	bx,offset hyper_stack
	jne	hpop_1				;jmp if stack has entry
	mov	dx,0
	jmp	hpop_exit
hpop_1:	sub	bx,2				;move to previous entry
	mov	dx,word ptr cs:[bx]		;get previous record#
	mov	cs:hyper_stack_ptr,bx
hpop_exit:
	pop	bx
	ret		


LIBSEG	ENDS
;;	end
