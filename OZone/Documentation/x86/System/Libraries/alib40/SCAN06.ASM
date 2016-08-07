	page	66,132
;******************************* SCAN06.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	strlen2:far
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
;SCAN_CHAR1 - scan asciiz buffer for character, case match
;  inputs:    al = character
;          es:di = string buffer, terminated with zero char.
;           
;  output: if flag set to "je" then match found
;                  es:di = pointer one char past match point
;                     cx = amount of data remaining to be searched
;          if flag set to "jne" then no match found
;                  es:di = pointer past end of buffer
;                     cx = zero
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_CHAR1
SCAN_CHAR1	PROC	FAR
	apush	ds,ax
	mov	ax,es
	mov	ds,ax
	call	strlen2		;returns cx=length 
	pop	ax
	repne	scasb
	pop	ds
	retf	
SCAN_CHAR1	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
