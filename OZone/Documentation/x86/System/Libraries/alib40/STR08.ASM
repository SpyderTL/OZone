	page	66,132
;******************************** STR08.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
LEGAL_CHAR_CHECK - scan target string for legal characters
;
; inputs:  ds:si = target string ptr
;             bx = length of string
;          es:di = legal character list
;             dx = length of legal char list
;            
; output: carry set if invalid character found. ds:si points at character
;
;* * * * * * * * * * * * * *

	public	legal_char_check
LEGAL_CHAR_CHECK	PROC	FAR
	apush	ax,bx,cx,dx,di
	mov	cx,bx
	jcxz	sspn5		;exit if no target string
	or	dx,dx
	jz	sspn3		;exit if no check char list

sspn1:	lodsb			;get next target string char
	xor	bx,bx		;clear index to use with legal char list
sspn2:	cmp	al,es:[bx+di]	;check if legal char
	je	sspn4		;jmp if legal char
	inc	bx		;move to next check char on list
	cmp	bx,dx		;
	jne	sspn2		;jmp if more check characters on list (loop)
;
; we have a character which is not in the legal char. list. Go tell caller
;
	dec	si
sspn3:	stc
	jmp	lcc_exit
;
; this character is legal. go check next char. in target string.
;
sspn4:	loop	sspn1		;loop till done	
sspn5:	clc		

lcc_exit:
	apop	di,dx,bx,cx,ax
	retf
LEGAL_CHAR_CHECK	ENDP

LIBSEG	ENDS
	end
