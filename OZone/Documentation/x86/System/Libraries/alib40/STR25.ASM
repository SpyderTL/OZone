	page	66,132
;******************************** STR25.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	strlen1:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_CLEANR - removes trailing blanks from string
;
; inputs:    DS:[SI] pointing to string
; 
; output:    CX = string length
;* * * * * * * * * * * * * *

	PUBLIC	STR_CLEANR
STR_CLEANR	PROC	FAR
    call    strlen1
    apush   ax,di,es
    JCXZ    sclr_exit
    PUSH    DS
    POP     ES
    MOV     DI,SI
    ADD     DI,CX
    DEC     DI
    MOV     AL,20h    ; ' '
    STD
    REPZ    SCASB
    JZ      sclr_cont
    INC     CX
sclr_cont:    
    XOR     AL,AL
    INC     DI
    INC     DI
    STOSB
sclr_exit:
    cld				;force direction flag at exit    
    apop    es,di,ax
    RETF
STR_CLEANR	ENDP

LIBSEG	ENDS
	end
