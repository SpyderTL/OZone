	page	66,132
;******************************** DISK9.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	dos_mem_allocate:far
	extrn	dos_mem_release:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
EXPAND_FILENAME - Expand a file string to the full path including drive.
;                 This is useful for user entered data which needs to
;                 be made consistient for processing.  See DECODE_FILENAME.
;
; inputs:    DS:[SI] pointing to a filename; the filename may contain
;                    drive specification and/or complete or partial path name.
;                    Drive specification and path name not required.
;                    Path string is terminated with a zero (null) character.
;                    
; outputs:  if no carry then,
;            DS:[SI] pointing to the full DRIVESPEC:\PATH\FILENAME
;            CX = length of full filename
;           if carry is set then filename is bad
;
; Note:  The file name is expanded and will overwrite the file name input.
;        Thus, the file name which is input needs to be in a buffer area
;        which will accomodate the expansion.       
;* * * * * * * * * * * * * *

expand_struc	struc
 restore_drv		DB	0
 restore_pth1           DB      ?		;'\'
 restore_pth2		DW	60 dup (?)

 tmp_target_path	db	64 dup (?)

 tested_path            db      ?,?,?		;'x:\'
	 		DB	64 dup (?)

 in_path		db	60 dup (?)	;local copy of input data
 in_path_ptr		dw	0		;ptr to input data
 
 uin_path_ptr		DW	0		;ptr to callers path info
 uin_path_seg		dw	0		;callers seg
expand_struc	ends
;------------------------

	public	EXPAND_FILENAME
EXPAND_FILENAME	PROC	FAR
   apush   ax,bx,dx,si,di,bp,ds,es
;
; allocate memory for work area
;   
   mov     dx,0
   mov     ax,size expand_struc +1
   call    DOS_MEM_ALLOCATE	;returns area (es:0) if no carry
   jc      ef_exit2		;jmp if memory not available
;
; setup our memory area
;
	mov	es:[uin_path_ptr],si
	mov	es:[uin_path_seg],ds
	mov	es:[restore_pth1],'\'
	mov	word ptr es:[tested_path+1],'\:'
	mov	word ptr es:in_path_ptr,offset in_path
;
; move users string into our memory area
;
	mov	cx,-1
	mov	di,offset in_path
ef_lp1:	lodsb
	stosb
	inc	cx
	cmp	al,0
	jne	ef_lp1		;loop till input copied to our memory
   CLD
   MOV     BX,ES
   MOV     DS,BX
   MOV     BP,CX
;
; save current path information
;   
   MOV	   AH,19h		;current drive to AL
   INT     21h
   MOV     byte ptr ds:[restore_drv],AL
   mov     SI,offset restore_pth2
   MOV	   AH,47h		;current directory -> ds:si
   MOV     DL,00
   INT     21h
;
; check if drive was specified
;   
   MOV     DI,word ptr ds:[in_path_ptr]
   MOV     CX,BP		;get length of in-path
   CMP     CX,+02
   JL      ef_sav_dir1		;jmp if no drive was specified
   CMP     BYTE PTR [DI+01],3Ah      ; ':'
   JNZ     ef_sav_dir1		;jmp if no drive was specified
   MOV	   DL,[DI]		;get in-path drive letter
   OR      DL,' '               ;force lower case
   SUB     DL,'a'               ;  & convert to drive#
   MOV	   AH,0Eh		;select in-path drive
   INT     21h
;
; verify drive was selected (legal)
;   
   MOV	   AH,19h		;current drive -> al
   INT     21h
   CMP	   DL,AL		;check if drive change occured
   JZ	   ef_drv_fnd		;jmp if legal drive specified
   JMP	   ef_err_exit		;illegal drive specified
ef_drv_fnd:
   ADD	   DI,+02		;move past in-path drive
   SUB	   CX,+02		;decrement in-path length
;
; save current directory again for this new drive
;   
ef_sav_dir1:
   mov     SI,offset restore_pth2
   MOV	   AH,47h		;current directory -> ds:si
   MOV     DL,00
   INT     21h
;
; extract path portion of file name
;   
   PUSH    DI
   MOV     AL,5Ch    ; '\'
ef_more_ck:
   MOV     word ptr ds:[in_path_ptr],DI
   MOV     BP,CX
   JCXZ    ef_last_slash		;jmp if no in-path found
   REPNZ   SCASB                ;scan for '\'
   JZ      ef_more_ck           ;jmp if '\' path start found
ef_last_slash:
   POP	   SI			;get in-path ptr
;
; copy path to local buffer and put zero at end
;   
   mov	   DI,offset tmp_target_path	;get tmp_target_path ptr
   MOV     CX,word ptr ds:[in_path_ptr]
   SUB     CX,SI                ;compute length of string to first in-path '\'
   JZ	   ef_bld_tested		;jmp if null path
   CMP     CX,+01
   JZ	   ef_bld_target		;jmp if root dir
   DEC     CX                   ;discard last '\'
;
; move path portion of string
;   
ef_bld_target:
   REPZ    MOVSB
   XOR     AL,AL
   STOSB				;put zero at end of path string
;
; switch to target path
;   
   mov	   DX,offset tmp_target_path
   MOV	   AH,3Bh		;set current dir -> ds:dx
   INT     21h
   JB	   ef_err_exit
;
; Now, start building the tested path string from the current location
;   
ef_bld_tested:
   MOV	   AH,19h		;current drive -> al
   INT     21h
   ADD     AL,41h
   MOV     byte ptr ds:[tested_path],AL
   MOV     DL,00
   mov     SI,offset tested_path+3
   MOV	   AH,47h		;current dir to ds:si
   INT     21h
   JB	   ef_err_exit
   mov     DI,offset tested_path+3
;
; check if this is the root directory
;   
   CMP     BYTE PTR [DI],00
   JZ      ef_add_fname		;jmp if this is root dir
   XOR     AL,AL
   MOV     CX,0FFFFh
   REPNZ   SCASB
   MOV     BYTE PTR [DI-01],5Ch      ; '\'
;
; append the filename to drive & path
;   
ef_add_fname:
   MOV     SI,word ptr ds:[in_path_ptr]
;
; check if this is a directory alias, '..' or '.'
;   
   CMP     BYTE PTR [SI],2Eh	 ; '.'
   JZ	   ef_err_exit		     ;jmp if alias directory entry
   MOV     CX,BP
   REPZ    MOVSB
   MOV     AL,CL
   STOSB
   mov     SI,offset tested_path
   MOV     AX,DI
   SUB     AX,SI
   CLC
   JMP     ef_restore_path
ef_err_exit:
   STC
ef_restore_path:
   PUSHF
   PUSH    AX			;save length of new path
;
; restore the origional directory
;   
   MOV     DX,OFFSET restore_pth1
   MOV	   AH,3Bh		;set current dir to ds:dx
   INT     21h
;
; restore the origional drive
;   
   MOV     DL,byte ptr ds:[restore_drv]
   MOV	   AH,0Eh		;set current drive
   INT     21h
;
; move new path to users buffer
;
   pop     cx
   push    cx
   les     di,dword ptr ds:uin_path_ptr
   mov     si,offset tested_path
   rep     movsb
;
; release memory buffers
;
   push    ds
   pop     es
   call    DOS_MEM_RELEASE
      
   POP     CX			;get length of path
   POPF
ef_exit2:   
   APOP    ES,DS,BP,DI,SI,DX,BX,AX
   RETF
EXPAND_FILENAME	ENDP

LIBSEG	ENDS
	end
