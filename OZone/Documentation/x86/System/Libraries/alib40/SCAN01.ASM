	page	66,132
;******************************* SCAN01.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
;SCAN_BLOCK_TINY1 - scan sequential buffers for string, case match
;  inputs:  es:bx   =   compare string start (string terminated with zero)
;           es:si   =   compare string current location
;           ds:di   =   buffer current location
;              cx   =   buffer size (remaining byte count)
;           direction flag = CLD state
;
;  output:  registers di,si,cx are updated
;           if al=0 then a match was found ds:si points at match end.
;                 use -si- ,-di- and -cx- as returned to continue searching
;                 in current buffer.  
;
;           if cx=0 then no match was found, check if bx=di to determine
;                   if a partial match is in process at buffer end.
;
;  Note:  If a partial match fails and the partial match was split
;         accross two buffers, then extra processing may be needed
;         by the caller to restart the compare in the first buffer.
;         Partial matches are detected by checking if -si- points
;         at start of compare string when end of buffer was reached.
;         If not at start, then partial match is in progress.
;
;         This routine is 46 bytes long and fast if searching for
;         short strings.
;
;                            code size   speed
;         SCAN_BLOCK_TINY1    46 bytes    2.36 (small is faster)
;         SCAN_BLOCK_TINY2    69 bytes   13.35 (matches ether case)
;         SCAN_BLOCK1         43 bytes    2.36
;         SCAN_BLOCK2        152 bytes    6.37 (matches either case)
;         SCAN_BLOCK_FAST    466 bytes    1.42 
;
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_BLOCK_TINY1
SCAN_BLOCK_TINY1	PROC	FAR
	apush	dx,bp
	cmp	si,bx
	jne	st_continue		;jmp if partial match in progress
restart_scan:
	mov	si,bx
	lodsb				;get next compare char
	repne	scasb			;scan for char
	jne	st_exit			;jmp if no match found
;
; the first character matches, check next char
;
st_continue:
	mov	dx,cx			;save cx,di incase of
	mov	bp,di			;   miscompare
cmp_lp:	lodsb
	test	al,al
	jz	st_exit1		;jmp if match found
	cmp	al,byte ptr es:[di]
	jne	cmp_fail		;jmp if compare failed
	inc	di
	dec	cx
	jcxz	st_exit			;jmp if out of data
	jmp	cmp_lp			;jmp if still matching
	
cmp_fail:
	mov	cx,dx			;restore cx,di
	mov	di,bp
	jmp	restart_scan
st_exit1:
	mov	si,bx			;reset compare ptr
st_exit:
	apop	bp,dx
	retf
SCAN_BLOCK_TINY1	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
