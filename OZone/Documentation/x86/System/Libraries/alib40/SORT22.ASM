;***************************** SORT22.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn    index_length:word
	extrn	sort_column:word
	extrn	sort_field_len:word
	extrn	last_sort_column:word
	extrn	dos_mem_allocate:far
	extrn	dos_mem_release:far
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
; merge_sort - sort indexed buffer. 
;  inputs:  ds:0 - ptr to index struc. <word buf_ptr>, <word record_length>
;           es:   - buffer seg,(index has offsets)
;              cx - length of sort field
;           cs:sort_column - starting column of sort field
;
;  Output:  index structure is sorted in decending order
;
;  Notes:   The index must have at least one entry.
;           Short or empty records are placed at top of index without
;           attempting to sort.
;
;****************************


data_buffer_seg		dw	0	;contains data to be sorted
work_seg		dw	0	;temp index sort area

delta			dw	0

	public	merge_sort              
merge_sort	proc	near
	cld
	cmp	cs:index_length,4
	jbe	sort_exit
	mov	cs:data_buffer_seg,es
	mov	dx,cs:sort_column
	add	dx,cx
	mov	cs:last_sort_column,dx
;
; allocate work area to sort index
;
	mov	dx,0
	mov	ax,cs:index_length
	call	dos_mem_allocate
	mov	cs:work_seg,es
	
	mov	cs:delta,4

lp1:	mov	ax,cs:delta
	cmp	ax,cs:index_length
	jae	ms_done			;jmp if done

	mov	cs:move_ptr,0		;temp index ptr for 'merge' routine

	mov	bx,0			;set bx at top of buffer
	mov	bp,cs:delta
lp2:	cmp	bx,cs:index_length
	jae	ms_4			;jmp if lp2 done
	call	merge
	add	bx,cs:delta
	add	bp,cs:delta
	jmp	lp2
;
; move the temp index back to origional
;	
ms_4:	shl	cs:delta,1		;delta * 2
	mov	cx,cs:index_length	;get length of move
	shr	cx,1			;length
	mov	di,0			;destination
	mov	si,0			;source
	push	ds
	pop	es
	mov	ds,cs:work_seg
	rep	movsw			;move work index -> origional index
	push	es
	pop	ds			;restore origional index seg
	jmp	lp1

ms_done:
	mov	es,cs:work_seg
	call	dos_mem_release	
sort_exit:	
	ret
merge_sort	endp

;--------------------------------------------------------------------
; MERGE - combine two sorted lists
;   inputs:  ds:bx = list1 index top
;            ds:bp = list2 index top, (may have -1 terminator)
;          cs:delta = length of each list
;          cs:data_buffer_seg = segment of data area
;          cs:work_seg = segment of work area
;          cs:sort_field_len
;          cs:sort_column
;
;  output: bx,bp updated to end of field
;
list1_length	dw	0
list2_length	dw	0
move_ptr	dw	0	;current store posn in work_seg
ds_save		dw	0

merge:	mov	cs:ds_save,ds
	mov	ax,cs:delta		;get list1 length
	mov	cs:list1_length,ax	;set list1 length
	mov	cs:list2_length,ax	;set list2 length
	
m_lp:	cmp	word ptr cs:list1_length,0
	je	sort2_only
	cmp	word ptr cs:list2_length,0
	je	move1
	cmp	word ptr ds:[bp],-1
	je	move1			;jmp if list2 empty
	cmp	bp,cs:index_length
	jae	move1
;
; list1 & list2 have data, look for short records
;
	mov	si,word ptr ds:[bx]	;get list1 record ptr
	add	si,cs:sort_column	;move to sort point
	mov	ax,word ptr ds:[bx+2]	;get length of record
	cmp	ax,cs:last_sort_column	;check if short record
	jb	move1			;jmp if list1 record short
;
; list1 has valid data, si = data buffer ptr
;
	mov	di,word ptr ds:[bp]	;get list2 record ptr
	add	di,cs:sort_column	;move to sort point
	mov	ax,word ptr ds:[bp+2]	;get record lenght
	cmp	ax,cs:last_sort_column	;check if short record
	jb	move2			;jmp if list2 record short
;
; both lists have valid records, do compare
;
	mov	cx,cs:cs:data_buffer_seg
	mov	ds,cx
	mov	es,cx
	mov	cx,cs:sort_field_len
	repe	cmpsb
	mov	ds,cs:ds_save		;restore index seg
	ja	move2			;jmp if list2 data smaller
	jmp	move1			;jmp if list1 data smaller	
;
; list1 is empty, check list2
;
sort2_only:
	cmp	cs:list2_length,0
	je	merge_done1		;jmp if end of both lists
sort2_cont:	
	cmp	word ptr ds:[bp],-1
	je	merge_done1		;jmp if end of both lists
;
; list2 has data move it
;
move2:	mov	ax,word ptr ds:[bp]	;get record ptr
	mov	dx,word ptr ds:[bp+2]	;get record length
	add	bp,4
	sub	cs:list2_length,4
	jmp	do_move
;
; list1 has data move it
;
move1:	mov	ax,word ptr ds:[bx]	;get record ptr
	mov	dx,word ptr ds:[bx+2]	;get record length
	add	bx,4
	sub	cs:list1_length,4
do_move:mov	di,cs:move_ptr
	mov	es,cs:work_seg
	stosw
	mov	ax,dx
	stosw
	mov	cs:move_ptr,di
	jmp	m_lp
;
merge_done1:
	ret

;
LIBSEG	ENDS
;;	end
