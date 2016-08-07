; GETS.asm


		include	consts.a
		include	stdin.a
		include macros.a

		echo	gets
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing


; Buffered Keyboard input routines
;
; Released to the public domain
; Created by: Randall Hyde
; Date: 5/22/96
; Updates:

cr		equ	0dh


; GETS-		Reads the remainder of the input line from the input buffer
;		and copies this data to ES:DI.  If the input buffer is
;		currently empty, this will force a new input line to be
;		read from the user.

		public	$gets
$gets		proc	far
		push	cx
		call	$GetcLen	;Get the number of chars in the buffer
		jcxz	EmptyBuf

		push	di
		push	ax
		dec	di
CopyChars:	inc	di
		call	$getc		;Read next available character
		mov	es:[di], al
		cmp	al, cr
		jne	CopyChars
		
		mov	byte ptr es:[di], 0
		pop	ax
		pop	di
		pop	cx
		ret

; If the input buffer is currently empty, just call rawgets to read
; the input line from the user.

EmptyBuf:	call	$rawgets
		pop	cx
		ret
$gets		endp




; GetsStk-	Like GETS except the pointer to the string is passed
;		on the stack rather than in ES:DI.

		public	$GetsStk
$GetsStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+6]
		call	$gets
		pop	di
		pop	es
		pop	bp
		ret	4
$GetsStk	endp


; $GetsCS-	The address of a string variable follows in the code
;		stream.  GetsCS reads a string via a call to GETS and
;		stores this character at the address specified by the
;		dword following the call.

		public	$GetsCS
$GetsCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to str buf.		
		call	$gets

		add	word ptr [bp+2], 4	;Skip ptr to char.

		pop	di
		pop	es
		pop	ax
		pop	bp
		ret
$GetsCS		endp

$segSTDIO	ends
		end
