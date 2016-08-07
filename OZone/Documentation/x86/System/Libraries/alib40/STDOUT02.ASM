	page	66,132
;******************************** STDOUT02.ASM *******************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MISC  )
; stdout_puts - display string to stdout
;  inputs:  The string to be displayed is placed after the CALL to
;           stdout_puts and is terminated with a zero char.
;
;           Example:      call   stdout_puts
;                         db     'This is a test message',0
;                         (execution continues here at first instruction
;                          past the text string)
;
;  ouptput:  none, all registers unchanged.
;
;  note:  This function can be used inside a simple macro to create
;         a one line display function.  The macro could automatically
;         add a carriage return and the zero character at the end.
;
;  note:  This function was contributed by Terje Mathisen

	public	stdout_puts
stdout_puts	proc	far
	push	bp
	mov	bp,sp
	apush	ax,dx,ds
	xchg	bx,[bp+2]	;get message offset & save bx
	mov	ds,[bp+4]	;get message segment
	test	ax,21cdh	;Terje's trick to skip over "int 21"
	org	$-2
loop1:	int	21h		;
	mov	dl,[bx]		;get char to display
	inc	bx
	mov	ah,2		;DOS function 2
	test	dl,dl		;check if end of message
	jnz	loop1		;loop till done
	xchg	bx,[bp+2]	;store return address & restore bx
	apop	ds,dx,ax,bp
	retf
stdout_puts	endp		

LIBSEG	ENDS
;;	end
