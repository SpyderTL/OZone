;***************************** SORT12.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc

	extrn	sort_column:word
	extrn	last_sort_column:word
	extrn	sort_field_len:word
	extrn	index_length:word
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
; selection_sort - sort indexed buffer. 
;  inputs:  ds:0  - ptr to index struc. <word buf_ptr>, <word record_length>
;           es:   - buffer seg,(index has offsets)
;              sort_field_len - length of sort field
;              dx - starting column of sort field
;
;  Output:  index structure is sorted in decending order
;
;  Notes:   The index must have at least one entry.
;           Short or empty records are placed at top of index without
;           attempting to sort.
;
;*********************

indx_seg	dw	0
buf_seg		dw	0

	public	selection_sort
selection_sort	proc	near
	cld
	cmp	cs:index_length,4
	jbe	sort_exit
	mov	bp,0
	mov	cs:sort_column,dx
	add	dx,cx
	mov	cs:last_sort_column,dx

	mov	cs:indx_seg,ds
	mov	cs:buf_seg,es

	mov	dx,bp
sn_loop1:
	mov	bp,dx
	mov	bx,dx
;
; dx = top of outside loop index ptr
; bp = current smallest index ptr
; bx+4 = next challenger for smallest
;
sn_loop2a:
	mov	si,word ptr ds:[bp]	;point si at lowest text string
	add	si,cs:sort_column	;move to sort column
	mov	ax,word ptr ds:[bp+2]	;get lenght of si string
	cmp	ax,cs:last_sort_column
	jb	make_bp_top 		;jmp if incomplete sort field

sn_loop2b:
	add	bx,4			;move to challenger
	cmp	word ptr ds:[bx],-1
	je	make_bp_top		;jmp if inside loop2 done
	mov	di,word ptr ds:[bx]	;point di at challenger
	add	di,cs:sort_column	;move to sort column
	mov	ax,word ptr ds:[bx+2]
	cmp	ax,cs:last_sort_column
	jb	force_bx_top		;jmp if incomplete sort field
	
	mov	cx,cs:sort_field_len
	mov	ds,cs:buf_seg
	push	si
	repe	cmpsb
	pop	si
	mov	ds,cs:indx_seg
	jbe	sn_loop2b		;jmp if ignoring challenger
make_bx_top:
	mov	bp,bx
	jmp	sn_loop2a		;go setup new challenger
;
; put bx on top and break out of inner loop, move on
;
force_bx_top:
	mov	bp,bx
;
; inner loop2 has completed one pass, set new smallest and bump -dx-
; dx=top ptr  bp=new smallest  bx=scratch
;
make_bp_top:
	mov	bx,dx
	mov	ax,word ptr ds:[bp]	;get old lowest
	xchg	ax,word ptr ds:[bx]	;put at challenger's space
	mov	word ptr ds:[bp],ax	;put challenger at top

	mov	ax,word ptr ds:[bp+2]
	xchg	ax,word ptr ds:[bx+2]
	mov	word ptr ds:[bp+2],ax
sn_done2:
	add	dx,4
	cmp	word ptr ds:[bp+4],-1
	jne	sn_loop1		;if not at end go do it again
		
sort_exit:	
	ret
selection_sort	endp

LIBSEG	ENDS
	end
