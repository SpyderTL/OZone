;***************************** SORT32.ASM ***********************************

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
; bubble_sort - sort indexed buffer. 
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

exchange_flag	db 	0

	public	bubble_sort
bubble_sort	proc	near
	cld
	cmp	cs:index_length,4
	jbe	sort_exit
	mov	cs:sort_column,dx
	add	dx,cx
	mov	cs:last_sort_column,dx
	mov	dx,cs:sort_column
sn_loop1:
	mov	bp,0
	mov	cs:exchange_flag,0
	mov	bx,bp
	add	bx,4
;
; registers -  bp - index ptr with lowest name  (si points at name)
;              bx - index of challenger         (di points at challenger name)
;
sn_loop2:
	cmp	word ptr ds:[bx],-1	;check if done
	je	sn1_done
	mov	si,word ptr ds:[bp]	;point si at lowest text string
	add	si,dx			;move to sort column
	mov	ax,word ptr ds:[bp+2]	;get lenght of si string
	cmp	ax,cs:last_sort_column
	jb	next_challenger		;jmp if incomplete sort field
	mov	di,word ptr ds:[bx]	;point di at challenger
	add	di,dx			;move to sort column
	mov	ax,word ptr ds:[bx+2]
	cmp	ax,cs:last_sort_column
	jb	put_on_top		;jmp if incomplete sort field
	mov	cx,cs:sort_field_len
	push	ds			;save index seg
	push	es			;set
	pop	ds			;  ds=es
	repe	cmpsb			;check the strings
	pop	ds			;restore index seg
	jbe	next_challenger
put_on_top:
	mov	ax,word ptr ds:[bp]	;get old lowest
	xchg	ax,word ptr ds:[bx]	;put at challenger's space
	mov	word ptr ds:[bp],ax	;put challenger at top

	mov	ax,word ptr ds:[bp+2]
	xchg	ax,word ptr ds:[bx+2]
	mov	word ptr ds:[bp+2],ax
	mov	cs:exchange_flag,1
next_challenger:
	add	bx,4
	add	bp,4
	jmp	sn_loop2
sn1_done:
	cmp	cs:exchange_flag,0
	jne	sn_loop1
sort_exit:	
	ret
bubble_sort	endp

LIBSEG	ENDS
	end
