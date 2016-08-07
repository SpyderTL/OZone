	page	66,132
;******************************** SYS3.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
COUNT_FLOP_DRIVES - count the number of floppy disk drives intalled
;
; inputs:    no parameters
; 
; output:    AX = number of floppy drives
; 
;* * * * * * * * * * * * * *

	public	COUNT_FLOP_DRIVES
COUNT_FLOP_DRIVES	PROC	FAR
     int     11h
     SHR     AX,1
     JB      CF_FND		;JMP IF FLOPPY FOUND
     XOR     AX,AX
     RETF
CF_FND:
     PUSH    CX
     AND     AX,0060h
     MOV     CL,05
     SHR     AX,CL
     INC     AX
     POP     CX
     RETF
COUNT_FLOP_DRIVES	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
GET_DRV_TYPE - determine drive type
;
; inputs:    DL = drive number (0 = drive A:)
; 
; output:    AX = floppy drive type
;             0 = invalid drive number
;             1 = 360k
;             2 = 1.2M
;             3 = 720k
;             4 = 1.44M
;* * * * * * * * * * * * * *

	public	GET_DRV_TYPE
GET_DRV_TYPE	PROC	FAR
     APUSH   BX,CX,DX,DI,SI,ES
     MOV     SI,DX
     MOV     AH,08
     INT     13h
     JAE     gdt_2
     MOV     AH,15h
     MOV     DX,SI
     INT     13h
     JAE     gdt_1
     MOV     DX,SI
     INT     11h
     MOV     DH,AL
     XOR     AX,AX
     TEST    DH,01
     JZ      gdt_exit
     ROL     DH,1
     ROL     DH,1
     AND     DH,03
     INC     DH
     CMP     DL,DH
     RCL     AL,1
     JMP     gdt_exit
gdt_1:
     XOR     AL,AL
     XCHG    AL,AH
     JMP     gdt_exit
gdt_2:
     JCXZ    gdt_3
     ADD     AL,BL
     JNZ     gdt_exit
     MOV     AX,CX
     MOV     CX,0005
     CMP     AX,4F12h
     LOOPZ   gdt_3
     CMP     AX,4F09h
     LOOPZ   gdt_3
     CMP     AX,4F0Fh
     LOOPZ   gdt_3
     CMP     AX,2709h
     LOOPZ   gdt_3
gdt_3:
     MOV     AX,CX
gdt_exit:
     APOP    ES,SI,DI,DX,CX,BX
     RETF
GET_DRV_TYPE	ENDP


LIBSEG	ENDS
	end
