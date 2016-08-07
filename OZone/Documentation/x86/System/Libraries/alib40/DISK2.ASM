	page	66,132
;******************************** DISK2.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
FILE_SIZE1 - find an open file's size
;
; inputs:    BX = file handle
; 
; output:    if CF = 0, DX:AX = file size (low word in AX)
;            if CF = 1, AX = DOS error code
;            
;* * * * * * * * * * * * * *

	public	FILE_SIZE1
FILE_SIZE1	PROC	FAR
   APUSH   BX,CX,SI,DI
   MOV	   AX,4201h		;set ds:ax to file posn (save)
   XOR     CX,CX
   MOV     DX,CX
   INT     21h
   JB      FSIZE_1
   MOV     DI,DX
   MOV     SI,AX
   MOV	   AX,4202h		;seek to end of file, size -> dx:ax
   XOR     CX,CX
   MOV     DX,CX
   INT     21h
   PUSH    DX
   PUSH    AX
   MOV	   AX,4200h		 ;restore orig. file posn
   MOV     CX,DI
   MOV     DX,SI
   INT     21h
   POP	   AX			;put file size in dx:ax
   POP     DX
FSIZE_1:
   APOP    DI,SI,CX,BX
   RETF
FILE_SIZE1	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
FILE_SIZE2 - find a closed file's size
;
; inputs:    DS:DX = pointer to file name asciiz string
; 
; output:    if CF = 0, DX:AX = file size (low word in AX)
;            if CF = 1, AX = DOS error code
;            
;* * * * * * * * * * * * * *

	public	FILE_SIZE2
FILE_SIZE2	PROC	FAR
	apush	bx,cx,si,di
	mov	ax,3d00h
	int	21h			;open file
	jc	fs_err2			;jmp if error
	mov	bx,ax			;get file handle
	call	file_size1
	pushf
	push	ax
	mov	ah,3eh
	int	21h			;close file
	pop	ax
	popf
fs_err2:
	apop	di,si,cx,bx	
	ret	
FILE_SIZE2	ENDP

LIBSEG	ENDS
	end
