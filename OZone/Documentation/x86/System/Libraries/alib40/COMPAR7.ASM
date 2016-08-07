	page	66,132
;******************************* COMPAR7.ASM ********************************

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
;COMPARE7 - compare strings -cx- long, either case, registers updated
;
; inputs:   DS:[SI] = address of string1
;           ES:[DI] = address of string2
;               cx  = length of compare
; 
; output:   if match  - si & di point at end of strings
;                     - cx = zero
;                     - flags are in "je" state
;           if different - si & di point one byte past the mismatch.
;                        - cx = number of bytes remaining to compare
;                        - flags are in "jne" state
;* * * * * * * * * * * * * *

	PUBLIC	COMPARE7
COMPARE7	PROC	FAR
	call	compare_strings
	retf
COMPARE7	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
