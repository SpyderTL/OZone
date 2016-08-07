	PAGE	66,132
;******************************** MEMORY.ASM *********************************
;
; MEM_OPEN     - interrogate memory and setup database
; MEM_ALLOCATE - allocate a block of memory
; MEM_PUT      - write to allocated memory area
; MEM_GET      - read from allocated memory area
; MEM_RELEASE  - release allocated memory block
; MEM_CLOSE    - close memory handler
;
; Note:  The following calls still need MEM_OPEN & MEM_CLOSE, but
;	 allow the MEM_PUT & MEM_GET calls to be avoided.
;
; DOS_MEM_ALLOCATE - returns segment for direct writes to allocated memory
; DOS_MEM_RELEASE  - releases memory allocated with DOS_MEM_ALLOCATE
;
; Note: The memory manager utilizes DOS,XMS, and EMS memory and isolates
;       the caller from memory minipulation.  All interfaces with memory
;       are handled through memory manager calls.
;
; Note: The mem_open,mem_allocate, and mem_close are required calls if any
;	part of the memory manager is utilized. For most efficient
;	memory allocation always let the memory manager decide where to
;	allocate memory from, and then use only the memory manager calls
;	to transfer data.  This strategy allows a program to work if any
;	of the three types of memory is available.
;
;	LIMITATIONS - The largest block which can be allocated for use
;                     is 64k
;		    - The maximum number of allocations active at once
;		      is set to 50.  Contact author to increase/decrease
;		    - The smallest allocation unit is 1 word
;                   - The maximum amount of memory which can be managed
;                     is about 32mega bytes
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
;
mem_pkt struc
 mem_fwd    dw	    ?	;forward memory address ptr. -1=end of chain
 mem_bak    dw	    ?	;backwards memory address ptr. 0=start of chain
 mem_flg    db	    ?	;see below
 mem_blk_sz dd	    ?	; bytes(dos) bytes(xms) bytes(ems)
 mem_loc    dd	    ?	; abs(dos)  index(xms)  index,page(ems)
mem_pkt ends

; mem_flg definitions  80 - pkt in use & memory in use
;		       40 - pkt in use & memory available to be allocated
;		       03 - memory type 1(dos) 2(xms) 3(ems)
;
mem_pkts	equ	50
pkt_area	label	byte
 db	((size mem_pkt)*(mem_pkts)) dup (0)	;all packets reside here
pkt_area_end	label	byte

free_srch_ptr	dw	pkt_area	;circular ptr for free pkt sreach

dos_chain	dw	0		;ptr to dos chain (0=no dos chain)
xms_chain	dw	0		;ptr to xms chain (0=no xms chain)
ems_chain	dw	0		;ptr to ems chain (0=no ems chain)

dos_initial_seg	dw	0		;seg of initial dos seg
dos_initial_sz	dw	0		;paragraphs allocated
;
;---------------------------------
; expanded memory data base
;---------------------------------

ems_handle	dw	0
ems_frame	dw	0		;seg of ems page, 0=no page
ems_initial_sz	dw	0		;16k-byte pages avail

current_logical_page	dw	-1

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
MEM_OPEN - interrogate memory and setup database.
;
; inputs:  none
;
; output:  no carry = success, ax=total 1k blocks allocated
;	    carry = error/warning, if ax=7 DOS memory was not found.
;				      ax=2 fatal programming error
;

; processing: 1. determine memory available and setup database
;	       2. allocate all available memory
;
; Note: DOS memory is required for many library functions so
;       it must be available.  See sample programs for method
;       needed to make DOS memory available.
;
;       This function is called once at the start of a program.
;	The Library_setup function calls mem_open, so it should
;	not need to be called directly.
;
;       The following calls still need MEM_OPEN & MEM_CLOSE, but
;	allow the MEM_PUT & MEM_GET calls to be avoided.
;
;       DOS_MEM_ALLOCATE - returns segment for direct writes to
;                          allocated memory
;       DOS_MEM_RELEASE  - releases memory allocated with DOS_MEM_ALLOCATE
;
;       The memory manager utilizes DOS,XMS, and EMS memory and isolates
;       the caller from memory minipulation.  All interfaces with memory
;       can be handled through memory manager calls.
;
;       The mem_open,mem_allocate, and mem_close are required calls if any
;	part of the memory manager is utilized. For most efficient
;	memory allocation always let the memory manager decide where to
;	allocate memory from, and then use only the memory manager calls
;	to transfer data.  This strategy allows a program to work if any
;	of the three types of memory is available.
;
;	LIMITATIONS - The largest block which can be allocated for use
;                     is 64k
;		    - The maximum number of allocations active at once
;		      is set to 50.  Contact author to increase/decrease
;		    - The smallest allocation unit is 1 word
;                   - The maximum amount of memory which can be managed
;                     is about 32mega bytes
;
;      Before doing an exec call to DOS it is necessary to do a mem_close
;      to make memory available.  Then, do a mem_open upon return.  The
;      library function SPAWN_DOS is the only function that does an exec
;      call to DOS.  After the mem_close and mem_open sequence all previous
;      data is lost.
;* * * * * * * * * * * * * *

	public	mem_open
mem_open	proc	far
	apush	bx,cx,dx,si,di,ds,es
	cld
	mov	ax,cs
	mov	ds,ax
	mov	es,ax

	cmp	dos_initial_sz,0
	je	mop_1			;jmp if first entry
	mov	ax,2
	stc
	jmp	mop_exit		;jmp if memory already allocated
;
; clear the packet area
;
mop_1:	mov	di,offset pkt_area
	mov	cx,(size mem_pkt)*mem_pkts
	cld
	mov	al,0
	rep	stosb
;
; check if any DOS memory is available, and if not return warning
;
	mov	bx,-1
	mov	ah,48h
	int	21h			;try to allocate impossible amount
;
; we should have the carry set here (error) and -bx- has maximum amount
; of memory available.
;
	cmp	bx,0			;check if any memory is available
	je	mop_error7		;jmp if no memory
;
; When using PS (periscope) it takes all of DOS memory, so we need to
; debug by using PSKEY and not RUN.COM.
;	
	mov	dos_initial_sz,bx	
	mov	ah,48h
	int	21h			;now allocate the maximum amount.
	jnc	mop_dos_setup		;jmp if DOS memory allocated ok
mop_error7:	
	mov	ax,7			;get error code
	stc
	jmp	mop_exit
;
; build one DOS packet with all available memory
;
mop_dos_setup:
	mov	dos_initial_seg,ax
	call	get_free_pkt		;returns free pkt ptr -bx-
	mov	dos_chain,bx
	mov	[bx.mem_fwd],-1		;end of chain
	mov	[bx.mem_bak],0		;start of chain
	mov	[bx.mem_flg],41h	;pkt has memory, type=DOS
	mov	ax,dos_initial_sz
	call	seg_to_abs
	mov	word ptr [bx.mem_blk_sz],ax
	mov	word ptr [bx.mem_blk_sz+2],dx

	mov	ax,dos_initial_seg
	call	seg_to_abs
	mov	word ptr [bx.mem_loc],ax	;store abs loc
	mov	word ptr [bx.mem_loc+2],dx	; in packet

;----------------------
; check if any XMS memory is available, and setup database if it is
;
check_for_xms:
	mov	ax,4300h
	int	2fh
	cmp	al,80h		;check if driver found
	jne	check_ems	;jmp if no xms memory present
;
	mov	ax,4310h
	int	2fh		;request control address
	mov	word ptr xms_control,bx
	mov	word ptr xms_control+2,es

; request size of largest block in -ax- (k bytes)

	mov	ah,8
	call	xms_control	;returns ax=largest k-blk  dx=total k-blks
	cmp	ax,0
	je	check_ems	;jmp if no xms available
;
; allocate largest xms block
;
mop_lp:	mov	dx,ax		;put largest block in -dx-
	mov	xms_initial_sz,ax
	mov	ah,9
	call	xms_control
	cmp	ax,01
	je	mop_2		;jmp if allocation sucessful
;
; xms will not allocated this block size, reduce size and retry
;	
	mov	ax,xms_initial_sz
	shr	ax,1
	cmp	ax,0
	jne	mop_lp		;jmp if reduced allocation greater than zero
	mov	ax,2
	stc
	jmp	mop_exit

mop_2:	mov	xms_from_read_handle,dx
	mov	xms_to_write_handle,dx
	mov	xms_handle,dx
;
; setup the XMS packet with all available memory
;
	call	get_free_pkt		;returns free pkt ptr -bx-
	mov	xms_chain,bx
	mov	[bx.mem_fwd],-1		;end of chain
	mov	[bx.mem_bak],0		;start of chain
	mov	[bx.mem_flg],42h	;pkt has memory, type=XMS

	mov	ax,xms_initial_sz	;get size in 1k blocks
	mov	dx,1024			;size of 1k blk
	mul	dx
	mov	word ptr [bx.mem_blk_sz],ax	  ;save size
	mov	word ptr [bx.mem_blk_sz+2],dx	;save size

	mov	word ptr [bx.mem_loc],0		;store relative loc
	mov	word ptr [bx.mem_loc+2],0	; in packet

;---------------------
; check if any EMS memory is available, and setup database if it is
;
check_ems:
	call	CHECK_FOR_EMS
	jc	mop_exit1		;jmp if no ems avail
	mov	ems_frame,bx		;save page frame
	
	mov	ah,42h			;get avail. page count
	int	67h
	or	ah,ah
	jz	mop_3			;jmp if no error
	mov	ax,2
	stc
	jmp	mop_exit
;
; allocate ems pages, bx=unallocated page count
;
mop_3:	mov	ems_initial_sz,bx	;save # 16k pages avail.
	cmp	bx,0
	je	mop_exit1		;jmp if no ems pages avail.
	mov	ah,43h			;allocate pages request code
	int	67h
	cmp	ah,0
	je	mop_4			;jmp if success
;
; try to allocate reduced amount
;
	shr	bx,1
	jmp	mop_3	
;
; setup the EMS packet will all available ems memory
;
mop_4:	mov	ems_handle,dx		;save ems handle
	call	get_free_pkt		;returns free pkt ptr -bx-
	mov	ems_chain,bx
	mov	[bx.mem_fwd],-1		;end of chain
	mov	[bx.mem_bak],0		;start of chain
	mov	[bx.mem_flg],43h	;pkt has memory, type=EMS

	mov	ax,ems_initial_sz
	mov	dx,1024*16		;16k page size
	mul	dx
	mov	word ptr [bx.mem_blk_sz],ax	  ;save size
	mov	word ptr [bx.mem_blk_sz+2],dx	;save size

	mov	word ptr [bx.mem_loc],0		;store relative loc
	mov	word ptr [bx.mem_loc+2],0	; in packet
	
;
; compute total amount of memory allocated in 1k blocks
;
mop_exit1:
	mov	ax,dos_initial_sz
	mov	cx,3
	shr	ax,cl
	push	ax
	mov	ax,ems_initial_sz
	mov	cx,3
	shl	ax,cl
	pop	bx
	add	ax,bx
	add	ax,xms_initial_sz
	clc

mop_exit:
	apop	es,ds,di,si,dx,cx,bx
	retf

mem_open	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
MEM_ALLOCATE - allocate a block of memory.
;
; inputs:     dx,ax=number of bytes to allocate, dx=high word ax=low word
;             bx=allocation method, 0=normal allocation
;                                   1=only allocate DOS memory
;
; outputs:   no carry  bx=memory mgr handle, use to read/write/release
;	     carry     insufficient memory, or too many allocations active
;                      or -bx- not set correctly
;
; note:   This function is called each time a new block of memory is needed.
;         If register BX is set to normal allocation, then the MEM_GET and
;         MEM_PUT calls must be used to access memory.
;* * * * * * * * * * * * * *

	public	mem_allocate
mem_allocate	proc	far
	apush	ax,cx,dx,si,di,ds,es
	mov	cx,cs
	mov	ds,cx
	mov	es,cx

	cmp	bx,0
	je	normal_allocation
	cmp	bx,1
	je	dos_allocation
	stc
	jmp	ma_exit				;jmp if -bx- not set correctly
;
; allocate DOS memory
;
dos_allocation:
	mov	bx,dos_chain
	call	find_memory			;check if any DOS memory
	jnc	ma_got_pkt			;jmp if memory found
	jmp	ma_failure			;jmp if no dos memory
			
normal_allocation:
	mov	bx,ems_chain
	call	find_memory			;check if any ems memory
	jnc	ma_got_pkt			; jmp if ems memory found

	mov	bx,xms_chain
	call	find_memory			;check if any xms memory
	jnc	ma_got_pkt			; jmp if xms memory found

	mov	bx,dos_chain
	call	find_memory			;check if any dos memory
	jc	ma_failure			; jmp if no dos memory
;
; we have a packet with enough memory, check if exact match
;
ma_got_pkt:
	cmp	dx,word ptr [bx.mem_blk_sz+2]
	jne	ma_extract_mem
	cmp	ax,word ptr [bx.mem_blk_sz]
	je	ma_exit1			;jmp if exact match
ma_extract_mem:	
	mov	si,bx
;
; -si- points to a packet with memory, strip out some for the caller
; -ax,dx- has amount of memory requested by caller
;
	call	get_free_pkt			;returns pkt in -bx-
	jc	ma_failure			;jmp if out of packets
;
; remove memory from the mother packet
;
	sub	word ptr [si.mem_blk_sz],ax
	sbb	word ptr [si.mem_blk_sz+2],dx
;
	mov	cl,[si.mem_flg]			;copy flg data
	mov	[bx.mem_flg],cl

	mov	word ptr [bx.mem_blk_sz],ax	;put size in new pkt
	mov	word ptr [bx.mem_blk_sz+2],dx
;
; compute address for new packet
;   dx,ax=memory allocated  si=mother pkt  bx=new packet
;
; Note: we must take the memory from the end of the mother packet, so that
;	insert_mem_packet never has to insert at front of chain.
;
        mov     ax,word ptr [si.mem_loc]        ;get mother pkt's location
	mov	dx,word ptr [si.mem_loc+2]

        add     ax,word ptr [si.mem_blk_sz]        ;compute end of mother's
	adc	dx,word ptr [si.mem_blk_sz+2]	   ;  memory (start of new pkt)

        mov     word ptr [bx.mem_loc],ax        ;store new pkt's
	mov	word ptr [bx.mem_loc+2],dx	;  memory location

	call	insert_mem_packet

ma_exit1:
	and	[bx.mem_flg],3fh			;remove flags from pkt
	or	[bx.mem_flg],80h			;set in-use flag
	clc
	jmp	ma_exit
ma_failure:
	stc	
ma_exit:
	apop	es,ds,di,si,dx,cx,ax
	retf
mem_allocate	endp

;------------------------------
; find_memory - scan one chain to look for free memory
;  inputs:  ds:bx - points to first packet on chain
;           dx,ax - number of bytes to allocate
;  output:  no carry, bx=packet with memory
;           carry = insufficient memory
;
find_memory:
	cmp	bx,0
	je	fm_failure			;jmp if no chain
     	test	[bx.mem_flg],040h		;check if avail. memory here
	jz	fm_next_pkt			; jmp if memory in-use
	cmp	dx,word ptr [bx.mem_blk_sz+2]	;check high word
	jb	fm_got_pkt			;jmp if sufficient mem in pkt
	ja	fm_next_pkt			;jmp if insufficient mem in pkt
	cmp	ax,word ptr [bx.mem_blk_sz]	;check low word
	jbe	fm_got_pkt			;jmp if memory found
fm_next_pkt:
	mov	bx,[bx.mem_fwd]			;get next packet
	cmp	bx,-1
	jne	find_memory			;jmp if more packets to check
fm_failure:	
	stc
	jmp	fm_exit				;no memory exit
fm_got_pkt:
	clc
fm_exit:
	ret		
;
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
MEM_PUT - write to allocated memory area.
;
; inputs:     bx = memory mgr handle
;	   bp:si = ptr to data
;             di = put location (index from start of block) 0=start of blk
;	      cx = length of bp:si data in words
;
;  output:   no carry = success
;	        carry = error code in -ax- (from EMS/XMS driver)
;
; note:  This function is called to transfer data to allocated memory.
;	        
* * * * * * * * * * * * * *

	public	mem_put
mem_put proc	far
	apush	ax,bx,cx,dx,si,di,bp,ds,es
	cld
	push	cs
	pop	ds
	mov	al,[bx.mem_flg]
	and	al,3				;isolate memory type
	cmp	al,3
	je	mp_ems
	cmp	al,2
	je	mp_xms
;
; move dos memory
;
	call	copy_to_dos_mem
	jmp	mp_exit
mp_xms: call	copy_to_xms_mem
	jmp	mp_exit
mp_ems: call	copy_to_ems_mem
mp_exit:
	apop	es,ds,bp,di,si,dx,cx,bx,ax
	retf
mem_put endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
MEM_GET - read from allocated memory area.
;
; inputs:      bx = memory mgr handle
;	    bp:di = location to store data
;	       si = get location (index from start of block)
;	       cx = number of words to read
;
; output:  no carry = success
;	   carry    = error code in -ax- (from EMS/XMS driver)
;
; processing: data is read from the start of block for -cx- bytes
;
; note:  This function is called to transfer data from allocated memory.
;* * * * * * * * * * * * * *

	public	mem_get
mem_get proc	far
	apush	ax,bx,cx,dx,si,di,bp,ds,es
	cld
	push	cs
	pop	ds
	mov	al,[bx.mem_flg]
	and	al,3				;isolate memory type
	cmp	al,3
	je	mg_ems
	cmp	al,2
	je	mg_xms
;
; move dos memory
;
	call	copy_from_dos_mem
	jmp	mg_exit
mg_xms: call	copy_from_xms_mem
	jmp	mg_exit
mg_ems: call	copy_from_ems_mem
mg_exit:
	apop	es,ds,bp,di,si,dx,cx,bx,ax
	retf
mem_get endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
MEM_RELEASE  - release allocated memory block.
;
; inputs:     bx = memory mgr handle
; 
; output:     none
; 
; processing:  1. convert packet into free memory.
;	       2. garbage collect on both sides of chain.
;
; note:  This function releases blocks of memory which were allocated
;	 by mem_allocate.
;* * * * * * * * * * * * * *

	public	mem_release
mem_release	proc	far
	apush	ax,bx,cx,dx,si,di,bp,ds,es
	push	cs
	pop	ds
	xor	[bx.mem_flg],0c0h		;set memory available (4x)
	cmp	[bx.mem_bak],0			;check if at start of chain
	je	mr_ck_fwd			;jmp if at top of chain
;
; there is a packet preceeding this one, check if we can combine packets
;
	mov	si,[bx.mem_bak]
	test	[si.mem_flg],80h		;check if mem available
	jnz	mr_ck_fwd			; jmp if memory is in-use
;
; the previous packet is not in-use, combine it with this pkt
;
	mov	ax,word ptr [bx.mem_blk_sz]
	mov	dx,word ptr [bx.mem_blk_sz+2]	;get released blk size

	add	word ptr [si.mem_blk_sz],ax
	adc	word ptr [si.mem_blk_sz +2],dx

	mov	[bx.mem_flg],0			;free this pkt
	call	extract_mem_pkt			;remove pkt from chain
	mov	bx,di				;move to previous pkt
;
; check if we can combine this packet with the forward pkt
;
mr_ck_fwd:
	cmp	[bx.mem_fwd],-1
	je	mr_exit				;jmp if at end of chain
	mov	si,[bx.mem_fwd]			;get forward pkt ptr

	test	[si.mem_flg],80h		;check if forward pkt in-use
	jnz	mr_exit				;jmp if memory in-use
;
; the fwd packet is not in-use, so combine it with mother pkt (bx)
;
	mov	ax,word ptr [si.mem_blk_sz]
	mov	dx,word ptr [si.mem_blk_sz+2]	;get released blk size

	add	word ptr [bx.mem_blk_sz],ax
	adc	word ptr [bx.mem_blk_sz +2],dx

	mov	[si.mem_flg],0			;free this pkt
	xchg	si,bx
	call	extract_mem_pkt			;remove pkt from chain

mr_exit:
	apop	es,ds,bp,di,si,dx,cx,bx,ax
	retf
mem_release	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
MEM_CLOSE - close memory handler.
;
; inputs:     none
; output:     none
; 
; note:  This function is called just before the program exits
;	 to return all memory back to the SYSTEM.  Normally,
;	 this is accomplished in the LIBRARY_TERMINATE function.
;* * * * * * * * * * * * * *

	public	mem_close
mem_close	proc	far
	apush	ax,bx,cx,dx,si,di,bp,ds,es
	push	cs
	pop	ds
	cmp	dos_initial_seg,0
	je	mc_xms				;jmp if dos mem not allocated
;
; release DOS memory
;
	mov	es,dos_initial_seg
	mov	ah,49h
	int	21h				;release DOS memory
	mov	dos_initial_seg,0
;
; check if xms memory allocated
;
mc_xms: mov	dx,xms_handle
	cmp	dx,0
	je	mc_ems				;jmp if no xms allocated
	mov	ah,0ah
	call	xms_control			;release xms memory block
	mov	xms_handle,0
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
	apop	es,ds,bp,di,si,dx,cx,bx,ax
	retf
mem_close	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
DOS_MEM_ALLOCATE - allocate dos memory for direct writes
;
; inputs:  dx,ax - number of bytes to allocate
; 
; output:   no carry  es = segment of memory allocated
;	       carry	 = failure allocating memory
;
; note:  This function is used only if the program wants to read and
;        write memory directly.  Is is faster than MEM_GET and MEM_PUT
;        but is limited to DOS memory only.	       
;* * * * * * * * * * * * * *

	public	dos_mem_allocate
dos_mem_allocate	proc	far
	apush	ax,bx,dx,ds
	push	cs
	pop	ds
	mov	bx,1				;allocate only DOS memory
	add	ax,15				;adjust for segment
	adc	dx,0				;adjust for segment usage
	and	ax,0fff0h			;mod 16
	call	mem_allocate
	jc	dma_exit
	mov	ax,word ptr cs:[bx.mem_loc]
	mov	dx,word ptr cs:[bx.mem_loc+2]
	test	ax,000fh			;check if even seg boundry
	jz	dma_make_seg
	or	ax,000fh
	add	ax,1
	adc	dx,0
dma_make_seg:	
	call	abs_to_seg
	mov	es,ax
	clc
dma_exit:
	apop	ds,dx,bx,ax
	retf
dos_mem_allocate	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
DOS_MEM_RELEASE - release memory allocated with DOS_MEM_ALLOCATE
;
;  inputs:  es = segment of memory to release
;  
;  output:  no carry = success
;	       carry = bad segment
;* * * * * * * * * * * * * *

	public	dos_mem_release
dos_mem_release proc	far
	apush	ax,bx,cx,dx,ds
	push	cs
	pop	ds
	mov	cx,es
	mov	bx,dos_chain
dmr_lp: cmp	bx,0
	je	dmr_failure
	mov	ax,word ptr [bx.mem_loc]
	mov	dx,word ptr [bx.mem_loc+2]
	test	ax,000fh			;check if even seg boundry
	jz	dmr_make_seg
	or	ax,000fh
	add	ax,1
	adc	dx,0
dmr_make_seg:
	call	abs_to_seg
	cmp	ax,cx
	je	dmr_found_it			;jmp if we have found the pkt
	mov	bx,[bx.mem_fwd]
	jmp	dmr_lp
;
; we have found the packet for this segment, release it
;
dmr_found_it:
	call	mem_release
	clc
	jmp	dmr_exit
dmr_failure:
	stc
dmr_exit:
	apop	ds,dx,cx,bx,ax
	retf
dos_mem_release endp
;---------------------------------------------------------------------------
; memory subroutines
;---------------------------------------------------------------------------
; copy_to_dos_mem - copy callers data to memory
;   inputs:  bp:si = from address
;		cx = number of words to transfer
;		di = index into block
;		bx = DOS memory handle (structure ptr)
;
copy_to_dos_mem:
	apush	ax,cx,dx,si,di,ds
;
; compute memory destination address, use info. in packet for base adr
;
	mov	ax,word ptr [bx.mem_loc]	;get block base adr
	mov	dx,word ptr [bx.mem_loc+2]	;  assumes seg of zero
	add	ax,di				;add in callers
	adc	dx,0				;  index
;
; convert absolute address in ds,ax into seg:offset
;
	mov	di,ax
	and	di,000fh			;isolate offset
	call	abs_to_seg
	mov	es,ax

	mov	ds,bp				; setup -from- segment
	rep	movsw				;move cx data blocks
	apop	ds,di,si,dx,cx,ax
	ret
;--------------------------------------------------------------------------
; copy_to_xms_mem - copy callers data to memory
;   inputs:  bp:si = from address
;		cx = number of words to transfer
;		di = index into segment
;		bx = current packet ptr
;   output:   carry set if error
;
copy_to_xms_mem:
	push	bx
	mov	ax,word ptr [bx.mem_loc]	;compute abs
	mov	dx,word ptr [bx.mem_loc+2]	; address to write
	add	ax,di
	adc	dx,0

	mov	word ptr [xms_to_write_address],ax
	mov	word ptr [xms_to_write_address+2],dx

	shl	cx,1				;convert words to bytes
	mov	word ptr xms_write_len,cx

	mov	xms_from_write_offset,si
	mov	xms_from_write_segment,bp

	mov	si,offset write_xms_packet
	mov	ah,0bh
	call	xms_control
	pop	bx
	cmp	ax,1
	jne	xms_failure1
	clc
	ret
xms_failure1:
	stc
	ret

;--------------------------------------------------------------------------
; copy_to_ems_mem - copy callers data to memory
;   inputs:  bp:si = from address
;		cx = number of words to transfer
;		di = index into segment
;		bx = current packet ptr
;   output:     carry set if error
;
;
copy_to_ems_mem:
	apush	 bx,ds,es
	add	si,word ptr [bx.mem_loc]	;compute page offset
	mov	bx,word ptr [bx.mem_loc+2]	;get page

; di = offset into emm page
; bx = page number
; bp:si = from address
; cx = number of bytes to transfer
;
	cmp	bx,CURRENT_LOGICAL_PAGE	;check if this sector is in mem.
	jz	ctem_1			;jump if page in memory
	mov	CURRENT_LOGICAL_PAGE,bx	;save new logical page indicator
	mov	dx,ems_handle		;get our handle
	mov	ax,4400h		;get request code & phys. page
	int	67h			;get data from eem handler
	or	ah,ah
	jnz	t_err
;
; compute the address of sector	returned by emm	handler
;
ctem_1: MOV	es,ems_frame		;destination (segment)
;
; setup	source address (users buffer)
;
	mov	ds,bp			;get -from- segment
	cld
	rep	movsw			;move block
	clc
	jmp	ctem_exit
t_err:	stc
ctem_exit:
	apop	 es,ds,bx
	ret
;
;--------------------------------------------------------------------------
; copy from memory to caller
;--------------------------------------------------------------------------
;   inputs:  bp:di = to address
;		si = index into memory block
;		cx = number of words to transfer
;		bx = current packet ptr
;
copy_from_dos_mem:
	apush	 bx,ds,es
	mov	es,bp
	mov	ax,word ptr [bx.mem_loc]
	mov	dx,word ptr [bx.mem_loc+2]
	add	ax,si
	adc	dx,0
	mov	si,ax
	and	si,0fh				;isolate offset
	call	abs_to_seg
	mov	ds,ax				;move seg to -ds-
	rep	movsw				;move data
	apop	 es,ds,bx
	ret
;---------------------------------
;** **XMS memory -> buffer
;---------------------------------
;   inputs:  bp:di = to address
;		si = index into memory block
;		cx = number of words to transfer
;		bx = current packet ptr
;
copy_from_xms_mem:
	push	bx
	mov	ax,si
	mov	dx,0
	add	ax,word ptr [bx.mem_loc]
	adc	dx,word ptr [bx.mem_loc+2]

	mov	word ptr [xms_from_read_address],ax
	mov	word ptr [xms_from_read_address+2],dx

	shl	cx,1				;convert words to bytes
	mov	word ptr xms_read_len,cx

	mov	xms_to_read_offset,di	;save buffer offset
	mov	xms_to_read_segment,bp	;save buffer segment

	mov	si,offset read_xms_packet
	mov	ah,0bh
	call	xms_control
	pop	bx
	cmp	ax,1
	jne	xms_failure2
	clc
	ret
xms_failure2:
	stc
	ret
;---------------------------------
;** **expanded memory -> buffer
;---------------------------------
;   inputs:  bp:di = to address
;		si = index into memory block
;		cx = number of words to transfer
;		bx = current packet ptr
;
copy_from_ems_mem:
	apush	bx,ds,es
	add	si,word ptr [bx.mem_loc]    ;compute offset
	mov	bx,word ptr [bx.mem_loc+2]  ;get emm page
;
; si = offset into emm page
; bx = page number

;  inputs bx = emm page
;  output si = pointer to data
;
	cmp	bx,CURRENT_LOGICAL_PAGE	;check if this sector is in mem.
	jz	dfem_1			;jmp if page already present
	mov	CURRENT_LOGICAL_PAGE,bx	;save new logical page indicator
	mov	dx,ems_handle		;get our handle
	mov	ax,4400h		;get request code & phys. page
	int	67h			;get	data from eem handler
	or	ah,ah			;check for errors
	jnz	terr
dfem_1:
	MOV	ds,ems_frame		;source (segment)
	mov	es,bp
	cld
	rep	movsw			;move block
	sti
	clc
	jmp	dfem_exit
terr:	stc
dfem_exit:
	apop	 es,ds,bx
	ret
;
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
CHECK_FOR_EMS:      detects EMS driver
;
; inputs:  none
;
; output:  if CF = 1, no Expanded Memory manager installed
;          if CF = 0, AH = EMM error code
;          if AH = 0, BX = page frame segment address
;          registers changed  AX,BX           
;* * * * * * * * * * * * * *

emm_name  DB      'EMMXXXX0',0

CHECK_FOR_EMS	proc	near
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
	jz	ie_exit			; jmp if no errors
no_ems:
	stc
ie_exit:
	apop	ds,di,si,cx
	ret
CHECK_FOR_EMS	endp

;--------------------------------------------------------------------------
; get_free_pkt - returns free packet offset in -bx-
;  inputs:  ds points to database
;  output:  no carry  -  ds:bx - pointer to free pkt
;           carry     -  out of free packets
;
get_free_pkt:
	push	cx
	mov	bx,free_srch_ptr		;search from top
	mov	cx,mem_pkts			;number of avail. pkts
gfp_lp:	cmp	bx,offset pkt_area_end
	jb	gfp_1
	mov	bx,offset pkt_area
gfp_1:	test	[bx.mem_flg],0c0h		;check if pkt in use
	jz	gfp_got_pkt
	add	bx,size mem_pkt
	loop	gfp_lp
;
; we have gone around once and no free packets were found. Abort
;	
	stc
	jmp	gfp_exit
gfp_got_pkt:
	mov	free_srch_ptr,bx
	clc
gfp_exit:	
	pop	cx		
	ret
;---------------------------------------------------------------------------
; extract_mem_pkt - unchains one packet
;  inputs: ds:bx - points at packet
;
extract_mem_pkt:
	mov	si,[bx.mem_fwd]		    ;get fwd
	mov	di,[bx.mem_bak]		    ;get bak
	mov	[di.mem_fwd],si		    ;put new fwd ptr in bak packet
	cmp	si,-1
	je	emp_exit		    ;exit if extracted pkt at end
	mov	[si.mem_bak],di		    ;put new bak ptr in fwd packet
emp_exit:
	ret
;---------------------------------------------------------------------------
; insert_packet - insert packet in chain
;  inputs: ds:bx - points to free packet (unchaned)
;	   ds:si - mother packet to insert after (mother packet)
;
; processing: Memory is always allocated from the end of a mother packet
;	      so this new packet is inserted after a mother packet.
;
insert_mem_packet:

; bx=new pkt,  si=insert after pkt
;
imp_3:	mov	di,[si.mem_fwd]		    ;get fwd packet
;
; fill in the new packet
;
        mov     [bx.mem_fwd],di             ;new fwd (old mother's fwd)
	mov	[bx.mem_bak],si		    ;new bak (mother)
;
; adjust chain of packets on both sides of new packet
;
	mov	[si.mem_fwd],bx		    ;point mother -> new
	cmp	di,-1			    ;check if forward pkt exists
	je	imp_exit
	mov	[di.mem_bak],bx		    ;point forward pkt mem_bak->new
imp_exit:
	ret
;---------------------------------------------------------------------------
; abs_to_seg - convert absolute adr to segment
;  inputs:  dx,ax = absolute address
;  output:  ax = segment
;
abs_to_seg:
	push	cx
	mov	cx,4
	and	ax,0fff0h		;remove non seg bits
ats_lp: shr	dx,1
	rcr	ax,1
	loop	ats_lp
	pop	cx
	ret

;---------------------------------------------------------------------------
; seg_to_abs - convert seg to absolute address
;  inputs: ax=segment
;  output: dx,ax = absolute addrss
;
seg_to_abs:
	push	cx
	mov	cx,4
	sub	dx,dx
sta_lp: shl	ax,1
	rcl	dx,1
	loop	sta_lp
	pop	cx
	ret


LIBSEG	ENDS
	end
