	page	66,132
;******************************** CRT2.ASM   *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include common.inc
.list
;----------------------------------------------------------------------------
	EXTRN	POSN_TO_ADR:NEAR
	
;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
;                        BLOCK display routines
;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°

;
;$PUT_CRT_BLK:    copies a string to video memory buffer, with selected
;             color attribute
;
; inputs:     CX = maximum number of characters to print (will also stop
;                  at NUL character)
;             DS:[SI] points to first character of string
;             ES:[DI] points to video buffer
;             AH = color attribute
;             DF = 0 (clear direction flag with CLD)
;  output:    ES:[DI] points to video buffer following string
;             if AL = 0
;                DS:[SI] points to byte following string's NUL terminator
;             if AL <> 0
;                DS:[SI] points to next byte in string after the last one
;                printed on the screen
;Uses:        AL, CX, DI, SI, flags
;
	PUBLIC	$PUT_CRT_BLK
$PUT_CRT_BLK	PROC	NEAR
    LODSB
    OR      AL,AL
    JZ	    $PCB_EXIT
    STOSW
    LOOP    $PUT_CRT_BLK
$PCB_EXIT:
    RET
$PUT_CRT_BLK	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
PUT_CRT_BLK - copies a string to video memory buffer, with selected
;             color attribute;
;
; inputs:         CX = maximum number of characters to print
;            DS:[SI] = pointer to first character of string
;            ES:[DI] = pointer to video buffer
;                 AH = color attribute
;                 DF = 0 (clear direction flag with CLD)
;            
; output:    ES:[DI] = pointer to next video buffer display point
;            DS:[SI] = pointer to byte following last one displayed
;
; notes:  registers changed = al,cx,di,si,flags
;
;* * * * * * * * * * * * * *

	PUBLIC	PUT_CRT_BLK
PUT_CRT_BLK	PROC	FAR
    LODSB
    OR      AL,AL
    JZ	    PCB_EXIT
    STOSW
    LOOP    PUT_CRT_BLK
PCB_EXIT:
    RETF
PUT_CRT_BLK	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( DISPLAY )
VERTICAL_REPEAT_CHR - repeat one or more columns of a character vertically
;
; inputs: ax = char
;         dx = row/col
;         bx = increment to next repeat
;         cx = char repeat length
;         si = operation(rows) repeat count
;
; output: registers changed = bx,si,di 
;* * * * * * * * * * * * * *

	PUBLIC	VERTICAL_REPEAT_CHR
VERTICAL_REPEAT_CHR	PROC	FAR	
    jcxz    vrc_exit
    apush   dx,es
    call    posn_to_adr
vrc_loop:
    apush   cx,di
    REPZ    STOSW
    APOP    DI,CX
    ADD     DI,BX
    DEC     SI
    JNZ     vrc_loop
    apop    es,dx
vrc_exit:
    RETF
VERTICAL_REPEAT_CHR	ENDP
;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
; repeat one or more columns of a character vertically
;  inputs: ax = char
;       es:di = starting display location
;          bx = increment to next repeat
;          cx = char repeat length
;          si = operation(rows) repeat count
;
;  output es:di = next display location
;            si = 0
; 
	PUBLIC	$VERTICAL_REPEAT_CHR
$VERTICAL_REPEAT_CHR	PROC	NEAR
    jcxz    $vrc_exit
$vrc_loop:
    apush   cx,di
    REPZ    STOSW
    APOP    DI,CX
    ADD     DI,BX
    DEC     SI
    JNZ     $vrc_loop
$vrc_exit:
    RET
$VERTICAL_REPEAT_CHR	ENDP

LIBSEG	ENDS
	end
