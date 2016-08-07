;***************************** SORT03.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	 dos_mem_allocate:far
	extrn	 dos_mem_release:far
.list

	public	sort_engine
sort_engine	dw	0		;ptr to sort kernel

	public	prime_name_ptr,prime_asciiz_off,prime_asciiz_seg
prime_name_ptr	label	dword
prime_asciiz_off	dw	0
prime_asciiz_seg	dw	0

	public	buffer,buffer_off,buffer_seg
buffer	label	dword
buffer_off	dw	0	;offset
buffer_seg	dw	0	;seg

	public	buffer_len
buffer_len	dw	0	;callers sort buffer len

	public	fixed_record_len
fixed_record_len dw	0	;if non-zero then, fixed record length

	public	rec_term_char
rec_term_char	db	0	;callers terminatior for variable record len

	public	sort_field_len
sort_field_len dw	0	;word  value of above

	public	sort_column,last_sort_column
sort_column	dw	0	;index to sort field
last_sort_column dw	0	;last column of sort field

	public	index_length
index_length	dw	0	;length of index	


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
; make_index - make index for sort routines
;  inputs:  es:di = pointer to buffer
;              cx = buffer length
;              bx = record length if fixed length, else zero if variable len.
;              al = record terminator for variable lenght records. else zero
;           ds:0  = ptr to buffer for index creation
;
;  Output:  ds:0  - ptr to index struc. <word buf_ptr>, <word record_length>
;                   Last entry contains -1 to indicate end of index.
;              di - ptr to partial record at end of buffer if -cx- non zero
;* * * * * * * * * * * * * *

	public	make_index              
make_index:
	push	bp
	mov	bp,0
	cld
	cmp	bx,0
	je	variable_records
;
; records are fixed length, bx=length
;
fixed_loop:
	cmp	cx,bx
	jb	buf_end			;jmp if incomplete record left
	
	mov	ds:[bp],di		;put ptr in index
	mov	ds:[bp+2],bx		;put length in index
	sub	cx,bx
	add	di,bx			;move to next record
	add	bp,4			;move to next index
	jmp	fixed_loop
buf_end:
	mov	word ptr ds:[bp],-1	;terminate index
	jmp	mi_exit
;
; records are variable length, -al- has record terminator char.
;  inputs:  es:di = pointer to buffer
;              cx = buffer length
;              bx = record length if fixed length, else zero if variable len.
;              al = record terminator for variable lenght records. else zero
;           ds:bp = ptr to buffer for index creation
;
variable_records:
	mov	bx,di		;save search start
	mov	si,cx
	repne	scasb
	jne	buf_end2	;jmp if partial record at end
	mov	ds:[bp],bx		;put ptr in index
	sub	si,cx
	mov	ds:[bp+2],si		;put length in index
	add	bp,4			;move to next index
	jcxz	buf_end3
	jmp	variable_records
		
	
buf_end2:
	mov	di,bx		;restore start ptr to partial record at end
	mov	cx,si		;restore lenght of partial record
buf_end3:
	mov	word ptr ds:[bp],-1	;terminate index
mi_exit:
	mov	cs:index_length,bp
	pop	bp
	ret

;-------------------------------------------------------------------------
; order_buffer - arrange records in index order
;  inputs: ds:si = buffer seg
;          dx = index seg
; 
;  output: carry set if insufficient memory
;
buf_in		label	dword
buf_off_in	dw	0
buf_seg_in	dw	0
index_seg_in	dw	0
temp_seg	dw	0

	public	order_buffer
order_buffer:
	mov	cs:buf_off_in,si
	mov	cs:buf_seg_in,ds
	mov	cs:index_seg_in,dx
		
	mov	dx,0
	mov	ax,0f000h		;allocate 61k bytes for work buffer
	call	dos_mem_allocate	;retruns es: = memory seg
	jc	no_memory3		;jmp if error
	mov	cs:temp_seg,es		;save index

	mov	bx,0			;index buffer ptr
	mov	di,0			;store ptr
	cld
;
; move data to temp buffer using index to select records.	
;
rec_move_lp:
	mov	ds,cs:index_seg_in
	mov	si,word ptr ds:[bx]	;get record ptr
	cmp	si,-1
	je	rec_move_done		;jmp if end of index
	mov	cx,word ptr ds:[bx+2]	;get record length
	mov	ds,cs:buf_seg_in
	rep	movsb			;move one record
	add	bx,4			;move to next index
	jmp	rec_move_lp	
;
; now move data from temp buffer back into the origional buffer
;
rec_move_done:
	mov	cx,di			;length of move from -di-
	les	di,cs:buf_in
	mov	ds,cs:temp_seg
	mov	si,0
	rep	movsb
		
	mov	es,cs:temp_seg
	call	dos_mem_release
	clc
no_memory3:	
	ret

LIBSEG	ENDS
;;	end
