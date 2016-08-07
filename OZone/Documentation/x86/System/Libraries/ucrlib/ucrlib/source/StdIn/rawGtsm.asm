		include	memory.a
		include	stdin.a

		echo	rawgetsm

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO,ds:nothing



; RAWGETSM-	Reads a line of text from the user and returns a pointer
;		to the string read.  Returns the pointer in ES:DI.  
;		Carry=0 if no error, 1 if heap overflow, EOF, or some 
;		other error (DOS).  Will raise an exception if exceptions
;		are active.
;
; The returned string is zero terminated and does not include the
; carriage return (ENTER) key code.
;
; Note: This routine always allocates 256 bytes when you call
;	it and then trims the space down to the actual size when done.
;	(256 characters is the maximum rawgets will read.)
;
; Released to the public domain.
; Created by: Randall Hyde
; Date: 7/90
; Updates:
;
;	8/11/90-	Modification to handle eof and other errors.
;	10/5/91-	Renamed to new naming conventions.
;	5/22/96		Modified per version 2, release 40 specifications.



		public	$RawGetsm
$rawgetsm	proc	far
		push	ax
		push	bx
		push	cx
		pushf

; Allocate storage for return string:

		mov	cx, 256
		call	$malloc
		jc	BadGETS

; Read data from keyboard until the user hits the enter key.
; Any exceptions that rawgetsm raises will be raised inside
; the rawgets routine below or malloc above.

		call	$rawgets
		jc	BadGets

; Really should call strlen here, but the new version wasn't available
; while this was being written.

		mov	bx, -1
GetStrLen:	inc	bx
		cmp	byte ptr es:[bx][di], 0
		jne	GetStrLen

; Deallocate any left over storage.  Since we are always making the
; string smaller than the initial allocation, the call to realloc
; will always be successful and never raise an exception.

		mov	cx, bx
		call	$realloc
		popf
		clc
		pop     cx
		pop	bx
		pop	ax
		ret

; If an error occured (exceptions are probably off since malloc and
; rawgets tend to raise exceptions on error), drop down here and
; return a NULL pointer and the carry flag set.

BadGets:	mov	di, 0
		mov	es, di
		popf
		stc
		pop	cx
		pop	bx
		pop	ax
		ret
$rawgetsm	endp
$segSTDIO	ends
		end
