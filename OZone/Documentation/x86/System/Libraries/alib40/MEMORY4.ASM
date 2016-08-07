	PAGE	66,132
;****************************** MEMORY4.ASM *********************************
;
;----------------------------------------------------------------------------
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
CHECK_DOS_MEMORY - check DOS memory size and amount available
;  inputs: ax = segment at end of program area (zseg)
;  outputs: ax = available blocks or paragraphs (16 bytes = 1 block)
;           bx = total memory size in blocks
;
;  note:  This routine scan for the MCB chain, rather than look in
;         the DOS database.  For some implementations of brain
;         damaged DOS, the scan works better.
;* * * * * * * * * * * * * *


	public	CHECK_DOS_MEMORY
CHECK_DOS_MEMORY	proc	far
	push	cx
        sub     bx,bx
        mov     es,bx
        mov     bx,es:[413h]            ;get mem. size in 1k blocks
        mov	cl,6
        shl	bx,cl
;
; compute our final program location in paragraphs
;  ax = our final offset
;
        mov	cx,bx
        sub	cx,ax
        mov	ax,cx
        pop	cx
	retf
CHECK_DOS_MEMORY	endp

LIBSEG	ENDS
;;	end
