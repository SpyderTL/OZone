	page	66,132
;******************************** STR31.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_JOIN -  appends string2 at end of string1
;
; inputs:    es:[dI] = address of first string
;                bx  = length of string 1
;	      ds:si  = address of second string
;                dx  = length of string 2     
;                
; output:  es:di = new string ptr (unchanged from input es:di)
;             cx = length of joined string at es:di
;* * * * * * * * * * * * * *

	PUBLIC	STR_JOIN
STR_JOIN	PROC	FAR
	APUSH   AX,BX,DX,SI,DI
	cld
	add	di,bx
	mov	cx,dx
	rep	movsb
	movsb			;pick up zero byte at end
	add	bx,dx
	mov	cx,bx
STR_JOIN_end:
    APOP    DI,SI,DX,BX,AX
    RETF
STR_JOIN	ENDP

LIBSEG	ENDS
	end
