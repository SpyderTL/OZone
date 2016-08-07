	page	66,132
;******************************** SYS1.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	SETUP_MOUSE:far
	extrn	HIDE_CURSOR:far
	extrn	SHOW_CURSOR:far
	extrn	BLINK_OFF:far
	extrn	BLINK_ON:far
	extrn	get_ansi_color:far
	extrn	clear_screen:far
	extrn	mem_open:far
	extrn	mem_close:far
	extrn	float_open:near
	extrn	float_close:near
	extrn	lib_info:byte
	extrn	is_stdout_console:far
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�
; LIBRARY_SETUP returns a pointer to the following structure.
;
;info	struc
; cpu_type	db	?	;0=88 1=186 2=286 3=386 4=486
; math_chip	db	?	;0=none 1=8087 2=287 3=387 4=487
; mouse_present	db	?	;0=no n=yes
; crt_type	db	?	;
; crt_mode	db	?
; mono_flag	db	?
; ansi_present	db	?	;0=no 1=yes
; users_color	db	?
; crt_seg	dw	?	;segment of crt buffer
; crt_rows	db	?	;
; crt_columns	db	?	;
; key_type	db	?	;keyboard type 0=old style 1=enhanced
; psp_seg	dw	?	;psp segment
;info	ends

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
LIBRARY_SETUP - setup library for use
;
;  inputs:  ax = psp segment
;           bx = number of floating variables needed
;           
;  output:  es:si = pointer to library info structure
;	     carry = error, library unusable
;
;      info	struc
;       cpu_type	db	?	;0=88 1=186 2=286 3=386 4=486
;       math_chip	db	?	;0=none 1=8087 2=287 3=387 4=487
;       mouse_present	db	?	;0=no n=yes
;       crt_type	db	?	;
;       crt_mode	db	?
;       mono_flag	db	?
;       ansi_present	db	?	;0=no 1=yes
;       users_color	db	?
;       crt_seg	dw	?	;segment of crt buffer
;       crt_rows	db	?	;
;       crt_columns	db	?	;
;       key_type	db	?	;0=old style 1=enhanced
;       psp_seg	dw	?
;      info	ends
;	     
;* * * * * * * * * * * * * *

fvar_count	dw	0		;number of floating variables needed

	public	LIBRARY_SETUP
LIBRARY_SETUP	PROC	FAR
	mov	lib_info.psp_seg,ax
	mov	cs:fvar_count,bx
		
	call	FIND_CPU_TYPE
	mov	lib_info.cpu_type,al

	call	MATH_HARDWARE
	mov	lib_info.math_chip,al

	call	SETUP_MOUSE
	jc	ls_disp
	mov	lib_info.mouse_present,1
ls_disp:
	call	display_info
	mov	lib_info.crt_type,al
	mov	lib_info.crt_rows,bl
	mov	lib_info.crt_columns,cl

	call	find_display_segment

	call	set_display_flags
	mov	lib_info.mono_flag,al

	call	CHECK_ANSI
	mov	lib_info.ansi_present,0
	jc	ansi_end
	mov	lib_info.ansi_present,1
ansi_end:
        call	HIDE_CURSOR			;;
	call	BLINK_OFF
	
	cmp	lib_info.ansi_present,0
	je	get_bios_color
	call	get_ansi_color
	mov	lib_info.users_color,ah
	jmp	color_end
get_bios_color:
	mov	ah,08h
	mov	bh,0			;page 0
	int	10h			;read display
	mov	lib_info.users_color,ah
color_end:

	mov	ax,0500h		;force display
	int	10h			;  page 0
	
	call	keyboard_setup		;determine keyboard type
	mov	lib_info.key_type,al	;0=old style  1=enhanced
	
	call	mem_open		;setup memory
;
; if mem_open returns an error or warning the carry is set and is returned
;
	jc	ls_skip1		;jmp if memory setup error
	mov	bx,cs:fvar_count
	call	float_open		;sets carry if error
ls_skip1:	
	push	cs
	pop	es
	mov	si,offset lib_info
ls_error:
	cld				;force direction flag
	retf

LIBRARY_SETUP	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
LIBRARY_TERMINATE - close out library for program exit
;
;  inputs:  ax = 0 clear screen at exit
;           ax = 1 do not clear screen
;           
;  output:  none
;* * * * * * * * * * * * * *

	public	library_terminate
library_terminate	proc	far
	cmp	ax,0
	jne	lt_skip			;skip clear screen if ax=n
	mov	ax,0720h		;clear_screen info
	call	clear_screen
	mov	dx,0			;cursor position
	jmp	lt_end
lt_skip:mov	dx,1800h

lt_end:	call	SHOW_CURSOR		;dx=cursor position to set
	call	BLINK_ON
	call	float_close
	call	mem_close
	retf
library_terminate	endp
;
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
FIND_CPU_TYPE - detects cpu type
;
; inputs:  none
; 
; output:    AX = 0 if 8086/8088
;            AX = 1 if 80186/80188
;            AX = 2 if 80286
;            AX = 3 if 386 (SX or DX)
;            AX = 4 if 486 (SX or DX)
;* * * * * * * * * * * * * *

	public	FIND_CPU_TYPE
FIND_CPU_TYPE	PROC	FAR
     XOR     AX,AX
     PUSH    AX
     POPF
     PUSHF
     POP     AX
     AND     AX,0F000h
     CMP     AX,0F000h
     JNZ     getcpu_2			;jmp if not 8088,80188,8086,80186
     PUSH    CX
     MOV     AX,0FFFFh
     MOV     CL,21h    			;286+ mask -cl- with 1fh
     SHL     AX,CL
     POP     CX
     JNZ     getcpu_1			;jmp if 80188 or 80186
;
; we have found an 8088 or 8086
;     
     XOR     AX,AX
     JMP     getcpu_exit
;
; we have found an 80188 or 80186
;     
getcpu_1:
     MOV     AX,0001
     JMP     getcpu_exit
;
; we have a 286+ cpu, determine if this is 286
;     
getcpu_2:
     MOV     AX,7000h
     PUSH    AX
     POPF
     PUSHF
     POP     AX
     AND     AX,7000h
     JNZ     getcpu_3			;jmp if not 80286
;
; we have found an 80286
;     
     MOV     AX,0002
     JMP     getcpu_exit
;
; we have found a 80386+ cpu, determine if 80386
;     
getcpu_3:
     PUSH    DX
     MOV     DX,0003			;preload code for 80386
     DB		66H,50H			;PUSH    EAX
     DB		66H,53H			;PUSH    EBX
     DB		66H,51H			;PUSH    ECX
     DB		66H,8BH,0DCH		;MOV     EBX,ESP
     DB		66H,83H,0E4H,8CH	;AND     ESP,-04
     DB		66H,9CH			;PUSHFD
     DB		66H,58H			;POP     EAX
     DB		66H,8BH,0C8H		;MOV     ECX,EAX
     DB		66H,35H,00,00,04,00	;XOR     EAX,00040000h
     DB		66H,50H			;PUSH    EAX
     DB		66H,9DH			;POPFD
     DB		66H,9CH			;PUSHFD
     DB		66H,58H			;POP     EAX
     DB		66H,25H,00,00,04,00	;AND     EAX,00040000h
     DB		66H,81H,0E1H,0,0,04,00	;AND     ECX,00040000h
     DB		66H,3BH,0C1H		;CMP     EAX,ECX
     JZ      getcpu_4			;jmp if 80386
;
; we have found an 80486
;     
     MOV     DX,0004			;preload 80486 code
getcpu_4:
     DB		66H,51H			;PUSH    ECX
     DB		66H,9DH			;POPFD
     DB		66H,8BH,0E3H		;MOV     ESP,EBX
     DB		66H,59H			;POP     ECX
     DB		66H,5BH			;POP     EBX
     DB		66H,58H			;POP     EAX
     MOV     AX,DX
     POP     DX
getcpu_exit:
     RETF
FIND_CPU_TYPE	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
MATH_HARDWARE - determines if 80x87 math coprocessor is installed
;
; inputs:    none
; 
; output:    AX = code for 80x87 model
;            0 = not installed
;            1 = 8087
;            2 = 287
;            3 = 387 (DX or SX)
;            4 = 487 (486DX or 487SX)
;            If the coprocessor is present, it is initilaized by MATH_HARDWARE.
;            
;* * * * * * * * * * * * * *

	public	MATH_HARDWARE
MATH_HARDWARE	PROC	FAR
     XOR     AX,AX
     PUSH    AX
     POPF
     PUSHF
     POP     AX
     AND     AX,0F000h
     CMP     AX,0F000h
     JZ      math_2
     INT     11h
     AND     AX,0002
     JZ      math_exit1			;jmp if no math chip
     PUSH    BP
     MOV     BP,SP
     SUB     SP,+04
     MOV     WORD PTR [BP-04],0000
     MOV     WORD PTR [BP-02],7F80h
     FLD     DWORD PTR [BP-04]
     FLD     ST(0)
     FCHS
     FCOMPP
     FSTSW   [BP-02]
     MOV     AX,[BP-02]
     MOV     SP,BP
     POP     BP
     SAHF
     MOV     AX,0002			;load code for 287
     JZ      math_exit1			;jmp if 287
     CALL    FIND_CPU_TYPE
math_exit1:
     RETF
math_2:
     PUSH    BP
     MOV     BP,SP
     SUB     SP,+02
     XOR     DX,DX
     MOV     [BP-02],DX
     FINIT
     FSTCW   [BP-02]
     PUSH    CX
math_3:
     MOV     CX,0003
     LOOP    math_3
     POP     CX
     MOV     AX,[BP-02]
     AND     AX,0300h
     CMP     AX,0300h
     JNZ     math_exit2		;jmp if no math chip
     INC     DX			;set dx=1 (8087)
math_exit2:
     MOV     AX,DX
     MOV     SP,BP
     POP     BP
     RETF
MATH_HARDWARE	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
keyboard_setup - determine type of keyboard attached
;
; inputs: none
; 
; output: al = 0(old style bios)  1(enhanced bios)
;* * * * * * * * * * * * * *

	public	keyboard_setup
keyboard_setup	proc	far
	push	es
	mov	ax,0
	mov	es,ax

	mov	ah,12h
	int	16h			;get extended bios shift status
	cmp	al,byte ptr es:[417h]	;check if memory copy correct
	jne	ks_old			;jmp if old style keyboard

	xor	byte ptr es:[417h],80h	;toggle insert mode
	mov	ah,12h
	int	16h			;get extended bios shift status
	cmp	al,byte ptr es:[417h]	;double check incase first check wrong
	jne	ks_old			;jmp if old style keyboard
	mov	al,1
	jmp	ks_exit			;exit, extended keyboard status
ks_old:	mov	al,0
ks_exit:pop	es
	retf	
keyboard_setup	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
FIND_MOUSE - determines if a mouse is installed
;
; inputs:    none
; 
; output:    AX = number of mouse buttons
;            AX = 0 if no mouse or mouse driver installed
;* * * * * * * * * * * * * *

	public	FIND_MOUSE
FIND_MOUSE	PROC	FAR
     push    bx
     xor     ax,ax
     or      al,cs:lib_info.mouse_present
     JNZ     ism_exit
     INT     33h
     AND     AX,BX
     MOV     cs:lib_info.mouse_present,al
ism_exit:
     POP     BX
     RETF
FIND_MOUSE	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
CHECK_ANSI - check if ANSI active
;
; inputs:    none
; 
; output:    CF = 1 if no ANSI driver active
;            CF = 0 if ANSI active
;* * * * * * * * * * * * * *

	public	CHECK_ANSI
CHECK_ANSI		PROC	FAR
     APUSH   AX,DX,DS
     call    is_stdout_console
     test    al,al
     jz      no_ansi1		;jmp if output redirected (force no ansi)
     MOV     AX,CS
     MOV     DS,AX
     CALL    console_input
     CALL    CHECK_ANSI_cont1

     DB	     1BH,'[6n$'
;
CHECK_ANSI_cont1:
     POP     DX
     CALL    console_output
     MOV     AH,0Bh		;check STDIN status, al=ff if input
     INT     21h
     CMP     AL,0FFh
     JZ      IA_1		;jmp if char. is ready from ansi call
     CALL    isansi_cont2

     db	     0dH,'    ',0dH,'$'

isansi_cont2:
     POP	DX
     CALL    console_output
no_ansi1:
     STC
     JMP     IA_2
IA_1:
     CALL    console_input
     CLC
IA_2:
     APOP    DS,DX,AX
     JB      NO_ANSI
     CLC
     RETF
NO_ANSI:
     STC
     RETF
CHECK_ANSI	ENDP
;------------------------------
console_output:
     MOV     AH,09
     INT     21h
     RET

console_input:
     MOV     AH,06
     MOV     DL,0FFh
     INT     21h
     JNZ     console_input
     RET

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
DISPLAY_INFO - determine display information
;
; inputs:    none
;            
; output:    AL = screen rows
;            CH = screen columns
;            BX:[SI] = video buffer address
;            register DX is modified
;* * * * * * * * * * * * * *

	public	display_info
display_info:
	push	es
	call	detectvid			;get video type
	cmp	ax,0
	je	display_info_exit		;exit if no display
;
; check for special case, dual display and alternate monochrome active
;
	mov	bx,0
	mov	es,bx
	cmp	al,3				;check if color display
	jb	mono_port			;jmp if mono
	cmp	word ptr es:[463h],3d4h		;verify color port active
	je	port_ck_end			;jmp if port ok
	mov	ax,2				;force monochrome display
	jmp	port_ck_end
mono_port:
	cmp	word ptr es:[463h],3b4h		;verify mono port active
	je	port_ck_end
	mov	ax,5				;force cga color
port_ck_end:
	
	push	ax
	mov	ax,0500h
	int	10h				;force page 0

	mov	ax,0
	mov	es,ax
	mov	bh,es:[449h]			;get display mode
	pop	ax

	cmp	al,6
	jbe	get_rows			;jmp if mono or cga
	cmp	al,9
	je	get_rows			;jmp if cga compatable

	push	ax
	push	bx
	mov	ax,1130h
	mov	bh,0
	push	es
	int	10h
	pop	es
	pop	bx
	pop	ax
	mov	bl,dl				;move rows to -bl-
	jmp	rows_ok      

get_rows:
	mov	bl,es:[484h]			;get rows
	cmp	bl,0
	je	fix_rows			;jmp if row info bad
	cmp	bl,80
	jb	rows_ok				;jmp if row info found
fix_rows:
	mov	bl,24				;force 25 lines on screen
rows_ok:
	inc	bl
get_columns:
	mov	cx,word ptr es:[44ah]		;get columns on display
display_info_exit:
	pop	es
	ret	
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
DETECTVID -  determine display type
;
;  inputs: none
;  
;  outputs:  ax = 0  no display
;                 1  monochrome
;                 2  hercules 
;                 3  cga digital (mono)
;                 4  cga analog  (mono)
;                 5  cga analog (color)
;                 6  ega mono
;                 7  ega color 64k
;                 8  ega color 64k+
;                 9  cga compatable
;                10  vga mono
;                11  vga color 
;* * * * * * * * * * * * * *

vga_mono	equ	10
vga_color	equ	11
monochrome	equ	1
hercules	equ	2

	public	detectvid
detectvid:
    mov ax,1a00h          ;used by mcga and vga
    int 10h
    cmp al,1ah            ;if al = 1ah then mcga or vga is present
    jnz dt1
    cmp bl,7              ;if active monitor is monochrome vga
    jnz do1
    mov ax,vga_mono       ;mono vga found
    ret
do1:
    cmp bl,8              ;if active monitor is color vga
    jnz do2
    mov ax,vga_color      ;color vga found
    ret
do2:
    cmp bl,0ah            ;if digital mcga
    jnz do3
    mov ax,3              ;digital mcga found
    ret
do3:
    cmp bl,0bh            ;if monochrome mcga
    jnz do4
    mov ax,4              ;analog monochrome mcga found
    ret
do4:
    cmp bl,0ch            ;if color mcga
    jnz dt1
    mov ax,5              ;analog color mcga found
    ret
dt1:
    mov ah,12h            ;used by ega
    mov bl,10h
    int 10h
    cmp bl,10h            ;if bl is not 10h then ega is present
    jz dt2
    cmp bh,1              ;if monochrome ega
    jnz do5
    mov ax,6              ;monochrome ega
    ret
do5:
    or bl,bl              ;or 64k ega board
    jnz do6
    mov ax,7              ;color ega with 64k memory
    ret
do6:
    mov ax,8              ;color ega with > 64k memory
    ret
dt2:
    mov dx,3d4h           ;address for cga crtc
    call find6845         ;look for controller
    jnc dt3               ;if clear then cga present
    mov dx,3b4h           ;address for hercules or mda
    call find6845         ;look for controller
    jnc dt4               ;jump if hercules or mda present
    mov ax,0              ;unable to detect card
    ret
dt3:
    mov ax,9              ;cga compatible present
    ret
dt4:
    mov dl,0bah           ;read this port
    in al,dx
    and al,80h            ;get value in ah
    mov ah,al
    mov cx,8000h          ;loop this many times
dt5:
    in al,dx              ;read port
    and al,80h
    cmp ah,al             ;has value changed
    loopz dt5
    jcxz dt6              ;if cx = 0 then mda is present
    mov ax,hercules       ;hercules card
    ret
dt6:
    mov ax,monochrome     ;mda card
    ret
;-------------------------------------------------------------------------
	public	find6845
find6845 proc near        ;find out if crtc is present
    mov al,0fh            ;select reg ( cursor low )
    out dx,al
    inc dx
    in al,dx              ;al = cursor low position
    mov ah,al             ;save value in ah
    mov al,66h            ;arbitrary value
    out dx,al             ;write to crtc
    mov cx,100h
f61:
    loop f61              ;wait for response
    in al,dx
    xchg ah,al            ;ah = returned value
    out dx,al             ;reset port
    cmp ah,66h            ;was value unchanged
    je f62
    stc                   ;if no response
f62:
    ret
find6845 endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SYSTEM  )
FIND_DISPLAY_SEGMENT  -  scan for current display buffer segment
;
;  inputs:   display mode 3 or 7 must be set and display page must = 0
;  
;  output:   display_segment is set
;
;* * * * * * * * * * * * * *

	public	find_display_segment
find_display_segment:
	push	ax
	push	bx
	push	es
	cli
	mov	ax,0b000h		;display seg?
	mov	es,ax
	mov	bx,es:[0]		;save current data
	mov	word ptr es:[0],0101h	;store code 0101 at b000
	mov	ax,0b800h		;move to b800
	mov	es,ax
	mov	cx,es:[0]		;save current data
	mov	word ptr es:[0],0303h	;store code 0303 at b800

	push	bx
	push	cx

	mov	ah,3
	mov	bh,0
	int	10h			;read cursor position -> dx
	mov	cx,dx			;save cursor posn

	mov	ah,2			;move
	mov	bh,0			; cursor
	mov	dx,0			;   to page 0
	int	10h			;     top left

	mov	ah,8			;read
	mov	bh,0			;  data
	int	10h			;    at cursor
;
; restore cursor position
;
	push	ax			;save data read
	mov	dx,cx
	mov	ah,2
	int	10h
	pop	ax			;restore data read 
;
; restore origional display buffer data
;
	pop	cx			;  origional
	pop	bx			;   display contents
	push	ax			;save data read
	mov	ax,0b000h
	mov	es,ax
	mov	word ptr es:[0],bx
	mov	ax,0b800h
	mov	es,ax
	mov	word ptr es:[0],cx
;
; recover data read from display to determine segment location
;	
	pop	ax
	cmp	ax,0101h
	je	use_b000
use_b800:
	mov	ax,0b800h
	jmp	set_seg_cont
use_b000:
	mov	ax,0b000h
set_seg_cont:
	mov	lib_info.crt_seg,ax
	sti
	pop	es
	pop	bx
	pop	ax
	ret

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�
; set_display_flags - determine cga snow flag and mono flag default settings
;  inputs: crt_info data stored in data base
;  output: al = mono flag (1=mono)
;          dx = snow flag (cga port if cga)
;
set_display_flags:
	sub	ax,ax
	mov	es,ax
;
; get display mode
;
	mov	al,byte ptr es:[449h]	;get display mode
	mov	lib_info.crt_mode,al	
;
; force display page zero
;
	mov	ah,5
	mov	al,0			;page 0
	int	10h	
;
; set cga flag
;
	mov	al,lib_info.crt_type
	cmp	al,3
	jb	mono_display
	cmp	al,5
	jbe	cga_display
	cmp	al,9
	je	cga_display
;
; we must have a color display, it is not a cga or mono
;
	mov	al,0
	mov	dx,0
	jmp	sdf_exit	
;
mono_display:
	mov	al,1
	mov	dx,0
	jmp	sdf_exit
	
cga_display:
	mov	al,0
	mov	dx,3dah
sdf_exit:
	ret

LIBSEG	ENDS
	end
