	page	66,132
;******************************* COMPAR1.ASM ********************************

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
;COMPARE1 - compare asciiz strings, use case, update registers
;
; inputs:   DS:[SI] = address of string1, must end with a zero char.
;           ES:[DI] = address of string2
; 
; output:   if match  - si & di point at end of strings
;                     - flags are in "je" state
;           if different - si & di point one byte past the mismatch.
;                        - flags are in "jne" state
;* * * * * * * * * * * * * *

	PUBLIC	COMPARE1
COMPARE1	PROC	FAR
	cld
	push	cx
	call	strlen1			;find length of string1
	repe	cmpsb
	pop	cx
	retf
COMPARE1	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
