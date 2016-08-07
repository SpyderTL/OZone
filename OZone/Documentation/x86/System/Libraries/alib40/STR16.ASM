	page	66,132
;******************************** STR16.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_UPPER - changes string to upper case
;
; inputs:    DS:[SI] pointing to string
; 
; output:    nothing
;* * * * * * * * * * * * * *

	PUBLIC	STR_UPPER
STR_UPPER	PROC	FAR
	apush	ax,si
su_lp1:	lodsb
	cmp	al,0
	je	su_exit			;jmp if end of string
	cmp	al,'a'
	jb	su_lp1			;jmp if char out of range
	cmp	al,'z'
	ja	su_lp1			;jmp if char out of range
	sub	byte ptr [si-1],20h	;convert to upper case
	jmp	su_lp1
su_exit:apop	si,ax
	retf	
STR_UPPER	ENDP

LIBSEG	ENDS
	end
