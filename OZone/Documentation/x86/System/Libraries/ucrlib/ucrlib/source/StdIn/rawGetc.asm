; rawGETC.asm


		include	excepts.a
		include	stdin.a

		echo	getc
	
$segSTDIO	segment	para public 'STDIO'
		assume	cs:$segSTDIO, ds:nothing


; GetcAdrs-	Points at the current keyboard input routine.

GetcAdrs	dword	$GetcStdIn

; Stack of GETC addresses.

GetcStkIndx	word	0
GetcStack	dword	16 dup ($GetcStdIn)
GSIsize		=	$-GetcStack

; CharBuf- Used to hold character when reading from standard input device.

CharBuf		byte	?


; LastChar- Used by BIOS keyboard routine to split non-ASCII keypresses
; into two separate calls.

LastChar	word	101h

; LastWasCR gets set to 1 when we read a CR.  If the char read when LastWasCR
; is one is a LF, this code eats the CR.

LastWasCR	byte	1		;Assume at start last char was CR.

; LastWasEOF gets set to 1 when we encounter EOF.  If an attempt is made to
; read past the end of file, this code raises an exception if exceptions are
; enabled.

LastWasEOF	byte	0		;Assume not at EOF.



; Keyboard input routines
;
; Released to the public domain
; Created by: Randall Hyde
; Date: 7/90
; Updates:
;
;	8/11/90-	Modifications to use DOS 3fh call and handle eof
;	2/20/91-	Modified routines to eat LFs following CRs after
;			call to DOS getc routine.
;	3/6/91-		Modified code to use DOS raw mode for standard
;			input rather than cooked mode.  Added SetInBIOS,
;			SetInStd, and SetInRaw routines.
;
;	5/22/96-	Conversion to Version 2, release 40 format.
;			Also added exception handling code.

cr		equ	0dh
lf		equ	0ah
CtrlZ		equ	1ah


; rawGetc-	Transfers control to the routine that reads an ASCII character
;		from the stdlib standard input device.  Normally, GetcAdrs points
;		at a subroutine that reads data from the DOS standard input
;		device.  Note: this routine is "raw" because it doesn't do any
;		internal buffering of the input data.  On each call to rawGetc
;		it reads a new character from the standard input device.

		public	$rawGetc
$rawGetc	proc	far
		jmp	GetcAdrs
$rawGetc	endp




; SetInAdrs- Stores ES:DI into GetcAdrs which sets the new keyboard vector.


		public	$SetInAdrs
$SetInAdrs	proc	far
		mov	word ptr GetcAdrs, di
		mov	word ptr GetcAdrs+2, es
		ret
$SetInAdrs	endp



; GetInAdrs-	Returns the address of the current output routine in ES:DI.

		public	$GetInAdrs
$GetInAdrs	proc	far
		les	di, GetcAdrs
		ret
$GetInAdrs	endp


; PushInAdrs-	Pushes the current input address onto the input stack
;		and then stores the address in es:di into the input address
;		pointer.  Returns carry clear if no problems.  Returns carry
;		set if there is an address stack overflow (Raises the
;		$GetcStkErr exception if exceptions are enabled).  
;		Does NOT modify anything if the stack is full.

		public	$PushInAdrs
$PushInAdrs	proc	far
		push	ax
		push	di
		cmp	GetcStkIndx, GSIsize
		jae	BadPush
		mov	di, GetcStkIndx
		add	GetcStkIndx, 4
		mov	ax, word ptr GetcAdrs
		mov	word ptr GetcStack[di], ax
		mov	ax, word ptr GetcAdrs+2
		mov	word ptr GetcStack+2[di], ax
		pop	di
		mov	word ptr GetcAdrs, di
		mov	word ptr GetcAdrs+2, es
		pop	ax
		clc
		ret

BadPush:	call	$GetXEnabled
		cmp	ax, 1
		jne	PIAReturnErr
		mov	ax, $GetcStkErr
		call	$Raise

PIAReturnErr:	pop	di
		pop	ax
		stc
		ret
$PushInAdrs	endp


; PopInAdrs-	Pops an input address off of the stack and stores it into
;		the GetcAdrs variable.

		public	$PopInAdrs
$PopInAdrs	proc	far
		push	ax
		mov	di, GetcStkIndx
		sub	di, 4
		clc			;Assume no stack underflow.
		jns	GoodPop

; If we drop down here, stack underflow has occured.  Check to see
; if exceptions are enabled.

		call	$GetXEnabled
		cmp	ax, 0
		je	ResetStk
		mov	ax, $GetcStkErr
		call	$Raise

; If this guy just went negative, set it to zero and push the address
; of the stdout routine onto the stack.

ResetStk:	xor	di, di
		mov	word ptr GetcStack, offset $GetcStdIn
		mov	word ptr GetcStack+2, seg $GetcStdIn
		stc		;Return error.

; The following instructions must *NOT* modify the carry flag.

GoodPop:	mov	GetcStkIndx, di
		mov	es, word ptr GetcAdrs+2
		mov	ax, word ptr GetcStack+2[di]
		mov	word ptr GetcAdrs+2, ax
		mov	ax, word ptr GetcStack[di]
		xchg	word ptr GetcAdrs, ax
		mov	di, ax
		pop	ax
		ret
$PopInAdrs	endp



; SetInBIOS- Points the input pointer at the GetcBIOS routine.

		public	$SetInBIOS
$SetInBIOS	proc	far
		mov	word ptr GetcAdrs, offset $GetcBIOS
		mov	word ptr GetcAdrs+2, cs
		ret
$SetInBIOS	endp



; SetInStd- Points the input pointer at the GetcStdIn routine.

		public	$SetInStd
$SetInStd	proc	far
		mov	word ptr GetcAdrs, offset $GetcStdIn
		mov	word ptr GetcAdrs+2, cs
		ret
$SetInStd	endp




; ResetStdIn-	Resets the standard input system.

		public	$ResetStdIn
$ResetStdIn	proc	far
		mov	GetcStkIndx, 0
		mov	word ptr GetcAdrs, offset $GetcStdIn
		mov	word ptr GetcAdrs+2, cs
		call	$FlushGetc
		ret
$ResetStdIn	endp
		




; GetcBIOS- 	Reads a character from the keyboard using the BIOS routines.
;		Behaves just like DOS call insofar as it returns a zero if
;		the user presses a non-ASCII key and then returns the scan
;		code as the next keypress.  Returns 1 in AH signifying that
;		we haven't reached EOF.

		public	$GetcBIOS
$GetcBIOS	proc	far
		cmp	byte ptr LastChar, 0
		jnz	GetNewChar
		mov	ah, 1
		mov	al, byte ptr LastChar+1
		mov	byte ptr LastChar, al
		mov	LastWasCR, 0			;BIOS doesn't convert
		clc					; CR-> CR/LF.
		ret

GetNewChar:	mov	ah, 0
		int	16h
		mov	LastChar, ax
		mov	ah, 1			;Never EOF.
		mov	LastWasCR, 0
		clc
		ret
$GetcBIOS	endp



; GetcStdIn- 	Reads a character from DOS' standard input.
;
; On return: ah=0 if eof, 1 if not eof.  AL=character.
;
; Modification 2/20/91:
;
;	Modified this code to eat any line feeds which immediately follow a
;	CR on the standard input.
;
;		3/8/91:
;
;	Modified this code to treat reading data from a file and from a
;	device as two different operations.  This removed some performance
;	problems and helped make the code a little "safer".
;
;
;		5/22/96
;
;	Modified this code to raise an exception if an attempt is made to
;	read past the end of file.

		public	$GetcStdIn
$GetcStdIn	proc	far
		assume	ds:$segSTDIO
		push	bx
		push	cx
		push	dx
		push	ds

		mov	ax, 4400h		;IOCTL read call
		xor	bx, bx			;Use std in handle.
		int	21h
		test	dl, 80h			;See if file (0) or device (1).
		jz	GetcAgain

		test	dl, 40h			;Check for EOF on device.
		jz	DeviceEOF

; At this point we're reading a character from a device.  Simply call the
; DOS character input routine so we can avoid buffering and other nasty
; problems.  Note we have to handle EOF ourselves here.  DOS, however,
; handles ctrl-C.

		mov	ah, 8
		int	21h
		mov	ah, 1
		cmp	al, CtrlZ
		jne	GoodRead
DeviceEOF:	call	$GetXEnabled
		cmp	ax, 0
		je	ReturnEOF
		mov	ax, $EndOfFile
		call	$Raise

ReturnEOF:	mov	ah, 0
		jmp	Short GoodRead


; If we're reading from a file (rather than a device like the keyboard),
; drop down here to read the character using standard buffered I/O.
; Make sure to strip off LFs following CRs (since LFs typically follow CRs
; in a file).

GetcAgain:	mov	ah, 3fh
		mov	dx, cs
		mov	ds, dx
		mov	CharBuf, 0		;Don't let LF trip us up.
		lea	dx, CharBuf		;Put char into CharBuf.
		mov	cx, 1			;Read one character.
		mov	bx, 0			;StdIn file handle
		int	21h
		jc	BadRead
		cmp	al, 1
		jne	FileEOF
		mov	ah, al			;Return EOF status in AH.

		mov	al, CharBuf		;Get char if not eof.
		cmp	al, LF			;Was last char a line feed?
		jne	NotLF
		cmp	LastWasCR, 0
		mov	LastWasCR, 0
		jne	GetcAgain

NotLF:		mov	LastWasCR, 0
		cmp	al, CR
		jne	GoodRead
		mov	LastWasCR,1

GoodRead:	clc
		pop	ds
		pop	dx
		pop	cx
		pop	bx
		ret

; End of file may cause an exception, but it won't return with the
; carry set (since the value in AH denotes EOF if exceptions are
; not enabled).

FileEOF:	call	$GetXEnabled
		cmp	ax, 0
		je	GoodRead
		mov	ax, $EndOfFile
		call	$Raise


; If there was an I/O error processing this character, raise an
; exception if exceptions are enabled.

BadRead:	push	ax
		call	$GetXEnabled
		cmp	ax, 0
		je	JustReturn
		mov	ax, $FileIO
		call	$Raise

JustReturn:	pop	ax		;Restore DOS error code.
		pop	ds
		pop	dx
		pop	cx
		pop	bx
		stc
		ret
$GetcStdIn	endp
		assume	ds:nothing
$segSTDIO	ends
		end
