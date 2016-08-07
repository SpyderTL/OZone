;***************************** SORT34.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
; bubble_sort_arrayd - bubble sort array of dwords
;  inputs:  ds:di - ptr to word array
;              dx - number of elements in array
;
;  Output:  if no carry array is sorted in decending order
;           carry = insufficient memory
;           
;  Note:  bubble_sort_arrayw uses 290 bytes for code
;*********************


	public	bubble_sort_arrayd
bubble_sort_arrayd	proc	far
	apush	ax,bx,cx,dx,si
	cld
	cmp	dx,1
	jbe	sort_exit		;exit if not enough data to sort
	sub	dx,1
sn_loop1:
	mov	cx,dx			;setup length of loop
	mov	bx,0			;set exchange flag = 0
	mov	si,di			;start at top of buffer
;
; registers -  si=moving ptr
;
sn_loop2:
	mov	ax,word ptr ds:[si+2]
	cmp	ax,word ptr ds:[si+6]
	jb	no_swap
	ja	do_swap
	
	mov	ax,word ptr ds:[si]	;get next array value
	cmp	ax,word ptr ds:[si+4]
	jbe	no_swap			;jmp if order ok
do_swap:
	mov	ax,word ptr ds:[si]	
	xchg	ax,word ptr ds:[si+4]	;swap order of array values
	mov	word ptr ds:[si],ax

	mov	ax,word ptr ds:[si+2]
	xchg	ax,word ptr ds:[si+6]
	mov	word ptr ds:[si+2],ax
	mov	bx,1			;set exchange flag = 1
no_swap:
	add	si,4
	loop	sn_loop2
	cmp	bx,0			;check if sort done
	jne	sn_loop1
sort_exit:
	apop	si,dx,cx,bx,ax
	retf
bubble_sort_arrayd	endp

LIBSEG	ENDS
	end
