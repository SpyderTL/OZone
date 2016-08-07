	page	66,132
;******************************** MKEY16.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	key_if_ready:far
	extrn	key_read:far
	extrn	str_cleanl:far
	extrn	HIDE_CURSOR:far
	extrn	SHOW_CURSOR:far
	extrn	is_digit:far
	extrn	is_alpha:far
	extrn	is_upper:far
	extrn	to_upper:far
	extrn	is_lower:far
	extrn	to_lower:far
	extrn	make_sound:far
	extrn	display_string_fill:far
	extrn	pick_color:byte
	extrn	pick_select_color:byte
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�
;---get_string-- database

input_color	db	0
exit_color	db	0

	public	key_flags	;used by window_edit also
key_flags	db	0	;01=numbers only 02=upper 04=lower 08=filename

starting_key_window_column db	0
key_window_row		 db	0
key_window_length	 db	0
current_key_window_column db	0
key_window_index 	 db	0

starting_key_buf_offset	dw	0
key_buf_ptr		dw	0
key_buf_seg		dw	0
key_buf_length		dw	0
key_buf_index		dw	0

last_cursor		db	0	;column of current cursor posn
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
GET_STRING - read string from the keyboard.
;
;inputs: es:di - point at buffer for string.  Buffer can be preloaded
;                with default display.  pad rest with zeros or spaces.
;           ah - color for edit line
;           al - color for edit line at exit time
;           ch - length of buffer
;           cl - length of window
;           dh - window row
;           dl - window column (starting)
;           bl - flag 01=numbers only 02h=upper case 04=lower case 08=filename
;             gs_numbers   equ  01h  ;get numbers only
;             gs_upper     equ  02h  ;get upper case characters
;             gs_lower     equ  04h  ;get lower case characters
;             gs_file      equ  08h  ;get filename characters only
;             gs_init      equ  10h  ;initialize (do once per string entry)
;             gs_key_wait  equ  20h  ;input keys till done or unknown key found
;             gs_key_check equ  40h  ;input key only if it is ready
;             gs_close     equ  80h  ;remove cursor and deselect string 
;
; output:   cx - size of string entered (-1=unknown key in -ax-)
;           ax - last key code if  cx=-1
;              - zero if gs_key_check and all keys processed ok
;
;  Note: The buffer length must be equal or greater than the window length
;
;        get_string is designed to operate in two modes.  The first mode
;        stays in get_string until the string is entered.  This mode requires
;        the flags: ( gs_init,gs_key_wait,gs_close) and all parameters.
;        The second mode allows get_string to poll the keyboard along with
;        other functions.  This mode can be used as follows:
;         1. call with gs_init flag and all parameters.
;         2. call with gs_key_check until string entered or abort key
;         3. call with gs_close to remove the cursor and delselect.
;        Steps 2&3 above only require the flag information in -bl- along
;        with the get_string call.
;* * * * * * * * * * * * * *

	PUBLIC	GET_STRING
GET_STRING	PROC	FAR
	apush	bx,dx,si,di,es
	mov	key_flags,bl		;save control flags
	test	bl,gs_init
	jz	gs_loop			;jmp if init not needed
     	call	get_string_setup
gs_loop:test	key_flags,gs_key_wait
	jnz	gs_wait			;jmp if wait for key mode
	test	key_flags,gs_key_check
	jz	gs_2			;jmp if no check for key
	call	KEY_IF_READY		;get key if available
	cmp	ax,0
	jne	gs_1			;jmp if key was found
	mov	ah,input_color
	call	key_display		;update display
	sub	ax,ax			;clear ax
	jmp	gs_2			;go check if close	
gs_wait:call	KEY_READ
gs_1:	mov	si,offset decode_table
	call	key_decode
	cmp	cx,-1
	je	gs_abort		;jmp if illegal key press
	call	key_processing
	cmp	ah,-1
	je	gs_abort		;jmp if abort key
	cmp	ah,2
	je	gs_loop			;jmp if error (ignore key)
	cmp	ah,3
	je	gs_exit			;jmp if <Enter> key pressed
	mov	ah,input_color
	call	key_display
	jmp	gs_loop
;
; scan string to determine length, remove trailing spaces at end of string.
;	
gs_exit:
	push	ds
	mov	si,starting_key_buf_offset
	mov	cx,key_buf_length
	mov	ds,key_buf_seg
	call	STR_CLEANL		;returns trimed length in -cx-
	pop	ds
gs_2:
gs_abort:
	test	key_flags,gs_close
	jz	gs_3			;jmp if no close requested
	apush	ax,cx
	mov	ah,exit_color
	call	key_display
	call	HIDE_CURSOR
	apop	cx,ax
gs_3:	apop	es,di,si,dx,bx
	retf		
GET_STRING	ENDP

;-----------------------------------------------------------------------------
;GET_STRING_SETUP: setup data, display window, cursor on, scan for existing
;                  string and pad end with zeros.
; inputs: es:di - point at buffer for string.  Buffer can be preloaded
;                 with default display.  pad rest with zeros or spaces.
;            ah - color for edit line
;            al - color for edit line at exit time
;            ch - length of buffer
;            cl - length of window
;            dh - window row
;            dl - window column (starting)
;            bl - flag 01=numbers only 02h=upper case 04=lower case 08=filename

GET_STRING_SETUP:
	cld
	mov	input_color,ah
	mov	exit_color,al
	
	mov	key_buf_seg,es
	mov	starting_key_buf_offset,di
	mov	key_buf_ptr,di
	mov	byte ptr key_buf_length,ch
	mov	byte ptr key_buf_index,0
	
	mov	starting_key_window_column,dl
	mov	key_window_row,dh
	mov	key_window_length,cl
	mov	current_key_window_column,dl
	mov	key_window_index,0

	mov	al,0
	mov	cx,key_buf_length
	repne	scasb
	mov	bx,cx			;save count
	jcxz	gss_skip1		;jmp if buffer full without zeros
	rep	stosb			;fill remainder of buffer with zeros
gss_skip1:
;
; compute length of string in buffer
;
	mov	cx,key_buf_length
	sub	cx,bx			;cx=string length
	dec	cx
	mov	key_buf_index,cx
	add	key_buf_ptr,cx
	inc	cx
;
; check if we are overflowing window
;
	cmp	cl,key_window_length
	jb	no_window_overflow
	mov	key_window_index,0
	mov	key_buf_index,0
	mov	di,starting_key_buf_offset
	mov	key_buf_ptr,di
	jmp	gss_display
no_window_overflow:
	dec	cl
	mov	key_window_index,cl
	add	current_key_window_column,cl
;
; display string
;
gss_display:
	mov	dl,current_key_window_column
	call	SHOW_CURSOR
	mov	ah,input_color
	call	key_display
	ret
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

	db	52h
	db	1
	dw	insert_key

	dw	-1		;end of table
	dw	normal_key	; last entry is normal key processing
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
KEY_DECODE - scan for special keys, determine key type and process flags.
;
; inputs: ah=key scan code
;         al=key ascii code
;      ds:si=pointer to decode table
;      key_flags - set to type of decode needed
;      
; output: if cx = 0 then,
;            al = key ascii code
;            ah = extended/nomal key flag
;            bx = processing offset (set to normal key if not in table and ah=0)
;         if cx=-1 then ax = illegal key
;
; note:   All keys not in table which have extended flag set are ignored.
;         Normal keys are processed using control flag supplied by user.
;* * * * * * * * * * * * * *

	public	key_decode
KEY_DECODE	proc	far
	xor	cx,cx			;preload exit code (success)
kd_loop:
	cmp	word ptr cs:[si],-1
	je	kd_srch_end
	cmp	word ptr cs:[si],ax
	je	kb_got_one
	add	si,4			;move to next entry
	jmp	kd_loop
;
; found a key in the table.  cs:[si+2] contains the processing offset
;
kb_got_one:
	mov	bx,word ptr cs:[si+2]
	jmp	kb_end1
;
; this key was not in the table. Check if it is legal
;
kd_srch_end:
	cmp	ah,0
	jne	bad_key		;jmp if bad key
	mov	bx,word ptr cs:[si+2]
	test	key_flags,01h	;
	jnz	numbers_only
	test	key_flags,02h
	jnz	upper_keys_only
	test	key_flags,04h
	jnz	lower_keys_only
	test	key_flags,08h
	jnz	file_keys_only
;
; this key needs to be returned as is.
;
	jmp	kb_end1
;
; ah=0 al=ascii code 
;
numbers_only:
	call	IS_DIGIT
	jnc	kb_end1			;jmp if key is a number 0-9
	jmp	bad_key
;
; ah=0 al=ascii code 
;
upper_keys_only:
	call	IS_ALPHA
	jnc	kb_end1			;jmp if not an alphabetic key
	call	IS_UPPER
	jnc	kb_end1			;jmp if char is upper case
	call	TO_UPPER
	jmp	kb_end1
;
; ah=0 al=ascii code 
;
lower_keys_only:
	call	IS_ALPHA
	jnc	kb_end1			;jmp if not an allphabetic key
	call	IS_LOWER
	jnc	kb_end1			;jmp if char is lower case
	call	TO_LOWER
	jmp	kb_end1
;
; ah=0 al=ascii code 
;
file_keys_only:
	jmp	kb_end1			;allow all keys for now

bad_key:
;	mov	dx,3		;duration
;	mov	bx,0a0h		;tone
;	call	make_sound
	mov	cx,-1
;;	mov	bx,offset normal_key
	mov	bx,word ptr cs:[si+2]	;get normal key processing routine
kb_end1:
	ret	
key_decode	endp	
;-----------------------------------------------------------------------------
;KEY_PROCESSING: process non-exit keys, and retrun operation code
;  inputs: al = ascii code
;          ah = extended flag or -1 if bad key (bad key handled previously)
;          bx = processing offset
;  output: ah = flag 0-buffer key in -al- and adjust cursor as necessary
;                    1-cursor move only (see -bx-)
;                    2-error/ignore (sound bell if -al- has bell char)
;                    3-enter key pressed
;                  0ffh-abort key pressed -al- has key code
;          bl = 0-cursor unchanged  1-cursor right 0ffh-cursor left
;
KEY_PROCESSING:
	les	di,dword ptr key_buf_ptr
	jmp	bx
;-----------------
abort_key:
	mov	ah,-1		;flag abort state
	jmp	kp_exit
;------------------
enter_key:
	mov	ah,3		;flag enter key
	jmp	kp_exit
;------------------
escape_key:
	mov	ah,-1
	jmp	kp_exit
;------------------
right_arrow_key:
	mov	cx,key_buf_index	;check
	inc	cx
	cmp	cx,key_buf_length	; if at end of buffer
	je	can_not_do		;   jmp if at end already
	cmp	byte ptr es:[di],0	;check if at end of data
	jne	rak1			;jmp if valid ascii here
        mov     byte ptr es:[di],' '    ;stuff space
rak1:	inc	key_buf_ptr
	inc	key_buf_index
	mov	cl,key_window_index
	inc	cl
	cmp	cl,key_window_length
	je	rak2			;jmp if at right edge already
	inc	key_window_index
	inc	current_key_window_column
rak2:
	jmp	cursor_only_exit
;------------------
left_arrow_key:
	cmp	key_buf_index,0
	je	can_not_do
	mov	cl,key_window_index
	cmp	cl,0
	je	lak1			;jmp if cursor at left edge already
;
; check if buffer index is ahead of window index and scrolling is needed
;
	cmp	cl,byte ptr key_buf_index
	jb	lak1			;jmp if buffer is ahead still
	dec	current_key_window_column
	dec	key_window_index
lak1:
	dec	key_buf_index
	dec	key_buf_ptr
	jmp	cursor_only_exit
;-----------------
home_key:
	mov	key_buf_index,0
	mov	cx,starting_key_buf_offset
	mov	key_buf_ptr,cx

	mov	key_window_index,0
	mov	cl,starting_key_window_column
	mov	current_key_window_column,cl
	jmp	cursor_only_exit
;-----------------
end_key:
	mov	cx,key_buf_length
	dec	cx
	mov	key_buf_index,cx
	add	cx,starting_key_buf_offset
	mov	key_buf_ptr,cx

	mov	cl,key_window_length
	dec	cl
	mov	key_window_index,cl
	add	cl,starting_key_window_column
	mov	current_key_window_column,cl

cursor_only_exit:
	mov	ah,1		;flag cursor move only
	jmp	kp_exit
;-------------------
delete_key:
	cmp	byte ptr es:[di],0	;check if char under cursor
	je	can_not_do		;jmp if no char here
;
; move end of string left 1 to cover deleted char. Fill zero at end
;
	mov	cx,key_buf_length
	sub	cx,key_buf_index
	dec	cx
	mov	si,di
dk_move:
	jcxz	dk_shift_done
	inc	si
	mov	ah,byte ptr es:[si]	;get forward key
	mov	byte ptr es:[di],ah	;cover key to left
	inc	di
	loop	dk_move
dk_shift_done:
        mov     byte ptr es:[si],0      ;put zero at end
	jmp	cursor_move_exit
;-------------------
backspace_key:
	call	left_arrow_key
	cmp	ah,2
	je	kp_exit
	mov	di,key_buf_ptr		;restore buffer ptr
	call	delete_key
	jmp	kp_exit

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
	mov	byte ptr es:[di],al	;store char
	mov	cx,key_buf_index
	inc	cx
	cmp	cx,key_buf_length
	je	cursor_move_exit	;jmp if at end of key buffer
	call	right_arrow_key
	jmp	norm_exit
;
; keyboard is in insert mode
;
insert_mode:
	mov	cx,key_buf_length
	dec	cx
	cmp	cx,key_buf_index	;check if at end of buffer
	je	im_stuff		;go stuff char
;
; open a hole for our insert char.
;
	sub	cx,key_buf_index	;compute number of char's to right
	mov	si,di
	dec	si
	add	si,cx
	add	di,cx
;
; move from end of buffer to present position, then move our char 
;
im_loop:
	mov	ah,byte ptr es:[si]
	mov	byte ptr es:[di],ah
	dec	si
	dec	di
	loop	im_loop

	mov	byte ptr es:[di],al
	call	right_arrow_key
	jmp	norm_exit
	
im_stuff:
	mov	byte ptr es:[di],al
	
norm_exit:
	mov	ah,0
	jmp	kp_exit
;-------------------
can_not_do:
	mov	dx,3		;duration
	mov	bx,0a0h		;frequency
	call	make_sound
	mov	ah,2
	jmp	kp_exit
cursor_move_exit:
insert_key:
	mov	ah,1
kp_exit:
	ret
;-----------------------------------------------------------------------------
;KEY_DISPLAY: redisplay key input window.
;  inputs: ah = color
;  output: none
;
KEY_DISPLAY:
	mov	cl,key_window_index
	inc	cl
	cmp	cl,key_window_length	;is cursor on left edge
	jne	not_at_far_right
	dec	cl
	cmp	cl,byte ptr key_buf_index
	je	not_at_far_right	;jmp if normal display will work
;
; the windows is showing the right portion of the buffer and some characters
; on the left are not displayed.
; Next, determine where display should start from.
;
	mov	cx,key_buf_index
	sub	cl,key_window_index
	mov	si,starting_key_buf_offset
	add	si,cx
	jmp	kd_display_out

not_at_far_right:
	mov	si,starting_key_buf_offset
kd_display_out:
	mov	dx,word ptr starting_key_window_column
	sub	ch,ch
	mov	cl,key_window_length
	push	ds
	push	es
	pop	ds
	call	display_string_fill
	pop	ds
	add	dl,key_window_index
	cmp	dl,last_cursor
	je	no_change
	mov	last_cursor,dl
;
; move cursor
;
	mov	dh,key_window_row
	mov	ah,2
	mov	bh,0			;page 0
	int	10h	
no_change:	
	ret
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
QGET_STRING - Quick call to get string & return when done
;
; inputs: cl = max string length (buffer length)
;         dx = display location (dh=row,dl=column)
;         es:di = pointer to buffer for data storage
;         
; output: cx = size of string entered, if -1 then illegal key (ax has key)
;         ax = if cx = -1 then cx=illegal key code
;              
; notes: This routine calls GET_STRING with some standard settings.
;        For full control use GET_STRING instead.         
;* * * * * * * * * * * * * *

	public	qget_string
QGET_STRING	PROC	FAR
	apush	bx,dx,si,di,ds,es
	mov	ch,cl			;set window length = string length
	mov	ah,pick_select_color	;set edit state color
	mov	al,pick_color		;set edit complete color
	mov	bl,gs_init+gs_key_wait+gs_close	;set edit flags
	call	get_string
	apop	es,ds,di,si,dx,bx
	retf
QGET_STRING	ENDP
;--------------------------------------------------------------------------

LIBSEG	ENDS
	end
