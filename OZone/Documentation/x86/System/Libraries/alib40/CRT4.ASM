	page	66,132
;******************************** CRT4.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	INCLUDE  COMMON.INC
.list
;----------------------------------------------------------------------------
	EXTRN	PUT_CRT_CHR:FAR
	EXTRN	REPEAT_PUT_CRT:FAR
	EXTRN	POSN_TO_ADR:NEAR
	EXTRN	ADR_TO_POSN:NEAR
	EXTRN	$PUT_CRT_BLK:NEAR
	EXTRN	$REPEAT_PUT_CRT:NEAR
	EXTRN	LIB_INFO:BYTE
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
CLEAR_SCREEN - fill screen with specified character and color
;
; inputs:    AH = color attribute
;            AL = fill character
;            
; output:    nothing
;
;* * * * * * * * * * * * * *

	PUBLIC	CLEAR_SCREEN
CLEAR_SCREEN	 PROC	FAR
    APUSH   BX,CX,DX,DI,SI,ES,AX
    mov     es,cs:lib_info.crt_seg
    mov     di,0			;page 0 offset
    mov     al,lib_info.crt_rows
    mul     lib_info.crt_columns
    mov     cx,ax			;put move count into -cx-
    POP     AX
    CALL    $REPEAT_PUT_CRT     	;put char to screen (es:di) cx times
    APOP    ES,SI,DI,DX,CX,BX
    RETF
CLEAR_SCREEN	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
DISPLAY_STRING - print string directly to video buffer.
;
; inputs: DS:[SI] = pointer to the string
;            DH = screen row, DL = screen column
;            AH = color attribute
;            
; output:    nothing
;
; notes:  String must be terminated by a NUL character.
;         cr/lf characters are handled & wrap to original column.
;
;* * * * * * * * * * * * * *

	PUBLIC	DISPLAY_STRING
DISPLAY_STRING	PROC	FAR
    push    bp
    mov     bp,sp
    APUSH   AX,BX,CX,DX,DI,SI
    PUSHF
    APUSH   ES
    call    posn_to_adr

TP_LP1:
    LODSB
    OR      AL,AL
    JZ      TP_DONE
    CMP     AL,0dh
    jbe     tp_special		;jmp if possible cr/lf
tp_out:    
    STOSW
    JMP	TP_LP1
tp_special:
    je      tp_return		;jmp if carriage return (0dh)
    cmp     al,0ah
    je      tp_feed		;jmp if line feed (0ah)
    jmp     tp_out
tp_return:
    call    adr_to_posn
    mov     dl,BYTE PTR [BP-8]	;set origional column, -dl-
    call    posn_to_adr
    jmp     tp_lp1
tp_feed:
    call    adr_to_posn
    inc     dh			;move to next row
    call    posn_to_adr
    jmp     tp_lp1        
;
TP_DONE:
    POP     ES
    POPF
    APOP    SI,DI,DX,CX,BX,AX,BP
    RETF
DISPLAY_STRING	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
DISPLAY_TEXT - print string directly to video buffer.
;
; inputs: DS:[SI] = pointer to the string
;            DH = screen row, DL = screen column
;            AH = color attribute
;            CX = text length
;            
; output:    nothing
;
;         cr/lf characters are no handled
;
;* * * * * * * * * * * * * *

	PUBLIC	DISPLAY_TEXT
DISPLAY_TEXT	PROC	FAR
    push    bp
    mov     bp,sp
    APUSH   AX,BX,CX,DX,DI,SI
    PUSHF
    APUSH   ES
    call    posn_to_adr

tt_lp1:
    LODSB
    jcxz    tt_done
    STOSW
    loop    tt_lp1
;
tt_DONE:
    POP     ES
    POPF
    APOP    SI,DI,DX,CX,BX,AX,BP
    RETF
DISPLAY_TEXT	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
DISPLAY_STRING_FILL - display string to screen at specified position.
;
; inputs:   DS:[SI] = pointer to the string
;            cx = maximum length of display line including fill at end
;            DH = screen row, DL = screen column
;            AH = color attribute
;            
;  output:   nothing
;  
;  notes:   If string is shorter than the display line length (cx), then
;           the remainder of the line is cleared.
;
;* * * * * * * * * * * * * *

	PUBLIC	DISPLAY_STRING_FILL
DISPLAY_STRING_FILL	PROC	 FAR
    push    bp
    mov     bp,sp
    APUSH   AX,BX,CX,DX,DI,SI,ES
    call    posn_to_adr
TPC_LP1:
    LODSB
    OR      AL,AL
    JZ      TPC_DONE
    CMP     AL,0dh
    jbe     tpC_special		;jmp if possible cr/lf
tpC_out:    
    STOSW
    loop   TPC_LP1
    jmp    tpc_done2
tpC_special:
    je      tpC_return		;jmp if carriage return (0dh)
    cmp     al,0ah
    je      tpC_feed		;jmp if line feed (0ah)
    jmp     tpC_out
tpC_return:
    call    adr_to_posn
    call    fill_to_end
tpc_return2:
    mov     dl,byte ptr [bp-7]	;restore origional column
    mov     cx,word ptr [bp-6]	;restore origional -cx-
    call    posn_to_adr
    jmp     tpC_lp1
tpC_feed:
    call    adr_to_posn
    inc     dh			;move to next row
    call    posn_to_adr
    jmp     tpC_lp1        
;
TPC_DONE:
    call    adr_to_posn
    call    fill_to_end
tpc_done2:
    APOP    ES,SI,DI,DX,CX,BX,AX,bp
    RETF
DISPLAY_STRING_FILL	ENDP
;------------------------
; fill display from present address to right edge
;   inputs:  dx=row/column
;            ax=last display char.
;            cx=maximum display length
;  output:  all registers returned unchanged
;
fill_to_end:
	apush	ax,dx
	mov	al,' '
fte_loop:	
	cmp	dl,lib_info.crt_columns
	je	fte_exit
	call	put_crt_chr
	inc	dl
	loop	fte_loop
fte_exit:
	apop	dx,ax	
	ret
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
DISPLAY_STRING_LIST -  display a list of strings
;

; inputs:  ds:bx points at table of offsets
;          ah= color
;
; output: none
;
; notes:  ds:bx points to a table of pointers.  The end of the table
;         is indicated by setting an entry to -1.  Each table entry
;         points to an asciiz string.
;* * * * * * * * * * * * * *

	PUBLIC	DISPLAY_STRING_LIST
DISPLAY_STRING_LIST	PROC	FAR
	apush   ax,bx,cx,dx,si,di,es
dsl_loop:	
	mov	si,word ptr ds:[bx]		;get string ptr
	mov	dx,word ptr ds:[si]		;get row/col
	add	si,2				;move to start of string
	call	posn_to_adr
	xor	cx,cx				;set max sting len
	call	$put_crt_blk	
	add	bx,2				;move to next string
	cmp	word ptr ds:[bx],-1
	jne	dsl_loop           		;jmp if more strings
	apop	es,di,si,dx,cx,bx,ax
	retf
DISPLAY_STRING_LIST	ENDP



LIBSEG	ENDS
	end
