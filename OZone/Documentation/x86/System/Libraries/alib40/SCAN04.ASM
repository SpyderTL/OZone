	page	66,132
;******************************* SCAN04.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
;SCAN_BLOCK2 - scan sequential buffers for string, match either case
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

other_case	db	0	;other case of first search char.

	PUBLIC	SCAN_BLOCK2
SCAN_BLOCK2	PROC	FAR
        apush	bp,dx
        mov	dl,20h
        mov	ah,es:[di]	;get first cmp string char
        cmp	ah,'A'
        jb	sb_3		;jmp if not alpha
	cmp	ah,'Z'
	jb	sb_1		;jmp if is lower
	cmp	ah,'a'
	jb	sb_3		;jmp if not alpha
	cmp	ah,'z'
	ja	sb_3		;jmp if not alpha
	xor	ah,dl		;make lower case
	jmp	sb_3
	
sb_1:	or	ah,dl		;make lower case
sb_3:	mov	cs:other_case,ah        
sb_lp0: mov	ah,es:[di]
        mov     dh,cs:other_case
;
; ah,dh = upper and lower case compare characters
; 
fast_lp:lodsb
	dec	cx
	cmp	al,dh
	je	sb_6
	cmp	al,ah
	je	sb_6
	jcxz	at_eof

	lodsb
	dec	cx
	cmp	al,dh
	je	sb_6
	cmp	al,ah
	je	sb_6
	jcxz	at_eof

	lodsb
	dec	cx
	cmp	al,dh
	je	sb_6
	cmp	al,ah
	je	sb_6
	jcxz	at_eof

	lodsb
	dec	cx
	cmp	al,dh
	je	sb_6
	cmp	al,ah
	je	sb_6
	jcxz	at_eof
        jmp	fast_lp
	
sb_6:	mov	bp,si
sb_lp2: inc	di
	mov	ah,es:[di]
	cmp	ah,0
	je	match
	jcxz	at_eof

           lodsb
           dec     cx
	   cmp	   al, ah
	   je	   @@bye
	   mov	   dh, al
	   or	   dh, dl
           sub     dh, 'a'
           cmp     dh, 'z' - 'a' + 1
	   jnc	   @@not_alpha
	   xor	   al,dl
@@not_alpha:
	cmp	al, ah
@@bye:
	je	sb_lp2
	
	add	cx,si
	sub	cx,bp
	
	mov	si,bp
	mov	di,bx
	jmp	sb_lp0
match:	mov	di,bx
at_eof: apop	dx,bp
	retf
SCAN_BLOCK2	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
