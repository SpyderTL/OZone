	page	66,132
;******************************** SCAN16.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
BUFFER_SEARCH - search string1 for the first occurance of string2
;
; inputs:    ES:[DI] pointing to string1
;            DS:[SI] pointing to string2
;            
; output:    if no carry - DI = offset of target in source string.
;            if carry -  no match
;
; note:  case is ignored.  Strings must end with null character (zero).
;* * * * * * * * * * * * * *

	PUBLIC	BUFFER_SEARCH
BUFFER_SEARCH	PROC	FAR
	APUSH   AX,BX,CX,DX,SI
;
; scan for length of string  -> cx
;
	push	di
	xor	al,al
	mov	cx,-1
	repnz	scasb
	not	cx
	dec	cx
	pop	di
	jmp	first_char_scan
BUFFER_SEARCH	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
BUFFER_SEACHC - search a buffer for the first occurance of a string
;                     
; inputs:    ES:[DI] pointing to buffer
;            DS:[SI] pointing to match-string.
;                cx = length of buffer
;
; output:    if no carry - DI = offset of target in source string.
;            if carry    - no match
;
; note:  case is ignored.  Match string in DS:SI must end with zero.
;* * * * * * * * * * * * * *

	public	buffer_searchc
BUFFER_SEARCHC	PROC	FAR	
	APUSH   ax,BX,CX,DX,SI
;
; in the following loop, the long-string ptr moves only (es:di)
;	
first_char_scan:
	mov	ah,byte ptr [si]	;get short-string char
	mov	al,byte ptr es:[di]	;get long_string char.
;
; convert -al- long_string to lower case
;
	cmp	al,'A'
	jb	bs_1			;jmp if not alpha
	cmp	al,'Z'
	ja	bs_1			;jmp if not alpha
	or	al,20h			;convert to lower
	cmp	ah,al			;compare strings
	je	match1			;jmp if match
;
; convert -al- long_string to upper case and try again
;
	and	al,0dfh			;convert to upper case
bs_1:	cmp	ah,al
	je	match1			;jmp if match	
;
; this long-string char does not match, move to next long string char
;
first_char_scan_cont:
	inc	di
	loop	first_char_scan
	jmp	str_not_found
;
; the first char matches. ds:si=short string ptr   es:di=long string ptr
;
match1:
	push	si
	push	di
match_lp:	
	inc	si
	mov	ah,byte ptr ds:[si]	;get next short string char
	inc	di			;move to next long string char
	mov	al,byte ptr es:[di]	;get long_string char.
	cmp	ah,0
	je	str_found		;jmp if we have a match
	cmp	al,0
	je	str_not_found2		;jmp if char not found
;
; convert -al- long_string to lower case
;
	cmp	al,'A'
	jb	bs_2			;jmp if not alpha
	cmp	al,'Z'
	ja	bs_2			;jmp if not alpha
	or	al,20h			;convert to lower
	cmp	ah,al			;compare strings
	je	match_lp		;jmp if match
;
; convert -al- long_string to upper case and try again
;
	and	al,0dfh			;convert to upper case
bs_2:	cmp	ah,al
	je	match_lp		;jmp if match
str_not_found2:
	pop	di
	pop	si
	jmp	first_char_scan_cont
	
str_not_found:	
	stc
	jmp	bs__exit	
str_found:
	pop	di			;put offset of match in -ax-
	pop	si
	clc
bs__exit:		
	APOP    SI,DX,CX,BX,AX
        RETF
BUFFER_SEARCHC ENDP

LIBSEG	ENDS
	end
