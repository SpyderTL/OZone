	page	66,132
;******************************* SCAN02.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
;SCAN_BLOCK_TINY2 - scan sequential buffers for string, matching either case
;  inputs:  es:bx   =   compare string start (string terminated with zero)
;           es:di   =   compare string current location
;           ds:si   =   buffer current location
;              cx   =   buffer size (remaining byte count)
;           direction flag = CLD state
;
;  output:  registers di,si,cx are updated
;           if ah=0 then a match was found ds:si points at match end.
;                 use -si- and -cx- as returned to continue searching
;                 in current buffer.
;
;           if cx=0 then no match was found, check if bx=di to determine
;                   if a partial match is in process at buffer end.
;
;  Note:  If a partial match fails and the partial match was split
;         accross two buffers, then extra processing may be needed
;         by the caller to restart the compare in the first buffer.
;
;                            code size   speed
;         SCAN_BLOCK_TINY1    46 bytes    2.36 (small is faster)
;         SCAN_BLOCK_TINY2    69 bytes   13.35 (matches ether case)
;         SCAN_BLOCK1         43 bytes    2.36
;         SCAN_BLOCK2        152 bytes    6.37 (matches either case)
;         SCAN_BLOCK_FAST    466 bytes    1.42 
;
;* * * * * * * * * * * * * *

	PUBLIC	SCAN_BLOCK_TINY2
SCAN_BLOCK_TINY2	PROC	FAR
	mov	dl,20h
        push	bp
sb_lp0: mov	ah,es:[di]	;get first char. of compare string
sb_lp1: jcxz	at_eof		;jmp if buffer empty
	call	compare		;compare first char
	jne	sb_lp1		;loop if no match
	mov	bp,si		;save start of possible match
sb_lp2: inc	di		;move to next compare string char.
	mov	ah,es:[di]	;get next compare string char.
	cmp	ah,0		;end of compare string?
	je	match		;jmp if all characters match
	jcxz	at_eof		;jmp if at end of buffer
	call	compare		;compare next char.
	je	sb_lp2		;jmp if match
	
	add	cx,si		;compute cx to restart search
	sub	cx,bp
	
	mov	si,bp		;get buffer ptr to restart search
	mov	di,bx		;get compare string start
	jmp	sb_lp0		;go restart search
match:	mov	di,bx		;set compare string ptr to start.
at_eof: pop	bp
	retf
SCAN_BLOCK_TINY2	ENDP
;
; compare character in -ah- to next char. in buffer.
;  inputs:    ah = compare string char.
;          ds:si = buffer ptr
;             cx = amount of data left in buffer
;             dl = case flag
;
compare:   lodsb			;get next char. from buffer
	   dec	   cx			;update count of buffer char's
	   cmp	   al, ah		;match?
	   je	   bye			;jmp if match
	   mov	   dh, al		;try matching other
	   or	   dh, dl		;  case if char
           sub     dh, 'a'		;     is an alpha
           cmp     dh, 'z' - 'a' + 1
	   jnc	   not_alpha
	   xor	  al,dl
not_alpha: cmp	al, ah
bye:	   ret
;------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
