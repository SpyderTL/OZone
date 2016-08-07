; GETC.asm


		include	consts.a
		include	stdin.a

		echo	getc
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing



; Buffered Keyboard input routines
;
; Released to the public domain
; Created by: Randall Hyde
; Date: 5/22/96
; Updates:

CtrlZ		equ	1ah


; HasData-	Contains true (1) if the InputBuffer contains value data.
;		This variable contains false (0) if we need to read a
;		new line of data before extracting characters from
;		the buffer.
;
; InputIndex-	Current index into the InputBuffer while we are reading
;		data out of it.
;
; Inputbuffer-	Holds one line of input data while buffering data.

HasData		word	0

InputIndex	word	0

InputBuffer	byte	128 dup (0)
		byte	0		;Guarantee zero terminating byte.




; FlushGetc-	Flushes the input buffer and forces the next input operation
;		to read a new line of text from the standard input device.

		public	$FlushGetc
$FlushGetc	proc	far
		mov	HasData,0
		ret
$FlushGetc	endp




; GETC-		Reads one character from the input buffer (forces a new
;		input line if the buffer is exhausted).

		public	$Getc
$Getc		proc	far
		push	es
		push	di
		cmp	HasData, 0
		jne	GetTheChar

; If there is no data in the buffer, read a new line here.

		lesi	InputBuffer
		call	$rawgets
		jc	BadGetc
		mov	InputIndex, 0
		mov	HasData, 1

GetTheChar:	mov	di, InputIndex
		mov	al, InputBuffer[di]
		inc	InputIndex
		cmp	al, 0		;See if at end of input.
		jne	GetcDone
		mov	al, cr		;Return CR if end of line.
		mov	HasData, 0	;Flag end of input data.
GetcDone:	pop	di
		pop	es
		clc
		ret

; If rawgets did not raise an exception, but did return an error,
; pass that error on through here.

BadGetc:	pop	di
		pop	es
		stc
		ret
$Getc		endp




; $GetcCS-	The address of a character variable follows in the code
;		stream.  GetcCS reads a character via a call to GETC and
;		stores this character at the address specified by the
;		dword following the call.

		public	$GetcCS
$GetcCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		call	$getc

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	[si], al		;Store the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$GetcCS		endp



; $GetcStk-	The address of a character variable is on the TOS.
;		GetcStk reads a character via a call to GETC and
;		stores this character at the address specified by the
;		address on TOS.

		public	$GetcStk
$GetcStk	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		call	$getc

		lds	si, [bp+6]		;Get ptr to char.
		mov	[si], al		;Store the char.

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret	4
$GetcStk	endp




; PeekC-	Returns the character at the front of the buffer but
;		does not remove that character from the buffer.
;		Forces the input of a new line of text if the input
;		buffer is empty.

		public	$Peekc
$Peekc		proc	far
		push	es
		push	di
		cmp	HasData, 0
		jne	PeekAtChar

; If there is no data in the buffer, read a new line here.

		lesi	InputBuffer
		call	$rawgets
		jc	BadPeekc
		mov	InputIndex, 0
		mov	HasData, 1

PeekAtChar:	mov	di, InputIndex
		mov	al, InputBuffer[di]
		cmp	al, 0		;See if at end of input.
		jne	GetcDone
		mov	al, cr		;Return CR if end of line.
GetcDone:	pop	di
		pop	es
		clc
		ret

; If rawgets did not raise an exception, but did return an error,
; pass that error on through here.

BadPeekc:	pop	di
		pop	es
		stc
		ret
$Peekc		endp



; $PeekcCS-	Like Peekc, except the address of a character variable
;		follows in the code stream.  This routine stores the
;		character at that address.

		public	$PeekcCS
$PeekcCS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		call	$Peekc

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	[si], al		;Store the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$PeekcCS	endp



; $PeekcStk-	The address of a character variable is on the TOS.
;		PeekcStk reads a character via a call to PEEKC and
;		stores this character at the address specified by the
;		address on TOS.

		public	$PeekcStk
$PeekcStk	proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		call	$Peekc

		lds	si, [bp+6]		;Get ptr to char.
		mov	[si], al		;Store the char.

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret	4
$PeekcStk	endp







; GetcLen-	Returns the number of remaining characters in the input
;		buffer (not including the terminating zero byte) in the
;		CX register.

		public	$GetcLen
$GetcLen	proc	far
		xor	cx, cx
		cmp	HasData, 0
		je	GCLDone

		push	di
		mov	di, InputIndex
		dec	cx
		dec	di
GCLlp:		inc	cx
		inc	di
		cmp	InputBuffer[di], 0
		jne	GCLlp
		pop	di
		jcxz	ResetHD
GCLDone:	ret

; If there was no data in the buffer, clear the HasData flag.
; A call to GETC after GetcLen will not return a carriage return,
; but this call (GetcLen) should have told them they were at the
; end of the line.  This behavior is necessary because the gets
; and getsm routines (that call this code to see if they need to
; read a new line) will ignore the CR at the end of the line.

ResetHD:	mov	HasData, 0
		ret
$GetcLen	endp


; $GetcLenCS-	Like GetcLen, except the address of an integer variable
;		follows in the code stream.  This routine stores the
;		number of characters at that address.

		public	$GetcLenCS
$GetcLenCS	proc	far
		push	bp
		mov	bp, sp
		push	cx
		push	ds
		push	si

		call	$GetcLen

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	[si], cx		;Store the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		pop	si
		pop	ds
		pop	cx
		pop	bp
		ret
$GetcLenCS	endp


; $GetcLenStk-	The address of a word variable is on the TOS.
;		GetcLenStk reads the size of the buffer via a call to 
;		GETCLEN and stores this character at the address 
;		specified by the address on TOS.

		public	$GetcLenStk
$GetcLenStk	proc	far
		push	bp
		mov	bp, sp
		push	cx
		push	ds
		push	si

		call	$getclen

		lds	si, [bp+6]		;Get ptr to char.
		mov	[si], cx		;Store the char.

		pop	si
		pop	ds
		pop	cx
		pop	bp
		ret	4
$GetcLenStk	endp




$segSTDIO	ends
		end
