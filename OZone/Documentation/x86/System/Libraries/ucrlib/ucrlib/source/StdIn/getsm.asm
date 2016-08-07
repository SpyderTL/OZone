; GETSM.asm



		include	consts.a
		include	stdin.a
		include memory.a

		echo	getsm
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing



; Buffered Keyboard input routines
;
; Released to the public domain
; Created by: Randall Hyde
; Date: 5/22/96
; Updates:
;
;
;
;
;
; GETSM-	Allocates enough storage to hold the current input
;		line on the heap and then copies that line to the
;		heap.  If there is no data currently in the input
;		buffer, this routine calls rawgetsm to read the line.

		public	$Getsm
$getsm		proc	far
		push	cx
		GetcLen		;Get the number of chars in the buffer
		jcxz	EmptyBuf

; Okay, there are some characters still in the buffer.  Malloc a
; sufficient amount of space to hold them.  Note: if exceptions
; are enabled, the call to MALLOC will raise an exception if
; there is an out of memory condition.  It will return with the
; carry flag set if there is an error and exceptions are not
; enabled.


		inc	cx		;Make room for zero byte.
		call	$malloc		;Get the space on the heap
		jc	BadGetsm	;If an error occurs.
		call	$gets		;Let GETS do all the real work.
		jc	BadGetsm
		pop	cx
		clc
		ret

BadGetsm:	
		xor	di, di		;Return a NULL pointer if
		mov	es, di		; there is a malloc or gets
		stc			; error.
		pop	cx
		ret

; If the input buffer is currently empty, just call rawgetsm to read
; the input line from the user.

EmptyBuf:	
		call	$rawgetsm
		pop	cx
		ret
$getsm		endp
$segSTDIO	ends
		end
