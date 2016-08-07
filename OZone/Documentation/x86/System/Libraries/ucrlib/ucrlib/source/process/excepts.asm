		.386
		option	segment:use16, proc:private

		include	consts.a
		include	excepts.a
		include	stdout.a

$ExceptData	segment	para public 'Exceptions'

ExceptMsgs	word	$DivideError, OFMsg
		byte	"Division error",0

OFMsg		word	$Overflow, BoundsMsg
		byte	"INTO (overflow) trap",0

BoundsMsg	word	$Bounds, InvMsg
		byte	"Bound trap",0

InvMsg		word	$InvOpcode, BrkMsg
		byte	"Invalid Opcode trap",0

BrkMsg		word	$Break, CritErrMsg
		byte	"BREAK (control-C) trap",0

CritErrMsg	word	$CritErr, ConvMsg
		byte	"Critical Error trap",0

ConvMsg		word	$Conversion,EOFMsg
		byte	"Conversion Error trap",0


EOFMsg		word	$EndOfFile, IOMsg
		byte	"End of File trap",0

IOMsg		word	$FileIO, MemMsg
		byte	"File Error trap",0

MemMsg		word	$InsuffMem, FreeMsg
		byte	"Insufficient Memory trap",0

FreeMsg		word	$FreeErr, PtrMsg
		byte	"FREE memory error",0

PtrMsg		word	$BadPointer, GCStkMsg
		byte	"Illegal pointer value for heap operation.",0

GCStkMsg	word	$GetcStkErr, PCStkMsg
		byte	"GetcAdrs stack under/overflow.",0

PCStkMsg	word	$PutcStkErr, RangeMsg
		byte	"PutcAdrs stack under/overflow.",0

RangeMsg	word	$RangeErr, FPMsg
		byte	"Range error.",0

FPMsg		word	$FPNotAvail, LastPrcsMsg
		byte	"Floating point code not available.",0

LastPrcsMsg	word	$LastProcess, NoPrcsMsg
		byte	"Last process.",0

NoPrcsMsg	word	$NoSuchProcess, BadModeMsg
		byte	"No such process.",0

BadModeMsg	word	$BadFileMode, NotFndMsg
		byte	"Bad FOPEN file mode.",0

NotFndMsg	word	$FileNotFnd, NoPathMsg
		byte	"File not found.",0

NoPathMsg	word	$PathNotFnd, TooManyMsg
		byte	"Path not found.",0

TooManyMsg	word	$TooManyOpen, AccessMsg
		byte	"Too many open files.",0

AccessMsg	word	$AccessDenied, InvalidMsg
		byte	"Access denied.",0

InvalidMsg	word	$InvalidAccess, InvMsg2
		byte	"Invalid file access.",0

InvMsg2		word	$InvalidHandle, InvMsg3
		byte	"Invalid file handle.",0

InvMsg3		word	$InvalidDrive, WrtProMsg
		byte	"Invalid drive specification.",0

WrtProMsg	word	$WriteProtected, SeekMsg
		byte	"Write protect error.",0

SeekMsg		word	$SeekError, ExistsMsg
		byte	"Seek error.",0

ExistsMsg	word	$FileExists, DiskFullMsg
		byte	"File already exists.",0

DiskFullMsg	word	$DiskFull,0
		byte	"Disk is full.",0

$ExceptData	ends




$segExceptions	segment	para public 'Exceptions'
		assume	cs:$segExceptions, ds:nothing

wp		textequ	<word ptr>
byp		textequ	<byte ptr>

$LastSSSP	equ	dword ptr $LastSPValue

Int0Ptr		dword	0
Int4Ptr		dword	0
Int5Ptr		dword	0
Int6Ptr		dword	0
Int23Ptr	dword	0
Int24Ptr	dword	0


; INT24 register values.  These must appear in this order.

Int24AX		word	?
Int24BX		word	?
Int24CX		word	?
Int24DX		word	?
Int24SI		word	?
Int24DI		word	?
Int24BP		word	?
Int24DS		word	?
Int24ES		word	?
Int24IP		word	?
Int24CS		word	?
Int24Flags	word	?


EndTryRet	dword	?	;Holds return address for EndTry procedure.



; Try-	On entry, TOS contains a dword pointer to the new
;	exception handler code.  Try "registers" this address
;	and returns leaving the old exception handler data
;	on the stack.

		public	$try
$try		proc	far
		sub	sp, 4		;Make room for new return address
		push	bp
		mov	bp, sp
		push	eax
		mov	eax, [bp+6]	;Get original return address.
		mov	[bp+2], eax	;Save as new return address.

; Okay, we've fixed the return address, now copy the current SS:SP save
; values to the stack.

		mov	eax, $LastSSSP
		mov	[bp+6], eax

		mov	$LastSSValue, ss	;Store current ss:sp values (after
		mov	ax, bp		; adjusting for the current activation 
		add	ax, 6		; record) into our local variables.
		mov	$LastSPValue, ax

; Exchange the current handler address with the handler address on the stack.

		mov	eax, $CurExpHndlr
		xchg	eax, [bp+10]
		mov	$CurExpHndlr, eax

; Okay, we're done, return to the caller leaving the old exception handling
; information on the stack.  Note that the caller must not disturb this
; information.

		pop	eax
		pop	bp
		ret
$try		endp



; EndTry- 	Cleans up the try frame sitting on the stack.

		public	$endtry
$EndTry		proc	far
		pop	EndTryRet	;Save our return address.
		lss	sp, $LastSSSP	;Restore stack pointer.
		pop	$LastSSSP	;Restore old LastSSSP value.
		pop	$CurExpHndlr	;Restore old Exception handler address.
		jmp	EndTryRet	;Return to our caller.
$EndTry		endp

; BadException winds up getting called if we have some exception that occurs without
; a corresponding exception handler.

		public	$BadException
$BadException	proc	far
		call	$print
		byte	nl,"Unclaimed Exception: ",0

		lesi	ExceptMsgs
ExceptMsgLp:	cmp	ax, es:[di]
		je	FoundException
		mov	di, es:[di+2]
		test	di, di
		jnz	ExceptMsgLp

		call	$print
		byte	"User-defined exception (",0
		call	$puti
		call	$print
		byte	")",nl,0
		jmp	CleanUp

FoundException:	add	di, 4
		puts

CleanUp:	putcr
		call	$CleanUpEx
		exitpgm
$BadException	endp




; PassException-Passes the current exception (in AX) through to the previous
;		exception handler (i.e., you have nested TRY statements and want
;		to pass an exception from one handler to the previously nested
;		exception handler).

		public	$PassException
$PassException	proc	far
		cmp	$LastSSSP, 0		;Make sure there is at least
		je	near ptr $BadException	; one exception frame.

		lss	sp, $LastSSSP
		pop	$LastSSSP
		pop	$CurExpHndlr

		jmp	$CurExpHndlr
$PassException	endp





; InitExceptions-
;
;	This procedure initializes the exception handling system.
;	You must call it before using any exceptions in the standard library.
;	Once you call this routine, you must call CleanUpEx before terminating
;	your program.
;
;	Note that if your program aborts without calling CleanUpEx, you will
;	probably have to reboot the system to reinitialize the system trap vectors.

		public	$InitException
$InitException	proc	far
		assume	ds:nothing, es:nothing
		push	eax
		push	es
		pushf
		cli				;No interrupts while messing with vectors!

; Initialize the CurExpHndlr variable

		mov	wp $CurExpHndlr, offset $BadException
		mov	wp $CurExpHndlr+2, cs


; Set up pointer to interrupt vector segment.

		xor	ax, ax
		mov	es, ax			;Point at int vector table.

; Before getting too carried away, let's make sure this isn't the second call to this
; procedure by the program.  It wouldn't do to wipe out the original saved values with
; the pointers to our routines (CleanUpEx couldn't do its own job at that point).

		mov	ax, es:[0]
		cmp	ax, offset Int0
		jne	OkToPatch
		mov	ax, es:[2]
		cmp	ax, seg Int0Ptr
		je	DontPatch

OkToPatch:	mov	eax, es:[0]		;Divide Error vector
		mov	Int0Ptr, eax

		mov	eax, es:[4*4]		;Overflow vector
		mov	Int4Ptr, eax

		mov	eax, es:[5*4]		;Bounds vector
		mov	Int5Ptr, eax

		mov	eax, es:[23h*4]		;Break (Control-C) vector
		mov	Int23Ptr, eax

		mov	eax, es:[24h*4]		;Critical Error vector
		mov	Int24Ptr, eax

; Okay, put the addresses of our interrupt handlers into the vectors.

DontPatch:	mov	ax, offset Int0
		mov	es:[0], ax

		mov	ax, offset Int4
		mov	es:[4*4], ax

		mov	ax, offset Int5
		mov	es:[5*4], ax

		mov	ax, offset Int6
		mov	es:[6*4], ax

		mov	ax, offset Int23
		mov	es:[23h*4], ax

		mov	ax, cs
		mov	es:[0+2], ax
		mov	es:[4*4+2], ax
		mov	es:[5*4+2], ax
		mov	es:[6*4+2], ax
		mov	es:[23h*4+2], ax

		mov	$XEnabled, 1		;Enable exceptions.
		popf
		pop	es
		pop	eax
		ret
$InitException	endp


; We must initialize interrupt 24h separately since its handler is a pain
; to deal with on a default basis.

		public	$InitEx24
$InitEx24	proc	far
		push	eax
		push	es
		pushf
		cli				;No interrupts while messing with vectors!

		xor	ax, ax
		mov	es, ax			;Point at int vector table.

; Before getting too carried away, let's make sure this isn't the second call to this
; procedure by the program.  It wouldn't do to wipe out the original saved values with
; the pointers to our routines (CleanUpEx couldn't do its own job at that point).

		mov	ax, es:[24h*4]
		cmp	ax, offset Int24
		jne	OkToPatch
		mov	ax, es:[24h*4+2]
		cmp	ax, seg Int24Ptr
		je	DontPatch

OkToPatch:	mov	eax, es:[24h*4]		;Critical Error vector
		mov	Int24Ptr, eax

; Okay, put the addresses of our interrupt handlers into the vectors.

DontPatch:	mov	ax, offset Int24
		mov	es:[24h*4], ax

		mov	ax, cs
		mov	es:[24h*4+2], ax

		mov	$XEnabled, 1		;Enable exceptions.
		popf
		pop	es
		pop	eax
		ret
$InitEx24	endp




; CleanUpEx-	Restores the interrupt vectors patched by the call to $InitExceptions.

		public	$CleanUpEx
$CleanUpEx	proc	far
		push	eax
		push	es
		pushf
		cli			;No interrupts while messing with vectors.

		xor	ax, ax
		mov	es, ax

; First, let's do a sanity check and make sure the interrupt vectors really point
; at our routines.

		mov	ax, es:[0]
		cmp	ax, offset Int0
		jne	DontCleanUp
		mov	ax, es:[2]
		cmp	ax, seg Int0
		jne	DontCleanUp

; Okay, restore the pointers using the saved values in our local variables.

		mov	eax, Int0Ptr
		mov	es:[0*4], eax
		
		mov	eax, Int4Ptr
		mov	es:[4*4], eax
		
		mov	eax, Int5Ptr
		mov	es:[5*4], eax
		
		mov	eax, Int6Ptr
		mov	es:[6*4], eax
		
		mov	eax, Int23Ptr
		mov	es:[23h*4], eax
		
		

; We need to do a separate check on INT 24h since the standard library
; package can initialize this exception separately.

DontCleanUp:	mov	ax, es:[24h*4]
		cmp	ax, offset Int24
		jne	DontCleanUp24
		mov	ax, es:[24*4+2]
		cmp	ax, seg Int24
		jne	DontCleanup24

		mov	eax, Int24Ptr
		mov	es:[24h*4], eax

DontCleanUp24:	mov	$XEnabled, 0		;Disable exceptions
		popf
		pop	es
		pop	eax
		ret
$CleanUpEx	endp




; Here are the ISRs to handle the hardware exceptions:
;
;
; Int0-	Division error interrupt.

Int0		proc	far
		add	sp, 4			;Remove return address
		popf				;Restore flags
		mov	ax, $DivideError
		jmp	$CurExpHndlr
Int0		endp


; Int4-	Overflow trap

Int4		proc	far
		add	sp, 4			;Remove return address
		popf				;Restore flags
		mov	ax, $Overflow
		jmp	$CurExpHndlr
Int4		endp



; Int5-	Bounds violation.  Note: this procedure requires some special code
;	because IBM, in their infinite wisdom, chose to use INT 5 for the
;	print screen operation.  This code must figure out if this is a
;	real bounds violation or an INT 5h (PrtSc) operation.

Int5		proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+2]		;Grab return address
		cmp	byp es:[di], 0cdh	;Bound opcode?
		je	DoInt5
		pop	di			;No Bound Opcode, use must
		pop	es			; have press the PrtSc key.
		pop	bp
		jmp	Int5Ptr

; Okay, we've got a bounds violation, handle that down here.

DoInt5:		add	sp, 4			;Remove return address
		popf				;Restore flags
		mov	ax, $Bounds
		jmp	$CurExpHndlr
Int5		endp


; Int6-	Invalid Opcode trap

Int6		proc	far
		add	sp, 4			;Remove return address
		popf				;Restore flags
		mov	ax, $InvOpcode
		jmp	$CurExpHndlr
Int6		endp



; Int23-	Break (control-C) pressed.

Int23		proc	far
		add	sp, 4			;Remove return address (No flags!)
		mov	ax, $Break
		jmp	$CurExpHndlr
Int23		endp


; Int24-	Critical Error Handler

Int24		proc	far
		add	sp, 4		;Remove DOS Critical Error return
		popf			; address from stack.

		pop	Int24AX		;Remove DOS parms from stack.
		pop	Int24BX
		pop	Int24CX
		pop	Int24DX
		pop	Int24SI
		pop	Int24DI
		pop	Int24BP
		pop	Int24DS
		pop	Int24ES
		pop	Int24IP
		pop	Int24CS
		pop	Int24Flags

		lesi	Int24AX		;Return a pointer to the registers' values.

; Note: we're about to bail on DOS.  If you do not return through DOS
; via an IRET instruction, DOS is in an unstable state until you execute
; another DOS call with a function number greater than 0Ch.  The following
; call reads the DOS BREAK flag (function 33h) and satisfies this condition.

		push	ax
		push	dx
		mov	ax, 3300h
		int	21h
		pop	dx
		pop	ax

; On entry to this routine, the H.O. bit of AX contains a one if there was
; a disk error.  Since we need to load the exception number into AX, this
; code copies the H.O. bit into the carry flag before transfering control
; to the exception handler.

		shl	ax, 1		;Put DISK Error bit into carry flag.

		mov	ax, $CritErr
		jmp	$CurExpHndlr
Int24		endp
$SegExceptions	ends
		end
