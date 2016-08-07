	page	66,132
;******************************** DISK1.ASM  *********************************

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
FILE_COPY - copy a file
;
; inputs:    DS:[SI] = address of source filename
;            ES:[DI] = address of destination filename
;            Both filenames must be ASCIIZ strings.
;            
; output:    if CF = 0, no problem
;            if CF = 1, AX = DOS error code (AX = -1 if insufficient memory)
;            All registers unchanged except for -AX-
;* * * * * * * * * * * * * *

fc_date1	dw	0	;file date
fc_date2	dw	0	;file date

	public	FILE_COPY
FILE_COPY	PROC	FAR
	apush	ax,bx,cx,dx,si,di,ds,es
	mov	ax,3d00h
	int	21h			;open input file
	jc	fc_error1		; jmp if open error
	mov	si,ax			;save file handle

	mov	dx,cx
	mov	ah,3ch
	xor	cx,cx
	int	21h			;create output file
	jc	fc_error2		;  jmp if create error
	mov	di,ax			;save file handle
	
	mov	bx,si
	mov	ax,5700h
	int	21h			;get input file date
	mov	cs:fc_date1,cx
	mov	cs:fc_date2,dx
		
	mov	dx,0
	mov	ax,-1
	call	dos_mem_allocate	;allocate memory
	jc	fc_error3		;  jmp if out of memory

	push	es
	pop	ds			;es & ds point at allocated memory
;
; setup to read & write data
;
	mov	cx,-1			;number of bytes to read
	xor	dx,dx			;ds:dx = buffer pointer
;
; read loop, bx=file handle,  cx=read buffer size  ds:dx = buffer pointer
;	
fc_loop:mov	bx,si			;get file handle
	mov	ah,3fh
	int	21h			;read file
	jc	fc_error4		;  jmp if read error
	cmp	ax,0			;check if any data read
	je	fc_done			;  jmp if all done
	
	mov	cx,ax
	mov	ah,40h
	mov	bx,di			;get file handle
	int	21h			;write data
	jc	fc_error4		;  jmp if error
	cmp	ax,cx
	jne	fc_error4
	cmp	cx,-1
	je	fc_loop			;loop till done
;
; file has been copied, set date of new file
;	
fc_done:	
	mov	bx,di			;get output file handle
	mov	cx,cs:fc_date1
	mov	dx,cs:fc_date2
	mov	ax,5701h		;set file date
	int	21h			;
	clc
	jmp	fc_getout1
	
fc_error3:
	call	fc_close1		;close both files
	mov	al,7
	jmp	fc_errc
	
fc_error2:
	call	fc_close2		;close the input file
fc_error1:
fc_errc:	
	stc
	jmp	fc_getout3

fc_error4:
	stc
fc_getout1:
	pushf	
	call	fc_close1		;close both files
	popf
fc_getout2:
	pushf	
	call	dos_mem_release
	popf
fc_getout3:	
	apop	es,ds,di,si,dx,cx,bx,ax
	retf
FILE_COPY	ENDP
;------------------------------------

fc_close1:
	mov	bx,di			;file2 handle
	mov	ah,3eh
	int	21h
fc_close2:	
	mov	bx,si			;file1 handle
	mov	ah,3eh
	int	21h
	ret	

LIBSEG	ENDS
	end
