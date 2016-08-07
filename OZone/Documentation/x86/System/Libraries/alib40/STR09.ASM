	page	66,132
;******************************** STR09.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
ILLEGAL_CHAR_CHECK - scan string for illegal characters
;
; inputs: ds:si = target string
;            bx = length of target string
;         es:di = list of illegal/check characters
;            dx = length of check list
;           
; output: carry set if illegal/check character found.  DS:SI point at match.
;* * * * * * * * * * * * * *

	public	illegal_char_check
ILLEGAL_CHAR_CHECK	PROC	FAR
	or	bx,bx
	jz	sbrk3		;jmp if no target string
	or	dx,dx
	jz	sbrk3		;jmp if no check list
sbrk1:	lodsb			;get char from target string
	mov	cx,dx
	repnz	scasb		;scan the check list
	jnz	sbrk2		;jmp if no match found
;
; whoops we found on of the dreaded match characters within our string.
;
	dec	si
	stc
	jmp	icc_exit
;
; setup to check next target string char.
;
sbrk2:	sub	di,dx		;restart the check char. pointer
	dec	bx		;count down length of target string
	jnz	sbrk1		;loop if more characters on target string
sbrk3:	clc

icc_exit:
	retf	
ILLEGAL_CHAR_CHECK	ENDP

LIBSEG	ENDS
	end
