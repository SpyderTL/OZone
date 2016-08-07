	page	66,132
;******************************** SCAN14.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	scan_last_char3:far
	extrn	compare1:far
.list
;----------------------------------------------------------------------------
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
SCAN_LAST_STR1 -  find last match of string in buffer, case match
;
; inputs:    ES:[DI] pointing to area to be searched
;                CX  length of search area
;            DS:[SI] pointing to asciiz match string.
;            
; output:    if flags set to "je"  ES:[DI+1] = offset of match
;            if carry - no match
;            registers cx,si modified
;            
; note:      case of strings must also match.
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_LAST_STR1
SCAN_LAST_STR1	PROC	FAR
	lodsb
sls_lp:	call	scan_last_char3		;find last char
	jne	sls_exit		;jmp if char not found
	apush	cx,si,di
	add	di,2
	sub	cx,2
	call	compare1
	apop	di,si,cx
	jcxz	sls_exit		;jmp if no more data
	jne	sls_lp			;jmp if no match	
sls_exit:
	retf
SCAN_LAST_STR1	ENDP

LIBSEG	ENDS
	end
