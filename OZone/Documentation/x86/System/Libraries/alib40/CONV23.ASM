	page	66,132
;******************************** CONV23.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
;DWORD_TO_HEX_STDOUT - display byte as decimal to stdout
;
; input:  dx,ax = binary value
; output: ascii hex to stdout
;* * * * * * * * * * * * * *

	public	dword_to_hex_stdout
DWORD_TO_HEX_STDOUT	PROC	FAR
	push	ax
	xchg	ax,dx
	call	word_to_hex_stdout
	pop	ax	
DWORD_TO_HEX_STDOUT	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
;WORD_TO_HEX_STDOUT - display word as decimal to stdout
;
; input:     ax = binary value
; output: ascii hex to stdout
;* * * * * * * * * * * * * *


	public	WORD_TO_HEX_STDOUT
WORD_TO_HEX_STDOUT	proc	far		
	push	ax
	xchg	ah,al
	call	BYTE_TO_HEX_STDOUT
	pop	ax
WORD_TO_HEX_STDOUT	ENDP	

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
;BYTE_TO_HEX_STDOUT - display byte as decimal to stdout
; display data byte as two hex ascii characters
;  inputs: al=data
;  output: registers ax,dx changed
;* * * * * * * * * * * * * *

	PUBLIC	BYTE_TO_HEX_STDOUT
BYTE_TO_HEX_STDOUT	PROC	FAR	
        mov     ah,0
        mov     dl,10h
        div     dl
        call    local_proc
        mov     al,dh
BYTE_TO_HEX_STDOUT	ENDP

local_proc	proc	far
        cmp     al,0Ah
        sbb     al,69h
        das
        xchg    ax,dx
        mov     ah,2
        int     21h
        retf
local_proc	endp        

LIBSEG	ENDS
	end
