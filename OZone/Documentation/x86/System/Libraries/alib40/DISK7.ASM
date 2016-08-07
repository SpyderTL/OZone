	page	66,132
;******************************** DISK7.ASM  *********************************


LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	extrn	diskread_open:far
	extrn	diskread_close:far
.list
;----------------------------------------------------------------------------

filehandle	dw	0

buffer		db	512 dup (?)
buffer_ptr	dw	buffer
buffer_count	dw	0

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
;FileChar_open - open disk file for buffer Read
;
; inputs:  ds:dx = pointer to asciiz file name
;
; output:  if no carry - file opened successfully
;                carry - error, either file can not be opened or
;                        file is already open.
;
; Note:  only one file can be open at a time if using the functions
;        FileChar_open, FileChar_close, FileChar_char
;* * * * * * * * * * * * * *

	public	FileChar_open
FileChar_open	proc	far
	push	bx
	call	diskread_open
	mov	cs:filehandle,bx
do_exit:pop	bx
	retf

FileChar_open	endp
;

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
;FileChar_read - read next char
;
; inputs:  none
;
; output:  if no carry - char read successfully
;                      - al = char read
;                carry - error, either file error, or file not open
;                        or at end of file.
;                      - If ax = zero then at end of file
;
; note:  FileChar_open must be called before this funciton can be
;        used.  Use FileChar_close when done with file.
;* * * * * * * * * * * * * *

	public	FileChar_read
FileChar_read	proc	far
	apush	DS,bx,cx
	mov	ax,cs
	mov	ds,ax
	mov	bx,filehandle
	cmp	bx,0
	je	eof_exit		;jmp if no files open
fc_lp:	mov	cx,buffer_count
	cmp	cx,0
	je	fill_buffer		;jmp if buffer empty
	dec	cx
	mov	buffer_count,cx
	mov	bx,buffer_ptr
	mov	al,byte ptr [bx]
	inc	bx
	mov	buffer_ptr,bx
	clc
	jmp	fc_exit

fill_buffer:	
	mov	cx,512
	mov	dx,offset buffer
	mov	ah,3fh
	int	21h
	jc	eof_exit
	cmp	ax,0
	je	eof_exit
	mov	buffer_count,ax
	mov	buffer_ptr,offset buffer
	jmp	fc_lp
	
eof_exit:
	sub	ax,ax
	stc
fc_exit:
	apop	cx,bx,DS
	retf

FileChar_read	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
;FileChar_close - close disk file used for Read
;
; inputs:  BX - file handle
;
; output:  none
;
;* * * * * * * * * * * * * *

	public	FileChar_close
FileChar_close	proc	far
	push	bx
	mov	bx,cs:filehandle
	call	diskread_close
dc_exit:
	mov	cs:filehandle,0
	pop	bx
	retf	
FileChar_close	endp
	
LIBSEG	ENDS
	end
