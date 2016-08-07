	page	66,132
;******************************** CONV05.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
HEX_STR_TO_BYTE - convert 2 hex ascii characters to 1 hex byte
;
;  inputs: ds:si points at hex data
;  
;  output: no carry - al = hex byte
;             carry - bad input data
;* * * * * * * * * * * * * *

;----------------------------------------------------------------------------
	public	HEX_STR_TO_BYTE
HEX_STR_TO_BYTE	PROC	FAR
	push	cx
	mov	ch,0
	call	hex_nibble
	jc	at1_exit	;jmp if conversion error
	call	hex_nibble
	mov	al,ch
at1_exit:
	pop	cx
	retf
HEX_STR_TO_BYTE	ENDP	
;---------------------------	
hex_nibble:
	lodsb
	mov	cl,4
	cmp	al,'a'
	jb	hn_ok1
	sub	al,20h		;convert to upper case if alpha
hn_ok1:	sub	al,'0'		;check if legal
	jc	hn_abort	;jmp if out of range
	cmp	al,9
	jle	hn_got		;jmp if number is 0-9
	sub	al,7		;convert to number from A-F or 10-15
	cmp	al,15		;check if legal
	ja	hn_abort	;jmp if illegal hex char
hn_got:	shl	ch,cl
	or	ch,al
	clc
	jmp	hn_exit
hn_abort:
	stc
hn_exit:		
	ret	
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
HEX_STR_TO_WORD - convert 4 hex ascii characters to 2 hex bytes
;
;  inputs: ds:si points at hex data
;  
;  output: no carry - al = hex word
;             carry - bad input data
;* * * * * * * * * * * * * *

	public	HEX_STR_TO_WORD
HEX_STR_TO_WORD	PROC	FAR
	call	HEX_STR_TO_BYTE
	mov	ah,al
	call	HEX_STR_TO_BYTE
	retf
HEX_STR_TO_WORD	ENDP	

LIBSEG	ENDS
	end
