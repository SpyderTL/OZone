	page	66,132
;******************************** DISK4.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
FILE_FLUSH - flushes the DOS output buffer for specified handle
;
; inputs:    BX = file handle
;            flushing the buffer guards against data loss in case power
;            outages.
;            
; output:    if CF = 0, no error; function successful
;            if CF = 1, AX = DOS error code
;* * * * * * * * * * * * * *

	public	FILE_FLUSH
FILE_FLUSH	PROC	FAR
   PUSH    BX
   MOV	   AH,45h		;duplicate file handle
   INT     21h
   JB      FF_EXIT
   MOV     BX,AX
   MOV	   AH,3Eh		;close file
   INT     21h
FF_EXIT:
   POP     BX
   RETF
FILE_FLUSH	ENDP

LIBSEG	ENDS
	end
