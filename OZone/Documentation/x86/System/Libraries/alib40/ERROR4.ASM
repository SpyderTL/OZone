	page	66,132
;******************************** ERROR4.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	error_handler2:far
	extrn	one_beep:far
	extrn	stdout_string:far
	extrn	stdout_crlf:far
	extrn	key_read:far

	extrn	bar_hotkey_color:byte
	extrn	err_asciiz:byte
	extrn	err_tbl_off:word
	extrn	err_tbl_seg:word
	extrn	error_number:byte
	extrn	error_flags:byte
	extrn	entry_seg:word
	extrn	entry_bp:word	
	extrn	err_tbl_off:word
	extrn	err_tbl_seg:word
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  ERROR  )
ERROR_PRIME2 - setup error handler with additional error information
;
; inputs:  ds:bp = table of additional errors used by ERROR_TABLE_HANDLER
;
; output:  none
;
;* * * * * * * * * * * * * *

	PUBLIC	ERROR_PRIME2
ERROR_PRIME2	proc	far
	mov	cs:err_tbl_seg,ds
	mov	cs:err_tbl_off,bp
	retf
ERROR_PRIME2	endp	
;	
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  ERROR  )
ERROR_TABLE_HANDLER2 - handle errors described in table provided by programmer
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
; Note: ERROR_PRIME2 must be caller before this routine is accessed
;* * * * * * * * * * * * * *

	public	error_table_HANDLER2
error_table_HANDLER2	proc	far
	apush	ax,bx,si,ds
	sub	bx,bx
	mov	bl,al
	shl	bx,1
	sub	bx,2
	add	bx,cs:err_tbl_off	 ;adjust of errors starting with 1
	mov	ds,cs:err_tbl_seg
	mov	si,word ptr [bx]	 ;get ptr to error msg
	call	one_beep
	call	stdout_crlf
	call	stdout_string
	call	key_read
	apop	ds,si,bx,ax
	retf	
error_table_HANDLER2	endp

LIBSEG	ENDS
	end
