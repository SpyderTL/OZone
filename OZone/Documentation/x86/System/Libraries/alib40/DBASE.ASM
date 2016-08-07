	page	66,132
;****************************** DBASE.ASM **********************************
;upper case routine names are available.
; DBASE_INIT     -setup                     DBASE_REPLACE   -replace record
; DBASE_READ -read record                   DBASE_REMOVE-delete record
; DBASE_READ_NEXT-read next record          DBASE_CLOSE - close & write
; DBASE_READ_PREV-read previous rec.        DBASE_KILL - delete database
; DBASE_RENAME    -change dbase name
; DBASE_APPEND   -write rec at end 
; DBASE_INSERT   -write rec at loc.                                         
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
buf_size	equ	16384
index_size	equ	512
;-----------
work_area	struc
buf		db     buf_size dup (?)
buf_end		dw   	?
index		db	index_size	dup (?)
index_end	dw	?

temp_buf	db     buf_size dup (?)			;used by DBASE_CLOSE
temp_buf_end	dw   	?				;  and $born_again
temp_index	db	index_size	dup (?)
temp_index_end	dw	?

f_key           dw      ?       ;set to 'JO' to allow verification of selector
f_handle	dw	?	;file handle
f_asciiz	db	40 dup (?)
f_flags		db	?	;see below
  created	equ	01h	;file was created or zero length initially.
  at_top	equ	02h	;file is at start, top of file in buffers.
  at_eof	equ	04h	;file is at eof, end of file in buffers.
  fdirty	equ	08h	;current block in memory has been modified

f_rec_bak	dw	?	;rec# for next block towards front of file
f_seek_bak	dd	?	;seek for next block towards front of file

f_rec		dw	?	;rec# for top of current block in mem
f_seek		dd	?	;seek for top of current block in memory

f_rec_fwd	dw	?	;rec# for next block towards end of file
f_seek_fwd	dd	?	;seek for next block towards end of file

buf_avail_ptr	dw	?	;offset of next avail. buf entry
index_avail_ptr dw	?	;offset of index next avail. free space

active_index	dw	?	;index ptr for last rec# read/written
active_block_size dw	?	;size of block in memory
record_count	dw	?	;number of records read from disk

work_area_end	db	?
work_area	ends
;--------------
;
; index structure
;
index_struc	struc
rec_no		dw	?	;modification rec# (-1 if record removed)
file_rec_no	dw	?	;origional file record number (-1 if insert)
buf_ptr		dw	?	;
index_struc	ends
;---------------
; error codes -> 0 = success
;                1 = database empty
;                2 = selector bad or database buffers damaged
;                3 = insuffficient memory
;                4 = disk read/write error, possibly file at eof or top
;                5 = illegal record number
;                6 = file open error, or disk full
;                7 = record length exceeds size of buffers
;                8 = unknown code error
;
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
DBASE_INIT - open and initialize an existing or new database
;
; inputs:  ds:dx = ptr to asciiz file name
;		   
; output:  no carry + al = 0 (sucessfully opened an existing database)
;             carry + al = 1 (new data base created)
;             carry + al = 3 (insufficient memory to open database)
;             carry + al = 4 (disk error)
;            bx = selector needed to access database (segment)
;            cx = number of records read initially, if zero this is null file.
;            
; processing: 1. allocate memory to handle database information
;             2. open the file or create it if necessary
;             3. initialize the data area
;             4. read the first block of data
;
; Notes:  The database routines are usually called in the following
;	  order:        1. DBASE_INIT
;		        2. database read/write routines
;			3. dbase_close
;				      
;* * * * * * * * * * * * * *

	public	DBASE_INIT
DBASE_INIT	proc	far
	apush	dx,si,di,ds,es
	cld
	mov	bx,dx			;save file asciiz ptr
;
;  try to allocate more memory
;
	mov	dx,0
	mov	ax,offset work_area_end		;get amount of space needed
	call	dos_mem_allocate
	mov	al,03h				;preload out of memory err
	jc	di_error  			;jmp if out of memory
;
; A free file control block has been found and the segment is in -ax- and -es-
;    ds:dx = file asciiz name
; Setup the control block
;
dinit2:		mov	cx,offset work_area_end
		shr	cx,1
		mov	di,offset buf
		mov	ax,0
		rep	stosw			;clear the database
;
; set the individual fields in the file_control block.
;
                mov     word ptr es:[f_key],'JO' ;set check word

dinit3:		mov	ax,offset buf
		mov	word ptr es:[buf_avail_ptr],ax
		
		mov	ax,offset index
		mov	word ptr es:[index_avail_ptr],ax
;
; move the file asciiz name to file_control
;
		apush	cx,si,di
		mov	si,bx		;from offset
		mov	di,offset f_asciiz
		mov	cx,40
		rep	movsb
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
		jc	open_failed
		mov	word ptr es:[f_handle],ax
;
;  read first record
;
		mov	al,1		;select forward read
		call	$disk_read	;read database
		jnc	di_rd_ok
		cmp	al,4		;check if eof or disk error
		jne	di_error	;jmp if bad error
di_rd_ok:	mov	cx,es:record_count
di_cont1:
		mov	al,0
		jcxz	di_e			;jmp if file of zero length
		jmp	dinit_exit
;
; the open failed, try to create the file
;
open_failed:
	mov	ah,3ch
	mov	cx,0
	int	21h		;file create
	jc	di_dsk_error
	mov	word ptr es:[f_handle],ax
	mov	al,1
di_e:	or	es:[f_flags],created+at_top+at_eof
	jmp	di_error

di_dsk_error:
	mov	al,4
di_error:
	stc
dinit_exit:
	mov	bx,es		;get database selector
	apop	es,ds,di,si,dx
	retf
DBASE_INIT	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
DBASE_READ - read specific record from the database.
;
; inputs: es = selector from DBASE_INIT
;         dx = record# to read
;
; output: no carry + al = 00 - if successful, cx=read amount
;            carry + al = 04 - record not here, could be no records are present
;            carry + al = 02 - selector bad or database corrupted.
;            carry + al = 07 - record was too big to fit in memory
;            carry + al = 08 - unknown error
;      es:si = ptr to record read (valid only if al=0)
;	  cx = record length including separator character. (present if al=0)
;
;* * * * * * * * * * * * * *

	public	DBASE_READ
DBASE_READ	proc	far
	apush	bx,dx,di,bp,ds
	call	verify1
	jc	drr_exit			;jmp if error type 1 or 2
	mov	al,0				;request search of all buffers
drr_retry_entry:
	call	$is_record_in_buf		;scan buffers
;
; is_record_in_buf returns 0 - got record , cx=size
;                          1 - try reading forward
;                          2 - try reading backwards
	cmp	al,0
	je	drr_got_record	
	test	es:[f_flags],fdirty
	jz	drr_do_disk
	call	$born_again			;write out changes
	jc	drr_exit
	jmp	drr_retry_entry
drr_do_disk:	
	call	$disk_read			;al=1 for forward  al=2 for bak
	jc	drr_exit         		;jmp if file at eof or top
	jmp	drr_retry_entry			;go see if we have read rec
;
; es:[bx] points at index structure for the requested record.
; set es:si pointing to rec data  or cx to length
;
drr_got_record:
	mov	es:[active_index],bx
	mov	si,es:[bx.buf_ptr]	;get ptr to record
	call	$compute_record_length
	mov	al,0
	clc
drr_exit:
	apop	ds,bp,di,dx,bx
	retf
DBASE_READ	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
dbase_read_next - read next sequential record.
;
; inputs:    es = selector from DBASE_INIT
;
; output: no carry or al = 00 - success
;            carry or al = 01 - record not here, could be no records are present
;            carry or al = 02 - selector bad or database corrupted.
;      es:si = ptr to record read (valid only if al=0)
;	  cx = record length including separator character. (present if al=0)
;         dx = record number
;
;* * * * * * * * * * * * * *

	public	dbase_read_next
dbase_read_next proc	far
	apush	bx,di,ds
	call	verify1
	jc	drn_exit			;jmp if error
	mov	bx,es:[active_index]		;get last record accessed
drn_01: mov	dx,es:[bx.rec_no]
	cmp	dx,-1				;check if removed record
	jne	drn_03
;
; the current record has been removed.	scan forward for record
;
	sub	bx,size index_struc
	cmp	bx,es:[index_avail_ptr]		;check if at end of index
	jne	drn_01				; jmp if not at end of index
;
; we have scanned to the end of the index and all records have been removed
; scan back till a vaild record# found
;
	mov	bx,es:[active_index]
drn_02: cmp	bx,offset index
	je	drn_04				;jmp if all records removed
	cmp	es:[bx.rec_no],-1
	jne	drn_03				;jmp if valid rec# found
	sub	bx,size index_struc
	jmp	drn_02

drn_04: mov	dx,es:[f_rec]
	jmp	drn_03

drn_03: inc	dx
	call	dbase_read			;read next record
drn_exit:
	apop	ds,di,bx
	retf
dbase_read_next	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
dbase_read_prev - read previous record. (write operations do not affect)
;
; inputs:     es = selector from DBASE_INIT
;
; output: no carry or al = 00 - success
;            carry or al = 01 - record not here, could be no records are present
;            carry or al = 02 - selector bad or database corrupted.
;      es:si = ptr to record read (valid only if al=0)
;	  cx = record length including separator character. (present if al=0)
;         dx = record number
;
;* * * * * * * * * * * * * *

drp_temp	dw	0

	public	dbase_read_prev
dbase_read_prev proc	far
	apush	bx,di,ds
	call	verify1
	jc	drp_ex
	mov	bx,es:[active_index]
	mov	dx,es:[bx.rec_no]
	cmp	dx,1
	jbe	drp_xx
	cmp	dx,-1
	jne	drp_01			;jmp if normal record
;
; this record has been deleted.
;
drp_00: mov	dx,es:[f_rec]		;get initial rec#
	cmp	bx,offset index		;check if at top of index
	je	drp_01			; jmp if deleted rec at top
	sub	bx,size index_struc
	cmp	bx,offset index
	je	drp_00			;jmp if at top of index
	mov	dx,es:[bx.rec_no]	;get previous rec#
	cmp	dx,-1			;check if removed record
	je	drp_00

drp_01: dec	dx
	call	dbase_read
	jmp	drp_ex
drp_xx:	mov	al,1
drp_ex:	apop	ds,di,bx
	retf
;
dbase_read_prev endp

;----------------------------------------------------------------------------
;------------------------------ dbase write ---------------------------------
;----------------------------------------------------------------------------
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
dbase_append - append this record to end of databse
;
; inputs:     es = selector from DBASE_INIT
;          ds:di = source data buffer
;	      cx = length of record excluding the separator character
;	      
; output:  no carry,  al = 0 (success)
;            carry or al = 02 - selector bad or database corrupted.
;                     dx = record # assigned
;
;* * * * * * * * * * * * * *

	public	dbase_append
dbase_append	proc	far
	apush	bx,cx,bp,si,di,ds,es
	call	verify2
	jc	da_exit				;jmp if error type 1 or 2
da_lp1:	test	es:[f_flags],at_eof
	jnz	da_at_eof			;jmp if at end of file
	mov	bx,es:[index_avail_ptr]
da_lp2:	sub	bx,size index_struc
	mov	dx,es:[bx.file_rec_no]
	inc	dx
	call	dbase_read			;read next block
	jmp	da_lp1
;
; we are at the end of file
;
da_at_eof:
	call	$check_if_room
	jnc	da_append			;jmp if room for this record
	call	$born_again			;assume we need to save mods
	jc	da_exit				;jmp if error
	jmp	da_lp1				;go scan to eof again
;
; append record to end of current block
;
da_append:
	mov	bx,es:[index_avail_ptr]
	call	$build_index_entry		;bx=index ptr  ds:si=data
	mov	es:[bx.file_rec_no],-1		;flag this record as insert
	mov	dx,es:[bx.rec_no]		;get append record#
	mov	es:[active_index],bx		;set new active index
	
	add	bx,size index_struc
	mov	es:[index_avail_ptr],bx		;update available index loc
	mov	al,0
	or	es:[f_flags],fdirty
	clc
da_exit:
	apop	es,ds,di,si,bp,cx,bx
	retf
dbase_append	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
dbase_insert - insert this record before specific record
;
; inputs:      es = selector from DBASE_INIT
;	    ds:di = source data buffer
;	       cx = length of record excluding the separator char if present
;              dx = record number to insert before
;
; output:  no carry,  al = 0 (success)
;            carry or al = 01 - record not here, could be no records are present
;            carry or al = 02 - selector bad or database corrupted.
;                     dx = record number assigned
;          
; Note: Inserts are placed in front of the record number input. 
;* * * * * * * * * * * * * *

	public	dbase_insert
dbase_insert	proc	far
	apush	bx,cx,si,di,bp,ds,es
	call	verify1
	jc	dii_exit
	call	dbase_read			;read the record
	jc	dii_exit
	call	$is_record_in_buf		;get index ptr
	call	$make_index_hole
	mov	si,di				;get buffer ptr -> ds:si
	call	$build_index_entry
	mov	es:[bx.file_rec_no],-1		;flag this record as insert
	call	$resequence
	mov	al,0
	or	es:[f_flags],fdirty
	clc
dii_exit:
	apop	es,ds,bp,di,si,cx,bx
	retf

dbase_insert	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
dbase_replace - replace data for a specific record
;
; inputs:     es = selector from DBASE_INIT
;          ds:di = source data buffer
;	      cx = length of record excluding the separator char if present
;             dx = record number to insert before
;
; output:  no carry,  al = 0 (success)
;            carry or al = 01 - record not here, could be no records are present
;            carry or al = 02 - selector bad or database corrupted.
;
;* * * * * * * * * * * * * *

dr_rec_size	dw	0	;size of replacement record
dr_file_rec	dw	0	;record #

	public	dbase_replace
dbase_replace	proc	far
	apush	bx,cx,dx,si,di,bp,ds,es
	call	verify1
	jc	dr_exit			;jmp if error type 1 or 2
	call	dbase_read		;read the correct record
	jc	dr_exit
	call	$is_record_in_buf		;get index ptr
	mov	si,di			;get buffer ptr -> si
	call	$build_index_entry
	mov	al,0
	or	es:[f_flags],fdirty
	clc
dr_exit:
	apop	es,ds,bp,di,si,dx,cx,bx
	retf

dbase_replace	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
DBASE_REMOVE - delete specific record
;
; inputs:      es = selector from DBASE_INIT
;	       dx = record number to delete
;
; output:  no carry,  al = 0 (success)
;            carry or al = 01 - record not here, could be no records are present
;             
;* * * * * * * * * * * * * *


	public	DBASE_REMOVE
DBASE_REMOVE	proc	far
	apush	bx,cx,dx,si,di
	call	verify1
	jc	ddr_exit
	call	dbase_read		;read the correct record
	jc	ddr_exit		;jmp if record not here
	call	$is_record_in_buf		;get index ptr
	mov	es:[bx.rec_no],-1	;flag this record as removed
	call	$resequence
	or	es:[f_flags],fdirty
	mov	al,0
	clc
ddr_exit:
	apop	di,si,dx,cx,bx
	retf

DBASE_REMOVE	endp
;----------------------------------------------------------------------------
;------------------------------ dbase close ---------------------------------
;----------------------------------------------------------------------------
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
dbase_close - close & write any pending data to file
;
; inputs:      es = database selector returned by DBASE_INIT
; 
; output:  no carry,  al = 0 (success)
;            carry or al = 02 - selector bad or database corrupted.
; 
;* * * * * * * * * * * * * *

dcc_temp_asciiz		db	'DBASE.$$$',0
dcc_temp_handle		dw	0

	public	dbase_close
dbase_close	proc	far
	apush	bx,cx,dx,si,di,bp,ds,es
	call	verify2
	jc	dcc_exit
	test	es:[f_flags],fdirty
	jz	dc_release			;jmp if disk still good
;
; save a copy of the buffers which contain the changes to temp buffers
;
	cld
	push	es
	pop	ds
	mov	si,offset buf
	mov	di,offset temp_buf
	mov	cx,offset index_end
	rep	movsb
;
; open a temp output file
;
	mov	ah,3ch
	mov	cx,0			     ;create for write
	mov	dx,offset dcc_temp_asciiz
	push	cs				;swap ds
	pop	ds				;  and cs
	int	21h
	jc	dcc_err2
	mov	dcc_temp_handle,ax
;
; move to start of database file
;
dc_lp1:	test	es:[f_flags],at_top
	jnz	dc_merge		;jmp if file at top
	mov	al,2
	call	$disk_read
	jnc	dc_lp1			;loop till top of file reached.
	cmp	al,4			;check if eof or disk error
	jne	dcc_err			;jmp if not possible eof
;
; merge database file and temp buffers -> temp file
;
dc_merge:
	call	$merge_and_write
;
; delete the database file, and rename the temp file to database file
;
	mov	ah,3eh
	mov	bx,dcc_temp_handle
	int	21h
	jc	dcc_err2

	mov	ah,3eh
	mov	bx,es:[f_handle]
	int	21h
	jc	dcc_err2
;
; delete the origional dbase file
;
	mov	ah,41h
	push	es
	pop	ds
	mov	dx,offset f_asciiz
	int	21h
	jc	dcc_err2
;
; rename the temp file to origional dbase name
;
	push	cs
	pop	ds
	mov	ah,56h			;rename
	mov	dx,offset dcc_temp_asciiz ;existing name
	mov	di,offset f_asciiz
	int	21h
	jc	dcc_err2
;
;  release memory
;
dc_release:
	call	dos_mem_release
	mov	al,0			;preload success code
	jnc	dcc_exit
	mov	al,8			;unknown error
	jmp	dcc_err

dcc_err2:
	mov	al,4			;disk error	
dcc_err:stc	
dcc_exit:
	apop	es,ds,bp,di,si,dx,cx,bx
	retf

dbase_close	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(DATABASE )
DBASE_KILL - delete dbase file
;
; inputs:       ds:dx = asciiz file name ptr
; 
; output:	carry set if error, error code from DOS function 41h
;* * * * * * * * * * * * * *

	public	DBASE_KILL
DBASE_KILL	proc	far
	mov	ah,41h
	int	21h
	retf
DBASE_KILL	endp
;-----------------------------------------------------------------------------
;------------------------------ local subroutines ----------------------------
;-----------------------------------------------------------------------------
; $disk_read - read block of data from the disk and create the index
;   inputs:  al = 1 - read next forward block
;                 2 - read back towards front of file
;   output:  no carry = success
;               carry & AL = 07 (record found exceeding buffer size)
;               carry & AL = 04 (disk read/write error or file at eof/top)
;               carry & AL = 08 (parameter error or unknown error)
;
;   processing: 1. update database of seek & record# depending upon direction
;               2. check if operation possible
;               3. read block, compute next block seek from seek_adjust,
;                  active_block_size
;               4. build index if valid read, check record_count
;               5. set f_flags to correct state
;
dr_input	db	0
               
$disk_read:
	apush	ax,bx,cx,dx,si,di,ds
	mov	cs:dr_input,al
	cmp	al,1
	je	dr_forward
	cmp	al,2
	je	dr_back
	mov	al,8
	jmp	dr_err

dr_forward:
	test	es:[f_flags],at_eof
	jnz	dr_eof				;jmp if at eof already
	and	es:[f_flags],not at_top		;clear at_top flag

	mov	dx,word ptr es:f_seek_fwd	;setup seek low word
	mov	cx,word ptr es:f_seek_fwd+2	;setup seek high word
	mov	ax,word ptr es:[f_rec_fwd]	;get record#
	jmp	do_seek
	
dr_back:
	test	es:[f_flags],at_top
	jnz	dr_err1 			;jmp if at top already
	and	es:[f_flags],not at_eof		;clear eof flag
	
	mov	dx,word ptr es:f_seek_bak	;setup seek low word
	mov	cx,word ptr es:f_seek_bak+2	;setup seek high word
	mov	ax,es:[f_rec_bak]		;get record#

do_seek:
	mov	word ptr es:[f_seek],dx
	mov	word ptr es:[f_seek+2],cx
	cmp	ax,0			;check if record #1
	jne	do_seek2		;jmp if valid rec#
	mov	ax,1
do_seek2:
	mov	es:[f_rec],ax		;save record#		
	mov	ah,42h			;DOS seek code
	mov	al,00h			;seek relative to file start
	mov	bx,es:[f_handle]	 ;file handle
	int	21h			;
	jc	dr_err1			;jmp if seek error
;
; the file pointer has been positioned, now read block
;
	mov	ah,3fh			;DOS read code
	mov	cx,buf_size/2		;get size of read
	mov	dx,offset buf		;get buffer offset
	push	ds			;save ds
	push	es			;set ds to
	pop	ds			;  buffer segment
	int	21h			;returns ax=number of bytes read
	pop	ds
	jc	dr_err1			;jmp if read error
	cmp	ax,0
	je	dr_eof			;jmp if nothing read (EOF)
	cmp	ax,buf_size/2
	je	dr_build_index
	or	es:[f_flags],at_eof	;set eof flag
;
; the data has been read into the buffer, now build index, ax=amount read
;
dr_build_index:
	mov	dx,es:[f_rec]		;get starting index#
	call	$build_index
	jc	dr_err			;jmp if record exceeds buffer size
;;	cmp	es:[active_block_size],0
;;	je	dr_eof2			;jmp if no data read
	cmp	es:[record_count],0
	jne	dr_compute_seeks
	or	es:[f_flags],at_eof
dr_compute_seeks:
	cmp	es:[index.rec_no],1	;check if at top
	je	compute_fwd		;jmp if next must be forward read
	cmp	cs:dr_input,1
	jne	compute_bak
;
; compute setting for f_rec_fwd, f_seek_fwd
;	
compute_fwd:
	mov	ax,es:[f_rec]
	add	ax,es:[record_count]
	mov	es:[f_rec_fwd],ax

	mov	ax,word ptr es:[f_seek]
	mov	bx,word ptr es:[f_seek+2]
	add	ax,es:active_block_size
	adc	bx,0
	mov	word ptr es:[f_seek_fwd],ax
	mov	word ptr es:[f_seek_fwd+2],bx

	mov	word ptr es:[f_seek_bak],0
	mov	word ptr es:[f_seek_bak+2],0
	mov	es:[f_rec_bak],1
	
	clc
	jmp	dr_quit
;
; compute setting for f_rec_bak, f_seek_bak
;
compute_bak:
	mov	es:f_rec_bak,1
	mov	word ptr es:[f_seek_bak],0
	mov	word ptr es:[f_seek_bak+2],0

	mov	es:f_rec_fwd,1
	mov	word ptr es:[f_seek_fwd],0
	mov	word ptr es:[f_seek_fwd+2],0
	
	clc
	jmp	dr_quit
	
dr_eof: cmp	es:[index.rec_no],1
	ja	dr_eof2				;jmp if not at top
	or	es:[f_flags],at_top
dr_eof2:or	es:[f_flags],at_eof

dr_err1:mov	al,4				;disk read/write error
dr_err:	stc					;error code in AL here
	jmp	dr_quit2
dr_quit:
	cmp	es:[index.rec_no],1
	ja	dr_quit2
	or	es:[f_flags],at_top
dr_quit2:	
	apop	ds,di,si,dx,cx,bx,ax
	ret
;-----------------------------------------------------------------------------
; $is_record_in_buf - check if record in memory
;   inputs:  dx = record number
;   output:  al =          0 - got record
;                              bx=record index ptr
;                              cx=size
;                          1 - try reading forward
;                          2 - try reading backwards
;
$is_record_in_buf:
	apush	dx,si
	cmp	dx,es:[f_rec]
	jb	irib_back
	mov	bx,es:[index_avail_ptr]
irib_x: sub	bx,size index_struc
	cmp	es:[bx.rec_no],-1		;check if deleted record
	je	irib_x
	cmp	dx,es:[bx.rec_no]
	ja	irib_forward
;
; record # falls somewhere in the block in memory.  scan for location
;	
	mov	bx,offset index - size index_struc
irib_lp:add	bx,size index_struc
	cmp	dx,es:[bx.rec_no]
	jne	irib_lp			;loop till record found

	mov	si,es:[bx.buf_ptr]
	call	$compute_record_length
	mov	al,0
	jmp	irib_exit
irib_forward:
	mov	al,1
	jmp	irib_exit	
irib_back:
	mov	al,2
irib_exit:
	apop	si,dx
	ret
;-----------------------------------------------------------------------------
;$build_index - build index for data in buf
; inputs: ax = amount of data in buffer
;         dx = starting record/sequience number
;
; output: no carry - index built ok
;            carry - al = 7 record too big

$build_index:
	apush	ax,bx,cx,dx,si,di
;
; the data has been read into the buffer, now build index,
;
bi_build_index:
	mov	es:record_count,-1
	mov	di,offset buf           		;get buffer offset
	mov	si,offset index          		;get index top
	mov	cx,ax					;get buffer length
;
; This file uses variable length records, registers are set as follows:
;  es:di = buffer ptr	es:si = index ptr  cx=buf len  dx=starting rec#
;
	mov	al,0             		;get record separator
	sub	si,size index_struc		;loop modification
	dec	dx				;loop modification for rec#
bi_var_lp:
	inc	es:record_count
	add	si,size index_struc		;move to next index
	inc	dx				;move to next rec#
	cmp	si,index_end
	jae	bi_var_zero_end			;jmp if end of index buffer
	mov	es:[si.file_rec_no],dx		;store rec#
	mov	es:[si.rec_no],dx
	mov	es:[si.buf_ptr],di		;store buffer ptr
	jcxz	bi_var_zero_end			;jmp if at end of disk data
	repne	scasb				;scan for next record separator
	je	bi_var_lp			;jmp if separator found
;
; the end of the buffer was reached
;
bi_var_zero_end:
	cmp	es:[record_count],0
	je	bi_err				;jmp if record too big
	mov	es:[si.file_rec_no],0		;mark index end
	mov	es:[si.rec_no],0
	mov	es:[index_avail_ptr],si

	mov	di,es:[si.buf_ptr]
	mov	es:[buf_avail_ptr],di		;set ptr past last valid rec
	mov	es:[active_block_size],di	;save size of this block
	mov	es:[si.buf_ptr],0		;zero residual buf_ptr
	clc
	jmp	bi_exit

bi_err:	mov	al,7				;set record too big error
	stc
	jmp	bi_exit
	
bi_eof:	clc
	or	es:[f_flags],at_eof	;set eof flag
bi_exit:
	apop	di,si,dx,cx,bx,ax
	ret

;------------------------------------------------------------------------
; $build_index_entry - create index entry
;  inputs:  bx = pointer to index destination
;          ds:si = data ptr
;  output:  none
;  processing:  1. construct the index entry
;               2. move the data to database buffer
;
$build_index_entry:
	apush	ax,cx,si,di,ds
	cmp	bx,offset index
	jne	bie_cont2		;jmp if not first index
	test	es:[f_flags],at_top
	jz	bie_cont1		;jmp if not index #1
	mov	ax,1
	jmp	bie_cont3
bie_cont1:
	mov	ax,es:f_rec
	jmp	bie_cont3
bie_cont2:			
	mov	ax,es:[bx.rec_no-size index_struc]	;get previous rec #
	inc	ax
bie_cont3:
	mov	es:[bx.rec_no],ax			;store rec#
	
	mov	di,es:buf_avail_ptr
	mov	es:[bx.buf_ptr],di			;store buf ptr

	call	strlen1
	cld
	rep	movsb					;move data to buffer
	movsb						;move zero at end
	mov	es:[buf_avail_ptr],di
	apop	ds,di,si,cx,ax
	ret
;------------------------------------------------------------------------
;$make_index_hole - create space for new entry in mod indx
; inputs: es:bx points at mod index index to make hole in front of
;
$make_index_hole:
	apush	cx,si,di,ds
	mov	di,offset index_end-1
	mov	si,di
	sub	si,size index_struc
	mov	cx,si
	sub	cx,bx
	inc	cx
	jcxz	maih_1		;jmp if at end
	std
	push	es
	pop	ds
	rep	movsb
	cld
maih_1:
	add	es:[index_avail_ptr],size index_struc
	apop	ds,di,si,cx
	ret
	
;----------------------------------------------------------------------------
;$compute_record_length - compute size of modification record
; inputs:    es:si = pointer to modification record
; output:    cx = record size including separator character if present
;
$compute_record_length:
	push	ax
	push	di
	mov	al,0             
	mov	di,si
	mov	cx,-1
	repne	scasb
	not	cx
	pop	di
cars_exit:
	pop	ax
	ret

;----------------------------------------------------------------------------
; $check_if_room - check if room for another operation
;   inputs:  cx = size of this record
;   output:  carry = no room
;
$check_if_room:
	mov	ax,es:[buf_avail_ptr]
	add	ax,cx
	cmp	ax,offset buf_end
	ja	cir_nope
	mov	ax,es:[index_avail_ptr]
	cmp	ax,offset index_end -4
	ja	cir_nope
	clc
	jmp	cir_exit
cir_nope:
	stc
cir_exit:
	ret
;----------------------------------------------------------------------------
; $born_again - close the database and reopen with a fresh copy
;   inputs:  dx = active record
;   outputs: no carry = success
;		carry = error, AL set to 1 (no records present)
;            registers  ax,bx,cx,si,di modified
;
xasciiz		db	40 dup (0)
target_record	dw	0		;record location to restore

$born_again:
	mov	cs:target_record,dx
	push	es
	call	dbase_close
	jc	ba_exit
	pop	es
;
; move a copy of the database file name locally
;
	push	es
	pop	ds
	mov	si,offset f_asciiz
	push	cs
	pop	es
	mov	di,offset xasciiz
	mov	cx,40
	rep	movsb
;
; setup parameters for dbase_init
;
	mov	dx,offset xasciiz
	push	cs
	pop	ds
	call	dbase_init
	jc	ba_exit			;jmp if error
	mov	es,bx			;setup the selector

ba_loop:mov	dx,cs:target_record
	call	$is_record_in_buf
	cmp	al,0
	je	ba_got_it
	call	$disk_read		;go and look in next block
	jnc	ba_loop
	cmp	dx,1			;check if null database
	je	ba_got_it
;
; we could not find this record
;
	cmp	es:[record_count],0	;check if null database
	je	ba_null
;
; the last record of a database was deleted, so use the previous record.
;
	mov	bx,es:[index_avail_ptr]
	sub	bx,size index_struc
	jmp	ba_got_it

ba_null:
	mov	al,8
	stc
	jmp	ba_exit
		
ba_got_it:
	mov	es:[active_index],bx	
	clc
ba_exit:	
	ret
;-----------------------------------------------------------------------------
; $resequence - resequence the sequence numbers from current record
;   inputs:  bx = current index ptr
;            dx = sequence # for this record
;   output: none
;
$resequence:
	apush	bx,dx
res_lp:	cmp	es:[bx.rec_no],0
	je	res_done		;jmp if end of index found
	cmp	es:[bx.rec_no],-1
	je	res_c			;jmp if removed (deleted) record
	mov	es:[bx.rec_no],dx
	inc	dx
res_c:	add	bx,size index_struc
	jmp	res_lp
res_done:
	apop	dx,bx
	ret
;-----------------------------------------------------------------------------
; $merge_and_write - merge file data with modifications in memory
;   inputs:  - file is at top
;            - index built
;            - temp_buf & temp_index have modificaton data
;            - output file open & handle at dcc_temp_handle
;
;  output:  no carry = success
;              carry = error
;
; processing:  1. write from file until disk rec# reaches first temp file rec#
;              2. write temp data until exhausted
;              3. read input file until it reaches last temp file rec#
;              4. write remaining file data

$merge_and_write:
	mov	bx,offset temp_index
	test	es:[f_flags],created
	jnz	maw_write_temp		;jmp if file is empty
;
; find first temp file rec#
;
maw_lp1:cmp	es:[bx.file_rec_no],1	;check if temp file at start
	je	maw_write_temp
;
; the modification data is not first block of file, copy file data until
; modification block area reached.
;
maw_copy_file:
	mov	bx,offset temp_index-size index_struc ;get first mod block rec#
maw_lpx:add	bx,size index_struc
	mov	ax,es:[bx.file_rec_no]
	cmp	ax,-1
	je	maw_lpx
	
maw_lp2:mov	bx,offset index
maw_lp3:call	write_file_record
	jc	maw_done			;jmp if error
	add	bx,size index_struc
	cmp	ax,es:[bx.file_rec_no]
	je	maw_write_temp		;jmp if start of modification data fnd
	cmp	es:[bx.rec_no],0	;check if end of file block
	jne	maw_lp3			;jmp if more data to copy
	push	ax
	mov	al,1
	call	$disk_read
	pop	ax
	jc	maw_write_temp		;jmp if eof
	mov	bx,offset index		;restart the index
	cmp	ax,es:[bx.file_rec_no]
	jne	maw_lp3			;loop till modify block reached
;
; copy data from temp_file to disk
;
maw_write_temp:
	mov	bx,offset temp_index - size index_struc
maw_lp4:add	bx,size index_struc
	cmp	es:[bx.rec_no],0
	je	maw_t1			;jmp if end of temp index
	cmp	es:[bx.rec_no],-1
	je	maw_lp4			;jmp if removed record (deleted)
	call	write_file_record
	jc	maw_done		;jmp if error
	jmp	maw_lp4
;
; write data following modification block
;
maw_t1:	mov	ax,es:[bx.file_rec_no - size index_struc]	;find
	inc	ax						; next file rec
	
maw_t2:	mov	bx,offset index				
maw_lp6:cmp	es:[bx.file_rec_no],ax
	je	maw_write_tail
	cmp	es:[bx.rec_no],0
	je	maw_get_more
	add	bx,size index_struc
	jmp	maw_lp6				
maw_get_more:
	push	ax
	mov	al,1
	call	$disk_read
	pop	ax
	jnc	maw_t2
	jmp	maw_done		;jmp if input file at eof
;
; copy data remaining
;
maw_write_tail:	
maw_lp7:cmp	es:[bx.file_rec_no],0
	je	maw_more_ck		;jmp if out of data in memory
	call	write_file_record
	jc	maw_done		;jmp if error
	add	bx,size index_struc
	jmp	maw_lp7			;jmp if more data to copy
maw_more_ck:
	push	ax
	mov	al,1
	call	$disk_read
	pop	ax
	jc	maw_success	;jmp if eof
	mov	bx,offset index
	jmp	maw_lp7
maw_success:
	clc	
maw_done:
	ret
;-----------------------------------------------------------------------------
; write_file_record - copy data from index file to output file
;  input:  es:bx = pointer to index for input data
;  output:  carry set if error
;
write_file_record:
	apush	ax,bx,cx,dx
	push	es
	pop	ds
	mov	si,es:[bx.buf_ptr]
	call	$compute_record_length
	mov	dx,si
	mov	bx,cs:dcc_temp_handle
	mov	ah,40h
	int	21h
	apop	dx,cx,bx,ax
	ret
;-----------------------------------------------------------------------------
; verify1 - check if database valid and has data in it
;  inputs:    es: setup
;  outputs:   no carry - al = 0 (success)
;                carry - al = 1 database empty
;                carry - al = 2 selector bad or database corrupted
;           registers bx,cx modified
;
verify1:test	es:[f_flags],at_top
	jz	verify2			;jmp if database has data
	test	es:[f_flags],at_eof
	jz	verify2			;jmp if database has data
	mov	cx,0			;record count
	mov	bx,offset index - size index_struc
v_lp:	add	bx,size index_struc
	cmp	es:[bx.rec_no],0
	je	v_check			;jmp if end of index
	cmp	es:[bx.rec_no],-1
	je	v_lp			;jmp if removed record
	inc	cx
	jmp	v_lp
v_check:jcxz	verify_bad1		;jmp if no records found
verify2:cmp     es:[f_key],'JO'
	mov	al,2			;preload error code for bad ES:
	jne	verify_bad
	clc
	mov	al,0
	jmp	verify_end
verify_bad1:
	mov	al,1			;signal database empty	
verify_bad:
	stc
verify_end:
	ret		
	
;-----------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
