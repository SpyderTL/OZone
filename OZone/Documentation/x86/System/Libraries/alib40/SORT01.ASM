;***************************** SORT01.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	 dos_mem_allocate:far
	extrn	 dos_mem_release:far

	extrn	make_index:near
	extrn	order_buffer:near

	extrn	sort_engine:word
	extrn	sort_field_len:byte
	extrn	sort_column:word
	extrn	last_sort_column:word
	extrn	buffer_off:word
	
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
; buffer sort, allocate memory for index.
;  inputs:  es:di = pointer to buffer, or asciiz if file
;              cx = buffer length, or zero if file
;              bx = record length if fixed length, else zero if variable len.
;              al = record terminator for variable lenght records. else zero
;   output: carry set if insufficient memory
;           no carry - cx = partial record size
;
;* * * * * * * * * * * * * *

index_seg	dw	0
bs_buf_off	dw	0

	public	buffer_sort
buffer_sort	proc	near
	apush	ax,es
	mov	dx,0
	mov	ax,0f000h		;allocate 61k bytes for index
	call	dos_mem_allocate	;retruns es: = memory seg
	jc	no_memory1		;jmp if error
	mov	cs:index_seg,es		;save index
	push	es
	pop	ds			;index buf seg now in -ds-
	apop	es,ax			;restore data buf seg

	call	make_index		;build index buffer
	push	cx			;save partial record size
	
	mov	cl,cs:sort_field_len	;get length of sort field
	mov	ch,0			;just incase
	mov	dx,cs:sort_column	;get starting byte posn
	mov	cs:last_sort_column,dx
	add	cs:last_sort_column,cx
	mov	ax,cs:buffer_off	;get buffer start	
	call	sort_engine		;near call

	push	es
	pop	ds			;ds=buffer seg
	mov	si,cs:bs_buf_off
	mov	dx,cs:index_seg
	call	order_buffer		;move all records to correct location
	jc	no_memory2
		
	mov	es,cs:index_seg
	call	dos_mem_release		;release index
	clc		
no_memory2:	
	pop	cx
no_memory1:
	ret
buffer_sort	endp

LIBSEG	ENDS
	end
