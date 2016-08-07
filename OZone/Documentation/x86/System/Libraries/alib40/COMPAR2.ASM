	page	66,132
;******************************* COMPAR2.ASM ********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	strlen1:far
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( COMPARE )
;COMPARE2 - compare asciiz strings, use case, registers unchanged.
;
; inputs:   DS:[SI] = address of string1, must end with zero char.
;           ES:[DI] = address of string2
; 
; output:   if match     - flags are in "je" state
;           if different - flags are in "jne" state
;* * * * * * * * * * * * * *

	PUBLIC	COMPARE2
COMPARE2	PROC	FAR
	cld
	apush	cx,si,di
	call	strlen1			;find length of string1
	repe	cmpsb
	apop	di,si,cx
	retf
COMPARE2	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
