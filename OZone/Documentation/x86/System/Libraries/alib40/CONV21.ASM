	page	66,132
;******************************** CONV21.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
WORD_TO_DEC_STDOUT - display byte as decimal to stdout
;
; inputs  ax = word
; 
; output  none
;* * * * * * * * * * * * * *

;==========================================================================
;  inputs:  ax = binary value
;  outputs: none
;
;  registers destroyed:  ax,dx
;
	extrn	ten:word
	public	word_to_dec_stdout
word_to_dec_stdout	proc	far
		call	local_proc
		retf
word_to_dec_stdout	endp
;--------------------------------
local_proc:    	xor	dx,dx
		div	cs:ten			;divide curent binary val by 10
		or	ax,ax			;check if done
		jz	db_display		;  jmp if done
		push	dx			;save remainder
		call	local_proc        	;recursion
		pop	dx
db_display:	add	dl,30h			;convert char. to ascii
		mov	ah,2
		int	21h			;display char. in -dl-
		ret
LIBSEG	ENDS
	end

