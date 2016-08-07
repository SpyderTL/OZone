	page	66,132
;******************************** SCAN15.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	strlen3:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
LAST_CHAR - find the last byte in a string matching register AL
;
; inputs:    DS:[BX] pointing to the first character of the string
;            AL = byte to find
;            
; output:    if CF = 1, no match
;            if CF = 0, AX = offset from DS:[BX] of the last matching byte
;* * * * * * * * * * * * * *

	PUBLIC	LAST_CHAR
LAST_CHAR	PROC	FAR
    push    cx
    CALL    strlen3
    call    last_charc
    pop     cx
    retf
LAST_CHAR ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( SEARCH  )
LAST_CHARC - find the last byte in n bytes matching AL
;
; inputs:    DS:[BX] pointing to the first character of the string
;            AL = byte to find
;            CX = number of bytes to search
;            
; output:    if CF = 1, no match
;            if CF = 0, AX = offset from DS:[BX] of the last matching byte
;* * * * * * * * * * * * * *

	PUBLIC	LAST_CHARC
LAST_CHARC	PROC	FAR
    APUSH   DI,ES
    STD
    PUSH    DS
    POP     ES
    MOV     DI,BX
    ADD     DI,CX			;find string end
    DEC     DI				;  and use as search start
    PUSH    CX
    REPNZ   SCASB			;scan from end of string for char.
    POP     CX
    JNZ     STRN_NO			;jmp if char not found
    
    MOV     AX,DI			;compute
    INC     AX				;  lenght of search
    SUB     AX,BX			;     match point -> AX
    
    CLC
    JMP     STRN_EXIT
STRN_NO:    
    STC
STRN_EXIT:    
    APOP    ES,DI
    cld
    RETF
LAST_CHARC	ENDP

LIBSEG	ENDS
	end
