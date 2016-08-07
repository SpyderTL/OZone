	page	66,132
;******************************** STR17.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_UPPERC:  changes n-length string to upper case
;
; inputs:    DS:[SI] pointing to string
;            CX = number of bytes in string
;            
; output:    nothing
;* * * * * * * * * * * * * *

	PUBLIC	STR_UPPERC
STR_UPPERC	PROC	FAR
	apush	ax,cx,si
	jcxz	stu_exit		;jmp if null string
stu_lp:	lodsb
	cmp	al,'a'
	jb	stu_next		;jmp if char out of range
	cmp	al,'z'
	ja	stu_next
	sub	byte ptr [si-1],20h	;convert to upper case
stu_next:
	loop	stu_lp
stu_exit:	
	apop	si,cx,ax
	retf
STR_UPPERC ENDP

LIBSEG	ENDS
	end
