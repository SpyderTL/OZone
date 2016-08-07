	page	66,132
;******************************** PULDOWN2.ASM *******************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	dos_mem_allocate:far
	extrn	dos_mem_release:far
	extrn	to_upper:far
	extrn	MENU_SYSTEM:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MENU   )
QMENU_SYSTEM - Quick pulldown menu bar
;
;  inputs:  ds:bx = pointer to list of names.  (See list format below)
;  
;  output:  ah = main menu index, 0=first item, 1=second, etc. -1=abort key
;           al = sub menu item if present
;
;  note: The menu list is displayed on the top line of the screen and is
;        built as follows:
;               db   'main option1',0
;               db     'sub option1',0
;               db     'sub option2',0
;               db	0			;end of main option1
;               db   'main option2',0
;               db	0			;end of main option2
;                  .
;                  .
;               db	0			;end of all options.
;
;         One zero between strings is a sub menu separation.
;         two zeros between strings is a new main menu item start
;         three zeros is end of all strings.
;* * * * * * * * * * * * * *

;---------------------------
qp_in_ptr	dw	0	;input list ptr
qp_in_seg	dw	0	;input list seg
qp_main_cnt	db	0	;number of main menu items
qp_sub_cnt	db	0	;number of sub menu's
qp_text_sz	dw	0	;text strings

qp_main_ptr	dw	0	;ptr to main entry structure
qp_sub_ptr	dw	0	;ptr to next sub menu struc
qp_text_ptr	dw	0	;ptr to next text definition

;---------------------------
	public	QMENU_SYSTEM
QMENU_SYSTEM	PROC	FAR
	apush	bx,cx,dx,si,di,bp,ds,es
	cld
	mov	cs:qp_in_ptr,bx
	mov	cs:qp_in_seg,ds
	sub	ax,ax				;setup to count menu items
	mov	word ptr cs:qp_main_cnt,ax
	mov	cs:qp_text_sz,ax
qp_lp1:	call	next_option
	add	cs:qp_text_sz,cx
	cmp	ah,1
	jne	qp_1				;jmp if not main menu item
	inc	cs:qp_main_cnt
qp_1:	cmp	ah,2
	jne	qp_2				;jmp if not sub menu
	inc	cs:qp_sub_cnt
qp_2:	cmp	ah,0
	jne	qp_lp1				;jmp if still counting
;
; compute amount of memory needed to build menu structure
;
	mov	ah,size menu_def
	mov	al,cs:qp_main_cnt
	add	al,cs:qp_sub_cnt
	inc	al
	mul	ah			;ax = memory for option struc's
	add	ax,cs:qp_text_sz
	add	ax,cs:qp_text_sz
;
; allocate -ax- bytes to hold structures
;
	mov	dx,0				;allocate dx,ax bytes
	call	dos_mem_allocate		;returns seg in -es-
	jc	qp_err				;jmp if no memory
;
; clear the memory area
;
	mov	cx,ax				;cx = length of alocated memory
	mov	di,0				;memory offset
	mov	al,0
	rep	stosb				;clear block
;
; compute start of major structure sections
;
	mov	ax,offset m_main01
	mov	qp_main_ptr,ax			;set ptr to first main entry

	mov	ah,size menu_def
	mov	al,cs:qp_main_cnt
	mul	ah
	add	ax,offset m_main01
	mov	qp_sub_ptr,ax			;set ptr to first sub menu

	mov	ah,size menu_def
	mov	al,cs:qp_sub_cnt
	mul	ah
	add	ax,qp_sub_ptr
	mov	qp_text_ptr,ax			;set ptr to text area
;
; fill in the structure header fields
;   registers:  ds:  = callers segment
;               es:  = assigned memory segment
;
	mov	es:[m_rows],1
	mov	es:[m_columns],80
	
;
; setup to fill in the main & sub structures
;
	mov	bx,cs:qp_in_ptr
	mov	ax,0
	
qp_lp2:	call	next_option
	cmp	ah,0
	je	qp_done2		;jmp if all done
	push	ax
	cmp	ah,2
	je	qp_set_sub		;jmp if sub option found
;
; ** main menu text found: registers  dx:si=start of text  ds:bx=next parse
;                                        cx=length of text
	mov	di,qp_main_ptr
;
; compute main menu item hot key
;	
     	mov	al,byte ptr [si]	;get first letter of text
	mov	ah,0
	call	to_upper
	sub	al,'A'
	add	ax,offset hot_key_tbl
	mov	bp,ax
	mov	al,byte ptr cs:[bp]	;look up hot key
	mov	es:[di.e_hot_key],al
;
;store length of text string
;
	mov	es:[di.e_length],cl
;
	mov	ax,qp_text_ptr		;get next text store ptr
	mov	es:[di.e_text_ptr],ax
	call	move_text		;move text and update ptr
;
; set process ptr
;
	mov	ax,word ptr es:[m_options]
	mov	es:[di.e_process],ax
	inc	es:[m_options]
;
; setup the column
;
	cmp	es:[m_options],1	;check if first entry
	jne	qp_5			; jmp if not first entry
	mov	al,1
	jmp	qp_6
qp_5:	mov	al,es:[di.e_column - size menu_entry] ;get previous column
	add	al,es:[di.e_length - size menu_entry]
	add	al,2			;two spaces
qp_6:	mov	es:[di.e_column],al	;store new column
     	add	cs:qp_main_ptr,size menu_entry
	pop	ax			;restore next_option info.
	jmp	qp_lp2
;
; ** sub menu text found: registers  ds:si=start of text  ds:bx=next parse
;                                       cx=length of text
;                                    es:di=main menu struc
;
qp_set_sub:
	push	bx
	mov	bx,cs:qp_sub_ptr
;
; compute length of sub menu box
;
	add	cl,2	
	cmp	byte ptr es:[di.e_sub_length],cl ;check if text will fit in box
	jae	qp_7			;jmp if text will fit
	mov	byte ptr es:[di.e_sub_length],cl ;enlarge box
qp_7:	sub	cl,2	
	
	mov	es:[bx.e_length],cl
	mov	ax,qp_text_ptr		;get next text store ptr
	mov	es:[bx.e_text_ptr],ax
	call	move_text		;move text and update ptr

;
; set process ptr
;
	cmp	es:[di.e_count],0	;check if this is the first
	jne	qp_08			;  jmp if not first
	mov	ax,es:[di.e_process]	;get origional process ptr
	mov	es:[di.e_process],bx	;replace process count with sub ptr
	xchg	al,ah
	mov	al,[di.e_count]
	jmp	qp_09
	
qp_08:	mov	ax,word ptr es:[bx.e_process-size menu_entry] ;get prev sub
	inc	al			;bump sub menu count
qp_09:	mov	es:[bx.e_process],ax

	add	al,2
	mov	es:[bx.e_row],al	;store row

	mov	al,es:[di.e_column]	;get main column
	inc	al
	mov	es:[bx.e_column],al

qp_11:	
	add	qp_sub_ptr,size menu_entry
	inc	byte ptr es:[di.e_count]	;count sum menu entries
	pop	bx
	pop	ax				;restore next_option info
	jmp	qp_lp2
qp_done2:
;
; we have built the data block, now call pulldown
;
	mov	ax,es
	mov	ds,ax
	mov	bx,0
	mov	ah,bar_save+bar_restore+bar_display+wait_valid_key
	call	MENU_SYSTEM
	push	ax
	call	dos_mem_release
	pop	ax
qp_err:
	apop	es,ds,bp,di,si,dx,cx,bx	
	retf
QMENU_SYSTEM	ENDP
;---------------------------
hot_key_tbl	label	byte
	db	30	;a
	db	48	;b
	db	46	;c
	db	32	;d
	db	18	;e
	db	33	;f
	db	34	;g
	db	35	;h
	db	23	;i
	db	36	;j
	db	37	;k
	db	38	;L
	db	50	;m
	db	49	;n
	db	24	;o
	db	25	;p
	db	16	;q
	db	19	;r
	db	31	;s
	db	20	;t
	db	22	;u
	db	47	;v
	db	17	;w
	db	45	;x
	db	21	;y
	db	44	;z
;---------------------------
; move_text
;  inputs:  es:ax = text store point
;              cx = text length
;           ds:si = text source ptr
;
move_text:
	apush	cx,si,di
	mov	di,ax
	rep	movsb
	mov	byte ptr es:[di],0
	inc	di
	mov	cs:qp_text_ptr,di
	apop	di,si,cx
	ret
;---------------------------
; get next option and return flags
;   inputs: ds:bx = current option ptr, or next process ptr if continuation
;              ah = should be set to zero on first call, then the state
;                   preserved until done.
;   output: ds:bx points past zero at end of option
;              ah = 0 end of options
;                   1 current option is main (ds:si)
;                   2 current option is sub (ds:si)
;              cx = length of current option (ds:si)
;              si = state of -bx- at entry, or start of current option
;              bx = next parse point
;
next_option:
	push	es
	mov	si,bx
	push	ds
	pop	es
	cmp	ah,1
	je	n_main		;jmp if main menu item was previous
	jb	n_main3		;jmp if this is first entry
;
; previous menu item was a sub menu
;
	lodsb			;get next char
	cmp	al,0
	jne	n_cont2		;continuing sub menu selection
	jmp	n_main2
;
; assume we are scanning a main option
;
n_main:	lodsb			;get next char
	cmp	al,0		;check if submenu next
	jne	sub_state1	;jmp if start of sub menu option
;
; we either have another main option next, or this is the end
;
n_main2:inc	bx		;move past zero
n_main3:lodsb
	cmp	al,0
	jne	n_cont1		;jmp if main menu item next
	mov	ah,0
	jmp	n_exit		;jmp if end of options
;
; the next option is a main menu item
;
n_cont1:mov	ah,1
	jmp	n_cont2
;
; we are transiting from a main to a sub menu
;
sub_state1:
	mov	ah,2
	jmp	n_cont2
;
; continuation of sub menu extraction
; 
n_cont2:mov	cx,0
n_cont3:lodsb
	inc	cx
	cmp	al,0
	jne	n_cont3		;loop till end of option found
	
n_exit:	xchg	si,bx
	pop	es
	ret
;--------------------------------------------------------------------------

LIBSEG	ENDS
	end
