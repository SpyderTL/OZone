	page	66,132
;******************************** STR28.ASM  *********************************

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
STR_REVERSE - reverses all characters in a string
;
; inputs:    DS:[SI] pointing to the first character of the string
;            
; output:    CX = string length
;
;* * * * * * * * * * * * * *

	PUBLIC	STR_REVERSE
STR_REVERSE	PROC	FAR
;;	push	cs
	call	strlen1
STR_REVERSE	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_REVERSEC - reverses n characters in a string
;
; inputs:    DS:[SI] pointing to the first character of the string
;            CX = number of bytes in string to reverse
;            
; output:    CX = string length
;* * * * * * * * * * * * * *

	PUBLIC	STR_REVERSEC
STR_REVERSEC	PROC	FAR
    APUSH   AX,BX,CX,SI
    MOV     bx,CX
    SHR     CX,1
    JZ      srr_exit
    ADD     bx,si
    DEC     bx
srr_lp:    
    MOV     AL,[bx]
    XCHG    [si],AL
    MOV     [bx],AL
    INC     si
    DEC     bx
    LOOP    srr_lp
srr_exit:
    APOP    SI,CX,BX,AX
    RETF
STR_REVERSEC ENDP

LIBSEG	ENDS
	end
