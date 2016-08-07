	page	66,132
;******************************** CONV22.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
DWORD_TO_DEC_STDOUT - display dword as decimal to stdout
;
; inputs  dx,ax = dword
; 
; output  dx.ax destroyed
;* * * * * * * * * * * * * *

;==========================================================================
	extrn	ten:word
	public	dword_to_dec_stdout  
DWORD_TO_DEC_STDOUT	proc	far
	push	bx
	call	local_proc
	pop	bx
	retf
dword_to_dec_stdout	endp

local_proc:	push	ax
		mov	ax,dx
		xor	dx,dx
		div	cs:ten
		mov	bx,ax
		pop	ax
		div	cs:ten
		xchg	bx,dx
;
; dx,ax = quotient
;    bx = remainder

		or	ax,ax
		jnz	dd_more
		or	dx,dx
		jnz	dd_more
		mov	dx,bx
		jmp	ddb_display
dd_more:
		push	bx			;save remainder		
	
		call	local_proc         	;recursion
		pop	dx
ddb_display:	add	dl,30h			;convert char. to ascii
		mov	ah,2
		int	21h			;display char. in -dl-
		ret
LIBSEG	ENDS
	end



