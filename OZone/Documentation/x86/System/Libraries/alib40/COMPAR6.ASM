	page	66,132
;******************************* COMPAR6.ASM ********************************

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
;COMPARE6 - compare asciiz strings, either case, registers unchanged
;
; inputs:   DS:[SI] = address of string1
;           ES:[DI] = address of string2
; 
; output:   if compare ok,  flag "je" set
;           if compare bad, flag "jne" set
;* * * * * * * * * * * * * *

	PUBLIC	COMPARE6
COMPARE6	PROC	FAR
	apush	ax,cx,si,di
	mov	cx,-1
	call	compare_strings
	apop	di,si,cx,ax
	retf
COMPARE6	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
