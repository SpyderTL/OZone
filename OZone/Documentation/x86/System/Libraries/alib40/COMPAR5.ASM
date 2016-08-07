	page	66,132
;******************************* COMPAR5.ASM ********************************

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
;COMPARE5 - compare asciiz strings, either case, update registers
;
; inputs:   DS:[SI] = address of string1, must end with a zero char.
;           ES:[DI] = address of string2
; 
; output:   if match  - si & di point at end of strings
;                     - flags are in "je" state
;           if different - si & di point one byte past the mismatch.
;                        - flags are in "jne" state
;* * * * * * * * * * * * * *

	PUBLIC	COMPARE5
COMPARE5	PROC	FAR
	apush	ax,cx
	mov	cx,-1
	call	compare_strings
	apop	cx,ax
	retf
COMPARE5	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
