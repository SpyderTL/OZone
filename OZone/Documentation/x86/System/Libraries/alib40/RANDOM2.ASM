	page	66,132
;******************************* RANDOM2.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( RANDOM  )
RANDOM_WORD2 -  generate random word value, using method 2
;
; inputs: (ds:bx)  struc
;                   rs1   dw  (random seed 1)
;                   rs2   dw  (random seed 2)
;                   range dw  mask to truncate number, normally a power
;                             of 2 is used.  Example  1fh, 1ffh, 3ffh, etc.
;                   
; output:  ax = random number
;
; note:  RANDOM_WORD2 is designed for applications which need to keep several
;        random number sequences going indepently.  The input structure
;        (ds:bx) can use a different set of data for each random sequence.
;        
;* * * * * * * * * * * * * *


randd	struc
rs1	dw	?
rs2	dw	?
range	dw	?
randd	ends

first_random	db	0
;-------------------------
	public	RANDOM_WORD2
RANDOM_WORD2	proc	  far
	mov	dx,[bx.rs2]
	mov	ax,[bx.rs1]
	mov	[bx.rs2],ax

	mov	cx,171
	mul	cx
	mov	cx,30269
	div	cx
	mov	ax,dx
;
; scale random number
;
gr_wrap_up:
	mov	[bx.rs1],ax		;save for next time
	and	ax,[bx.range]		;scale number
	retf
RANDOM_WORD2	endp

LIBSEG	ENDS
	end
