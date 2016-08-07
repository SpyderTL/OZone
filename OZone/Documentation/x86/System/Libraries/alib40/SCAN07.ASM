	page	66,132
;******************************* SCAN07.ASM *********************************

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
;SCAN_CHAR2 - scan asciiz buffer for character, match either case
;  inputs:    dl = character
;          ds:si = string buffer, terminated with zero char.
;           
;  output: if flag set to "je" then match found
;                  ds:si = pointer one char past match point
;                     cx = amount of data remaining to be searched
;          if flag set to "jne" then no match found
;                  ds:si = pointer past end of buffer
;                     cx = zero
;           register -ax- modified
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_CHAR2
SCAN_CHAR2	PROC	FAR
	push	dx
	mov     dh,dl
	mov	ah, dl		;try matching other
	or	ah, 20h		;  case if char
        sub     ah, 'a'		;     is an alpha
        cmp     ah, 'z' - 'a' + 1
	jnc	not_alpha
	xor	dh,20h
not_alpha:
	call	strlen1		;returns cx=length 
lp1:	lodsb
	cmp	al,dl
	je	c2_exit		;jmp if match
	cmp	al,dh
	je	c2_exit		;jmp if match
	loop	lp1
c2_exit:	
	pop	dx
	retf	
SCAN_CHAR2	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
