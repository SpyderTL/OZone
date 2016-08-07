	page	66,132
;******************************** SYS2.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	lib_info:byte
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
SPAWN_DOS - execute a second copy DOS
;
; inputs:    DS:[SI] points to command tail
;            See DOS function 4bh for more information on command tail.
;            
;            if DS:[SI] points to a nul byte, control is transfered
;            to the second copy of COMMAND.COM and you get a DOS prompt.
;            control is passed back to the calling program when EXIT is
;            entered at the DOS prompt.
;
;            if DS:[SI] points to a program name string, the program
;            will be executed, and control will pass back to the calling
;            program at the termination of the second program.
;            
; output:    nothing
;
;* * * * * * * * * * * * * *

	public	SPAWN_DOS
SPAWN_DOS	proc	far
     APUSH   BX,CX,DX,DI,SI
     PUSHF
     APUSH   DS,ES
     CLD
     MOV     ES,LIB_INFO.PSP_SEG
     MOV     AX,ES:[002Ch]
     MOV     CS:[ENVIORN_SEG],AX		;SAVE ENVIORNMENT SEG
;
; check input string
;
     push    si
     mov     cx,0
slp: lodsb
     inc     cx
     cmp     al,0
     je      sl_tail
     cmp     al,0dh
     je      sl_tail
     cmp     al,'<'
     je      sl_tail
     cmp     al,'>'
     je      sl_tail
     cmp     al,'|'
     je      sl_tail
     jne     slp
sl_tail:
     mov     byte ptr ds:[si-1],0dh
     pop     si
	
     MOV     AX,CS
     MOV     ES,AX
     MOV     CS:[TAIL_SEG],AX
     mov     cs:[fcb1_seg],ax
     mov     cs:[fcb2_seg],ax
     MOV     DI,offset S_PARAM
     MOV     CS:[DI],CL
     JCXZ    SYS_1
     ADD     BYTE PTR CS:[DI],03
     INC     DI
     MOV     AX,432Fh			;'C/'
     STOSW
     MOV     AL,20h    ; ' '
     STOSB
     REPZ    MOVSB
SYS_1:
     MOV     AL,0Dh
     STOSB
     CLI
     MOV     CS:[S_STACK_OFF],SP
     MOV     CS:[S_STACK_SEG],SS
     STI
     MOV     DS,CS:[ENVIORN_SEG]
     XOR     AX,AX
     MOV     DX,offset S_COMSPEC
SYS_2:
     MOV     SI,AX
     INC     AX
     MOV     DI,DX
     MOV     CX,0008
     REPZ    CMPSB
     JNZ     SYS_2
     MOV     DX,SI
     MOV     BX,offset ENVIORN_SEG
     MOV     AX,4B00h
     INT     21h
     CLI
     MOV     SP,CS:[S_STACK_OFF]
     MOV     SS,CS:[S_STACK_SEG]
     STI
     APOP    ES,DS
     POPF
     APOP    SI,DI,DX,CX,BX
     RETF

S_COMSPEC	DB	'COMSPEC='
S_PARAM		DB	132 DUP (0)

ENVIORN_SEG     DW	0

	        DW	S_PARAM
TAIL_SEG        dW      00

fcb1_ptr	dw	fcb1
fcb1_seg	dw	0

fcb2_ptr	dw	fcb2
fcb2_seg	dw	0

fcb1		db 11 dup (' '), 5 dup (0)
fcb2		db 11 dup (' '), 5 dup (0)

S_STACK_SEG	DW	0	;STACK SEG SAVE
S_STACK_OFF	DW	0	;STACK OFFSET SAVE

SPAWN_DOS	endp


LIBSEG	ENDS
;;	end
