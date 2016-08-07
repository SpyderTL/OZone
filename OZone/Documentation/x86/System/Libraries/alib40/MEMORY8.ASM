	PAGE	66,132
;****************************** MEMORY8.ASM *********************************
;
;----------------------------------------------------------------------------
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list

;-----------------------------------------------------------------------;
;	Segment Descriptor (part of Global Descriptor	Table)		 ;
;-----------------------------------------------------------------------;
DESC	STRUC			  ;data segment descriptor
 DESC_LMT   DW	0		 ;segment limit (length)
 DESC_BASEL DW	0		 ;bits 15-0 of physical address
 DESC_BASEH DB	0		 ;bits 23-16 of physical address
 DB	0			 ;access rights	byte
 DW	0			 ;reserved
DESC	ENDS

align 4
;-----------------------------------------------------------------------
; bios extended	memory database
;-----------------------------------------------------------------------;
;	Global Descriptor Table (GDT), used for extended memory moves	;
;-----------------------------------------------------------------------;
;Access	Rights Byte (93H) is
;	P=1	(segment is mapped into physical memory)
;	E=0	(data segment descriptor)
;	D=0	(grow up segment,	offsets	must be	<= limit)
;	W=1	(data segment may	be written into)
;	DPL=0	(privilege level 0)

GDT	LABEL	BYTE		 ;begin	global descriptor table
	DESC	<>		;dummy descriptor
	 DESC	<>		 ;descriptor	for GDT	itself
SRC	DESC	<512,,,93H,>	;source descriptor
TGT	DESC	<512,,,93H,>	;target descriptor
	 DESC	<>		 ;BIOS CS descriptor
	 DESC	<>		 ;stack segment descriptor

c16	dw	16		;constant 16

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
EXT_READ - read block of ext memory
;  inputs: dx,ax = from	address	(extended memory) 1meg base assumed
;	   es:di = to address (conventional memory)
;	      cx = bytes to move
;   output - ah	= error	code, or zero if no error
;          
;* * * * * * * * * * * * * *


	public	EXT_READ
EXT_READ	proc	far
	mov	bx,di			;move -to- offset to bx
	add	dl,10h			;  to extended byte address
	mov	SRC.DESC_BASEL,ax	;store target
	mov	SRC.DESC_BASEH,dl	;  address

	mov	ax,es			;get users buffer segment
	mul	C16			;convert to byte address
	add	ax,bx			;add offset
	adc	dl,0			;add any carry to high address byte
	mov	TGT.DESC_BASEL,AX	;store source
	mov	TGT.DESC_BASEH,dl	;  address
	jmp	short do_transfer
EXT_READ	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
EXT_WRITE - write to EXT memory
;   inputs:  es:si = from address (conventional	memory)
;	     dx,ax = extended memory address, 1k offset assumed
;		cx = bytes to move
;  outputs - ah	= error	code, or zero if no errors
;
;          
;* * * * * * * * * * * * * *


	public	EXT_WRITE
EXT_WRITE	proc	far
	mov	bx,si
	add	dl,10h			;convert to extended byte address
	mov	TGT.DESC_BASEL,ax	;store target
	mov	TGT.DESC_BASEH,dl	;  address

	mov	ax,es			;get users	buffer segment
	mul	C16			;convert to byte address
	add	ax,bx			;add offset
	adc	dl,0			;add any carry to high address byte
	mov	SRC.DESC_BASEL,AX	;store source
	mov	SRC.DESC_BASEH,dl	;  address
	jmp	short do_transfer
EXT_WRITE	endp
;
;----------------------------------------------------------------------------
do_transfer:
	push	bp
	mov	SRC.DESC_LMT,cx
	mov	TGT.DESC_LMT,cx
	mov	ax,cs			;point
	mov	es,ax			;	-es:si-
	mov	si,offset GDT		;	  at GDT
	shr	cx,1		    ;number of words	to transfer
	mov	ah,87h			;block move code
	int	15h			;call bios
	pop	bp
	retf				;if -ah- is non	zero an	error occured

LIBSEG	ENDS
;;	end
