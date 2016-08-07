	page	66,132
;******************************* COMPAR4.ASM ********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( COMPARE )
;COMPARE4 - compare strings -cx- long, use case, registers unchanged
;
; inputs:   DS:[SI] = address of string1
;           ES:[DI] = address of string2
;               cx  = length of compare in bytes
; 
; output:   if match     - flags are in "je" state
;           if different - flags are in "jne" state
;
;* * * * * * * * * * * * * *

	PUBLIC	COMPARE4
COMPARE4	PROC	FAR
	cld
	apush	cx,si,di
	repe	cmpsb
	apop	di,si,cx
	retf
COMPARE4	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
