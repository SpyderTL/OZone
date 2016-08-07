	page	66,132
;******************************** DISKB.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	strlen2:far
	extrn	lib_info:byte
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
FIND_HOME_PATH - find the full path and filename of the executing program
;
; inputs:    nothing
; 
; output:    ES:[DI] = pointer to the the name of the executing program
;                CX  = length of path string.
;
;  note:     The filename returned is an ASCIIZ string, and may be mixed
;            upper- and lower-case characters.
;            
;* * * * * * * * * * * * * *

	public	FIND_HOME_PATH
FIND_HOME_PATH	PROC	FAR
   mov	es,lib_info.psp_seg
   CLD
   APUSH   AX,DS
   MOV	   ES,WORD PTR ES:[002Ch]	;get enviorn seg
   XOR     DI,DI
   XOR     AL,AL
   MOV     CX,0FFFFh
FHP_1:
   REPNZ   SCASB			;look for name
   SCASB
   JNZ     FHP_1
   ADD     DI,2
   PUSH    ES
   POP     DS
   CALL    strlen2
   APOP    DS,AX
   RETF
FIND_HOME_PATH	ENDP

LIBSEG	ENDS
;;	end
