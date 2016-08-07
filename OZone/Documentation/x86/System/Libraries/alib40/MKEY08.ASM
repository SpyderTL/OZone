	page	66,132
;******************************** MKEY08.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	key_read:far
	extrn	to_upper:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
YES_OR_NO - wait for yes or no user response
;
;  inputs: al - 0=wait for Yes/NO/abort key, and ignore all others
;               1=wait for Yes/No/abort key, and return others also
;               
;  outputs: no carry - al = Yes/No ascii character in upper case
;              carry - al = 03 if abort, and others also if requested
;* * * * * * * * * * * * * *

;-----------------
yesno_flag	db	0	;0=ignore illegal keys  1=return illegal keys
;-----------------
	public	yes_or_no
YES_OR_NO	PROC	FAR
	mov	yesno_flag,al
yn_loop:	
	call	KEY_READ
	cmp	al,03		;check for ctrl-c
	je	yn_bad2		; jmp if abort request	
	cmp	al,1bh		;check for escape
	je	yn_bad2		; jmp if escape
	shr	ah,1		;check if extended key
	jc	yn_bad1		; jmp if bad key
	call	TO_UPPER
	cmp	al,'Y'
	je	yn_got		;jmp if ok
	cmp	al,'N'
	je	yn_got		;jmp if ok
yn_bad1:cmp	yesno_flag,0
	je	yn_loop	
yn_bad2:stc
	jmp	yn_exit
yn_got:	clc
yn_exit:retf		
YES_OR_NO	ENDP

LIBSEG	ENDS
	end
