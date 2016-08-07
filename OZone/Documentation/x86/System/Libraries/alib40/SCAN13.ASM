	page	66,132
;******************************* SCAN13.ASM *********************************

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
;SCAN_LAST_CHAR4 - scan buffer for last char match, match either case
;  inputs:    dl = character
;          ds:si = string buffer, terminated with zero char.
;             cx = buffer length
;           
;  output: if flag set to "je" then match found
;                  ds:si = pointer one char past match point
;                     cx = amount of data remaining to be searched
;          if flag set to "jne" then no match found
;                  ds:si = pointer past end of buffer
;                     cx = zero
;           register -ax- modified
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_LAST_CHAR4
SCAN_LAST_CHAR4	PROC	FAR
	push	dx
	mov     dh,dl
	mov	ah, dl		;try matching other
	or	ah, 20h		;  case if char
        sub     ah, 'a'		;     is an alpha
        cmp     ah, 'z' - 'a' + 1
	jnc	not_alpha
	xor	dh,20h
not_alpha:
	add	si,cx
	std
lp1:	lodsb
	cmp	al,dl
	je	c4_exit		;jmp if match
	cmp	al,dh
	je	c4_exit		;jmp if match
	loop	lp1
c4_exit:pop	dx
	cld
	retf	
SCAN_LAST_CHAR4	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
