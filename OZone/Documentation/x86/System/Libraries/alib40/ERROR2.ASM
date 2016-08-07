	page	66,132
;******************************** ERROR2.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc

	extrn	err_asciiz:byte
	extrn	err_tbl_off:word
	extrn	err_tbl_seg:word
	extrn	error_number:byte
	extrn	error_flags:byte
	extrn	entry_seg:word
	extrn	entry_bp:word	
	extrn	err_tbl_off:word
	extrn	err_tbl_seg:word
	
	extrn	error_handler1:far
	extrn	one_beep:far
	extrn	library_terminate:far
	extrn	message:far
	extrn	bar_hotkey_color:byte
;----------------------
.list
;----------------------------------------------------------------------------

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  ERROR  )
error_prime - setup error handler with additional error information
;
; inputs:  ds:bp = table of additional errors used by ERROR_TABLE_HANDLER
;          ds:di = ptr to file name for use by ERROR_FILE_HANDLER
;
; output:  none
;
; note:  If either ERROR_TABLE_HANDLER1 or ERROR_FILE_HANDLER1 are used
;        they must first be primed with the error information.  Error
;        files can be built with EDREC and the first record will be
;        error #1.  Similiarly a table can be built in memory which
;        consists of a list of pointers to text strings.         
;* * * * * * * * * * * * * *

	PUBLIC	error_prime1
error_prime1	proc	far
	apush	cx,si,di,es
	mov	cs:err_tbl_seg,ds
	mov	cs:err_tbl_off,bp
	mov	cx,13
	cld
	mov	si,di
	mov	di,offset err_asciiz
	push	cs
	pop	es
	rep	movsb
	apop	es,di,si,cx
	retf
error_prime1	endp	
;	
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  ERROR  )
ERROR_TABLE_HANDLER1 - handle errors described in table provided by programmer
;
; inputs:      al = error number
;	       ah - flags 80h = fatal_error, abort after display
;                         40h = non_fatal1, return to retry
;                         20h = non_fatal2, return after any key press
;                         10h = fatal_return, fatal error but return after key
;                         08h = spare
;			  04h = spare
;			  02h = spare
;			  01h = spare
;
; output:  none
;
; Note: ERROR_PRIME must be caller before this routine is accessed
;* * * * * * * * * * * * * *

	public	error_table_HANDLER1
error_table_HANDLER1	proc	far
	apush	ax,bx,si,ds
	sub	bx,bx
	mov	bl,al
	shl	bx,1
	sub	bx,2			;adjust for errors starting with 1
	add	bx,cs:err_tbl_off        ;index into error
	mov	ds,cs:err_tbl_seg
	mov	si,word ptr [bx]	 ;get ptr to error msg
	call	error_HANDLER1
	apop	ds,si,bx,ax
	retf	
error_table_HANDLER1	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  ERROR  )
ERROR_FILE_HANDLER1 - handle errors described in file provided by programmer
; inputs:      al = error number (1+)
;	       ah - flags 80h = fatal_error, abort after display
;                         40h = non_fatal1, return to retry
;                         20h = non_fatal2, return after any key press
;                         10h = fatal_return, fatal error but return after key
;                         08h = spare
;			  04h = spare
;			  02h = (future) error_text, ds:bp has message
;			  01h = (future) error_value, bp has error number
;
; output:  none
;
; Note: ERROR_PRIME must be called before this routine is accessed
;* * * * * * * * * * * * * *

	public	error_file_HANDLER1
error_file_HANDLER1	proc	far
	apush	ax,bx,cx,dx,si,di,ds,es
	mov	cs:entry_seg,ds
	mov	bx,cs
	mov	ds,bx
	mov	es,bx

	mov	entry_bp,bp
	mov	error_number,al
	mov	error_flags,ah
	call	one_beep

	mov	ah,bar_hotkey_color
	mov	al,0			;separator
	mov	dx,0101h
	mov	bx,0630h
	mov	si,offset err_asciiz	;get file name
	mov	bp,msg_save_win+msg_restore_win+msg_anykey+msg_close+msg_open+msg_disp
	call	message
	apop	es,ds,di,si,dx,cx,bx,ax
	test	cs:error_flags,fatal_error
	jnz	ferror_abort		;jmp if no return from error
	retf

ferror_abort:
	mov	ax,0
	call	library_terminate
	mov	ah,4ch
	int	21h
error_file_HANDLER1	endp

LIBSEG	ENDS
	end
