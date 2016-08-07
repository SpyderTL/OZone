	page	66,132
;******************************** PULDOWN1.ASM *******************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	draw_box:far
	extrn	save_window:far
	extrn	display_string_fill:far
	extrn	key_if_ready:far
	extrn	restore_window:far
	extrn	box_shrink:far

	extrn	posn_to_adr:near
	extrn	$put_crt_chr:near
	extrn	$put_crt_blk:near

	extrn	lib_info:byte
	extrn	breakflag:byte
	extrn	bar_hotkey_color:byte
	extrn	bar_text_color:byte
	extrn	bar_select_color:byte
	extrn	submenu_text_color:byte
	extrn	submenu_select_color:byte
;----------------------------------------------------------------------------

;
; m_flag equates
;
m_saved		equ	80h		;screen data under menu saved
;

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MENU   )
MENU_SYSTEM - Menu bar display and decode of user selection
;
; inputs:  ds:bx - pointer to info structure see COMMON.INC
;	      ah - control flags (see below)
;    bar_save		equ	80h	;save display data under bar
;    bar_restore	equ	40h	;restore display data under bar before exit
;    bar_display	equ	20h	;display the menu bar
;    wait_valid_key	equ	10h	;wait forever till valid key found
;    return_bad_key	equ	08h	;wait for key and return unknown keys
;    no_mouse_sim	equ	04h	;do not simulate mouse with arrow keys
;
; output:  cl=0   ax=don't care (none key process occurred)
;	   cl=1   ax=process ptr
;	   cl=2   ax=key (unknown key press)
;	   cl=3   ax=click row/column (unknown mouse click)
;	   cl=4   ax=key (abort key pressed)
;* * * * * * * * * * * * * *

;---------------------------
pm_input_flags db      0
;---------------------------
	PUBLIC	MENU_SYSTEM
MENU_SYSTEM	PROC	FAR
	apush	bx,si,di,bp,ds,es
	mov	pm_input_flags,ah
;
; check if initial setup needed
;
pm_1:	test	[bx.m_flag],m_saved	;check if screen saved
	jnz	pm_4			;jmp if screen saved already
	test	ah,bar_save		;check if screen save requested
	jz	pm_4			;jmp if screen save not needed
	call	menu_save
pm_4:	test	pm_input_flags,bar_display ;check if menu bar display needed
	jz	pm_12			;jmp if no display needed
;
; display the menu bar
;
pm_10:	call	display_menu_bar
	test	pm_input_flags,wait_valid_key+return_bad_key
	jnz	pm_12			;jmp if wait for key wanted
;
; no key wait flags are set, so exit now
;
	mov	cl,0
	clc
	jmp	pm_exit
		
pm_12:	cmp	[bx.m_selected_main],0	;check if any selections active
	jne	pm_20			;jmp if selection has been made
;
; no selections have been make on the main menu, wait for key
;
	call	menu_key		;wait for key
	cmp	cl,0			;main selection key
	jne	pm_40			;jmp if not selection type key
	mov	[bx.m_selected_main],si ;save selection
	cmp	[si.e_count],0		;check if any submenu entries
	je	pm_70			; jmp if no submenu (do process)
	jmp	pm_10			;go display selection
;
; a main menu selection has occured, check if submenu available
;
pm_20:	mov	si,[bx.m_selected_main] ;get selected menu item info
	cmp	[si.e_count],0		;check number of submenu items
	jne	pm_30			;jmp if submenu display needed
;
; a main menu selection has occurred, no submenu exists, wait for key
;
	call	menu_key
	cmp	cl,1
	ja	pm_40			;jmp not selection key
	cmp	al,0dh
	je	pm_70			;jmp if <Enter> key pressed
	cmp	si,[bx.m_selected_main]
	je	pm_70			;jmp if click or alt-? for selected item
;
; this selection must be for a new main menu item, so update & redisplay
;
	mov	[bx.m_selected_main],si
	jmp	pm_10
;
; a submenu is available for selected main entry, display submenu
;
pm_30:	call	display_submenu
	call	menu_key		;wait for key
	call	restore_window
	cmp	cl,2			;was key a submenu selection key
	jne	pm_36			;jmp if not submenu selection key
	cmp	al,0dh
	je	pm_70			;jmp if <Enter> key pressed
	cmp	si,[bx.m_selected_sub]
	je	pm_70			;jmp if click or alt-? for selected item
;
; a new submenu item has been selected, update data and redisplay
;
	mov	[bx.m_selected_sub],si
	jmp	pm_10
;
; a non-submenu key was found while submenu displayed, what is it?
;
pm_36:	cmp	cl,1			;check if main menu key
	ja	pm_40			;jmp if not main menu select
;
; a main menu select key occured within a submenu
;
pm_38:	mov	[bx.m_selected_sub],0
	mov	[bx.m_selected_main],si
	jmp	pm_10
;
; an unknown or unexpected key was found, is it an abort key?
;
pm_40:	cmp	cl,3
	jne	pm_60			;jmp if not abort key
	cmp	al,1bh			;check for escape
	jne	pm_42			;  jmp if not escape
	cmp	[bx.m_selected_main],0		
	je	pm_42			;jmp if <esc> and no selections active
	mov	[bx.m_selected_main],0
	mov	[bx.m_selected_sub],0
	jmp	pm_10			;go redisplay menu bar
pm_42:	mov	cl,4			;abort exit code
	mov	[bx.m_selected_main],0
	mov	[bx.m_selected_sub],0
	jmp	pm_exit
;
; an unknown key was found and it is not an abort key, does the caller want it?
;
pm_60:	test	pm_input_flags,return_bad_key
	jz	pm_10			;jmp if user does not want it
	mov	cl,2			;setup unknown key return
	cmp	ch,0			;was it an unknown key
	je	pm_exit			;jmp if unknown key
	mov	cl,3			;setup unknown click
	jmp	pm_exit			;jmp if unknown click
;
; a menu item has been selected for execution, return the hit
;
pm_70:	mov	[bx.m_selected_main],0	;deselect main
	mov	[bx.m_selected_sub],0	;deselect sub
	mov	cl,1			;return hit code
	mov	ax,[si.e_process]	;return the process info
;
; exit states are -  cl=0   ax=don't care
;		     cl=1   ax=process info for key/mouse hit
;		     cl=2   ax=unknown key
;		     cl=3   ax=unknown click location (row/col)
;		     cl=4   ax=abort key if ctrl-c or esc
pm_exit:
	push	cx
	pushf
;
; check if area under bar is to be restored
;	
	test	pm_input_flags,bar_restore	;check for release memory & cleanup
	jz	pm_exit1		      ;jmp if not cleanup time
	call	restore_window
pm_exit1:	
	popf
	pop	cx
	apop	es,ds,bp,di,si,bx
	retf
MENU_SYSTEM	ENDP
;-----------------------------------------------------------------------------
; menu_save - save area under menu bar
;   inputs:  ds:bx - points at menu structure

menu_save:
	apush	ax,bx,ds
;
; use save_window to save area of screen
;
	mov	dx,word ptr es:[bx.m_left_column]
	mov	bx,word ptr es:[bx.m_rows]
	xchg	bh,bl
	call	save_window
	apop	ds,bx,ax
	ret

;-----------------------------------------------------------------------------
; display_menu_bar - display the top menu bar
;   inputs:  ds:bx - point at menu structure
;
display_menu_bar:
	apush	ax,bx,ds
	cld
;
; compute amount of area for menu bar
;
	mov	cl,[bx.m_columns]
	sub	ch,ch
;
; setup addresses, and clear menu bar area
;
	mov	dx,word ptr [bx.m_left_column]
	call	posn_to_adr
	mov	ah,byte ptr cs:bar_text_color
        mov     al,' '
	rep	stosw			;clear the menu bar area
;
; setup to display menu
;
	mov	bp,bx
	add	bp,m_main01		;point at first menu item
dmb_1:
	mov	dx,word ptr ds:[bp.e_column]
	call	posn_to_adr
	mov	cl,ds:[bp.e_length]
	sub	ch,ch
	mov	si,ds:[bp.e_text_ptr]
;
; display first char. as hot key
;	
	mov	ah,cs:bar_hotkey_color
	lodsb
	call	$put_crt_chr
	dec	cx
;
; display remaining char's
;	
	mov	ah,byte ptr cs:bar_text_color
	cmp	bp,[bx.m_selected_main] ;check if this menu item selected
	jne	dmb_2			;jmp if not selected
	mov	ah,byte ptr cs:bar_select_color
;
; cx=#chars  ds:si=string  es:di=display ah=color
;	
dmb_2:	call	$put_crt_blk
	add	bp,size menu_entry
	cmp	ds:[bp.e_length],0	;check if done with display
	jne	dmb_1			;loop if another entry
	apop	ds,bx,ax
	ret

;-----------------------------------------------------------------------------
;display_submenu - display a submenu
;  inputs: ds:bx - point at menu structure
;
;------------------------
dsm_bx_sav   dw      0
;------------------------
display_submenu:
	apush	ax,bx,cx,dx,si,di,bp,ds
	mov	di,[bx.m_selected_main]
	mov	ah,[di.e_sub_length]		;get length of box
	add	ah,2				;adjust for box borders
	mov	al,[di.e_count]			;get number of submenu items
	add	al,2				;adjust for box border
	mov	cx,ax				;save	ax

; ch=columns in box  cl=rows in box,
;
	mov	dx,word ptr [di.e_column]	;get main selection address
	add	dh,1				;move down one row
	mov	dsm_bx_sav,bx
	mov	bh,cl				;rows in box -> bh
	mov	bl,ch				;columns in box -> bl
;
; dx=box address  bh=rows bl=columns
;
	call	save_window			;save current window data
	mov	ah,byte ptr cs:submenu_text_color
	mov	al,1				;select double line box
	call	draw_box
	call	box_shrink
	mov	bp,cs:dsm_bx_sav
;
; display the submenu text
;
	mov	di,[di.e_process]		;get ptr to first submenu struc
;
; check if any selected, and if not select first one
;
	cmp	ds:[bp.m_selected_sub],0
	jne	dsm_loop			;jmp if item selected
	mov	ds:[bp.m_selected_sub],di	;select first item

dsm_loop:
	mov	si,[di.e_text_ptr]		;get text ptr
	mov	ch,0
	mov	cl,bl				;get window size
	mov	dh,[di.e_row]
	mov	dl,[di.e_column]
	mov	ah,byte ptr cs:submenu_text_color
	cmp	ds:[bp.m_selected_sub],di	;check if this item selected
	jne	dsm_out				;jmp if not selected
	mov	ah,byte ptr cs:submenu_select_color
dsm_out:
	call	display_string_fill
	add	di,size menu_entry
	dec	bh				;decrement item count
	jnz	dsm_loop			;loop till done

	apop	ds,bp,di,si,dx,cx,bx,ax
	ret
;-----------------------------------------------------------------------------
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MENU   )
; key_mouse_wait - wait for key or mouse input
;   inputs:  ds:bx - points at menu structure
;   output:  if no carry then dh=row  dl=column of mouse click
;	     if carry	ax=keyboard info.
;			dx=cursor location
;	     if carry and ax=0 then breakflag is set
; processing:  1. check the break_flag and exit if set
;	       2. put mouse cursor on screen.
;	       3. track mouse movements
;	       4. return any keypresses or mouse clicks found.
;	       5. remove the mouse cursor at exit
;-------------------

character_under_cursor	dw	0
cursor_column		db	1
cursor_row		db	1
;-------------------
key_mouse_wait	proc	far
	apush	bx,ds
kmw_loop:
	shr	byte ptr breakflag,1
	mov	ax,0			;preload abort code
	jc	kmw_exit		;jmp if ctrl-break active
	call	KEY_IF_READY		;get key if pressed
	or	ax,ax
	jnz	kmw_got_key
;
; check if mouse click occured
;
kmw_ck_mouse:
	cmp	cs:lib_info.mouse_present,0
	jne	kmw_mouse_active	;jmp if mouse is present
	test	cs:pm_input_flags,no_mouse_sim
	jnz	kmw_loop		;jmp if mouse simulation off
;
; there is no mouse present, simulate the mouse cursor
;
	mov	dx,word ptr cursor_column
	jmp	kmw_cursor_sim

kmw_mouse_active:
	push	bx
	mov	ax,0003
	int	33h		;get mouse status
	or	bx,bx		;check if any clicks
	pop	bx
	jz	kmw_update	;jmp if no mouse clicks
kmw_flush_mouse:
	push	bx
	mov	ax,0003
	int	33h
	or	bx,bx
	pop	bx
	jnz	kmw_flush_mouse  ;read mouse till all clicks returned
;
; convert pixel row (dx) and pixel column (cx) to character address.
; Since this is CRT mode 3 or 7 we know their are 8 pixels per char.
;
	call	pixels_to_adr
	mov	ax,dx		;move mouse posn -> ax
	clc
	jmp	kmw_exit
;
; there isn't any keyboard or mouse activity, update mouse position
;
kmw_update:
	call	pixels_to_adr		;get mouse adr dh=row  dl=column
kmw_cursor_sim:
	test	cs:pm_input_flags,no_mouse_show
	jnz	kmw_loop		;jmp if no mouse cursor needed
	call	posn_to_adr		;get crt address in es:di
	cmp	character_under_cursor,0
	jne	kmw_update1		;jmp if mouse on screen
;
; this is the first entry, so save char. under cursor and show mouse cursor.
;
	mov	ax,word ptr es:[di]	;get screen data
	mov	character_under_cursor,ax ; and save it
	mov	word ptr es:[di],ax
	mov	word ptr cursor_column,dx
	jmp	kmw_loop
;
; check if mouse has moved. dx=current mouse adr.  es:di=current display adr
;
kmw_update1:
	cmp	dx,word ptr cursor_column
	jne	kw_mousing		;jmp if mouse movement
;
; the mouse cursor is on screen, but has not moved, update it's color
;	
	mov	ax,word ptr es:[di]	;get present char. under mouse
	apush	es,si,bx
	mov	bx,0
	mov	es,bx
	mov	ah,byte ptr es:46ch	;get clock setting
	and	ah,06h
	mov	bh,ah
	shl	ah,1
	shl	ah,1
	shl	ah,1
	or	ah,bh
	apop	bx,si,es
	
	mov	word ptr es:[di],ax	
	jmp	kmw_loop		;jmp if no mouse movement
;
; the mouse has moved, update the cursor posn
;
kw_mousing:
	call	remove_mouse_cursor
	mov	word ptr cursor_column,dx
	jmp	kmw_loop

kmw_got_key:
	cmp	[bx.m_selected_main],0
	jne	kmw_got_key1		;jmp if menu is active
	test	cs:pm_input_flags,no_mouse_sim	;check if cursor simulation on
	jnz	kmw_got_key1		;jmp if cursor simulation off
	cmp	ax,014dh
	jne	kmw_key1		;jmp if not right-arrow
;
; cursor right
;
	cmp	dl,79
	jae	kmw_loop		;jmp if at right edge already
	inc	dl
	jmp	kmw_key_cursor

kmw_key1:
	cmp	ax,014bh
	jne	kmw_key2		;jmp if not left-arrow
;
; cursor left
;
	cmp	dl,0
	je	kmw_loop		;jmp if already at left edge
	dec	dl
	jmp	kmw_key_cursor

kmw_key2:
	cmp	ax,0148h
	jne	kmw_key3		;jmp if not up-arrow
;
; up arrow key
;
	cmp	dh,0
	je	kmw_loop		;jmp if already at top
	dec	dh
	jmp	kmw_key_cursor

kmw_key3:
	cmp	ax,0150h
	jne	kmw_got_key1		;jmp if not down-arrow
;
; cursor down
;
	cmp	dh,cs:lib_info.crt_rows ;check if at bottom already
	jae	kmw_loop		;jmp if at bottom already
	inc	dh
;
; remove cursor & update its position
;
kmw_key_cursor:
	call	remove_mouse_cursor
	mov	word ptr cursor_column,dx
	cmp	cs:lib_info.mouse_present,0
	je	kmw_loop		;jmp if no mouse present
	mov	cx,dx
	sub	ch,ch
	shl	cx,1
	shl	cx,1
	shl	cx,1
	sub	dl,dl
	xchg	dl,dh
	shl	dx,1
	shl	dx,1
	shl	dx,1
	mov	ax,4
	int	33h			;update mouse position
	jmp	kmw_loop


kmw_got_key1:
	stc
kmw_exit:
	call	remove_mouse_cursor
	apop	ds,bx
	retf
key_mouse_wait	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MENU   )
; get_menu_cursor - return current cursor position
;  inputs: none
;  output: dx = cursor posn
;


	public	get_menu_cursor
get_menu_cursor	proc	far
	mov	dx,word ptr cs:cursor_column
	retf
get_menu_cursor	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MENU   )
; set_menu_cursor - return current cursor position
;  inputs: dx = cursor position
;  output: none
;


	public	set_menu_cursor
set_menu_cursor	proc	far
	apush	ax,cx,dx
	mov	word ptr cs:cursor_column,dx
	mov	cx,dx
	sub	ch,ch
	shl	cx,1
	shl	cx,1
	shl	cx,1
	sub	dl,dl
	xchg	dl,dh
	shl	dx,1
	shl	dx,1
	shl	dx,1
	mov	ax,4
	int	33h			;update mouse position
	apop	dx,cx,ax	
	retf
set_menu_cursor	endp

;--------------------------------------------------------------------------
remove_mouse_cursor:
	pushf
	apush	ax,dx,di
	cmp	character_under_cursor,0
	je	rmc_exit		;jmp if no mouse cursor
	mov	dx,word ptr cursor_column
	call	posn_to_adr
	mov	ax,character_under_cursor
	mov	word ptr es:[di],ax
	mov	character_under_cursor,0
rmc_exit:
	apop	di,dx,ax
	popf
	ret
;-----------------------------
; inputs:  dx = pixel row
;	   cx = pixel column
; output:  dh=crt char row
;	   dl=crt char column
;
pixels_to_adr:
	shr	dx,1
	shr	dx,1
	shr	dx,1
	shr	cx,1
	shr	cx,1
	shr	cx,1
	mov	dh,cl
	xchg	dh,dl		;move char. row->dh  move char. column->dl
	ret
;-----------------------------------------------------------------------------
; menu_key - processes key press
;   inputs:  ds:bx - points at menu structure
;   output:  cl=0 initial main selection key found (click or alt-?)
;		  si=menu structure for selection
;		  if ch=0 then ax=key  dx=loc
;		  if ch=1 then dx=click
;	     cl=1 secondary main selection key. right,left,click,alt-?,enter
;		  si=menu structure for selection
;		  if ch=0 then ax=key	dx=loc
;		  if ch=1 then dx=click
;	     cl=2 submenu selection key. up,down,click,enter
;		  si=menu structure for selection
;		  if ch=0 then ax=key	dx=loc
;		  if ch=1 then dx=click
;	     cl=3 abort key found, ax=key if esc or ctrl-c
;	     cl=4 other key/click
;		  if ch=0 then ax=key	dx=loc
;		  if ch=1 then dx=click
;
;
menu_key:
	apush	bx,ds
mk_loop:
	call	key_mouse_wait
	jnc	mk_ck_mouse		;jmp if mouse activity
	or	ax,ax
	jz	mk_abort		;jmp if break key
;
; the keyboard was used, -ax- has keystroke  001b=esc
;					     000d=Enter
;					     014b=left arrow
;					     014d=right arrow
;					     0148=up
;					     0150=down
;					     0003=control-c
;
	cmp	ah,0			;check if normal key
	je	mk_norm_key
;
; extended keystroke found, check type
;
	cmp	al,4dh
	jne	mk_04			;jmp if not right arrow
;
; right arrow key pressed
;
mk_right:
	cmp	[bx.m_selected_main],0
	je	mk_unknown_key		;jmp if no main selection yet
	mov	si,[bx.m_selected_main]		;get current selection
	add	si,size menu_entry
	cmp	[si.e_length],0			;check if at right end
	je	wrap_right
	jmp	mk_main2_key			;jmp if new selection (si)
wrap_right:
	lea	si,[bx.m_main01]
	jmp	mk_main2_key			;jmp with wraped selection (si)
;
; extended key decode, not right arrow, check if left arrow
;
mk_04:	cmp	al,4bh
	jne	mk_06				;jmp if not left arrow
;
; left arrow key was found
;
	cmp	[bx.m_selected_main],0		;is right arrow possible
	je	mk_unknown_key			;jmp if right arrow not expected
	mov	si,[bx.m_selected_main]		;get current selection
	lea	dx,[bx.m_main01]
	cmp	si,dx
	je	wrap_left			;jmp if at end
	sub	si,size menu_entry
	jmp	mk_main2_key
wrap_left:
	add	si,size menu_entry
	cmp	[si.e_length],0
	jne	wrap_left
	sub	si,size menu_entry
	jmp	mk_main2_key			;jmp if new selection (si)
;
;extended key decode, not right, not left, check if up arrow
;
mk_06:	cmp	al,48h
	jne	mk_08				;jmp if not up arrow
;
; up arrow was found. Check if we are expecting up arrow (submenu active)
;
	cmp	[bx.m_selected_sub],0
	je	mk_unknown_key			;jmp if up arrow not expected
	mov	si,[bx.m_selected_sub]
	mov	di,[bx.m_selected_main]
	cmp	[di.e_process],si		;are we at top of selections
	je	wrap_up				;jmp if at top
	sub	si,size menu_entry
	jmp	mk_sub_key
wrap_up:mov	cl,[di.e_count]			;get number of submenu items
wrap_up_lp:
	dec	cl
	jz	wrap_up1
	add	si,size menu_entry
	jmp	wrap_up_lp
wrap_up1:
	jmp	mk_sub_key
;
;extended key decode, not right, not left, not up, check if down key
;
mk_08:	cmp	al,50h				;check if down arrow
	jne	mk_10				;jmp if not down arrow
;
; down arrow key was found
;
	cmp	[bx.m_selected_sub],0
	je	mk_unknown_key			;jmp if down arrow not expected
;
; check if we are at end of item list by scanning to end
;
	mov	di,[bx.m_selected_main]
	mov	si,[di.e_process]		;get ptr to first submenu entry
	mov	cl,[di.e_count]			;get number of submenu entries
mk_09:	dec	cl
	jz	mk_down1
	add	si,size menu_entry
	jmp	mk_09
mk_down1:
	cmp	si,[bx.m_selected_sub]		;check if we are at end
	je	mk_down_wrap			;jmp if at end
	mov	si,[bx.m_selected_sub]
	add	si,size menu_entry
	jmp	mk_sub_key
mk_down_wrap:
	mov	si,[di.e_process]
	jmp	mk_sub_key
;
; extended key decode, it is not right,left,up,down, check if main alt-?
;
mk_10:	lea	si,[bx.m_main01]		;get ptr to first struc
        mov     cl,[bx.m_options]               ;get number of struc's to scan
	call	hot_key_scan
	cmp	si,0				;check if key found
	je	mk_12				;jmp if hot key not main item
;
; a main menu hot key was found. check if main is selected
;
	cmp	[bx.m_selected_main],0
	je	mk_main1_key			;jmp if this is initial select
	jmp	mk_main2_key
;
; extended key decode, it is not right,left,up,down,main alt-?, check if sub alt
;
mk_12:	cmp	[bx.m_selected_sub],0
	je	mk_unknown_key			;jmp if sub alt-? not expected
	mov	di,[bx.m_selected_main]
	mov	si,[di.e_process]		;get top of sub menu list
	mov	cl,[di.e_count]			;get number of sub menu items
	call	hot_key_scan
	cmp	si,0
	je	mk_unknown_key			;jmp if key not sub alt-?
	jmp	mk_sub_key			;jmp if sub hot key found
;
; normal key decode start.
;
mk_norm_key:
	cmp	al,03		;check for ctrl-c
	je	mk_abort
	cmp	al,1bh
	je	mk_abort	;jmp if <escape>
	cmp	al,09
	je	mk_right	;jmp if <tab>
	cmp	al,0dh
	jne	mk_unknown_key	;jmp if not <enter> key
;
; the <enter> key was found, check which mode we are in
;
	mov	si,[bx.m_selected_sub]
	cmp	si,0		;check if sub menu selected
	jne	mk_sub_key	;jmp if this is sub menu selection
	mov	si,[bx.m_selected_main]
	cmp	si,0
	jne	mk_main2_key	;jmp if this is a main menu selection
	
;!	jmp	mk_unknown_key
;
; Mouse click decode start.
;
mk_ck_mouse:
	cmp	[bx.m_selected_sub],0
	jne	mk_40			;jmp if sub menu selected
mk_20:	cmp	dh,[bx.m_top_row]	;check if correct row for main
	jne	mk_unknown_mouse	;jmp if not within main range
	mov	si,bx
	add	si,offset m_main01
mk_mouse_lp:
	cmp	[si.e_length],0
	je	mk_unknown_mouse    ;jmp if no click on option
	mov	ah,[si.e_column]
	add	ah,[si.e_length];compute right edge of key
	cmp	dl,ah
	jb	mk_got_mouse	;jmp if mouse key found
	add	si,size menu_entry
	jmp	mk_mouse_lp	;loop till mouse decoded
;
; a valid mouse click was found.  ds:si points at match structure
;
mk_got_mouse:
	cmp	[bx.m_selected_main],0
	je	mk_main1_mouse		;jmp if initial main selection
	jmp	mk_main2_mouse		;jmp if secondary mouse selection
;
; we have a mouse click, and a sub menu is active.
;
mk_40:	mov	di,[bx.m_selected_main]
	mov	cl,[di.e_count]		;get number of submenu items
	mov	si,[di.e_process]	;get ptr to first submenu sturc
mk_submouse_scan:
	cmp	ah,[si.e_row]
	je	mk_subrow_fnd		;jmp if row found
	dec	cl
	jz	mk_20			;jmp if row was not found
	add	si,size menu_entry
	jmp	mk_submouse_scan
;
; the mouse click was on a possibly correct row, check column
;
mk_subrow_fnd:
	cmp	al,[si.e_column]
	jb	mk_20			;jmp if mouse too far left
	mov	cl,[si.e_column]
	add	cl,[si.e_length]
	cmp	al,cl
	ja	mk_20			;jmp if mouse too far right
	jmp	mk_sub_mouse		;jmp if submenu mouse hit
;
; keyboard exit states
;
mk_main1_key:
	mov	ch,0
	mov	cl,0
	jmp	mk_exit
mk_main2_key:
	mov	ch,0
	mov	cl,1
	jmp	mk_exit
mk_sub_key:
	mov	ch,0
	mov	cl,2
	jmp	mk_exit
mk_abort:
	mov	ch,0
	mov	cl,3
	jmp	mk_exit
mk_unknown_key:
	mov	ch,0
	mov	cl,4
	jmp	mk_exit
	jmp	mk_exit
;
; mouse exit states
;
mk_main1_mouse:
	mov	ch,1
	mov	cl,0
	jmp	mk_exit
mk_main2_mouse:
	mov	ch,1
	mov	cl,1
	jmp	mk_exit
mk_sub_mouse:
	mov	ch,1
	mov	cl,2
	jmp	mk_exit
mk_unknown_mouse:
	mov	ch,1
	mov	cl,4
mk_exit:
	apop	ds,bx
	ret
;-------------------------------------
; scan the menu structure for this key
;  inputs: ds:si = menu structures (either main or sub)
;	      cl = number of structures to search
;	      ax = key press
;  output: ds:si = ptr to hit structure, or zero if key not found
;
hot_key_scan:
	sub	ch,ch
hks_scan_lp:
	cmp	al,[si.e_hot_key]
	je	hks_exit		 ;jmp if hot key found
	add	si,size menu_entry
	loop	hks_scan_lp
	mov	si,0
hks_exit:
	ret
;-----------------------------------------------------------------------------

LIBSEG	ENDS
	end
