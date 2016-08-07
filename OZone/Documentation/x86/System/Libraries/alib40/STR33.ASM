	page	66,132
;******************************** STR33.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	strlen1:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_COPY - copy a string to existing buffer
;
; inputs:    DS:[SI] pointing to string
;            ES:[DI] pointing to destination buffer
;            
; output:    CX = string length
;
; note:      The string's terminating NUL byte is also copied.
;* * * * * * * * * * * * * *

	PUBLIC	STR_COPY
STR_COPY	PROC	FAR
    CALL    strlen1
    APUSH   CX,SI,DI
    CLD
    REPZ    MOVSB
            movsb                  ;move zero byte
    APOP    DI,SI,CX
    retf
STR_COPY	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  STRING )
STR_COPYC - copy CX bytes to an existing buffer
;
; inputs:    DS:[SI] pointing to ASCII string
;            ES:[DI] pointing to destination buffer
;            CX = number of bytes to copy
;
; output:    nothing
;
; note:      The string's terminating NUL byte is NOT copied.
;* * * * * * * * * * * * * *

	PUBLIC	STR_COPYC
STR_COPYC	PROC	FAR
    APUSH   CX,SI,DI
    CLD
    REPZ    MOVSB
    APOP    DI,SI,CX
    RETF
STR_COPYC ENDP

LIBSEG	ENDS
	end
