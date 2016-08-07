		.386
		option	segment:use16, proc:private

		include	consts.a
		include	stdin.a

		echo	scanf
	
wp		textequ	<word ptr>

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing

; Scanff- 	See SCANF comments for details.  This code is just like SCANF except
;		it processes the "F" and "G" options for floating point input.
;
;	Note:	If you use SCANFF in your program, you should not use SCANF.  SCANFF
;		does everything that SCANF does and more.  The reason for having
;		two separate routines is so you don't have to link in the floating
;		point code if your program does not use floating point arithmetic.



$$ReturnAdrs	textequ	<dword ptr [bp+2]>

OprndPtr	dword	?

		public	$scanff
$scanff		proc	far
		push	bp
		mov	bp, sp
		pusha
		push	es
		push	ds
		pushf

; Save the current terminating character.

		call	$GetTermCh
		push	ax


; Get pointers to the return address (format string).

		cld
		les	di, $$ReturnAdrs
		lds	si, $$ReturnAdrs


; Okay, search for the end of the format string.  After these instructions,
; di points just beyond the zero byte at the end of the format string.  This,
; of course, points at the first address beyond the format string.

		mov	al, 0
		mov	cx, 65535
	repne	scasb
		mov     wp OprndPtr, di
		mov	wp OprndPtr+2, es

ScanItems:      lodsb			;Get char si points at.
ScanItems2:	cmp	al, 0		;EOS?
		jz	ScanfDone
		cmp	al, "%"		;Start of a format string?
		jz	FmtItem

		cmp	al, " "
		jz	SkipWS

; If the current format character is not a space or a "%", then
; skip that character if it appears next in the input stream.

		call	$GetcLen	;Bail if at end of line.
		jcxz	ScanItems

		mov	bl, al
		call	$peekc
		cmp	al, bl
		jne	ScanItems
		call	$getc
		jmp	ScanItems

; If the current format string character is a space, skip all
; white space we encounter in the input stream.

SkipWSLp:	call	$getc
SkipWS:		call	$peekc
		cmp	al, ' '
		je	SkipWSLp
		cmp	al, tab
		jne	SkipWS2			;Crazy jump to due a bug
		jmp	SkipWSLp		; in MASM (so it appears).

; Now skip all white space we find in the format string:

SkipWS2:	lodsb
		cmp	al, ' '			;Skip additional whitespace
		jz	SkipWS2			; in the format string.
		jmp	ScanItems2


FmtItem:	call	GetFmtItem		;Process the format item here.
		jmp	ScanItems

ScanfDone:    	pop	ax			;Retrieve original terminating
		call	$SetTermCh		; character and restore it.

		les	di, OprndPtr		;Make return address point past
		mov	[bp+2], di		; the format string and any
		mov	[bp+4], es		; operands.
		popf
		pop	ds
		pop	es
		popa
		pop	bp
		ret
$scanff		endp



; If we just saw a "%", come down here to handle the format item.

GetFmtItem	proc	near

		lodsb				;Get char beyond "%"

; See if the user wants to specify a handle rather than a straight pointer

		mov	ah, 0			;Assume it's not "^".
		cmp	al, '^'
		jne     ChkFmtChars
		mov	ah, al
		lodsb				;Skip "^" character

; Okay, process the format characters down here.

ChkFmtChars:	and	al, 05fh		;l.c. -> U.C.
		cmp	al, 'D'
		je	GetDec
		cmp	al, 'I'
		je	GetDec
		cmp	al, 'C'
		je	GetChar

		cmp	al, 'X'
		je	GetHexWord

		cmp	al, 'H'
		je	GetHexByte

		cmp	al, 'U'
		je	GetUDec

		cmp	al, 'S'
		je	GetString

		cmp	al, 'F'
		je	GetFloat

		cmp	al, 'G'
		je	GetDouble

		cmp	al, 'L'
		jne	Default

; If we've got the "L" modifier, this is a long value to print, get the
; data type character as the next value:

		lodsb
		and	al, 05fh		;l.c. -> U.C.
		cmp	al, 'D'
		je	JmpDec
		cmp	al, 'I'
		jne	TryLU
JmpDec:		jmp	LongDec

TryLU:		cmp	al, 'U'
		jne	Default
		jmp	LongU



; If none of the above, simply return without reading anything.

Default:	ret


; Get a signed decimal value here.

GetDec:		call	doTerm			;Check for terminating char.
		call	GetPtr			;Get next pointer into ES:BX
		call	$geti			;Read the integer value.
		mov	es:[bx], ax
		ret


; Read a character variable here.

GetChar:	call	doTerm
		call	GetPtr			;Get next pointer into ES:BX
		call	$getc
		mov	es:[bx], al
		ret


; Read a hexadecimal word value here.

GetHexWord:	call	doTerm
		call	GetPtr			;Get next pointer into ES:BX
		call	$getw
		mov	es:[bx], ax
		ret


; Read hex bytes here.

GetHexByte:	call	doTerm
		call	GetPtr			;Get next pointer into ES:BX
		call	$geth
		mov	es:[bx], al
		ret


; Input unsigned decimal numbers here:

GetUDec:	call	doTerm
		call	GetPtr			;Get next pointer into ES:BX
		call	$getu
		mov	es:[bx], ax
		ret


; Input a string here:

GetString:	call	doTerm
		call	GetPtr
		push	di
		mov	di, bx			;Point ES:DI at dest location.
		call	$gets
		pop	di
		ret				;We're done!


; Input a real4 floating point value here.

GetFloat:	call	doTerm
		call	GetPtr
		call	$Getf
		fstp	real4 ptr es:[bx]
		ret


; Input a real8 floating point value here.

GetDouble:	call	doTerm
		call	GetPtr
		call	$getf
		fstp	real8 ptr es:[bx]
		ret


; Input a signed long decimal value here.

LongDec:	call	doTerm
		call	GetPtr			;Get next pointer into ES:BX
		push	eax
		call	$getl
		mov	es:[bx], eax
		pop	eax
		ret				;We're done!


; Input an unsigned long decimal value here.

LongU:		call	doTerm
		call	GetPtr			;Get next pointer into ES:BX
		push	eax
		call	$getul
		mov	es:[bx], eax
		pop	eax
		ret				;We're done!
GetFmtItem	endp




; GetPtr- Grabs the next pointer which OprndPtr points at and returns this
;	  far pointer in ES:BX.

GetPtr		proc	near
		les	di, OprndPtr
		les	bx, es:[di]
		add	word ptr OprndPtr, 4

; See if this is a handle rather than a pointer.

		cmp	ah, '^'
		jne	NotHandle
		les	bx, es:[bx]
NotHandle:	ret
GetPtr		endp


; doTerm-	Checks the character immediately beyond the format item.
;		If it is not a space or zero byte, set the termination
;		character up so the numeric input routines will legally
;		terminate on this character.

doTerm		proc	near
		mov	al, ds:[si]	;Get char past fmt item.
		cmp	al, " "
		jbe	itsWS
		call	$SetTermCh	;Set as terminating char.
		ret

ItsWS:		mov	al, 0		;No special terminating char.
		call	$SetTermCh
		ret
doTerm		endp
$segSTDIO	ends
		end
