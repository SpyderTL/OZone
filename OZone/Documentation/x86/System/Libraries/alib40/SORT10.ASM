;***************************** SORT10.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc

	extrn	selection_sort:near
	extrn	buffer_sort:near
	
	extrn	sort_engine:word
	extrn	buffer_off:word
	extrn	buffer_seg:word
	extrn	buffer_len:word
	extrn	fixed_record_len:word
	extrn	rec_term_char:byte
	extrn	sort_field_len:word
	extrn	sort_column:word

.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
SELECTION_SORT_BUFFER - selection sort of buffer in memory
;
; inputs:  es:di = ptr to buffer with data to be sorted
;             cx = length of buffer in bytes
;             bx = record length if fixed, else zero if variable length record
;             al = variable lenght record separator, else zero if fixed record
;             dx = starting column for sort
;             ah = length of sort field
; 
; output:    carry set if insufficient memory to do sort  
;          
;* * * * * * * * * * * * * *

	extrn	selection_sort:near
	
	PUBLIC	SELECTION_SORT_BUFFER
SELECTION_SORT_BUFFER	PROC	FAR
	push	bp
	mov	bp,offset selection_sort
	mov	cs:sort_engine,bp
	mov	cs:buffer_off,di
	mov	cs:buffer_seg,es
	mov	cs:buffer_len,cx
	mov	cs:fixed_record_len,bx
	mov	cs:rec_term_char,al
	mov	byte ptr cs:sort_field_len,ah
	mov	cs:sort_column,dx
	call	buffer_sort
	pop	bp
	retf
SELECTION_SORT_BUFFER	ENDP	

LIBSEG	ENDS
	end
