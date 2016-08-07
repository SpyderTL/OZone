	PAGE	66,132
;******************************** MISC2.ASM  *********************************
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing
;----------------------------------------------------------------------------
	include	mac.inc
	extrn	stdout_crlf:far
	extrn	stdout_string:far
	extrn	word_to_hex_stdout:far
	extrn	stdout_char:far	

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC   )
; REGISTER_DUMP - unsigned 32 bit number compare
;  inputs  registers
;  outputs  registers displayed on stdout on one line
;           registers are unchanged
;
;  note:  This function is intended for debugging programs.
;* * * * * * * * * * * * * *


	public	REGISTER_DUMP
REGISTER_DUMP	proc	far
	mov	cs:rd_ds,ds
	mov	cs:rd_ax,ax
	mov	ax,cs
	mov	ds,ax
	mov	ds:rd_dx,dx
	mov	ds:rd_si,si
	mov	ds:rd_bp,bp
	
	call	stdout_crlf

	mov	bp,sp
	mov	ax,word ptr ss:[bp+2]	
	call	word_to_hex_stdout	;display cs
	mov	al,':'
	call	stdout_char
	mov	ax,word ptr ss:[bp+0]	;get IP
	call	word_to_hex_stdout
	mov	al,' '
	call	stdout_char

	mov	si,offset msg_a
	call	stdout_string
	mov	ax,rd_ax
	call	word_to_hex_stdout
	mov	al,' '
	call	stdout_char

	mov	si,offset msg_b
	call	stdout_string
	mov	ax,bx
	call	word_to_hex_stdout
	mov	al,' '
	call	stdout_char

	mov	si,offset msg_c
	call	stdout_string
	mov	ax,cx
	call	word_to_hex_stdout
	mov	al,' '
	call	stdout_char

	mov	si,offset msg_d
	call	stdout_string
	mov	ax,ds:rd_dx
	call	word_to_hex_stdout
	mov	al,' '
	call	stdout_char

	mov	si,offset msg_si
	call	stdout_string
	mov	ax,rd_ds
	call	word_to_hex_stdout
	mov	al,':'
	call	stdout_char
	mov	ax,rd_si
	call	word_to_hex_stdout
	mov	al,' '
	call	stdout_char

	mov	si,offset msg_di
	call	stdout_string
	mov	ax,es
	call	word_to_hex_stdout
	mov	al,':'
	call	stdout_char
	mov	ax,di
	call	word_to_hex_stdout
	mov	al,' '
	call	stdout_char
	
	mov	si,offset msg_bp
	call	stdout_string
	mov	ax,bp
	call	word_to_hex_stdout
	
	mov	ax,ds:rd_ax
	mov	dx,ds:rd_dx
	mov	si,ds:rd_si
	mov	bp,ds:rd_bp
	mov	ds,ds:rd_ds	
		
	retf
REGISTER_DUMP	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC   )
; STACK_DUMP - unsigned 32 bit number compare
;  inputs  registers
;  outputs  registers displayed on stdout on one line
;           registers are unchanged
;
;  note:  This function is intended for debugging programs.
;* * * * * * * * * * * * * *


	public	STACK_DUMP
STACK_DUMP	proc	far
	mov	cs:rd_ds,ds
	mov	cs:rd_ax,ax
	mov	ax,cs
	mov	ds,ax
	mov	ds:rd_dx,dx
	mov	ds:rd_si,si
	mov	ds:rd_bp,bp
	
	call	stdout_crlf

	mov	bp,sp
	add	bp,4
	mov	si,offset msg_sp
	call	stdout_string
	mov	ax,ss
	call	word_to_hex_stdout	;display ss
	mov	al,':'
	call	stdout_char
	mov	ax,bp
	call	word_to_hex_stdout	;display sp
	mov	al,' '
	call	stdout_char

	mov	rloop,12
sloop:	mov	ax,word ptr [bp]
	call	word_to_hex_stdout
	mov	al,' '
	call	stdout_char
	add	bp,2
	dec	rloop
	jnz	sloop
	
	
	mov	ax,ds:rd_ax
	mov	dx,ds:rd_dx
	mov	si,ds:rd_si
	mov	bp,ds:rd_bp
	mov	ds,ds:rd_ds	
		
	retf
STACK_DUMP	endp

rloop	db	0

rd_ax	dw	0
rd_dx	dw	0
rd_si	dw	0
rd_bp	dw	0
rd_ds	dw	0

msg_a	db	'A=',0
msg_b	db	'B=',0
msg_c	db	'C=',0
msg_d	db	'D=',0
msg_si	db	'DS:SI=',0
msg_di	db	'ES:DI=',0
msg_bp	db	'BP=',0
msg_sp	db	'SS:SP=',0

LIBSEG	ENDS
;;	end
