	page	66,132
;******************************* COMPAR8.ASM ********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	compare_strings:near
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( COMPARE )
;COMPARE8 - compare strings -cx- long, either case, registers unchanged
;
; inputs:   DS:[SI] = address of string1
;           ES:[DI] = address of string2
;               cx  = length of compare
; 
; output:   if match     - flags are in "je" state
;           if different - flags are in "jne" state
;
;* * * * * * * * * * * * * *

	PUBLIC	COMPARE8
COMPARE8	PROC	FAR
	apush	ax,cx,si,di
	call	compare_strings
	apop	di,si,cx,ax
	retf
COMPARE8	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
