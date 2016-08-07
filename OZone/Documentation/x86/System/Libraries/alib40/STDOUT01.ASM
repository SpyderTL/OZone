	page	66,132
;******************************** STDOUT01.ASM *******************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC  )
; stdout_char - display character to stdout
;  inputs: al = char.
;

	public	stdout_char
stdout_char	proc	far
		push	dx
		push	ax
		mov	ah,02h
		mov	dl,al	
		int	21h
		pop	ax
		pop	dx
		retf			
stdout_char	endp		
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC  )
; stdout_string - put string to stdout
; inputs ds:si point at string terminated with a zero
; output:ds:si point at end of string
;

	public	stdout_string
stdout_string	proc	far
	push	ax
	cld
ds_loop:lodsb         			;get next char
	test	al,al
	jz	stdout_string_exit		;exit if done
	call	stdout_char
	jmp	ds_loop
stdout_string_exit:
	pop	ax
	retf
stdout_string	endp	
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC  )
; stdout_crlf - sends cr/lf to stdout one time
;   inputs:  none
;   output:  ax modified
;

	public	stdout_crlf
stdout_crlf	proc	far
	mov	al,0dh
	call	stdout_char
	mov	al,0ah
	call	stdout_char
	retf
stdout_crlf	endp	
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC  )
;  stdout_spaces - put one or more spaces to stdout
;    inputs:  ah = space count
;    output:  ax modified
;

	public	stdout_spaces
stdout_spaces	proc	far
	mov	al,' '
display_repeat:
	call	stdout_char
	dec	ah
	jnz	display_repeat
	retf
stdout_spaces	endp

LIBSEG	ENDS
	end
