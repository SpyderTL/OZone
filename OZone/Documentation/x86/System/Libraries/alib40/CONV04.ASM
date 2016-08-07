	page	66,132
;******************************** CONV04.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	lib_info:near
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
WORD_TO_DEC_STR - convert an integer value to an ASCIIZ string
;
; inputs:    DS:[SI] pointing to a buffer space
;            (WORD_TO_DEC_STR) AX = integer value
;            WORD_TO_DEC_STR requires a 7-byte (or greater) buffer;
;            
; output:    ASCIIZ string at DS:[SI]; numerals are right-justified
;            with spaces in front.  Conversion always creates 6 characters.
;            Storage area is cleared to spaces first.  End of string is
;            indicated by stuffing a zero hex char.  Negative numbers will
;            have a sign appended to the front
;* * * * * * * * * * * * * *

	PUBLIC	WORD_TO_DEC_STR
WORD_TO_DEC_STR	PROC	FAR
    APUSH   AX,BX,CX,DX,DI,SI,ES,DS
    POP     ES
    MOV     DI,SI
    CLD
    MOV     SI,AX
    MOV     CX,0006
    MOV     AL,20h    ; ' '
    REPZ    STOSB
    MOV     ES:[DI],CL
    MOV     AX,SI
    MOV     BX,000Ah
    OR      SI,SI
    JNS     wts_cont
    NEG     AX
wts_cont:    
    XOR     DX,DX
    DIV     BX
    ADD     DX,+30h
    DEC     DI
    MOV     ES:[DI],DL
    OR      AX,AX
    JNZ     wts_cont
    MOV     AL,20h    ; ' '
    OR      SI,SI
    JNS     wts_exit
    MOV     AL,2D    ; '-'
wts_exit:    
    DEC     DI
    STOSB
    APOP    ES,SI,DI,DX,CX,BX,AX
    RETF
WORD_TO_DEC_STR ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
WORD_TO_DEC_STRL - convert an integer value to a left justified string
;
; inputs:    DS:[SI] pointing to a buffer space
;             AX = integer value
;            
; output:    string at DS:[SI]; numerals are left-justified
;            without any spaces in front or rear.
;            Storage area is not cleared before conversion.
;            String is not terminated with a zero.  All numbers are
;            assumed positive.
;            not handled.
;            SI - points past string
;* * * * * * * * * * * * * *

	PUBLIC	WORD_TO_DEC_STRL
WORD_TO_DEC_STRL PROC	FAR
		apush	ax,cx,dx
		call	word_to_crt2
		apop	dx,cx,ax
		retf
WORD_TO_DEC_STRL endp

word_to_crt2:	xor	dx,dx
		div	cs:ten			;divide curent binary val by 10
		or	ax,ax			;check if done
		jz	db_stuff		;  jmp if done
		push	dx			;save remainder
		call	word_to_crt2   		;recursion
		pop	dx
db_stuff:	mov	al,dl
		add	al,30h
		mov	ah,ch			;get color
		mov	byte ptr [si],al
		inc	si
		ret

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
WORD_TO_DEC_CRT - convert word to decimal ascii and display
;
; inputs:  ax = binary value
;          di = display offset
;          ch = color
;          
; outputs: none
;
; registers changed:  ax,dx
;* * * * * * * * * * * * * *

ten	dw	10

 	public	WORD_TO_DEC_CRT
WORD_TO_DEC_CRT   	proc	far
		push	es
		mov	es,cs:lib_info.crt_seg
		call	word_to_crt1
		pop	es
		retf
WORD_TO_DEC_CRT	endp

word_to_crt1	proc	near
		xor	dx,dx
		div	cs:ten			;divide curent binary val by 10
		or	ax,ax			;check if done
		jz	db_display		;  jmp if done
		push	dx			;save remainder
		call	word_to_crt1   		;recursion
		pop	dx
db_display:	mov	al,dl
		add	al,30h
		mov	ah,ch			;get color
		stosw
		ret
word_to_crt1	endp		
;---------------------------------------------------------------------------

LIBSEG	ENDS
	end
