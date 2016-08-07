	page	66,132
;******************************** SYS4.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	breakflag:byte
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
BREAK_KEY_INTERCEPT - grab keyboard abort keys
;
; inputs:  none
; output:  none
;
; note:      BREAK_KEY_INTERCEPT traps Ctrl+Break, Ctrl+C and
;            Ctrl-Alt-Del key sequences.  When one of these
;            key combinations is pressed, the inforation is passed
;            to KEY_READ, KEY_IF_READY, KEY_OR_MOUSE.
;* * * * * * * * * * * * * *

	public	BREAK_KEY_INTERCEPT
BREAK_KEY_INTERCEPT	PROC	FAR
     nop			;this NOP is needed
     APUSH   AX,BX,DX,DS,ES
     MOV     AX,3509h
     INT     21h			;get int09 contents -> es:bx
     MOV     CS:[old_break_off],BX
     MOV     CS:[old_break_seg],ES
     PUSH    CS
     POP     DS
     LEA     DX,[BREAK_INT_HANDLER]
     MOV     AX,2509h
     INT     21h
     MOV     BYTE PTR CS:[BREAK_KEY_RESTORE],90h
     MOV     BYTE PTR CS:[BREAK_KEY_INTERCEPT],0CBh
     APOP    ES,DS,DX,BX,AX
     RETF
BREAK_KEY_INTERCEPT	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
BREAK_KEY_RESTORE - release keyboard abort keys
;
; inputs:    no parameters
; output:    nothing
;* * * * * * * * * * * * * *

	public	BREAK_KEY_RESTORE
BREAK_KEY_RESTORE	PROC	FAR
     RETF
     APUSH   AX,DX,DS
     LDS     DX,DWORD PTR CS:[old_break_off]
     MOV     AX,2509h
     INT     21h
     MOV     BYTE PTR CS:[BREAK_KEY_INTERCEPT],90h
     MOV     BYTE PTR CS:[BREAK_KEY_RESTORE],0CBh
     APOP    DX,DX,AX
     RETF

;-----------------------------------------
; Break interrupt handler
;
BREAK_INT_HANDLER:
     PUSHF
     APUSH   AX,BX,ds,es
     XOR     AX,AX
     MOV     ES,AX
     MOV     AL,BYTE PTR ES:[0417h]	;get keyboard flags
     AND     AL,0Fh			;isolate ctrl,alt,shift keys
     CMP     AL,0Ch			;check for ctrl and alt
     JE      bih_3			; jmp if ctrl and alt
     CMP     AL,04			;check if ctrl
     JE      bih_1			; jmp if ctrl
     JMP     bih_9			;jmp if not ctrl-break
;
; the control key is depressed
;     
bih_1:
     IN      AL,60h			;read key from keyboard
     JMP     bih_2
bih_2:
     CMP     AL,46h			;check for ctrl-break
     JZ      bih_5			;  jmp if ctrl-bread
     CMP     AL,2Eh			;check for ctrl-c
     JZ      bih_5			;  jmp if ctrl-c
     JMP     bih_9		
;
; ctrl and alt keys are down
;     
bih_3:
     IN      AL,60h
     CMP     AL,53h  			;check if DEL key
     JZ      bih_5			;  jmp if DEL key found
     JMP     bih_9
;
; ctrl-c or ctrl-break or ctrl-alt-del  has been found     
;
bih_5:
     MOV     BYTE PTR BREAKFLAG,01
;
; remove the break key from the keyboard
;     
     IN      AL,61h
     MOV     AH,AL
     OR      AL,80h
     OUT     61h,AL

     MOV     AL,20h    ; ' '
     OUT     20h,AL
     APOP    es,ds,BX,AX
     POPF
     IRET
bih_9:
     APOP    ES,DS,bx,ax
;     POPF
;     PUSHF
     CALL    DWORD PTR CS:[old_break_off]
     IRET
old_break_off		DW	0
old_break_seg		DW	0

BREAK_KEY_RESTORE	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
BREAK_CHECK -  check if break key pressed
;
; inputs:  none
; output:  flags set for je or jz if not set
;* * * * * * * * * * * * * *

	PUBLIC	BREAK_CHECK
BREAK_CHECK	PROC	FAR
	CMP	BREAKFLAG,0
	RETF
BREAK_CHECK	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
BREAK_CLEAR -  clear the break flag
;
; inputs:  none
; output:  none
;* * * * * * * * * * * * * *

	PUBLIC	BREAK_CLEAR
BREAK_CLEAR	PROC	FAR
	mov	BREAKFLAG,0
	RETF
BREAK_CLEAR	ENDP
	

LIBSEG	ENDS
	end
