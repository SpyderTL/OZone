	page	66,132
;******************************* SCAN12.ASM *********************************

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
;SCAN_LAST_CHAR3 - scan  buffer for last char match, case match
;  inputs: es:di = asciiz string
;             al = character to search for
;             cx = buffer length
;
;  output:  registers di,cx are updated
;           if flags in "je" state then match was found at es:[di]
;
;           if flags in 'jne' state then no match was found
;                  cx=0 and es:di point at start of buffer
;           direction flag = CLD state
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_LAST_CHAR3
SCAN_LAST_CHAR3	PROC	FAR
	std
	add	di,cx
	repne	scasb
	jcxz	sl3
	inc	di
sl3:	cld
	retf	
SCAN_LAST_CHAR3	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
