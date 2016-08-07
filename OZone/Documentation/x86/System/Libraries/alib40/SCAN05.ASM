	page	66,132
;******************************* SCAN05.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc

	extrn	strlen1:far
	extrn	dos_mem_allocate:far
	extrn	dos_mem_release:far
.list
;----------------------------------------------------------------------------
; data needed by SCAN_BLOCK routines
;
LARGENUM	= 255
MAXPATLEN	= 254

data_area	struc
iPatLen		dw ?
aiPatStart	db MAXPATLEN dup (?)
piPatCurr	dw ?
aiDelta1	db 256 dup (?)
;
; variables used by Check_tail
;
pchSaveTrgCurr	dw	?
iSaveTrgLen	dw	?
;
; variables used by search
;
pchTrgSave	dw	?
pchTrgStart	dw	?
data_area	ends

our_data_seg	dw	0

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
;SCAN_BLOCK_FOPEN - initialize fast scan of sequential buffers
;  input:  ds:si = points at string to search for (max length 254)
;             dl = 0 for match case, 20h for match either case
;
;  output:    ax = 0 if sucessful,  1 if error
;             possible errors are: - string length too long or zero bytes.
;                                  - insufficient memory
;
;  Note:  The fast block scan functions need to be called as follows:
;            SCAN_BLOCK_FOPEN  - allocate memory, initialize tables for scan
;            SCAN_BLOCK_FAST   - actual scan operation, call repeatedly
;            SCAN_BLOCK_FCLOSE - release memory allocated by SCAN_BLOCK_FOPEN
;
;         See SCAN_BLOCK_FAST and SCAN_BLOCK_FCLOSE
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_BLOCK_FOPEN
SCAN_BLOCK_FOPEN	PROC	FAR
	apush	bx,cx,dx,si,di,es
	cld
	push	dx
	mov	dx,0
	mov	ax,size data_area
	call	dos_mem_allocate
	pop	dx
	jc	md1_abort	;jmp if insufficient memory
	mov	cs:our_data_seg,es
;
; determine compare string length
;
	call	strlen1
	jcxz	md1_abort	;jmp if zero length compare string
	cmp	cx,MAXPATLEN
	ja	md1_abort	;jmp if string too long
	mov	es:iPatLen,cx
;
; fill aiDelta1 table with length of compare string
;
	mov	ah, cl
	mov	al, cl
	mov	cx, 256 / 2
	mov	di, offset aiDelta1
	rep	stosw

;For each character 'x' in the pattern string, set aiDelta1['x']
;with the distance that 'x' is away from the end of the pattern string.
;If 'x' occurs more than once, use the smallest distance (which
;  is already built in to the algorithm).
;If 'x' is the last character in the pattern string, use
;  LARGENUM instead of 0.
;For case insensitivity, aiDelta1['x'] = aiDelta1['X'].
;Example: if the pattern string is 'Kitty' and DL = 20h, then
;  aiDelta1['k'] = aiDelta1['K'] = 4
;  aiDelta1['i'] = aiDelta1['I'] = 3
;  aiDelta1['t'] = aiDelta1['T'] = 1 (the 2nd 't' overwrites 2)
;  aiDelta1['y'] = aiDelta1['Y'] = LARGENUM
;  all other entries (i.e. those entries of aiDelta1['x'] where
;  'x' in not in the pattern string) have a distance of 5

		mov	cl, al
		sub	bh, bh
md1_loop2:	dec	al
		jnz	md1_skip1
		mov	al, LARGENUM
md1_skip1:	mov	bl, [ds:si]
		inc	si
		mov	[es:aiDelta1 + bx], al
		mov	ah, bl
		or	ah, dl
		sub	ah, 'a'
		cmp	ah, 'z' - 'a' + 1
		jnc	md1_skip2
		xor	bl, dl
		mov	[es:aiDelta1 + bx], al
md1_skip2:	loop	md1_loop2

;Convert the pattern string into distances, using the aiDelta1
;  table (aiPatStart[i] = aiDelta1[pchPatStart[i]]).  This
;  speeds up the search routine later.

		mov	cx, [es:iPatLen]
		sub	si,cx
		mov	di, offset aiPatStart
md1_loop3:	mov	bl, [ds:si]
		mov	bl, [es:aiDelta1 + bx]
		mov	[es:di], bl
		inc	di
		inc	si
		loop	md1_loop3
		mov	byte ptr [es:si], 00h

;Start at the beginning of the pattern string.

		mov	[es:piPatCurr], offset aiPatStart

		sub	ax, ax		; return okay
md1_exit:	apop	es,di,si,dx,cx,bx
		retf

md1_abort:	mov	ax, 0001h	; return error
		jmp	md1_exit
SCAN_BLOCK_FOPEN	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
;SCAN_BLOCK_FCLOSE - terminate fast scan sequential buffers
;  inputs:  none
;  outputs: none
; 
;  See SCAN_BLOCK_FOPEN and SCAN_BLOCK_FAST
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_BLOCK_FCLOSE
SCAN_BLOCK_FCLOSE	PROC	FAR
	push	es
	mov	es,cs:our_data_seg
	call	dos_mem_release
	pop	es
	retf
SCAN_BLOCK_FCLOSE	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
;SCAN_BLOCK_FAST - fast scan of sequential buffers for string
;  inputs:  ds:si = points at block of data to be scanned
;              cx = block length (byte count)
;
;  output:  ds:si = points at remaining data to be scanned
;              cx = number of bytes remaining to be scanned
;              ax = 0 for match found (may be match split between two blocks)
;                   1 for end of block, no match.
;
;  note:  SCAN_BLOCK_FAST can find multiple matches in a buffer, and
;         automatically sets up inputs to be re-entered.  Matches split
;         across two buffers (blocks) are also handled.
;
;         SCAN_BLOCK_FAST can be called repeatedly as long as the compare
;         string is not changed.  If the compare string changes, then
;         SCAN_BLOCK_FCLOSE must be called, followed by SCAN_BLOCK_FOPEN.
;
;                            code size   speed
;         SCAN_BLOCK_TINY1    46 bytes    2.36 (small is faster)
;         SCAN_BLOCK_TINY2    69 bytes   13.35 (matches ether case)
;         SCAN_BLOCK1         43 bytes    2.36
;         SCAN_BLOCK2        152 bytes    6.37 (matches either case)
;         SCAN_BLOCK_FAST    466 bytes    1.42 
;
;         See also SCAN_BLOCK_FOPEN and SCAN_BLOCK_FCLOSE
;
;  Example:      mov   ds, seg pattern
;                mov   si, offset pattern
;                mov   dl, 20h
;                call  SCAN_BLOCK_FOPEN
;                test  ax, ax
;                jnz   error
;
;                 mov   ds, seg target
;        read_loop:
;                 mov   si, offset target
;                 (setup ds,si,cx here for SCAN_BLOCK_FAST call)
;                 (if last buffer then goto to done)
;        search_loop:
;                 call  SCAN_BLOCK_FAST
;                 test  ax, ax
;                 jz    read_loop
;                 (process match found here, ds:si point at end of match)
;                 jcxz  read_loop
;                 jmp   search_loop
;
;          done:  call   SCAN_BLOCK_FCLOSE
;
; Credits:  This code origionally provided by Mike Levis and modified
;           by Jeff Owens
;* * * * * * * * * * * * * *


cx_iTrgLen	equ cx
dx_iPatLen1	equ dx
dx_piSavePatCurr equ dx
si_pchTrgCurr	equ si
di_piPatCurr	equ di
bp_pchTrgEnd	equ bp


	PUBLIC	SCAN_BLOCK_FAST
SCAN_BLOCK_FAST	PROC	FAR
		apush	bx,dx,di,bp,es
		mov	es,cs:our_data_seg

		sub	bh, bh
		mov	di_piPatCurr, [es:piPatCurr]

;get length of pattern string (may be partial match)

		mov	dx_iPatLen1, [es:iPatLen]
		add	dx_iPatLen1, offset aiPatStart
		sub	dx_iPatLen1, di_piPatCurr

;get address of target string end

		mov	bp_pchTrgEnd, si_pchTrgCurr
		add	bp_pchTrgEnd, cx_iTrgLen

; if (iPatLen1 > iTrgLen) then no possible match

		cmp	dx_iPatLen1, cx_iTrgLen
		ja	s_no_match

		mov	[es:pchTrgStart], si_pchTrgCurr

;use brute force if partial match is in progress

		cmp	dx_iPatLen1, [es:iPatLen]
		jne	s_slow

;Jump over characters in target string that are not in the
;  pattern string, and/or jump to the character in the target
;  string that is the same as the last chacter of the pattern
;  string.

s_fast:		mov	bl, [si_pchTrgCurr]
		mov	bl, [es:aiDelta1 + bx]
                cmp	bl, LARGENUM          
                je	s_fast_end            
                add	si_pchTrgCurr, bx     
                jc	s_no_match            
                cmp	si_pchTrgCurr, bp_pchTrgEnd
                jb	s_fast                     
                jmp	s_no_match                
s_fast_end:
		inc	si_pchTrgCurr             
		mov	[es:pchTrgSave], si_pchTrgCurr
		sub	si_pchTrgCurr, dx_iPatLen1

; if (pchTrgCurr < pchTrgStart) {pchTrgCurr += iPatLen1;   goto fast;}

		cmp	si_pchTrgCurr, [es:pchTrgStart]
		jnb	s_slow
		add	si_pchTrgCurr, dx_iPatLen1
		jmp	s_fast

;Do a char-by-char comparison of the target string with the pattern string.

s_slow:		mov	bl, [si_pchTrgCurr]
		mov	al, [es:aiDelta1 + bx]
		mov	bl, [es:di_piPatCurr]
		cmp	al, bl
		jne	s_skip1
		inc	si_pchTrgCurr
		inc	di_piPatCurr
		dec	dx_iPatLen1
		jnz	s_slow
		jmp	s_match
s_skip1:

;Since the pattern has not been found in the target string yet,
;  adjust target string index to look for the next match
;  ("pchTrgSave + 2" is needed to avoid backsliding)

		add	si_pchTrgCurr, dx_iPatLen1
		cmp	al, LARGENUM
		je	s_skip2a
		cmp	si_pchTrgCurr, [es:pchTrgSave]
		jnb	s_skip2b
s_skip2a:	mov	si_pchTrgCurr, [es:pchTrgSave]
		add	si_pchTrgCurr, 0002h
s_skip2b:

;Check to see if there are more characters in the target string

		cmp	si_pchTrgCurr, bp_pchTrgend
		jnbe	s_skip3
		mov	dx_iPatLen1, [es:iPatLen]
		mov	di_piPatCurr, offset aiPatStart
		jmp	s_fast
s_skip3:

s_no_match:	mov	ax, 0001h
		jcxz	s_null_string
		call	CheckTail
		sub	cx_iTrgLen, cx_iTrgLen
		jmp	short s_exit

s_null_string:  mov	[es:piPatCurr], di_piPatCurr
		jmp	short s_exit

s_match:	sub	cx_iTrgLen, si_pchTrgCurr
		add	cx_iTrgLen, [es:pchTrgStart]
		mov	[es:piPatCurr], offset aiPatStart
		sub	ax, ax

s_exit:		apop	es,bp,di,dx,bx
		retf
SCAN_BLOCK_FAST	ENDP
;====================================================================
;  CheckTail
;    Called only by Search to look for partial matches at the tail end
;    of the target string, using a brute force variation.
;    Essential, this routine scans the target string tail to get
;    characters that are in the pattern string, and then uses the brute
;    force method on them.

CheckTail	proc	near

		mov	ax, dx_iPatLen1
		mov	dx_piSavePatCurr, di_piPatCurr
		dec	ax

; if (iTrgLen > iPatLen1 - 1)
;    iTrgLen = iPatLen1 - 1;
; iSaveTrgLen = iTrgLen;

		cmp	cx_iTrgLen, ax
		jbe	ct_skip1
		mov	cx_iTrgLen, ax
ct_skip1:	mov	ax, [es:iPatLen]
		mov	ah, cl

		lea	si_pchTrgCurr, [bp_pchTrgEnd - 1]

; while (iPatLen != aiDelta1[*pchTrgCurr] && iTrgLen --)  pchTrgCurr ++;

ct_loop1:	mov	bl, [si_pchTrgCurr]
		mov	bl, [es:aiDelta1 + bx]
		cmp	al, bl
		je	ct_skip2
		dec	si_pchTrgCurr
		loop	ct_loop1

; pchTrgCurr ++; if (pchTrgCurr == pchTrgEnd)
;    goto no_match;

ct_skip2:	inc	si_pchTrgCurr
		cmp	si_pchTrgCurr, bp_pchTrgEnd
		je	ct_no_match

; iTrgLen = iSaveTmpLen - iTrgLen;

		mov	al, ah
		neg	cx_iTrgLen
		sub	ah, ah
		add	cx_iTrgLen, ax

ct_loop2:	mov	[es:iSaveTrgLen], cx_iTrgLen
		mov	[es:pchSaveTrgCurr], si_pchTrgCurr

;    while (aiDelta1[*pchTrgCurr++] == *piPatCurr++ && iTrgLen--)
;    if (aiDelta1[*(pchTrgCurr - 1)] == *(piPatCurr - 1))
;       goto match

ct_loop3:	mov	bl, [si_pchTrgCurr]
		mov	al, [es:aiDelta1 + bx]
		mov	bl, [es:di_piPatCurr]
		inc	si_pchTrgCurr
		inc	di_piPatCurr
		cmp	al, bl
		loope	ct_loop3
		je	ct_match

;    piPatCurr = piSavePatCurr
;    pchTrgCurr = pchSaveTrgCurr + 1
;    iTrgLen = iSaveTrgLen
; } while (iTrgLen --);

		mov	di_piPatCurr, dx_piSavePatCurr
		mov	si_pchTrgCurr, [es:pchSaveTrgCurr]
		mov	cx_iTrgLen, [es:iSaveTrgLen]
		inc	si_pchTrgCurr
		loop	ct_loop2

ct_no_match:	mov	ax, 0001h
		mov	[es:piPatCurr], offset aiPatStart
		jmp	ct_exit

ct_match:	mov	[es:piPatCurr], di_piPatCurr
		cmp	si_pchTrgCurr, bp_pchTrgEnd
		sbb	ax, ax
		inc	ax

ct_exit:	mov	si_pchTrgCurr, bp_pchTrgEnd
		ret
CheckTail	endp

LIBSEG	ENDS
;;	end
