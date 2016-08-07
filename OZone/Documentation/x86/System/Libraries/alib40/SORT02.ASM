;***************************** SORT02.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc

	extrn	dos_mem_allocate:far
	extrn	dos_mem_release:far
	
	extrn	order_buffer:near
	extrn	make_index:near
	extrn	DiskWrite_open:far
	extrn	DiskWrite_buffer:far
	extrn	DiskWrite_close:far
	
	extrn	sort_engine:word
	extrn	sort_field_len:word
	extrn	sort_column:word
	extrn	last_sort_column:word
	extrn	buffer_off:word
	extrn	fixed_record_len:word
	extrn	rec_term_char:byte
	extrn	prime_asciiz_off:word
	extrn	prime_asciiz_seg:word
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
; file sort, read file into buffers and sort them.
;            use merge sort to combine files.
;
;  inputs:  es:di = pointer to buffer, or asciiz if file
;              cx = buffer length, or zero if file
;              bx = record length if fixed length, else zero if variable len.
;              al = record terminator for variable lenght records. else zero
;
;   output:   carry set if insufficient memory, or disk error
;
;* * * * * * * * * * * * * *


buffer_size	equ	4000h		

prime_handle	dw	0
prime_seg	dw	0
last_prime_read	dw	0		;size of last prime read
prime_index_seg	dw	0

temp1_asciiz	db	'temp1.$$$',0
temp1_handle	dw	0
temp1_seg	dw	0
last_temp1_read	dw	0
temp1_index_seg	dw	0

temp2_asciiz	db	'temp2.$$$',0
 temp2_handle	dw	0

	public	file_sort
file_sort	proc	near
	mov	cs:prime_Asciiz_seg,es
	mov	cs:prime_Asciiz_off,di	
;
; compute last_sort_column
;
	mov	dx,cs:sort_column
	mov	cs:last_sort_column,dx
	mov	dx,cs:sort_field_len
	add	cs:last_sort_column,dx
	
	mov	dx,di			;get asciiz ptr
	push	es
	pop	ds			;get asciiz seg
	mov	ax,3d00h		;open file for read-only
	int	21h			;ax = handle if no carry
	mov	cs:prime_handle,ax
;
; allocate memory for prime buffer
;
	mov	dx,0
	mov	ax,buffer_size		;allocate 32k
	call	dos_mem_allocate
	jc	fs_err			;jmp if insifficient memory
	mov	cs:prime_seg,es		;save buffer
;
; allocate memory to form new prime index
;
	mov	dx,0
	mov	ax,buffer_size		;allocate 32k
	call	dos_mem_allocate
	jc	fs_err			;jmp if insifficient memory
	mov	cs:prime_index_seg,es	;save prime index buf
;
; allocate memory for temp1 buffer
;
	mov	dx,0
	mov	ax,buffer_size		;allocate 32k
	call	dos_mem_allocate
	jc	fs_err			;jmp if insifficient memory
	mov	cs:temp1_seg,es		;save buffer
;
; allocate memory for temp1 index
;
	mov	dx,0
	mov	ax,buffer_size		;allocate 32k
	call	dos_mem_allocate
	jc	fs_err			;jmp if insifficient memory
	mov	cs:temp1_index_seg,es	;save buffer
;
; read and sort prime
;
	mov	di,cs:prime_index_seg	;get index seg
	mov	ds,cs:prime_seg
	mov	bx,cs:prime_handle
	call	read_and_sort
	mov	cs:last_prime_read,bx
;
; order data in buffer
;
	mov	ds,cs:prime_seg
	mov	si,0
	mov	dx,cs:prime_index_seg
	call	order_buffer
;
; write prime data to temp1
;
	mov	ah,3ch			;file create
	push	cs
	pop	ds
	mov	dx,offset temp1_asciiz
	mov	cx,0			;normal read/write file
	int	21h
	jc	bad_file
	mov	cs:temp1_handle,ax

	mov	bx,cs:temp1_handle
	mov	ah,40h
	mov	cx,cs:last_prime_read
	mov	dx,0			;offset buffer
	mov	ds,cs:prime_seg	
	int	21h
	jc	bad_file
;
; read and sort next prime block 
;
rf_loop:
;
; read and sort prime
;
	mov	di,cs:prime_index_seg		;get index seg
	mov	ds,cs:prime_seg
	mov	bx,cs:prime_handle
	call	read_and_sort
	mov	cs:last_prime_read,bx
	cmp	bx,0
	je	fs_tail				;jmp if prime exhausted
;
; merge sorted buffer & temp1 -> temp2
;
; rewind temp1 file
;
	mov	bx,cs:temp1_handle	;rewind
	mov	cx,0			;  temp1
	mov	dx,0
	mov	ax,4200h		;file seek relative to start
	int	21h
;
; create temp2 file
;
	push	cs
	pop	ds
	mov	dx,offset temp2_asciiz
	call	DiskWrite_open
	jc	bad_file
;
; merge prime + temp1 -> temp2
;
	mov	bp,0			;prime index ptr setup
;
; read and sort temp1
;
read_temp1:
	mov	di,cs:temp1_index_seg		;get index seg
	mov	ds,cs:temp1_seg
	mov	bx,cs:temp1_handle
	call	read_and_sort
	mov	cs:last_temp1_read,bx
	
	mov	bx,0			;temp1 index ptr setup
	
merge_lp:	
	mov	ds,cs:prime_index_seg
	mov	si,word ptr ds:[bp]	;get prime buffer ptr
	mov	cx,word ptr ds:[bp+2]	;get record length
	mov	ds,cs:prime_seg

	mov	es,cs:temp1_index_seg
	mov	di,word ptr es:[bx]	;get temp1 buffer ptr
	mov	ax,word ptr es:[bx+2]	;get record length
	mov	es,cs:temp1_seg

	cmp	cs:last_temp1_read,0
	jne	fs_2			;jmp if temp1 not = eof
	cmp	si,-1
	jne	write_prime		;jmp if prime has data
	jmp	merge_done
;
; temp1 = eof  prime has data	
;
;fs_1:	cmp	di,-1
;	jne	write_temp1		;jmp if temp1 has data
;	jmp	merge_done
;
; temp1 not at eof
;
fs_2:	cmp	di,-1
	je	read_temp1		;jmp if at end of temp1 index
;
; temp1 has data
;
	cmp	si,-1
	je	write_temp1		;jmp if prime index at end
;
; both prime & temp1 index's have data
;
     	cmp	cx,cs:last_sort_column	;check if truncated prime
	jb	write_prime		;jmp if prime record truncated

	cmp	ax,cs:last_sort_column
	jb	write_temp1		;jmp if temp1 record truncated
	
	add	si,cs:sort_column
	add	di,cs:sort_column

	apush	cx,si,di
	mov	cx,cs:sort_field_len
	rep	cmpsb			;compare prime & temp1
	apop	di,si,cx
	jae	write_temp1
;
; cx=record len, ds=buffer seg   si=buffer offset
;
write_prime:
	mov	dx,si
	add	bp,4			;move index fwd
	jmp	do_write
;
; ax=record len  es=buffer seg  di=buffer offset
;	
write_temp1:
	mov	dx,di
	mov	cx,ax
	push	es
	pop	ds
	add	bx,4			;move index fwd
;
do_write:
	call	DiskWrite_buffer	;write temp2
	jmp	merge_lp		
		
merge_done:	
;
; delete temp1 and rename temp2 -> temp1
;
	mov	bx,cs:temp1_handle
	mov	ah,3eh			;close file
	int	21h
	
	mov	dx,offset temp1_asciiz
	push	cs
	pop	ds
	mov	ah,41h
	int	21h			;delete temp1

	call	DiskWrite_close		;close temp2
;
; rename temp2 -> temp1
;
	mov	dx,offset temp2_asciiz
	mov	di,offset temp1_asciiz
	push	ds
	pop	es
	mov	ah,56h
	int	21h
;
; re-open temp1
;
	mov	ah,3dh			;file create
	push	cs
	pop	ds
	mov	dx,offset temp1_asciiz
	mov	al,2			;normal read/write file
	int	21h
	jc	bad_file
	mov	cs:temp1_handle,ax
	
	jmp	rf_loop
;
; no more prime data.  delete prime.  rename temp1 -> prime
;
fs_tail:
	mov	bx,cs:prime_handle
	mov	ah,3eh
	int	21h			;close prime
	
	lds	dx,dword ptr cs:prime_Asciiz_off
	mov	ah,41h
	int	21h			;delete prime

	mov	bx,cs:temp1_handle
	mov	ah,3eh
	int	21h			;close temp1.$$$
	
	mov	dx,offset temp1_asciiz
	push	cs
	pop	ds
	les	di,dword ptr cs:prime_Asciiz_off
	mov	ah,56h
	int	21h
	clc
	jmp	fs_exit

bad_file:
fs_err:
fs_exit:pushf
	cmp	cs:prime_seg,0
	je	fs_exit2		;jmp if not allocated
	mov	es,cs:prime_seg
	call	dos_mem_release
	mov	cs:prime_seg,0
fs_exit2:
	cmp	cs:prime_index_seg,0
	je	fs_exit3
	mov	es,cs:prime_index_seg
	call	dos_mem_release
	mov	cs:prime_index_seg,0
fs_exit3:
	cmp	cs:temp1_seg,0
	je	fs_exit4
	mov	es,cs:temp1_seg
	call	dos_mem_release
	mov	cs:temp1_seg,0
fs_exit4:
	cmp	cs:temp1_index_seg,0
	je	fs_exit5
	mov	es,cs:temp1_index_seg
	call	dos_mem_release
	mov	cs:temp1_index_seg,0
fs_exit5:
	popf			
	ret
file_sort	endp	 
;----------------------------------------------------------------------
; read_and_index - read file and index data
;  inputs:  ds:0 = buffer seg
;             bx = file handle
;             di = index seg
;  output: bx = amount of data read
;
last_read	dw	0
handle		dw	0
buffer_segment	dw	0

read_and_sort:
	apush	ax,cx,dx,si,bp,es
	mov	cs:handle,bx
	mov	cs:buffer_segment,ds
	
	mov	cx,buffer_size
	mov	dx,0
	mov	ah,3fh
	int	21h			;read data
	mov	cs:last_read,ax		;save amount of data read
	test	ax,ax
	jz	ras_exit		;exit if at eof
;
; build index
;
	mov	ds,di			;get index_seg
	mov	di,0               	;index buf offset
	mov	cx,ax                	;get size of last read
	mov	bx,cs:fixed_record_len
	mov	al,cs:rec_term_char
	mov	es,cs:buffer_segment
	call	make_index		;make index
;
; if partial record at end, seek back in file
;
	cmp	cs:last_read,buffer_size
	jne	skip_adjust1		;jmp if at eof
	jcxz	skip_adjust1		;jmp if no partial record at end

	sub	cs:last_read,cx	
	mov	bx,cs:handle		;seek back
	mov	dx,0
	xchg	dx,cx			;cx,dx = seek rel
;
; convert move to (negative) move back in file
;
       	not	cx
	neg	dx
	sbb	cx,-1
	
	mov	ax,4201h		;file seek relative to current loc
	int	21h
skip_adjust1:
;
; sort the index
;
	mov	cx,cs:sort_field_len
	mov	dx,cs:sort_column
	mov	si,0			;buffer offset
	call	sort_engine
ras_exit:	
	mov	bx,cs:last_read
	apop	es,bp,si,dx,cx,ax
	ret

LIBSEG	ENDS
;;	end
