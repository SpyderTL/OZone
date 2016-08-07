	PAGE	66,132
;****************************** MEMORY6.ASM *********************************
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

ems_handle	dw	0
ems_frame	dw	0		;seg of ems page, 0=no page
ems_initial_sz	dw	0		;16k-byte pages avail

current_logical_page	dw	-1

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
EMS_CHECK - check if EMS memory is present
;
; inputs:  none
;
; output:  if CF = 1, no Expanded Memory manager installed
;          if CF = 0, AH = EMM error code
;          if AH = 0, ES = page frame segment address
;                     BX = available pages, each page is 4k-bytes
;                     DX = total ems pages
;          registers changed  AX,BX,ES           
;
; note:  The ems page frame is stored internally for use by
;        the ems read and write functions.
;* * * * * * * * * * * * * *

emm_name  DB      'EMMXXXX0',0

	public	EMS_CHECK
EMS_CHECK	proc	far
	apush	cx,si,di,ds
	cld
;
; get the interrupt handler attached to int 67h
;
	mov	ah,35h
	mov	al,67h
	int	21h			;ask DOS for int 67 handler
;
; setup to scan vector for name of EMM handler (EMMXXXX0)
;
	push	cs
	pop	ds
	mov	si,offset emm_name	;offset of our copy of handler name
	mov	di,0ah			;offset of name within handler
	mov	cx,8			;length of name string
	repz	cmpsb
	jne	no_ems			;jmp if name not found
;
; ask EMS driver for the page frame
;
	mov	ah,41h
	int	67h			;return the page frame in -bx-
	or	ah,ah			;check if error
	jnz	no_ems			; jmp if error
	mov	es,bx			;save page frame
	mov	ah,42h			;get avail. page count
	int	67h
	or	ah,ah
	jnz	no_ems			;jmp if error getting page count
	clc
	jmp	ie_exit	
no_ems:
	stc
ie_exit:
	apop	ds,di,si,cx
	retf
EMS_CHECK	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
EMS_ALLOCATE - allocate EMS memory
;  inputs: bx -	number of 4k pages to allocate
;  output:      if no carry, then success
;               carry = failure 
;     
;* * * * * * * * * * * * * *


	public	EMS_ALLOCATE
EMS_ALLOCATE	proc	far
;
; allocate ems pages, bx=unallocated page count
;
	cmp	bx,0
	je	mop_4			;jmp if no ems pages avail.
	mov	ah,43h			;allocate pages request code
	int	67h
	cmp	ah,0
	jne	mop_4			;jmp if failure
      	mov	ems_handle,dx		;save ems handle
      	clc
      	jmp	ea_exit
mop_4:	stc
ea_exit:retf
EMS_ALLOCATE	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
EMS_PAGE - request page of ems memory
;   inputs:  bx = ems page needed
;
;  output:   no carry = success
;            carry = error, error code in -ah-
;* * * * * * * * * * * * * *


	public	EMS_PAGE
EMS_PAGE	proc	far
	cmp	bx,CURRENT_LOGICAL_PAGE	;check if this page is in mem.
	jz	er_ok			;jump if page in memory
	mov	CURRENT_LOGICAL_PAGE,bx	;save new logical page indicator
	mov	dx,ems_handle		;get our handle
	mov	ax,4400h		;get request code & phys. page
	int	67h			;get data from eem handler
	or	ah,ah
	jnz	er_err
er_ok:	clc
	jmp	er_exit
er_err:	stc
er_exit:retf
EMS_PAGE	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
EMS_RELEASE - release allocated ems memory
;  inputs:  none
;  output:  none
;* * * * * * * * * * * * * *


	public	EMS_RELEASE
EMS_RELEASE	proc	far
;
; check if ems memory allocated
;
mc_ems: mov	dx,ems_handle
	cmp	dx,0
	je	mc_exit				;jmp if no ems allocated
;
; release ems memory block
;
	mov	ah,45h
	int	67h				;release ems memory block
	mov	ems_handle,0
mc_exit:
	retf
EMS_RELEASE	endp

LIBSEG	ENDS
;;	end
