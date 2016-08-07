	page	66,132
;******************************** STR19.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_LOWER - changes bytes of a string to lower case
;
; inputs:    DS:[SI] = address of an ASCIIZ string
; 
; output:    nothing
;* * * * * * * * * * * * * *

	PUBLIC	STR_LOWER
STR_LOWER	PROC	FAR
	apush	ax,si
	cld
stl_lp:	lodsb
	cmp	al,0
	je	stl_exit
	cmp	al,'A'
	jb	stl_lp
	cmp	al,'Z'
	ja	stl_lp
	add	byte ptr [si-1],20h		;convert to lower case
	jmp	stl_lp
stl_exit:
	apop	si,ax
	retf	
STR_LOWER	ENDP

LIBSEG	ENDS
	end
