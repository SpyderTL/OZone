		.386
		option	segment:use16, proc:private

		include	consts.a
		include	stdin.a
		include	excepts.a
		include	stdout.a

		echo	scanf
	
wp		textequ	<word ptr>

$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing

; Scanf- Like the "C" routine by the same name.  Calling sequence:
;
;               call    scanf
;               db      "format string",0
;               dd      item1, item2, ..., itemn
;
; The format string is identical to "C".  Item1..Itemn are pointers to
; values to print for this string.  Each item must be matched by the
; corresponding "%xxx" item in the format string.
;
; Format string format:
;
; 1)    If a non-whitespace character in the format string matches the next
;	input character, scanf eats that input character;  otherwise scanf
;	ignores the character in the format string.  If any whitespace char-
;	acter appears, scanf ignores all leading whitespace characters (new-
;	line not included) before an item.  If there is no whitespace on the
;	input, scanf ignores the whitespace characters in the input stream.
;
; 2)	Format Control Strings:
;
;	General format:  "%^f" where:
;
;				^ = ^
;				f = a format character
;
;			The "^" is optional.
;
;	^ present	The address associated with f is the address of a
;				pointer to the object, not the address of
;				the object itself.  The pointer is a far ptr.
;
;	f is one of the following
;
;		d -	Read a signed integer in decimal notation.
;		i -	Read a signed integer in decimal notation.
;		x -	Read a word value in hexadecimal notation.
;		h -	Read a byte value in hexadecimal notation.
;		u -	Read an unsigned integer in decimal notation.
;		c -	Read a character.
;		s -	Read a string.
;		f,g -	Floating point not supported, although this routine
;			processes the "f" or "g".
;
;		ld-	Read a long signed integer.
;		li-	Read a long signed integer.
;		lx-	Read a long hexadecimal number.
;		lu-	Read a long unsigned number.
;
;
;	Calling Sequence:
;
;		call	Scanf
;		db	"Format String",0
;		dd	adrs1, adrs2, ..., adrsn
;
;	Where the format string is ala "C" (and the descriptions above)
;	and adrs1..adrsn are addresses (far ptr) to the items to print.
;	Unless the "^" modifier is present, these addresses are the actual
;	addresses of the objects to print.
;



$$ReturnAdrs	textequ	<dword ptr [bp+2]>

OprndPtr	dword	?

		public	$Scanf
$scanf		proc	far
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
$scanf		endp



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
		je	GetFloat

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



; SCANF does not support floating point input.  Raise an exception
; if they attempt to read a floating point value.

GetFloat:	call	$GetXEnabled
		cmp	ax, 0
		je	NoExceptions
		mov	ax, $FPNotAvail
		call	$Raise

; If exceptions are disabled, print and error message and continue.

Zero		real4	0.0

NoExceptions:	call	$print
		byte	nl,bell,"SCANF: Cannot use 'F' or 'G' formats.",nl,0
		call	GetPtr	;Skip the pointer
		ret



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
		call	$SetTermCh		;Set as terminating char.
		ret

ItsWS:		mov	al, 0		;No special terminating char.
		call	$SetTermCh
		ret
doTerm		endp
$segSTDIO	ends
		end
