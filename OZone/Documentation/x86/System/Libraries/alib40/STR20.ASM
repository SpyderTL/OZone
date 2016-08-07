	page	66,132
;******************************** STR20.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_LOWERC -  changes n bytes of a string to lower case
;
; inputs:    DS:[SI] = address of an ASCIIZ string
;            CX = number of bytes
;            
; output:    nothing
;* * * * * * * * * * * * * *

	PUBLIC	STR_LOWERC
STR_LOWERC	PROC	FAR
	apush	ax,cx,si
	jcxz	stlc_exit	;jmp if null string
	cld
stlc_lp:lodsb
	cmp	al,'A'
	jb	stlc_next
	cmp	al,'Z'
	ja	stlc_next
	add	byte ptr ds:[si-1],20h	;convert to lower case
stlc_next:
	loop	stlc_lp
stlc_exit:
	apop	si,cx,ax
	retf		
STR_LOWERC ENDP

LIBSEG	ENDS
	end
