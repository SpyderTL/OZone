	PAGE	66,132
;****************************** MEMORY7.ASM *********************************
;
;----------------------------------------------------------------------------
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	cmos_type:far
	extrn	cmos_read_word:far
.list
;----------------------------------------------------------------------------

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
EXT_CHECK - check if EXT memory is present
; inputs:  none
; output:  ax = size of available extended memory in 1k blocks
;          bx = total amount of extended memory installed
;          
;* * * * * * * * * * * * * *


	public	EXT_CHECK
EXT_CHECK	proc	far
	call	cmos_type
	mov	ax,0			;preload 0
	cmp	dl,-1
	je	ext2			;jmp if cmos unknown type
	mov	ah,30h			;address of cmos ext_size variable
	call	cmos_read_word
ext2:	push	ax			;save total ext memory size
	clc				;clear carry
	mov	ah,88h			;get extended memory size code
	int	15h			;call bios
	jnc	cont_ext1		;jump if we may	have extended memory
	clc
	jmp	ce_exit    		;jump if no extended installed
cont_ext1:
	pop	bx			;get total ext size in 1k blocks
ce_exit:
	retf
EXT_CHECK	endp


LIBSEG	ENDS
;;	end
