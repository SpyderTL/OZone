	page	66,132
;******************************** CONV06.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
BYTE_TO_HEX_STR - convert hex byte to two ascii characters
;
; inputs:    al = hex byte
;         ds:si = storage buffer for ascii
;         
; output:    si = points past last store (bumped by 2)
;* * * * * * * * * * * * * *

;----------------------------------------------------------------------------
	public	BYTE_TO_HEX_STR
BYTE_TO_HEX_STR	PROC	FAR
	mov	cs:crt_direct,0
	jmp	hex1_entry
BYTE_TO_HEX_STR	ENDP	
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
BYTE_TO_HEX_CRT - convert hex byte to ascii and display
;
; inputs:    al = hex byte
;         ds:si = storage buffer for ascii
;         
; output:    si = points past last store (bumped by 2)
;* * * * * * * * * * * * * *

	public	BYTE_TO_HEX_CRT
BYTE_TO_HEX_CRT	proc	far
	mov	cs:crt_direct,1
BYTE_TO_HEX_CRT	ENDP	
hex1_entry	PROC	FAR	
	push	ax
	mov	ah,al		;save for later
	shr	al,1
	shr	al,1
	shr	al,1
	shr	al,1
	call	btha		;convert one nibble
	xchg	ah,al
	call	btha
	pop	ax
	retf
HEX1_ENTRY	ENDP
;-----------------------	
CRT_DIRECT	DB	0
;-----------------------
btha:	and	al,0fh
	add	al,90h		;convert
	daa			;  -al- bits 0-3
	adc	al,40h		;     to hex
	daa			;        ascii
	cmp	cs:crt_direct,0
	je	btha_stuff
	int	29h
	ret
btha_stuff:	
	mov	byte ptr [si],al
	inc	si
	ret	
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
WORD_TO_HEX_STR - convert hex word to four ascii characters
;
; inputs:    ax = hex word
;         ds:si = storage for 4 ascii characters
;         
; output:    si = pointer past last store (bumped by 4)
;* * * * * * * * * * * * * *

	public	WORD_TO_HEX_STR
WORD_TO_HEX_STR	PROC	FAR
	MOV	CS:CRT_DIRECT,0
	jmp	hex2_entry
WORD_TO_HEX_STR	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
WORD_TO_HEX_CRT - hex word to ascii and display it
;
; inputs:    ax = hex word
;         ds:si = storage for 4 ascii characters
;         
; output:    si = pointer past last store (bumped by 4)
;* * * * * * * * * * * * * *

	public	WORD_TO_HEX_CRT
WORD_TO_HEX_CRT	PROC	FAR
	mov	cs:crt_direct,1
WORD_TO_HEX_CRT	ENDP	
hex2_entry	PROC	FAR		
	xchg	ah,al
	call	hex1_entry
	xchg	ah,al
	call	hex1_entry
	retf
HEX2_ENTRY	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
DWORD_TO_HEX_STR - hex double word to ascii
;
;INPUTS: DX,AX = HEX
;
;OUTPUTS: si points past last byte stored
;* * * * * * * * * * * * * *

	public	DWORD_TO_HEX_STR
DWORD_TO_HEX_STR	proc	far
	mov	cs:crt_direct,0
	jmp	hex4_entry
DWORD_TO_HEX_STR	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
DWORD_TO_HEX_CRT - hex double word to ascii and display
;
;INPUTS: DX,AX = HEX
;
;OUTPUTS: NONE
;* * * * * * * * * * * * * *

	public	DWORD_TO_HEX_CRT
DWORD_TO_HEX_CRT	proc	far
	mov	cs:crt_direct,1
hex4_entry:
	xchg	ax,dx
	call	hex2_entry
	xchg	ax,dx
	jmp	hex2_entry	
DWORD_TO_HEX_CRT	endp

LIBSEG	ENDS
	end
