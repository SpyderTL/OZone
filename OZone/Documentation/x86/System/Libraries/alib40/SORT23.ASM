;***************************** SORT23.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing
;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	extrn	dos_mem_allocate:far
	extrn	dos_mem_release:far
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
; merge_sort_arrayw - sort array of words. 
;  inputs:  ds:0 - ptr to word array
;              cx - number of elements in array (range 2-16383)
;
;  Output:  if no carry array is sorted in decending order
;           carry = insufficient memory
;           
;  Note:  merge_sort_arrayw uses 290 bytes for code and allocates
;         memory to hold array being sorted.
; 
;  Psuedo code:
;
;int array2sort[n]; /* array with indexes from 0 to n-1 as in C */
;                   /* replace int with whatever datatype you want to sort */
;int l;          /* length of sorted sets */
;int first;      /* first element to be sorted */
;  l=1;
;  while (l<n)
;  {
;    first=0;
;    while (first+l<n)
;    {
;      merge(array2sort[first..first+l-1], array2sort[first+l..first+2*l-1]);
;      first= first + 2 * l;
;    }
;    l= 2*l; /* We now have sorted sets of length 2*l */
;  }
;****************************

work_seg		dw	0	;temp index sort area
sort_buffer_seg		dw	0
delta			dw	0
no_sort_flag		db	0	;set =1 if no sort in merge pass
sorted_flag		db	0	;set =1 if index already sorted

	public	merge_sort_arrayw              
merge_sort_arrayw	proc	far
	apush	ax,bx,cx,dx,si,di,bp,ds,es
	cld
	cmp	cx,1
	jbe	sort_exit		;jmp if not enough data to sort
	shl	cx,1
	mov	bp,cx			;bp=sort buffer length (bytes)
	mov	cs:sort_buffer_seg,ds
;
; allocate work area
;
	mov	dx,0
	mov	ax,bp
	call	dos_mem_allocate
	jc	sort_exit3
	mov	cs:work_seg,es
	mov	cs:delta,2

    	mov	di,cs:delta		;setup list2 start
lp1:	mov	bx,0			;setup store ptr for 'merge' routine
	mov	si,0                 	;set si at top of buffer
	mov	cs:sorted_flag,1	;preload already sorted flag
	
lp2:	call	merge
	mov	cl,cs:no_sort_flag	;get 1 if no sort occured
	and	cs:sorted_flag,cl	;keep 1 in sorted_flag if block sorted
	add	si,cs:delta
	add	di,cs:delta
	cmp	si,bp			;bp=sort buffer length
	jb	lp2			;jmp if more data to sort
;
; move the temp index back to origional
;	
ms_4:	cmp	cs:sorted_flag,1
	je	ms_done			;jmp if no sort needed

	mov	di,cs:delta
	shl	di,1
	mov	cs:delta,di
	cmp	di,bp			;check if delta > buffer length
	jae	ms_done
;
	mov	ax,ds			;swap
	mov	cx,es			;  buffer
	mov	ds,cx			;    pointers
	mov	es,ax			;       ds & es
	jmp	lp1

ms_done:
	mov	ax,ds
	cmp	ax,cs:sort_buffer_seg	;check if good data in work seg
	jne	sort_exit2		;jmp if sort data in sort_buffer
		
	mov	cx,bp			;bp=sort_buffer_length
	shr	cx,1			;length
	mov	di,0			;destination
	mov	si,0			;source
	mov	es,cs:sort_buffer_seg
	mov	ds,cs:work_seg
	rep	movsw			;move work index -> origional index
sort_exit2:	
	mov	es,cs:work_seg
	call	dos_mem_release	
sort_exit:
	clc
sort_exit3:
	apop	es,ds,bp,di,si,dx,cx,bx,ax
	retf
merge_sort_arrayw	endp

;--------------------------------------------------------------------
; MERGE - combine two sorted lists
;   inputs:  ds:si = list1 index top
;            ds:di = list2 index top, (may be short list)
;          cs:delta = length of each list
;            es:bx = active storage pointer of work area
;               bp = sort buffer length (byte count)
;
;  output: si,di updated to end of field
;
starting_list2_len	dw	0

merge:	mov	cs:no_sort_flag,0	;preload data unsorted state
	mov	cx,cs:delta		;get list1 length
	mov	dx,cx			;set list2 length
;
; check length of list2
;	
	mov	ax,dx			;get list2 length
	add	ax,di			;compute last location
	sub	ax,bp			;ax = list2 length adjustment
	jb	mer_cont2		;jmp if length ok
	sub	ax,cx
	jbe	mer_cont1		;jmp if only list2 needs adjusting
	mov	dx,0			;list2 is zero length
;
; adjust list1 length
;
	sub	cx,ax
	jmp	mer_cont2
;
; adjust list2 length
;
mer_cont1:	
	add	ax,cx
	sub	dx,ax			;adjust list2 length
mer_cont2:
	mov	cs:starting_list2_len,dx
;
;             bp=sort buffer length    ds:si=list1 ptr  cx=list1 length  
; ax=scratch  es:bx=store ptr          ds:di=list2 ptr  dx=list2 length
;
m_lp:	cmp	cx,0
	je	sort2_only		;jmp if list1 length=0
	cmp	dx,0
	je	move1			;jmp if list2 length=0
;
; both lists have valid records, do compare
;
	mov	ax,word ptr ds:[si]
	cmp	ax,word ptr ds:[di]
	ja	move2			;jmp if list2 data smaller
	jmp	move1			;jmp if list1 data smaller	
;
; list1 is empty, check list2
;
sort2_only:
	cmp	dx,0			;check if list2 has data
	je	merge_done1		;jmp if end of both lists
;
; check if no sort was needed for list1, (everything already sorted)
;
	cmp	dx,cs:starting_list2_len ;has list2 data been merged
	jne	sort2_cont		;jmp if merge occured
	mov	cs:no_sort_flag,1	;set no sort this pass flag
sort2_cont:	
;
; list2 has data move it
;
move2:	mov	ax,word ptr ds:[di]	;get list2 data
	add	di,2
	sub	dx,2			;list2 length - 2
	jmp	do_move
;
; list1 has data move it
;
move1:	lodsw
	sub	cx,2			;list1 length - 2
do_move:mov	word ptr es:[bx],ax
	add	bx,2
	jmp	m_lp
;
merge_done1:
	ret

;
LIBSEG	ENDS
	end
