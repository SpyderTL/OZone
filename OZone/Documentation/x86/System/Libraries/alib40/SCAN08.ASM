	page	66,132
;******************************* SCAN08.ASM *********************************

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
;SCAN_CHAR3 - scan  buffer for character, case match
;  inputs:    al = character
;          es:di = string buffer, terminated with zero char.
;             cx = buffer length
;           
;  output: if flag set to "je" then match found
;                  es:di = pointer one char past match point
;                     cx = amount of data remaining to be searched
;          if flag set to "jne" then no match found
;                  es:di = pointer past end of buffer
;                     cx = zero
;* * * * * * * * * * * * * *


	PUBLIC	SCAN_CHAR3
SCAN_CHAR3	PROC	FAR
	repne	scasb
	retf	
SCAN_CHAR3	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
;;	end
