	page	66,132
;******************************** ERROR3.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	one_beep:far
	extrn	library_terminate:far
	extrn	key_read:far
	extrn	stdout_crlf:far
		
	extrn	stdout_string:far
	extrn	entry_seg:word
	extrn	entry_bp:word
	extrn	error_number:byte
	extrn	error_flags:byte
	extrn	error_index:word
;-----------------------------------------------------------------------------
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  ERROR  )
LIB_ERROR_HANDLER2 - handle pre defined library errors
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
; note:  LIB_ERROR_HANDLER2 is intended for library use only, but can be
;        called from application.               
;* * * * * * * * * * * * * *

	public	LIB_ERROR_HANDLER2
LIB_ERROR_HANDLER2	proc	far
	apush	ax,bx,si,ds
	sub	bx,bx
	mov	bl,al
	shl	bx,1
	add	bx,offset error_index-2  ;index into table
	mov	si,word ptr cs:[bx]	 ;get ptr to error msg
	push	cs
	pop	ds
	call	one_beep
	call	stdout_crlf
	call	stdout_string
	call	key_read
	apop	ds,si,bx,ax
	retf	
LIB_ERROR_HANDLER2	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  ERROR  )
ERROR_HANDLER2 - handle fatal errors
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


err_key_sav	dw	0	;user key press used to confirm box is viewed.

	public	ERROR_HANDLER2
ERROR_HANDLER2	proc	far
	apush	bx,cx,dx,si,di,ds,es
	mov	cs:entry_seg,ds

	mov	entry_bp,si
	mov	error_number,al
	mov	error_flags,ah
	call	one_beep
;
; display the error text
;
eh1_cont2:
	push	ds
	mov	ds,cs:entry_seg
	mov	si,cs:entry_bp
	call	stdout_crlf
	call	stdout_string
	pop	ds
;
; check type of exit processing, and wait for key if necessary, then exit
;
error_key1:
	call	KEY_READ			;get key press
	mov	cs:err_key_sav,ax		;save keypress
;
; determine what type of exit is needed
;
	apop	es,ds,di,si,dx,cx,bx
	test	cs:error_flags,fatal_error
	jnz	error_abort1		;jmp if no return from error
	mov	ax,cs:err_key_sav	;restore key press
	retf

error_abort1:
	mov	ax,0
	call	library_terminate
	mov	ah,4ch
	int	21h
	
ERROR_HANDLER2	endp
;---------------------------------------------------------------------------

LIBSEG	ENDS
	end
