	page	66,132
;******************************** ERROR1.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	one_beep:far
	extrn	draw_box:far
	extrn	library_terminate:far
	extrn	restore_window:far
	extrn	box_shrink:far
	extrn	save_window:far
	extrn	key_read:far
	extrn	display_string_fill:far
	extrn	window_string:far
		
	extrn	bar_hotkey_color:byte
	extrn	entry_seg:word
	extrn	entry_bp:word
	extrn	error_number:byte
	extrn	error_flags:byte
	extrn	error_index:word
;-----------------------------------------------------------------------------
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  ERROR  )
LIB_ERROR_HANDLER1 - handle pre defined library errors
;
; inputs:     al = error number (see error_index)
;	      ah = flags 80h = fatal_error, abort after display
;                        40h = non_fatal1, return to retry
;                        20h = non_fatal2, return after any key press
;                        10h = fatal_return, fatal error but return after key
;                        08h = spare
;                        04h = spare
;			 02h = spare
;			 01h = spare
;
; output:  displayed error message as follows:
;          1 - Incompatable display mode
;          2 - Code error, Contact program author for possible
;              problem resolution
;          3 - Disk read error, Press any key to contine
;          4 - Fatal disk error, Press any key
;          5 - Out of memory, Press any key to abort current operation
;          6 - Path change failed, Press any key
;          7 - insufficient DOS memory to run program,
;              Press any key to abort.
;          8 - Error in finding/reading quote file QUOTE.DAT
;          9 - Memory manager transfer error.  This is usually
;              a programming error.  Contact the author for assistance.
;         10 - Open of above file failed, possibly the file does not
;              exist or is not in correct directory.
;         11 - The program configuration (.CFG) file is missing an <end>
;              statement.   press any key to continue
;
; note:  LIB_ERROR_HANDLER1 is intended for library use only, but can be
;        called from application.               
;* * * * * * * * * * * * * *

	public	lib_ERROR_HANDLER1
lib_ERROR_HANDLER1	proc	far
	apush	ax,bx,si,ds
	sub	bx,bx
	mov	bl,al
	shl	bx,1
	add	bx,offset error_index-2  ;adjust of errors starting with 1
	mov	si,word ptr cs:[bx]	 ;get ptr to error msg
	push	cs
	pop	ds
	call	error_HANDLER1
	apop	ds,si,bx,ax
	retf	
lib_ERROR_HANDLER1	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  ERROR  )
ERROR_HANDLER1 - handle fatal errors
;
; inputs:     ds:si = error text terminated with null character (00).
;                ah = flags 80h - fatal_error, abort after display
;                           40h - non_fatal1, return to retry
;                           20h - non_fatal2, return after any key press
;                           10h - fatal_return, fatal error but return after key
;                           08h - spare
;			    04h - spare
;			    02h - spare
;			    01h - spare
;
; output:	ax = last keypress if a return was requested.
;
; notes:  If the abort option is requested, the library will be closed and
;         the DOS return call executed.
;* * * * * * * * * * * * * *


error_key_save	dw	0	;user key press used to confirm box is viewed.

	public	ERROR_HANDLER1
ERROR_HANDLER1	proc	far
	apush	bx,cx,dx,si,di,ds,es
	mov	cs:entry_seg,ds
	mov	bx,cs
	mov	ds,bx
	mov	es,bx

	mov	entry_bp,si
	mov	error_number,al
	mov	error_flags,ah
	call	one_beep
;
; display with error in box, es:si point at error
;
eh_box_display:
	mov	ah,byte ptr bar_hotkey_color
	mov	dx,0101h
	mov	bx,0630h
;
; check if screen save needed
;
	test	cs:error_flags,non_fatal1+non_fatal2+fatal_return
	jz	eh_boxit	;jmp if no window save
	call	save_window
eh_boxit:
	call	draw_box
	call	box_shrink
	push	es
	pop	ds
	mov	ah,byte ptr bar_hotkey_color
;
; display the error text inside the box
;
eh_cont2:
	push	ds
	mov	si,cs:entry_bp
	mov	ds,cs:entry_seg
	call	window_string
	pop	ds
;
; check type of exit processing, and wait for key if necessary, then exit
;
error_key:
	call	KEY_READ			;get key press
	mov	cs:error_key_save,ax		;save keypress
;
; check if screen restore needed
;
	test	cs:error_flags,non_fatal1+non_fatal2+fatal_return
	jz	eh_error_key	    ;jmp if no window save
	call	restore_window
eh_error_key:
;
; determine what type of exit is needed
;
	apop	es,ds,di,si,dx,cx,bx
	test	cs:error_flags,fatal_error
	jnz	error_abort		;jmp if no return from error
	mov	ax,cs:error_key_save	;restore key press
	retf

error_abort:
	mov	ax,0
	call	library_terminate
	mov	ah,4ch
	int	21h
	
ERROR_HANDLER1	endp
;---------------------------------------------------------------------------

LIBSEG	ENDS
	end
