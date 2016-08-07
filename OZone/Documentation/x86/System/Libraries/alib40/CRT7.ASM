	page	66,132
;******************************** CRT7.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	INCLUDE	 COMMON.INC
.list
;----------------------------------------------------------------------------
	EXTRN	POSN_TO_ADR:NEAR
	EXTRN	MEM_ALLOCATE:FAR
	EXTRN	MEM_PUT:FAR
	EXTRN	MEM_GET:FAR
	EXTRN	MEM_RELEASE:FAR
	EXTRN	LIB_INFO:BYTE
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
save_window - save area of display in memory buffer
;
; inputs: dx=box left corner (dh=row,dl=column)
;         bh=rows in window
;	  bl=columns in window
;	  
; output: carry set if error
; 
; processing: save up to three window areas which can be restored
;	       with restore_window.  The memory manager is called
;	       to allocate room to store windows saved.
;* * * * * * * * * * * * * *

sav_struc	struc
 sw_handle		dw	?	;seg of allocated memory
 sw_di_sav	dw	?	;display starting offset
 sw_bx_sav	dw	?	;bh=rows bl=columns
sav_struc	ends

sw_saved_cnt	dw	0	;number of windows saved

sw_sav1		sav_struc<>
		sav_struc<>
		sav_struc<>
		sav_struc<>
;--------------------------
	public	save_window
save_window	proc	far
	apush	ax,bx,cx,dx,si,di,ds,es
	call	posn_to_adr			;compute display location
	push	bx				;save box rows/columns
	mov	ax,bx
	mul	ah				;ax= # bytes in box
	shl	ax,1				;add in size of attributes
	sub	dx,dx				;setup for mem allocation
	mov	bx,0				;normal allocation
	call	mem_allocate
	mov	ax,bx				;move handle to -ax-
	jc	sw_exit				;jmp if error
;
; compute location to store allocated seg
;
sw_cont:
	pop	bx				;restore box rows & column cnt
	mov	cx,cs:sw_saved_cnt
	mov	si,offset sw_sav1
sw_lookup:
	jcxz	sw_skip				;jmp if first entry
	add	si,size sav_struc
	loop	sw_lookup
sw_skip:mov	word ptr cs:[si.sw_handle],ax	;save segment allocated
	mov	word ptr cs:[si.sw_bx_sav],bx	;save box rows(bh) columns(bl)
	mov	word ptr cs:[si.sw_di_sav],di	;save display offset

	inc	cs:sw_saved_cnt
;
; es:di = display address   ax=allocated mem seg  bh=rows  bl=columns
;
	sub	ax,ax
	mov	al,cs:lib_info.crt_columns
	shl	ax,1
	
	mov	dx,bx			;dh=rows to save  dl=columns per row
	mov	bp,es			;bp=from seg (display)
	mov	bx,cs:[si.sw_handle]	;get to handle
	mov	si,di			;si=from offset (display)
	mov	di,0			;di=to index (offset)
;
; bp:si=from(display) di=to(index) cx=words  bx=handle
;
sw_sav_lp:
	sub	cx,cx
	mov	cl,dl
	call	mem_put
	add	si,ax			;move to next crt line
	mov	cl,dl
	shl	cx,1
	add	di,cx			;update -to- ptr
	dec	dh
	jnz	sw_sav_lp
	clc
sw_exit:apop	es,ds,di,si,dx,cx,bx,ax
	retf
save_window	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
restore_window - restore a previously saved area of display
;
; inputs: none
; 
; output: carry set if error
;         all registers are saved
; 
; processing: restore uses information in save_window to restore the last
;	       window saved.  Up to three windows can be saved and then
;	       restored in reverse order.
;* * * * * * * * * * * * * *

	public	restore_window
restore_window	proc	far
	apush	ax,bx,cx,dx,si,di,ds,es
;
; compute location to restore from data saved by save_window
;
	mov	cx,cs:sw_saved_cnt
	jcxz	rw_abort			;jmp if no windows saved
	mov	si,offset sw_sav1
rw_lookup:
	add	si,size sav_struc
	loop	rw_lookup
	sub	si,size sav_struc
	mov	dx,word ptr cs:[si.sw_bx_sav]	;get box rows(bh) columns(bl)
	mov	di,word ptr cs:[si.sw_di_sav]	;get display offset
	mov	bp,cs:lib_info.crt_seg
	mov	bx,word ptr cs:[si.sw_handle]	;get segment allocated
	mov	si,0

;
; bp:di = display address   si=index bx=handle   dh=rows  dl=columns
;
	sub	ax,ax
	mov	al,cs:lib_info.crt_columns
	shl	ax,1				;compute bytes on one crt row
rw_sav_lp:
	sub	cx,cx
	mov	cl,dl
	call	mem_get				;restore window
	add	di,ax				;move to next crt line
	mov	cl,dl
	shl	cx,1
	add	si,cx				;move to next buffer index
	dec	dh
	jnz	rw_sav_lp

	call	mem_release

rw_cont:dec	cs:sw_saved_cnt
	clc
	jmp	rw_exit
rw_abort:
	stc
rw_exit:		
	apop	es,ds,di,si,dx,cx,bx,ax
	retf
restore_window	endp
;

LIBSEG	ENDS
	end
