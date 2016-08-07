;***************************** SORT33.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
; bubble_sort_arrayw - bubble sort array of words
;  inputs:  ds:di - ptr to word array
;              dx - number of elements in array
;
;  Output:  array is sorted in decending order
;           
;  Note:  bubble_sort_arrayw uses 43 bytes for code
;*********************


	public	bubble_sort_arrayw
bubble_sort_arrayw	proc	far
	apush	ax,bx,cx,dx,si
	cld
	cmp	dx,1
	jbe	sort_exit		;exit if not enough data to sort
	dec	dx
sn_loop1:
	mov	cx,dx			;setup length of loop
	xor	bx,bx			;set exchange flag = 0
	mov	si,di			;start at top of buffer
;
; registers -  si=moving ptr
;
sn_loop2:
	lodsw				;get next array value
	cmp	ax,word ptr ds:[si]
	jbe	no_swap			;jmp if order ok
	xchg	ax,word ptr [si]	;swap order of array values
	mov	word ptr [si-2],ax
	inc	bx			;set exchange flag = 1
no_swap:
	loop	sn_loop2
	cmp	bx,0			;check if sort done
	jne	sn_loop1
sort_exit:
	apop	si,dx,cx,bx,ax
	retf
bubble_sort_arrayw	endp

LIBSEG	ENDS
	end
