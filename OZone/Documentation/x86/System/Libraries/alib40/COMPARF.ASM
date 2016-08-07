	page	66,132
;******************************* COMPARF.ASM ********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc

	extrn	dos_mem_allocate:far
	extrn	dos_mem_release:far
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( COMPARE )
;COMPARE_FILES - compares two files
;
; inputs:   DS:[SI] = address of file1 asciiz
;           DS:[DI] = address of file2 asciiz
; 
; output:  AX = 0 if successful compare
;* * * * * * * * * * * * * *


file1_handle	dw	0
file2_handle	dw	0

read_amount1	dw	0

file1_name	db	30 dup (0)
file2_name	db	30 dup (0)

buffer_length	equ	4000h
file1_buf	equ	0		;
file2_buf	equ	4000h		;

	public	compare_files
compare_files	proc	far
   apush   bx,cx,dx,si,di,ds,es
   mov	   dx,0
   mov     ax,8000h
   call    dos_mem_allocate
   
   cld	
   MOV     DX,si
   MOV	   AX,3D00h			;open file
   INT     21h
   JB      error
   mov	   cs:file1_handle,ax

   mov	   dx,di
   MOV	   AX,3D00h			;open file
   INT     21h
   JB      error
   mov	   cs:file2_handle,ax

   push    es
   pop     ds				;point at buffers

cmp_loop:   
   MOV	   AH,3Fh			;read file
   MOV     BX,cs:file1_handle
   mov	   dx,file1_buf
   mov	   cx,buffer_length
   int	   21h
   mov     cs:read_amount1,ax
   OR      AX,AX
   JZ      done_ok

   MOV	   AH,3Fh			;read file
   MOV     BX,cs:file2_handle
   mov	   dx,file2_buf
   mov	   cx,buffer_length
   INT     21h
   cmp	   cs:read_amount1,ax
   jne     error			;jmp if different length files
   OR      AX,AX
   JZ      done_ok

	mov	si,offset file1_buf
	mov	di,offset file2_buf
	mov	cx,ax
	cld
	rep	cmpsb
	jne	error
	jmp	cmp_loop
	
done_ok:
	mov	ax,0
	jmp	exit
error:
	mov	ax,1	
exit:
	push	ax			;save error code (al)
        MOV     BX,file1_handle
        MOV	AH,3Eh			;close file
        INT     21h
        MOV     BX,file2_handle
        MOV	AH,3Eh			;close file
        INT     21h
        call	dos_mem_release
	pop	ax
	apop    es,ds,di,si,dx,cx,bx
	retf
compare_files	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
