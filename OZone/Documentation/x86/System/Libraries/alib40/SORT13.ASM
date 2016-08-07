;***************************** SORT13.ASM ***********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc

.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SORT   )
selection_sort_arrayw  - sort word array (integers)
;  inputs:  ds/es:si - ptr to array of words
;                 dx - number of items in array (range 0-32767)
;           direction flag is in CLD state.
;
;  Output:  array is sorted in decending order
;           Registers  ax,bx,cx,dx,si,di are modified
;
;  Note:   code size is 29 bytes.
;*********************


	public	selection_sort_arrayw

do_swap:	lea	bx,ds:[di-2]	;get  [di-2]
		mov	ax,ds:[bx]	;get new smallest
		dec	cx		;do not put "jmp" here, too slow
		jcxz	tail		;jmp if one pass done
loop1:		scasw			;compare
		ja	do_swap		;jmp if new smallest
		loop	loop1		;jmp if more data
tail:		xchg	ax,ds:[si-2]	;put smallest
		mov	[bx],ax		;  at top

selection_sort_arrayw	proc	far
		mov	bx,si		;set smallest ptr -bx-
		lodsw			;get smallest
		mov	di,si		;set moving compare ptr
		dec	dx		;adjust loop count
		mov	cx,dx
		jg	loop1		;loop till done
		retf			
selection_sort_arrayw	endp

LIBSEG	ENDS
	end
