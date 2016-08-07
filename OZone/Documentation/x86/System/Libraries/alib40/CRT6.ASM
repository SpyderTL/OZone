	page	66,132
;******************************** CRT6.ASM   *********************************

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
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
GET_ANSI_COLOR - get color attribute used by ANSI driver.
;
; inputs:    none
; output:    AH = color attribute
;* * * * * * * * * * * * * *

	public	get_ansi_color
GET_ANSI_COLOR	PROC	FAR
    APUSH   BP,BX,CX,DX
    XOR     BH,BH
    MOV     AH,03
    INT     10h			;get cursor position (dx) and size (cx)
    PUSH    DX			;save origional cursor position
    CALL    read_cursor_at_0
    PUSH    AX			;save char. read using bios
;
; setup to write char. using dos call
;    
    PUSH    DS			;save our segment
    MOV     AX,CS		;set segment
    MOV     DS,AX		;  to -cs:-
    MOV     BX,0001		;select stdout
    
    CALL    GAC_1		;put address on stack
GAC_1:
    POP     DX			;set dx= offset l_21b2
    MOV     CX,0001
    MOV     AH,40h
    INT     21h			;write stdout(bx) 1 byte(cx) data at ds:dx
    CALL    read_cursor_at_0
    POP     DS			;restore data segment
    MOV     BP,AX		;save char. read using dos
    XOR     BH,BH
    POP     AX			;restore char. read using bios
    MOV     BL,AH		;move bios color to -> bl
    MOV     AH,09
    MOV     CX,0001
    PUSH    BP			;save char. read using dos
    INT     10h			;write char.(al) bl=bios color bh=page cx=repeat
    POP     BP			;restore char. read using dos
    POP     DX			;restore origional cursor position
    MOV     AH,02		;
    PUSH    BP			;save char. read using dos
    INT     10h			;restore origional cursor posn
;				first pop of -ax- restores char read using DOS
    APOP    AX,DX,CX,BX,BP
    RETF
GET_ANSI_COLOR	ENDP

;----------------------    
; read_cursor_at 0 - read character at cursor position
;  inputs: none
;  output: ax = character
;
read_cursor_at_0:    
    MOV     AH,02
    XOR     DX,DX	 	;set cursor address -> 0
    XOR     BH,BH		;select page 0
    INT     10h			;set cursor position from -dx- bh=page
    MOV     AH,08
    INT     10h			;read character & color at cursor -> ax
    RET
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
CURSOR_ - Move cursor and set size to standard underscore.
;
; inputs:    DH = row
;            DL = column
;            
; outputs:   register -ax- is modified
; 
;* * * * * * * * * * * * * *

	public	cursor_
CURSOR_	PROC	FAR
	mov	al,0
	jmp	cursor_entry
CURSOR_	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
SHOW_CURSOR - move cursor to (row, col) and update cursor shape
;
; inputs:    DH = row offset from top of screen
;            DL = column offset from left side
;
; outputs:   register -ax- modified
;
; notes:     Cursor shape is underscore if INSERT is off, large block
;            if INSERT is on.
;* * * * * * * * * * * * * *

	public	SHOW_CURSOR
SHOW_CURSOR	PROC	FAR
     mov     al,80h
cursor_entry:
    pushf
    APUSH   BP,BX,CX,DX,SI,ES
    MOV     AH,0Fh
    INT     10h			;get video mode -> al=mode bh=page ah=pixels
    MOV     AH,02
    INT     10h			;set cursor position -> -dx-
    XOR     AH,AH

    mov     al,cs:lib_info.crt_rows
    mov     bx,cs:lib_info.crt_seg

    mov     cx,0
    mov     es,cx
    MOV     CX,0507h
    MOV     DX,WORD PTR ES:[0463h] ;get crt port address  mono=3b4 color=3d4
    CMP     DX,03B4h		;check if mono display
    JNZ     c_color		; jmp if color display
    CMP     AL,1Dh		;check if rows = 29
    JGE     c_color		; jmp if 29 rows or more
    MOV     CX,0C0Dh
    MOV     AL,2Ah
c_color:
    AND     BL,BYTE PTR ES:[0417h] ;
    JZ      c_skip
    SHR     CH,1
c_skip:
    CMP     AL,1Dh
    JB      c_bios_set
    CMP     AL,2Dh    ; '-'
    JB      c_wrt_port
c_bios_set:
    MOV     AH,01
    INT     10h			;set text mode cursor size (cx)
    JMP     c_exit
c_wrt_port:
    MOV     AL,0Ah
    MOV     AH,CH
    OUT     DX,AX
    INC     AL
    MOV     AH,CL
    OUT     DX,AX
    MOV     WORD PTR ES:[0460h],CX
c_exit:
    APOP    ES,SI,DX,CX,BX,BP
    POPF
    RETF
SHOW_CURSOR	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
HIDE_CURSOR - make hardware cursor invisible at present location
;
; inputs:    none
; outputs:   none
;
;* * * * * * * * * * * * * *

	public	HIDE_CURSOR
HIDE_CURSOR	PROC	FAR
    APUSH   AX,CX
    MOV     CX,2020h
    MOV     AH,01
    PUSH    BP
    INT     10h
    POP     BP
    APOP    CX,AX
    RETF
HIDE_CURSOR	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
BLINK_ON:  enable blinking attriutes
;
; inputs: none
; output: none
;
; notes:  The opposite of blink is intenisified colors.  The normal default
;         is blink on.
;* * * * * * * * * * * * * *

	public	BLINK_ON
BLINK_ON		PROC	FAR
    PUSH    BX
    MOV     BX,0001
    JMP     blink_entry
BLINK_ON ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
BLINK_OFF:  disable blinking attriutes
;
; inputs: none
; output: none
;
; note: Blink off turns intensified color selection on.  The default at
;       boot time is blink on.
;* * * * * * * * * * * * * *

	public	BLINK_OFF
BLINK_OFF	PROC	FAR
    PUSH    BX
    MOV     BX,0000
blink_entry:
    APUSH   AX,DX,ES
    SUB     AX,AX
    MOV     ES,AX
    MOV     AL,BYTE PTR ES:[0487h]	;get ega/vga control flag
    OR      AL,AL
    JNZ     ega_vga_blink			;jmp if flag seems active
;
; program mono/cga controller directly
;     
    MOV     DX,WORD PTR ES:[0463h]	;get crt port address
    ADD     DL,04
    MOV     AL,BYTE PTR ES:[0465h]	;current mode select register setting
    OR      BX,BX			;bx=0(BLINK_OFF)  bx=1(BLINK_ON)
    JZ      cga_mono_boff		;jmp if blink off request
    OR      AL,20h
    JMP     cga_mono_bon
;
; blink off
;    
cga_mono_boff:
    AND     AL,0DFH			;disable blink bit
cga_mono_bon:
    OUT     DX,AL
    MOV     BYTE PTR ES:[0465h],AL	;set new mode select reg data
    JMP     blink_exit
;
; ega/vga blink setting
;    
ega_vga_blink:
    MOV     AX,1003h
    INT     10h				;bx=0(BLINK_OFF)  bx=1(BLINK_ON)
blink_exit:
    APOP    ES,DX,AX
    POP     BX
    RETF
BLINK_OFF	ENDP

LIBSEG	ENDS
	end
