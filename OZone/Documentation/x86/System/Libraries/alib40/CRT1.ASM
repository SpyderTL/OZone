	page	66,132
;******************************** CRT1.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include	common.inc
.list
;----------------------------------------------------------------------------
	EXTRN	POSN_TO_ADR:NEAR
	EXTRN	LIB_INFO:BYTE
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
PUT_CRT_CHR - display single character
;             write character (ax) to display at row/column (dx)
;
; inputs: ax = char & color
;         dx = address
;
; outputs:es = display segment
;* * * * * * * * * * * * * *

	PUBLIC	PUT_CRT_CHR
PUT_CRT_CHR		PROC	FAR
    apush   dx,di,ax
    mov	    al,dh	;get row
    mul     lib_info.crt_columns
    xor     dh,dh
    add     ax,dx	;compute offset
    shl     ax,1	;adjust for word offset
    mov     di,ax
    mov     es,lib_info.crt_seg
    pop     ax		;restore print char
    cld
    STOSW
    apop    di,dx
    RETF
PUT_CRT_CHR	ENDP
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�
;local version of put_crt_chr.  This version uses the display offset
;rather than the row/column to place char.
;
;  inputs:  es:di = display address
;              ax = display char & color

;  output:     di = next display location
;
	PUBLIC	$PUT_CRT_CHR
$PUT_CRT_CHR:
	cld
	stosw
	ret
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
GET_CRT_CHR -  read character and attribute from text screen
;
; inputs:    DH = screen row
;            DL = screen column
;
; output:    AH = color atttribute
;            AL = ASCII character code
;
;* * * * * * * * * * * * * *

	PUBLIC	GET_CRT_CHR
GET_CRT_CHR		PROC	FAR
    apush       dx,di,es
    call	posn_to_adr
    mov         ax,word ptr es:[di]
    apop	es,di,dx
    retf
GET_CRT_CHR ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
REPEAT_PUT_CRT - displays a single char CX times.
;
; inputs:  ax = char (ah=color attribute, al=ascii character)
;          dx = display location (dh=row, dl=column)
;          cx = count
;
;output:  none
;
;notes:  The character and color (ax) are displayed starting at
;        location (dx) until count (cx) is counted down to zero.
;* * * * * * * * * * * * * *

	PUBLIC	REPEAT_PUT_CRT
REPEAT_PUT_CRT	PROC	FAR
    jcxz    rpc_done
    cld
    apush   es,dx,di
    call    posn_to_adr
    REP	STOSW
    apop    di,dx,es
rpc_done:
    RETF
REPEAT_PUT_CRT	ENDP
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�
; $REPEAT_PUT_CRT displays a single char CX times.
;  inputs:  ax = char
;        es:di = display offset
;           cx = count
; output:  di - updated to point at next char.
;          cx = 0
;
	PUBLIC	$REPEAT_PUT_CRT
$REPEAT_PUT_CRT:
    jcxz    $rpc_done
    cld
    REP	    STOSW
$rpc_done:    
    RET


LIBSEG	ENDS
	end
