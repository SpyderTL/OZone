	page	66,132
;******************************** DISK3.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
FILE_COUNT - counts the number of files matching an ASCIIZ filespec string.
;
; inputs:    DS:[DX] pointing to filespec string
;            CX = file attributes
;            
; output:    AX = number of files matching the filespec string
;
; notes:     The filespec string may include the '*' and '?' wildcards.
;* * * * * * * * * * * * * *

	public	FILE_COUNT
FILE_COUNT	PROC	FAR
   push    bp
   cld
   XOR     BP,BP
   MOV	   AH,4Eh		;find first file
FC_01:
   INT     21h
   JB      FC_02
   INC     BP
   MOV	   AH,4Fh		;find next file
   JMP     FC_01
FC_02:
   MOV     AX,BP
   POP     BP
   RETF
FILE_COUNT	ENDP

LIBSEG	ENDS
	end
