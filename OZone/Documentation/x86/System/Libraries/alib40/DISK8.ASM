	page	66,132
;******************************** DISK8.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
FILE_EXIST - determines if a file exists and can be opened
;
; inputs:    DS:[DX] pointing to ASCIIZ filename
; 
; output:    if CF = 0, file exists
;            if CF = 1, AX = DOS error code
;* * * * * * * * * * * * * *

	public	FILE_EXIST
FILE_EXIST	PROC	FAR
   push    bx
   mov	   ax,3d00h		;open file at ds:dx
   INT     21h
   JB      FEX_EXIT
   MOV     BX,AX
   MOV	   AH,3Eh		;close file
   INT     21h
FEX_EXIT:
   POP     BX
   RETF
FILE_EXIST	ENDP

LIBSEG	ENDS
	end
