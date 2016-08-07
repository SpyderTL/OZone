	page	66,132
;******************************** DISKF.ASM  *********************************


LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc

	extrn	dos_mem_allocate:far
	extrn	dos_mem_release:far
.list
;----------------------------------------------------------------------------

file_handle		dw	0	;file handle

buffer_address	label	dword
buffer_pointer	dw	0
BufferSegment	dw	0

BufferSize	equ	8000h
available	dw	0	;bytes available in buffer


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
;DiskWrite_open - open disk file for buffer write
;
; inputs:  ds:dx = pointer to asciiz file name
;
; output:  if no carry - file opened successfully
;                carry - error, either file can not be opened or
;                        file is already open.
;
;* * * * * * * * * * * * * *

	public	DiskWrite_open
DiskWrite_open	proc	far
	apush	ax,cx,dx,es
	cmp	cs:file_handle,0
	jne	error				;jmp if file already open
	mov	ah,3ch				;file create
	mov	cx,0				;create normal read/write
	int	21h
	jc	error				;jmp if file error
	mov	cs:file_handle,ax
	mov	dx,0
	mov	ax,BufferSize
	call	dos_mem_allocate
	jc	error				;jmp if insufficient memory
	mov	cs:BufferSegment,es
	mov	cs:buffer_pointer,0
	mov	cs:available,BufferSize
	jmp	do_exit
error:	stc
do_exit:apop	es,dx,cx,ax
	retf

DiskWrite_open	endp
;

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
;DiskWrite_buffer - open disk file for buffer write
;
; inputs:  ds:dx = pointer to write data
;             cx = amount of data to write
;
; output:  if no carry - file written successfully
;                carry - error, either file error, or file not open
;                        or data block exceeds 32000 bytes.
;
; note:  DiskWrite_open must be called before this funciton can be
;        used.  Use DiskWrite_close when done with file.
;        The largest data block which can be buffered is 32000 bytes.
;* * * * * * * * * * * * * *

	public	DiskWrite_buffer
DiskWrite_buffer	proc	far
	apush	ax,bx,es
	cmp	cs:file_handle,0
	je	db_error
	cmp	cx,cs:available		;check if room
	jb	db_move			;jmp if room
	cmp	cx,BufferSize
	ja	db_error		;jmp if too much data

	call	write_buffer
	jc	db_error
	
db_move:apush	cx,si,di
	cld
	sub	cs:available,cx
	mov	si,dx
	les	di,cs:buffer_address
	rep	movsb
	mov	cs:buffer_pointer,di
	apop	di,si,cx
	clc
	jmp	db_exit	
db_error:stc
db_exit:apop	es,bx,ax
	retf

DiskWrite_buffer	endp
;-----------------------------
write_buffer:		
	apush	ds,dx,cx
	mov	bx,cs:file_handle
	mov	ah,40h
	mov	cx,cs:buffer_pointer
	mov	dx,0			;offset buffer
	mov	ds,cs:BufferSegment
	int	21h
	mov	cs:buffer_pointer,0
	mov	cs:available,BufferSize
	apop	cx,dx,ds
	ret

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
;DiskWrite_close - close disk file used for buffer write
;
; inputs:  none
;
; output:  none
;
;* * * * * * * * * * * * * *

	public	DiskWrite_close
DiskWrite_close	proc	far
	apush	ax,bx,cx,es
	cmp	cs:file_handle,0
	je	dc_exit			;jmp if no file open
	mov	cx,cs:buffer_pointer
	jcxz	close_it		;jmp if buffer empty
	call	write_buffer
close_it:
	mov	bx,cs:file_handle
	mov	ah,3eh			;close file
	int	21h
	mov	es,cs:BufferSegment
	call	dos_mem_release
	mov	cs:file_handle,0	;enable diskwrite_open
dc_exit:
	apop	es,cx,bx,ax
	retf	
DiskWrite_close	endp
;
	
LIBSEG	ENDS
	end
