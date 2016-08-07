	page	66,132
;******************************* COMPAR3.ASM ********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( COMPARE )
;COMPARE3 - compare strings -cx- long, use case, update registers
;
; inputs:   DS:[SI] = address of string1
;           ES:[DI] = address of string2
;               CX  = length of compare
; 
; output:   if match  - si & di point at end of strings
;                     - cx = zero
;                     - flags are in "je" state
;           if different - si & di point one byte past the mismatch.
;                        - cx = number of bytes remaining to compare
;                        - flags are in "jne" state
;
;* * * * * * * * * * * * * *

	PUBLIC	COMPARE3
COMPARE3	PROC	FAR
	cld
	repe	cmpsb
	retf
COMPARE3	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
