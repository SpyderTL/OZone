	page	66,132
;******************************* SCAN10.ASM *********************************

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
;SCAN_LAST_CHAR1 - scan asciiz string for last match, case match
;  inputs: es:di = asciiz string
;             al = character to search for
;
;  output:  registers di,cx are updated
;           if flags in "je" state then match was found at es:[di+1]
;
;           if flags in 'jne' state then no match was found
;                  cx=0 and es:di point at start of buffer
;           direction flag = CLD state
;
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_LAST_CHAR1
SCAN_LAST_CHAR1	PROC	FAR
	push	ds
	push	es
	pop	ds
	call	strlen2
	pop	ds

	std
	add	di,cx
	dec	di
	repne	scasb
	cld
	retf
SCAN_LAST_CHAR1	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
