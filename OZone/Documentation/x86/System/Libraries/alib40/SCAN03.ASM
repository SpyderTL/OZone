	page	66,132
;******************************* SCAN03.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc

	extrn	strlen1:far
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
;SCAN_BLOCK1 - scan sequential buffers for string, match case
;  inputs:  ds:bx   =   compare string start (string terminated with zero)
;           ds:si   =   compare string current location
;           es:di   =   buffer current location
;              cx   =   buffer size (remaining byte count)
;           direction flag = CLD state
;
;  output:  registers di,si,cx are updated
;           if flags set for "je" then es:di points past match
;                 if bx not equal to si then partial match is in progress
;                 at end of buffer.  CX should also be zero at this point.
;                 use -si- ,-di- and -cx- as returned to continue searching
;                 in current buffer.  
;
;           if flags set for "jne" then no match was found
;
;  Note:  If a partial match fails and the partial match was split
;         accross two buffers, then extra processing may be needed
;         by the caller to restart the compare in the first buffer.
;         Partial matches are detected by checking if -si- points
;         at start of compare string when end of buffer was reached.
;         If not at start, then partial match is in progress.
;
;         This routine is 43 bytes long and fast if searching for
;         long strings which are very similiar.
;
;                            code size   speed
;         SCAN_BLOCK_TINY1    46 bytes    2.36 (small is faster)
;         SCAN_BLOCK_TINY2    69 bytes   13.35 (matches ether case)
;         SCAN_BLOCK1         43 bytes    2.36
;         SCAN_BLOCK2        152 bytes    6.37 (matches either case)
;         SCAN_BLOCK_FAST    466 bytes    1.42 
;
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_BLOCK1
SCAN_BLOCK1	PROC	FAR
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

cmp_lp:	cmp	byte ptr ds:[si],0
	je	st_match1
	jcxz	st_match2		;jmp if at end of buffer
	cmpsb
	jne	no_match
	dec	cx
	jmp	cmp_lp
no_match:	
	mov	cx,dx			;restore cx,di
	mov	di,bp
	jmp	restart_scan
;
; we have found a match, set exit registers
;
st_match1:
	mov	si,bx
;
; we are at end of buffer, and have a partial match
;
st_match2:
		
st_exit:
	apop	bp,dx
	retf
SCAN_BLOCK1	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
