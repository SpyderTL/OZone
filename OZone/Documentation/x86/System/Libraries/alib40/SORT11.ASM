;***************************** SORT11.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc

	extrn	selection_sort:near
	extrn	file_sort:near
	
	extrn	sort_engine:word
	extrn	prime_asciiz_off:word
	extrn	rec_term_char:byte
	extrn	sort_field_len:word
	extrn	sort_column:word
	extrn	fixed_record_len:word
.list

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
SELECTION_SORT_FILE - selection sort of file
;
; inputs:  es:di = ptr to asciiz file name string      
;             bx = record length if fixed, else zero if variable length record
;             al = variable lenght record separator, else zero if fixed record
;             dx = starting column for sort
;             ah = length of sort field
; 
; output:   carry set if insufficient memory to do sort
;           
;* * * * * * * * * * * * * *

	PUBLIC	SELECTION_SORT_FILE
SELECTION_SORT_FILE	PROC	FAR
	push	bp
	mov	bp,offset selection_sort
	mov	cs:sort_engine,bp
	
	mov	cs:fixed_record_len,bx
	mov	cs:rec_term_char,al
	mov	byte ptr cs:sort_field_len,ah
	mov	cs:sort_column,dx
	call	file_sort
	pop	bp
	retf
SELECTION_SORT_FILE	ENDP


LIBSEG	ENDS
	end
