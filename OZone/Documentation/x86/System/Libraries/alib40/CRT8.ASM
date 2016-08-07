	page	66,132
;******************************** CRT8.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include	 common.inc
.list
;----------------------------------------------------------------------------
	extrn	lib_info:byte
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
DISK_TO_CRT - loads a screen image file saved by CRT_TO_DISK
;
; inputs:    DS:[DX] = address of ASCIIZ filename
; 
; outputs:   if CF = 1, AX = MS-DOS file I/O error code
;            if CF = 0, no error
;            registers modified = AX            
;
;notes:     The input file is assumed to be closed when DISK_TO_CRT is
;           called, and is left closed upon exit.
;* * * * * * * * * * * * * *

	public	disk_to_crt
DISK_TO_CRT	PROC	FAR
    MOV     AH,01
    JMP     ctd_entry
DISK_TO_CRT	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
CRT_TO_DISK - saves a screen image as a file
;
; inputs:    DS:[DX] = address of ASCIIZ filename
; 
; outputs:   if CF = 1, AX = MS-DOS file I/O error code
;            if CF = 0, no error
;            registers modified = AX
;* * * * * * * * * * * * * *

	public	crt_to_disk
CRT_TO_DISK	PROC	FAR
    MOV     AH,00
ctd_entry:
    PUSHF
    PUSH    BP
    MOV     BP,SP
    SUB     SP,+02
    APUSH   BX,CX,DX,SI,DS,ES,DX
    MOV     [BP-02],AH
    mov     al,cs:lib_info.crt_rows
    mov     ch,cs:lib_info.crt_columns
;;    call    DISPLAY_PARMS ;out: al=rows ch=columns bx:si=crt buf  dx=cga port
    MUL     CH
    SHL     AX,1
    POP     DX
    PUSH    AX
    XOR     CX,CX
    MOV     AX,3C00h
    ADD     AH,[BP-02]
    INT     21h			;create file ds:dx using attribute (cx)
    POP     CX
    mov     ds,cs:lib_info.crt_seg
    JB	    ctd_exit
    MOV     BX,AX
    MOV     DX,0		;assume display offset is zero (page 0)
    MOV     AH,40h
    SUB     AH,[BP-02]
    INT     21h			;write to file bx=handle cx=len ds:dx=data
    JB      CTD_CONT
    CMP     AX,CX
    JZ      CTD_01
CTD_CONT:
    PUSH    AX
    MOV     AH,3Eh
    INT     21h			;close file handle (bx)
    POP     AX
    STC
    JMP     ctd_exit

CTD_01:    
    MOV     AH,3Eh
    INT     21h			;close file handle (bx)
    JB      ctd_exit
    CLC
ctd_exit:
    APOP    ES,DS,SI,DX,CX,BX
    MOV     SP,BP
    POP     BP
    JB      ctd_exit2
    POPF
    CLC
    RETF
ctd_exit2:
    POPF
    STC
    RETF
CRT_TO_DISK	ENDP


LIBSEG	ENDS
	end
