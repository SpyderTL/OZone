	page	66,132
;******************************** DISK6.ASM  *********************************


LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc

.list
;----------------------------------------------------------------------------

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
;DiskRead_open - open disk file for buffer Read
;
; inputs:  ds:dx = pointer to asciiz file name
;
; output:  if no carry - file opened successfully
;                        BX = file handle
;                carry - error, either file can not be opened or
;                        file is already open.
;
;* * * * * * * * * * * * * *

	public	DiskRead_open
DiskRead_open	proc	far
	push	ax
	mov	ah,3dh				;file open
	mov	al,0				;open for read
	int	21h
	mov	bx,ax
do_exit:pop	ax
	retf

DiskRead_open	endp
;

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
;DiskRead_block - open disk file for buffer Read
;
; inputs:  ds:dx = buffer
;             cx = amount of data to Read (buffer must be big enough)
;             bx = handle of file open for read
;
; output:  if no carry - file read successfully
;                carry - error, either file error, or file not open
;                        or at end of file.
;                      - If ax = zero then at end of file
;
; note:  DiskRead_open must be called before this funciton can be
;        used.  Use DiskRead_close when done with file.
;* * * * * * * * * * * * * *

	public	DiskRead_block
DiskRead_block	proc	far
	mov	ah,3fh
	int	21h
	retf

DiskRead_block	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
;DiskRead_close - close disk file used for Read
;
; inputs:  BX - file handle
;
; output:  none
;
;* * * * * * * * * * * * * *

	public	DiskRead_close
DiskRead_close	proc	far
	push	ax
	mov	ah,3eh			;close file
	int	21h
dc_exit:
	pop	ax
	retf	
DiskRead_close	endp
	
LIBSEG	ENDS
	end
