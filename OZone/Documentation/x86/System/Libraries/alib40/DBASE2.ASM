	page	66,132
;***************************** DBASE2.ASM *********************************
; FD_INIT       -setup                    FD_REPLACE   -replace record
; FD_READ       -read record              FD_REMOVE    -delete record
; FD_READ_NEXT  -read next record         FD_CLOSE     -close & write
; FD_READ_PREV  -read previous rec.       FD_KILL      -delete database
; FD_APPEND     -write rec at end 
;----------------------------------------------------------------------------

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing
;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	lib_info:byte
	extrn	dos_mem_allocate:far
	extrn	dos_mem_release:far
	extrn	strlen1:far
;----------------------------------------------------------------------------
;------------------------------ data section --------------------------------
;----------------------------------------------------------------------------
index_buf_siz	equ	32768
insert_buf_siz	equ	16384
disk_buf_siz	equ	16000

work_area	struc
;
; All indexes and record # start at zero.  rec# = index
;
index_buf		db	index_buf_siz dup (?)
index_buf_end		db	?
;
; append buffer entries have to be deleted and sorted in place.
;
append_buf		db	insert_buf_siz dup (?)
append_buf_end		db	?
append_nxt_wrt		dw	?		;ptr to next write position

disk_buf		db	disk_buf_siz dup (?)
disk_buf_end		db	?
disk_buf_dirty		db	?	;flag to force write 0=clean 1=dirty
end_disk_buf_data	dw	?

f_handle		dw	?	;file handle
f_asciiz		db	80 dup (?)

record_len		dw	?	;lenght of record
max_records_in_buf 	dw	?	;max number of records in disk_buf
bytes_per_blk		dw	?	;size of each disk block

current_disk_buf_blk	dw	?	;disk blk number
top_rec_no_in_buf	dw	?	;rec# at top of buffer

work_area_end		db	?	;last byte of work area
work_area	ends

;-----------
; index_buf uses byte entries of the following format:
top_flag	equ	80h		;top of index
eof_flag	equ	40h		;eof on disk, no data here
valid_flag	equ	20h		;this is a valid index entry
;                       10h		;unused
;          	   	08h		;unused
;                       04h
delete_flag	equ	02h		;delete this rec.
in_memory_flag	equ	01h		;cleared when next buf read

;-----------
; record numbers are positive numbers 0-32767
; Appends are indicated by pointing into the append_buf.  This will
;  result in a negative record number
; The append numbers change if records are deleted.
;

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
;FD_INIT - open and initialize an existing or new database
;
; inputs:  ds:dx = ptr to asciiz file name
;             ax = record size in bytes
; output:  carry set = error, else
             bx = selector needed to access database (segment)
;            ax = 0 if data found
; processing: 1. allocate memory to handle database information
;             2. open the file or create it if necessary
;             3. initialize the data area
;             4. read the first block of data
;
; Notes:  The database routines are usually called in the following
;	  order:        1. FD_INIT
;		        2. database read/write routines
;			3. FD_close
;				      
;* * * * * * * * * * * * * *

	public	FD_INIT
FD_INIT	proc	far
	apush	dx,si,di,ds,es
	cld
	mov	bx,dx			;save file asciiz ptr
	mov	cs:fd_temp,ax		;save record size
;
;  try to allocate more memory
;
	mov	dx,0
	mov	ax,offset work_area_end		;get amount of space needed
	call	dos_mem_allocate
	mov	al,03h				;preload out of memory err
	jc	dinit_exit  			;jmp if out of memory
;
; A free file control block has been found and the segment is in -ax- and -es-
;    ds:dx = file asciiz name
; Setup the control block
;
dinit2:		mov	cx,offset work_area_end
		shr	cx,1
		mov	di,offset index_buf
		mov	ax,0
		rep	stosw			;clear the database
;
; set the individual fields in the file_control block.
;
dinit3:		mov	ax,offset append_buf
		mov	word ptr es:[append_nxt_wrt],ax
		mov	ax,offset disk_buf
		mov	word ptr es:[end_disk_buf_data],ax
;
; move the file asciiz name to file_control
;
		apush	cx,si,di
		mov	si,bx		;from offset
		mov	di,offset f_asciiz
		mov	cx,40
		rep	movsb
;
; compute max records
;
		mov	ax,cs:fd_temp		;get record size
		mov	es:[record_len],ax

		mov	cx,ax			;save record len
		sub	dx,dx
		mov	ax,(offset disk_buf_end	- offset disk_buf)
		cmp	cx,ax
		jbe	divide_ok		;jmp if divide ok
		mov	ax,3
		jmp	dinit_exit
divide_ok:	div	cx
		mov	es:[max_records_in_buf],ax
		mul	es:[record_len]
		mov	es:[bytes_per_blk],ax	;save buffer size
		
		apop	di,si,cx
;
; attempth to open the file
;  ds:dx point to asciiz name of file
;
		mov	dx,bx
		mov	cx,2		;open for write
		mov	ah,3dh		;open code
		mov	al,2
		int	21h
		jc	dinit_exit
		mov	word ptr es:[f_handle],ax

		call	build_index
dinit_exit:
	mov	bx,es		;get database selector
	mov	ax,eof_flag
	and	al,es:[index_buf] ;set ax zero if data found
	apop	es,ds,di,si,dx
	retf
FD_INIT	endp

fd_temp		dw	?

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
;FD_READ - read specific record from the database.
;
; inputs: es = selector from FD_INIT
;         bx = record# to read
;
; output: no carry - if successful, cx=read amount
;            carry - unknown error
;      es:si = ptr to record read (valid if no carry)
;         
;* * * * * * * * * * * * * *

	public	FD_READ
FD_READ	proc	far
	apush	ax,bx,cx
	test	bx,8000h
	jz	fd_normal_rec
	mov	si,bx		;move append record ptr to rec#
	clc
	jmp	fd_done
fd_normal_rec:
	call	local_read
fd_done:
	apop	cx,bx,ax
	retf
FD_READ	endp

;-----------
; local_read - read indexed record from memory or disk, no appends
;  inputs: bx = record # to read
;  output: carry set if error, if no carry then the following is valid.
;          ax = current block #
;          bx = record #
;          cx = record # at block top
;       es:si = pointer to record data
;
local_read:
	apush	dx,di
	call	compute_blk_index_ptr
	test	byte ptr es:[bx],in_memory_flag
	jz	fd_get_from_disk
	jmp	local_exit
	
fd_get_from_disk:	
	call	$read_blk
	jc	whoops_exit
	call	compute_blk_index_ptr
	test	byte ptr es:[bx],in_memory_flag
	jnz	local_exit
	stc
	jmp	whoops_exit
local_exit:
	clc
whoops_exit:
	apop	di,dx
	ret
	
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
;FD_READ_NEXT - read next sequential record.
;
; inputs:    es = selector from FD_INIT
;            bx = current rec#
;
; output: no carry  =  success
;            carry  = end of data.
;      es:si = ptr to record read (valid if no carry)
;         bx = record number
;
;* * * * * * * * * * * * * *


	public	FD_READ_NEXT
FD_READ_NEXT proc	far
	apush	ax,cx,di
	test	bx,8000h
	jnz	doing_appends
;
; we are processing a normal index
;
fdn_1:	inc	bx		;move to next entry
	test	byte ptr es:[bx],valid_flag
	jnz	fd_normal1
;
; end of index data, do appends now
;
start_appends:
	mov	bx,offset append_buf
	mov	si,bx
	cmp	bx,es:[append_nxt_wrt]
	jne	fd_normal_exit
	jmp	fd_eof_exit

fd_normal1:
	test	byte ptr es:[bx],delete_flag
	jnz	fdn_1    		;jmp if delete found
	call	local_read		;get data from disk/memory
	jmp	fd_exit
;
; we are walking appends
;
doing_appends:
	add	bx,es:[record_len]
	cmp	bx,es:[append_nxt_wrt]
	je	fd_eof_exit   		;jmp if no more data
	mov	si,bx			;setup si also
fd_normal_exit:
	clc
	jmp	fd_exit
fd_eof_exit:
	stc
fd_exit:
	apop	di,cx,ax
	retf
FD_READ_NEXT	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
;FD_READ_PREV - read previous record. (write operations do not affect)
;
;
; inputs:    es = selector from FD_INIT
;            bx = current rec#, set to -1 if append
;
; output: no carry  =  success
;            carry  = end of data.
;      es:si = ptr to record read (valid only no carry)
;         bx = record number
;
;* * * * * * * * * * * * * *


	public	FD_READ_PREV
FD_READ_PREV proc	far
	apush	ax,cx,di
	test	bx,8000h
	jnz	fdp_in_appends
fdp_01:	test	byte ptr es:[bx],top_flag
	jnz	fd_at_top
	dec	bx			;move up one index
	test	byte ptr es:[bx],delete_flag
	jnz	fdp_01			;jmp if delete
	clc
	jmp	fdp_80

fdp_in_appends:
	cmp	bx,offset append_buf
	je	fd_ap_top		;jmp if at top of appends
	sub	bx,es:record_len	;move up one record
	mov	si,bx
	clc
	jmp	fdp_exit
;
; we are at top of appends, now move to bottom of index
;
fd_ap_top:
	mov	bx,offset index_buf
	test	byte ptr es:[bx],eof_flag
	jnz	fd_at_top
;
; scan for end of index's
;
fdp_lp:	inc	bx
	test	byte ptr es:[bx],eof_flag
	jz	fdp_lp			;loop till eof found
	dec	bx
fdp_80:
	call	local_read		;read this record
	clc
	jmp	fdp_exit

fd_at_top:
	stc
fdp_exit:	
       	apop	di,cx,ax
	retf
;
FD_READ_PREV endp

;----------------------------------------------------------------------------
;------------------------------ dbase write ---------------------------------
;----------------------------------------------------------------------------
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
;FD_APPEND - append this record to end of databse
;
; inputs:     es = selector from FD_INIT
;          ds:si = source data buffer
;	      
; output:  carry = error
;          no carry = bx - assigned record #
;
;* * * * * * * * * * * * * *

	public	FD_APPEND
FD_APPEND	proc	far
	apush	ax,cx,si,di
	cld
	mov	di,es:[append_nxt_wrt]
	mov	cx,es:[record_len]
	mov	bx,di			;preload new record#
;
; check if room
;
	mov	ax,di
	add	ax,cx			;compute data extent
	cmp	ax,offset append_buf_end
	ja	fa_no_room		;jump if out of room

	rep	movsb			;move the data
	mov	es:[append_nxt_wrt],di	;save new store ptr
	clc
	jmp	fda_exit
fa_no_room:
	stc
fda_exit:
	apop	di,si,cx,ax
	retf
FD_APPEND	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
;FD_REPLACE - replace data for a specific record
;
; inputs:     es = selector from FD_INIT
;             bx = record number modified
;
; output:  no carry,   =  (success)
;            carry     = error
;
; note:  It is assumed that the data has been modified and all we
;        need to do is set status flags and exit.
;* * * * * * * * * * * * * *

	public	FD_REPLACE
FD_REPLACE	proc	far
	test	bx,8000h
	jnz	fdr_exit		;exit if append was modified
      	test	byte ptr es:[bx],in_memory_flag
	jnz	set_replace
	stc
	jmp	fdr_exit
set_replace:
	mov	es:[disk_buf_dirty],1
fdr_exit:
	clc
	retf
FD_REPLACE	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
;FD_REMOVE - delete specific record
;
; inputs:      es = selector from FD_INIT
;	       bx = record number to delete
;
; output:  no carry  (success)
;            carry  = error
;             
;* * * * * * * * * * * * * *


	public	FD_REMOVE
FD_REMOVE	proc	far
	test	bx,8000h
	jz	fdx_1			;jmp if normal record
;
; we need to remove an entry from the append buffer
;
	cld
	mov	di,bx			;destination
	add	bx,es:[record_len]
	mov	si,bx			;source data
	mov	cx,es:[append_nxt_wrt]
	sub	cx,si			;compute lenght of move
	jcxz	save_ptrs		;jump if last record in append buf
	push	ds			;save ds
	push	es			;  move es to
	pop	ds			;  ds
	rep	movsb
	pop	ds			;restore ds
save_ptrs:
	mov	es:[append_nxt_wrt],di
	jmp	fdd_exit
;
; set delete_flag in index
;	
fdx_1:	test	byte ptr es:[bx],valid_flag
	jnz	set_delete
	stc
	jmp	fdd_exit
set_delete:
	or	byte ptr es:[bx],delete_flag
fdd_exit:
	clc
	retf
FD_REMOVE	endp
;----------------------------------------------------------------------------
;------------------------------ dbase close ---------------------------------
;----------------------------------------------------------------------------
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
; FD_CLOSE - close & write any pending data to file
;
; inputs:      es = database selector returned by DBASE_INIT
; 
; output:	none
; 
;* * * * * * * * * * * * * *

dcc_temp_asciiz		db	'DBASE.$$$',0
dcc_temp_handle		dw	0

	public	FD_CLOSE
FD_CLOSE  proc	far
	apush	bx,cx,dx,si,di,bp,ds,es
	call	write_current_blk
	call	write_appends_and_deletes
	call	dos_mem_release
	apop	es,ds,bp,di,si,dx,cx,bx
	retf

FD_CLOSE	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
;FD_KILL - delete dbase file
;
; inputs:       ds:dx = asciiz file name ptr
; 
; output:	carry set if error, error code from DOS function 41h
;* * * * * * * * * * * * * *

	public	FD_KILL
FD_KILL	proc	far
	mov	ah,41h
	int	21h
	retf
FD_KILL	endp
;-----------------------------------------------------------------------------
;------------------------------ local subroutines ----------------------------
;-----------------------------------------------------------------------------
;
; $read_blk - read block from disk
;    inputs  ax = block to read
;    output  ax destroyed
;            carry set if error
;
$read_blk:
	apush	bx,cx,dx
	call	seek_blk_top
;
; dx,ax = new seek position if carry=clear
; if carry set then error code in -ax-
;
	jc	rb_error
;
; read a block of data
;
	mov	es:[current_disk_buf_blk],ax
	mov	bx,es:[f_handle]	;get file handle
	mov	cx,es:[bytes_per_blk]	;get read size
	push	ds
	mov	dx,es
	mov	ds,dx			;buffer ptr = ds:dx
	mov	dx,offset disk_buf
	mov	ah,3fh
	int	21h			;read disk
;
; -ax- = number of bytes read
; if carry -ax- = error code
;
	pop	ds
	jc	rb_error
	add	ax,offset disk_buf
	mov	es:[end_disk_buf_data],ax

	call	compute_blk_index_ptr
	mov	es:[top_rec_no_in_buf],cx
	mov	es:[current_disk_buf_blk],ax
;
; build index entries, clear old in_memory_flags, set new in_memory_flags
;
	mov	al,4		;code for set in_memory for this blk
	call	index_changes	;update blk flags
	clc
rb_error:
	apop	dx,cx,bx
	ret	
;--------------------------------------------------------------------------
; write_current_blk - seek to start of block and overwrite disk data
;   inputs:  none
;   outputs: none
;   processing:  1. write current block back to disk
;                2. clear all in_memory and modify_flags in index
;
write_current_blk:
	apush	ax,bx,cx,dx,ds
	cmp	es:[disk_buf_dirty],0
	je	skip_writes			;jmp if disk_buf unchanged
rb_seek:
	mov	ax,es:[current_disk_buf_blk]
	call	seek_blk_top

	mov	bx,es:[f_handle]
	mov	ah,40h			;write block
	mov	cx,es:[end_disk_buf_data]
	sub	cx,offset disk_buf	;compute size of write
	jcxz	wcb_exit		;exit if buffer empty
	mov	dx,es
	mov	ds,dx
	mov	dx,offset disk_buf
	int	21h
	mov	byte ptr es:[disk_buf_dirty],0
;
; clear all modify flags in index
;
skip_writes:
	mov	al,1
	call	index_changes			;clear in_memory_flag
wcb_exit:
	apop	ds,dx,cx,bx,ax
	ret
;--------------------------------------------------------------------------
; write_appends_and_deletes - merge datafile with insert buffer,
;                             also check for deletes at same time.
;   inputs: none
;   ouptut: carry set if error
;   notes: the datafile is assumed to be open and rewound

temp_asciiz	db	'dbase.$$$',0
temp_handle	dw	0


write_appends_and_deletes:
	apush	bx,cx,dx,si,di
	mov	ax,0
	call	seek_blk_top		;move to top of file
;
; open temp output file
;
	mov	ah,3ch
	mov	cx,0			     ;create for write
	mov	dx,offset temp_asciiz
	push	cs				;swap ds
	pop	ds				;  and cs
	int	21h
	jc	wi_err
	mov	temp_handle,ax

; setup to process index

	mov	si,offset index_buf
wi_lp1:
	test	byte ptr es:[si],valid_flag
	jz	wi_appends	;jmp if no more data on disk
wi_2:	test	byte ptr es:[si],delete_flag
	jz	wi_6		;jmp if not deleted rec
	call	read_rec	;read record from disk and discard
	jmp	wi_8
wi_6:	call	read_rec	;read next record
	mov	dx,offset disk_buf
	call	write_rec	;write record to output
wi_8:	inc	si		;move to next record
	jmp	wi_lp1	
;
wi_appends:
	mov	cx,es:[append_nxt_wrt]
	sub	cx,offset append_buf
	jcxz	close_and_exit	;jmp if no append data
	mov	dx,offset append_buf
	call	write_rec2	;write append data
;
; close input file
;
close_and_exit:
	mov	ah,3eh
	mov	bx,es:[f_handle]
	int	21h
	jc	wi_err
;
; close temp output file
;
	mov	ah,3eh
	mov	bx,temp_handle
	int	21h
	jc	wi_err
;
; delete input file
;
	mov	ah,41h
	push	es
	pop	ds
	mov	dx,offset f_asciiz
	int	21h
	jc	wi_err
;
; rename temp output file as new input file.
;
	push	cs
	pop	ds
	mov	ah,56h			;rename
	mov	dx,offset dcc_temp_asciiz ;existing name
	mov	di,offset f_asciiz
	int	21h
	jnc	wi_exit
wi_err: stc	
wi_exit:
	apop	di,si,dx,cx,bx
	ret
;----------

read_rec:
	mov	cx,es:[record_len]
read_rec2:				;!!!! entry point beware
	mov	ah,3fh			;DOS read code
	mov	dx,offset disk_buf	;get buffer offset
	mov	bx,es:[f_handle]
	push	ds			;save ds
	push	es			;set ds to
	pop	ds			;  buffer segment
	int	21h			;returns ax=number of bytes read
	pop	ds
	ret
;----------
; write record of data at es:dx
write_rec:
	mov	cx,es:[record_len]
write_rec2:				;!!!! entry point beware
	mov	bx,temp_handle
	push	ds
	push	es
	pop	ds
	mov	ah,40h
	int	21h
	pop	ds
	ret
;-----------------------------------------------------------------------------
; seek_blk_top - move disk ptr to start of disk block
;  inputs:  ax = block #
;
seek_blk_top:
	apush	ax,bx,cx,dx
	mul	es:[bytes_per_blk]	;compute seek point
	mov	cx,dx
	mov	dx,ax			;get seek ptr in cx:dx

	mov	al,0			;seek from start of file
	mov	bx,es:[f_handle]	;get file handle
	mov	ah,42h
	int	21h
	apop	dx,cx,bx,ax
	ret
;-----------------------------------------------------------------------------
; index_changes - update index buffer
;   inputs:  es = data seg
;            bx = record # within block
;            al = 1 clear all in_memory flags for current block
;                 4 set in_memory for current block
;
op_request	db	?

index_changes:
	apush	ax,bx,cx,dx,si
	mov	cs:op_request,al
	
	mov	cx,es:end_disk_buf_data
	sub	cx,offset disk_buf
	jcxz	ic_exit		;zero len block
	mov	ax,cx
	mov	dx,0
	div	es:[record_len]
	mov	cx,ax		;number of records -> cx
	
	mov	si,es:[top_rec_no_in_buf]
	cmp	cs:op_request,4
	je	ic_inmemory	;jmp if set in_memory_flag
ic_clear:
	mov	al,not in_memory_flag
ic_lp1:	and	byte ptr es:[si],al	;clear in_memory_flag
	inc	si
	loop	ic_lp1
	jmp	ic_exit
;
ic_inmemory:
	mov	al,in_memory_flag
ic_lp2:	or	byte ptr es:[si],al	;set in_memory_flag
	inc	si
	loop	ic_lp2

ic_exit:
	apop	si,dx,cx,bx,ax
	ret
;-----------------------------------------------------------------------------
; build_index - build index by reading disk and setting flags
;  inputs:  f_handle = file handle which is assumed to be open
;           index_buf - assumed to be all zero
;  output:  carry set if error
;           ax is destroyed or set to error code
;  processing 1. set top_flag
;             2. set eof_flag
;             3. set valid flags if records on disk
;
bi_eof_flag	db	0
last_blk_start	dw	?
size_last_blk	dw	?

build_index:
	apush	bx,cx,dx,di
	mov	bi_eof_flag,0
	mov	size_last_blk,0
	mov	last_blk_start,0
	or	es:[index_buf],top_flag	;set top indicator
	mov	ax,0			;seek to blk #0
	call	seek_blk_top
	mov	di,offset index_buf	;pointer to current index
;
; read a block of data
;
bi_read:
	mov	cx,es:[bytes_per_blk]	;get read size
	call	read_rec2		;read block
	jc	bi_err			;jmp if error
;
; ax = number of bytes read, may be zero if at eof before call
;
	mov	cx,ax
	cmp	ax,es:[bytes_per_blk]
	je	bi_2			;jmp if full blk read
	mov	bi_eof_flag,1
	jcxz	bi_3			;jmp if eof
bi_2:	mov	last_blk_start,di	;save start of blk
	mov	size_last_blk,ax
bi_lp1:	or	byte ptr es:[di],valid_flag
	inc	di
	sub	cx,es:[record_len]
	ja	bi_lp1			;loop till done
;
; check if this is last block
;
	cmp	bi_eof_flag,0
	je	bi_read			;loop to read next blk
bi_3:	or	byte ptr es:[di],eof_flag
	clc
;
; errors possible are: al=05 (access denied)   06 (bad handle)
;
bi_err: 
	apop	di,dx,cx,bx
	ret
;                       
;-----------------------------------------------------------------------------
; compute_blk_index_ptr - compute block number from index
;   inputs:  bx = record # (index ptr)
;   output:  ax = block #
;            si = future buffer ptr for this record#
;            cx = record # at block top
;
compute_blk_index_ptr:
	apush	bx,dx,di
	mov	cx,0		;first record of block 0
	mov	ax,0		;first block
cb_mod:	cmp	bx,es:[max_records_in_buf]
	jb	find_buffer
	sub	bx,es:[max_records_in_buf]
	add	cx,es:[max_records_in_buf]	;bump rec #
	inc	ax				;bump block #
	jmp	cb_mod
;
; bx = rec index into buf
; cx = first record number of current block
; ax = block #
;
find_buffer:
	push	ax				;save blk #
	mov	ax,bx
	mul	es:[record_len]
	add	ax,offset disk_buf
	mov	si,ax
	pop	ax				;restore blk #
	apop	di,dx,bx
	ret
;-----------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
