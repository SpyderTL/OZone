	PAGE	66,132
;****************************** MEMORY5.ASM *********************************
;
;----------------------------------------------------------------------------
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------

;---------------------------------
; xms extended memory data base
;---------------------------------

xms_handle	dw	0
xms_control	dd	0		;address of driver entry point
xms_initial_sz	dw	0		;1k bytes avail.

	align	4
write_xms_packet	label	dword
  xms_write_len		dd	0  	;length	of write in bytes
  xms_from_write_handle	dw	0	;always zero for conventional memory
  xms_from_write_offset	dw	0	;store buffer offset here
  xms_from_write_segment dw	0	;store buffer segment here
  xms_to_write_handle	dw	0	;handle from	xms driver
  xms_to_write_address	dd	0	;byte address from start of	xms block


	align	4
read_xms_packet	label	dword
  xms_read_len		dd	0  	;length of read in bytes
  xms_from_read_handle	dw	0	;from xms driver
  xms_from_read_address	dd	0	;byte address from start of xms block
  xms_to_read_handle	dw	0	;always zero
  xms_to_read_offset	dw	0	;store buffer offset here
  xms_to_read_segment	dw	0	;store buffer segment here

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
XMS_CHECK - check XMS memory size and amount available
; check	if XMS eXtended	Memory Specification driver exists
;  inputs:  none
;  output:  es:bx = XMS	control	address	if bx not equal zero
;              ax = size of largest block available in k-bytes
;	       dx = total size of avail. memory in k-bytes
;              cx = A20 line state, 0=disabled & wraping, 1=enabled
;
;	       bx = zero if no XMS driver found
;
;  note:  This function must be called before other XMS functions
;         to setup the internal control address
;* * * * * * * * * * * * * *


	public	XMS_CHECK
XMS_CHECK	proc	far
	mov	ax,4300h
	int	2fh
	cmp	al,80h		;check if driver found
	mov	bx,0		;pre	load failure code
	jne	xms_check_exit	;jmp if driver not found
;
	mov	ax,4310h
	int	2fh		;request control address
	mov	cs:word ptr xms_control,bx
	mov	cs:word ptr xms_control+2,es
;
; get xms status
;
	mov	ah,8
	call	xms_control		;returns ax=largest block in 1k chunks
;                                                dx=total 1k blocks avail.
; querry the xms driver for state of A20 line
;
	apush	ax,bx
	mov	ah,07
	call	xms_control
	mov	cx,ax
	apop	bx,ax
		
xms_check_exit:
	retf
XMS_CHECK	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
XMS_UMB_CHECK - check if UMB area allocated by XMS driver
;  inputs:  none
;  output:  if no carry
;              DX = size of largest UMB in paragraphs (16-bit blocks)
;           if carry, then function not available
;           
;* * * * * * * * * * * * * *


	public	XMS_UMB_CHECK
XMS_UMB_CHECK	proc	far
	apush	ax,bx
	mov	ah,10h
	mov	dx,4000h
	call	xms_control
	cmp	ax,1
	je	xuc_exit1
	cmp	bl,80h
	je	xuc_exit2	;jmp if function not implemented
xuc_exit1:
	clc
	jmp	xuc_exit
xuc_exit2:
	stc
xuc_exit:
	apop	bx,ax
	retf
XMS_UMB_CHECK	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
XMS_ALLOCATE - allocate xms memory
;  inputs: dx -	size needed in k-bytes
;  output: ax =	0001 if	block allocated	ok
;	   dx =	handle for block allocated
;
; note: the handle in -dx- is saved internally and is not needed.
;       xms_read and xms_write will use the stored handle.  This
;       means that only one xms block can be allocated at a time.
;     
;* * * * * * * * * * * * * *


	public	XMS_ALLOCATE
XMS_ALLOCATE	proc	far
	mov	ah,9
	call	xms_control
      	mov	xms_from_read_handle,dx
	mov	xms_to_write_handle,dx
	mov	xms_handle,dx
	retf
XMS_ALLOCATE	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
XMS_READ - read XMS memory block
;   inputs:  bp:di = to address
;	     dx,ax = index into memory block
;		cx = number of words to transfer
;
;  output:      ax = result code, 1 = success
;* * * * * * * * * * * * * *


	public	XMS_READ
XMS_READ	proc	far
	apush	dx,cx,si
	mov	word ptr [xms_from_read_address],ax
	mov	word ptr [xms_from_read_address+2],dx

	shl	cx,1				;convert words to bytes
	mov	word ptr xms_read_len,cx

	mov	xms_to_read_offset,di	;save buffer offset
	mov	xms_to_read_segment,bp	;save buffer segment

	mov	si,offset read_xms_packet
	mov	ah,0bh
	call	xms_control
	apop	si,cx,dx
	retf
XMS_READ	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
XMS_WRITE - write block of data to XMS memory
;   inputs:  bp:si = from address
;		cx = number of words to transfer
;	     dx,ax = index into segment
;
;  output: ax = result code, 1 = success
;* * * * * * * * * * * * * *


	public	XMS_WRITE
XMS_WRITE	proc	far
	apush	dx,cx,si
	mov	word ptr [xms_to_write_address],ax
	mov	word ptr [xms_to_write_address+2],dx

	shl	cx,1				;convert words to bytes
	mov	word ptr xms_write_len,cx

	mov	xms_from_write_offset,si
	mov	xms_from_write_segment,bp

	mov	si,offset write_xms_packet
	mov	ah,0bh
	call	xms_control
	apop	si,cx,dx
	retf
XMS_WRITE	endp


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
XMS_RELEASE - release current XMS memory block
;  inputs:
;* * * * * * * * * * * * * *


	public	XMS_RELEASE
XMS_RELEASE	proc	far
	apush	ax,dx
        mov	dx,xms_handle
	cmp	dx,0
	je	mc_xms				;jmp if no xms allocated
	mov	ah,0ah
	call	xms_control			;release xms memory block
	mov	xms_handle,0
mc_xms: apop	dx,ax
	retf
XMS_RELEASE	endp

LIBSEG	ENDS
;;	end
