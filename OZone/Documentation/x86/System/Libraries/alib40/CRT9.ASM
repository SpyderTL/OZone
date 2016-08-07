	page	66,132
;******************************** CRT9.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	INCLUDE	COMMON.INC
.list
;----------------------------------------------------------------------------
	EXTRN	LIB_INFO:BYTE
;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
;                        MISC.  display routines
;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
; convert row/column to display offset
;  inputs: dh=row dl=column
;  output: es:di = display ptr
;
	PUBLIC	POSN_TO_ADR
POSN_TO_ADR	PROC	NEAR
    apush   ax,dx
    mov	    al,dh	;get row
    mul     lib_info.crt_columns
    xor     dh,dh
    add     ax,dx	;compute offset
    shl     ax,1	;adjust for word offset
    mov     di,ax
    mov     es,lib_info.crt_seg
    apop    dx,ax
    ret
POSN_TO_ADR	ENDP	
;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
; convert display offset to row/column
;  inputs: es:di = display ptr
;  output: dh=row dl=column
;
	PUBLIC	ADR_TO_POSN
ADR_TO_POSN	PROC	NEAR
	push	ax
	mov	ax,di		;get offset
	shr	ax,1
	div	lib_info.crt_columns
	mov	dx,ax
	xchg	dh,dl
	pop	ax
	ret
ADR_TO_POSN	ENDP


LIBSEG	ENDS
	end
