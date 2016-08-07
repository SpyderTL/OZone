		include	stdout.a
		include	excepts.a
		include	stdin.a

		echo	gets

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO,ds:nothing



; rawGETS-	Reads a line of text from the user and stores the 
;		characters into the buffer pointed at by ES:DI.  
;		The string must be large enough to hold the 
;		result (max=255 characters).
;
;	The returned string is zero terminated and does not include the
;	carriage return (ENTER) key code.
;
; Released to the public domain.
; Created by: Randall Hyde
; Date: 10/5/91
; Updates:
;
;	10/5/91-	Modified original GETS (GETSM) routine to produce
;			this one.
;
;	5/22/96-	Modifications for Version 2, release 40


		public	$rawGets
$rawgets	proc	far
		push	es
		push	ax
		push	bx
		push	cx
		push	di
		pushf

; Read data from keyboard until the user hits the enter key.

		xor	bx, bx
RdKbdLp:	call	$rawgetc
		jc	BadGetc
		cmp	ah, 0				;EOF?
		jz	EndString
		cmp	al, 0				;Scan code?
		jnz	GotKey				;If so, ignore it.
		call	$rawgetc
		jmp	RdKbdLp

GotKey:		cmp	al, 08				;Backspace
		jne	NotBS
		or	bx, bx 				;Don't do it if at
		jz	RdKbdLp				; beginning of line.
		dec	bx
		call	$putc
		jmp	RdKbdLp

NotBS:		cmp	al, 13				;See if ENTER.
		jnz	NotCR
		call	$putc
		mov	al, 0ah
		putc
		mov	byte ptr es:[bx][di], 0
		inc	bx
		jmp	GetsDone

NotCR:		cmp	al, 1bh				;ESC
		jne	NotESC
		mov	al, 8
EraseLn:	putc
		dec	bx
		jne	EraseLn
		jmp	RdKbdLp

NotESC:		mov	es:[bx][di], al
		putc
		inc	bx
		cmp	bx, 255
		jb	RdKbdLp
		mov	al, 7				;Bell
		call	$putc
		dec	bx
		jmp	RdKbdLp

GetsDone:	popf
		clc
		pop	di
		pop     cx
		pop	bx
		pop	ax
		pop	es
		ret

EndString:	mov	ax, 0
BadGetc:	popf
		pop	di
		pop	cx
		pop	bx
		add	sp, 2			;Don't restore AX.
		pop	es
		stc				;Pass error status.
		ret
$rawgets	endp




; RawGetsStk-	Like rawGets above except the address to store the string
;		appears on the stack rather than in the ES:DI registers.

		public	$rawGetsStk
$rawGetsStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+6]
		call	$rawGets
		pop	di
		pop	es
		pop	bp
		ret	4
$rawGetsStk	endp




; RawGetsCS-	Like rawGets above except the address to store the string
;		appears follows in the code stream  rather than in the 
;		ES:DI registers.

		public	$rawGetsCS
$rawGetsCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+2]
		les	di, es:[di]
		add	wp [bp+2], 4
		call	$rawGets
		pop	di
		pop	es
		pop	bp
		ret	
$rawGetsCS	endp
$segSTDIO	ends
		end
