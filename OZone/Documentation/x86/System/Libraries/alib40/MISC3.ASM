	PAGE	66,132
;******************************** MISC3.ASM  *********************************
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing
;----------------------------------------------------------------------------
	include	mac.inc

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC   )
; A20_CHECK - check if A20 line is active
;  inputs: none
;  outputs  ax = 0 a20 is wrapping (normal DOS state)
;           ax = 1 a20 is not wrapping
;
;* * * * * * * * * * * * * *


	public	A20_CHECK
A20_CHECK	proc	far
	push	ds
	push	es
	mov	ax,0
	mov	es,ax
	dec	ax
	mov	ds,ax
	mov	ax,word ptr es:[4eh]
	cmp	ax,word ptr ds:[5eh]
	jne	no_wrap
	mov	word ptr ds:[5eh],1234h
	cmp	word ptr es:[4eh],1234h
	mov	word ptr ds:[5eh],ax
	jne	no_wrap
is_wraping:
	pop	es
	pop	ds
	mov	ax,0			;wrapping, normal dos state
	jmp	wrap_display
no_wrap:
	pop	es
	pop	ds
	mov	ax,1			;no wrap, A20 disabled
wrap_display:
	retf
A20_CHECK	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC   )
; A20_WRAP_OFF - check if A20 line is active
;  inputs: none
;  outputs  ax = 0 a20 is wrapping (normal DOS state)
;           ax = 1 a20 is not wrapping
;
;* * * * * * * * * * * * * *


	public	A20_WRAP_OFF
A20_WRAP_OFF	proc	far
	MOV	AX,0DF90h
	CALL	command_8042		;ah=8042 command
	retf
A20_WRAP_OFF	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC   )
; A20_WRAP_ON - check if A20 line is active
;  inputs: none
;  outputs  ax = 0 a20 is wrapping (normal DOS state)
;           ax = 1 a20 is not wrapping
;
;* * * * * * * * * * * * * *


	public	A20_WRAP_ON
A20_WRAP_ON	proc	far
      	MOV	CX,0800h
await:	MOV	AX,0DD00h		;
	CALL	command_8042		;ah=command
	LOOPNZ	await
	retf
A20_WRAP_ON	endp
;-----------------------------------
;  ah=command for port 60h  al=att command ?
command_8042:
	CLI
	CALL	wait_8042_inbuf_ful
	JNZ	c8_cont
	MOV	AL,0D1H
	OUT	64H,AL			;force next out to 60 to be cmd
	CALL	wait_8042_inbuf_ful
	JNZ	c8_cont
	MOV	AL,AH
	OUT	60H,AL			;see notes
	CALL	wait_8042_inbuf_ful
c8_cont:STI
	RET

wait_8042_inbuf_ful:
	XOR	CX,CX
L02A1:	IN	AL,64H			;read 8042 status
	AND	AL,2			;check 8042 input buffer full
	LOOPNZ	L02A1
	RET

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC   )
; SEG_TO_ABS - convert segment:offset to absolute address
;  inputs: ax:bx = segment offset
;  outputs dx,ax = absolute adderss
;
;* * * * * * * * * * * * * *


	public	seg_to_abs
seg_to_abs	proc	far
	push	cx
	MOV	CX,010H
	MUL	CX
	add	ax,bx
	adc	dx,0
	pop	cx
	RETF
seg_to_abs	endp

LIBSEG	ENDS
;;	end
