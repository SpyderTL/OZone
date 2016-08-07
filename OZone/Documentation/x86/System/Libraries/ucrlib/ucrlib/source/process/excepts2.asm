		.386
		option	segment:use16, proc:private

		include	consts.a
		include	excepts.a
		include	stdout.a
		echo	EnableExcepts, DisableExcepts, GetXEnabled, Raise


$segExceptions	segment	para public 'Exceptions'
		assume	cs:$SegExceptions, ds:nothing

wp		textequ	<word ptr>
byp		textequ	<byte ptr>



; $CurExpHndlr contains the address of the Raise routine.  If the user has not
; called the InitExcept routine, this variable points at a default RAISE routine
; that aborts the program after printing an appropriate error routine.  The
; InitExcept routine stores the address of the real RAISE routine into this
; pointer during its execution.
;
; The whole purpose of this exercise is to avoid forcing the system to link
; in the exception handling package (at 1-2K, it's somewhat large) just because
; several routines in the standard library reference the RAISE routine.

; The following must always appear in this order
; This is the exception frame that appears on the stack while we are
; waiting for an exception to occur.  This local copy here holds the
; information for the most recent exception.

$LastSSSP	equ	this dword
$LastSPValue	word	0
$LastSSValue	word	0
$CurExpHndlr	dword	BadRaise

; End of order sensitive values.


; $XEnabled-	This variable is a boolean value.  It contains one if
;		exceptions are enabled for certain other library routines
;		including atoi, atou, atol, etc.  If exceptions are enabled,
;		these routines will raise an exception if an error occurs.
;		if exceptions are disabled, this routines return their error
;		status without raising an exception.

$XEnabled	word	0



; The following routines provide access to the $XEnabled variable above.


		public	$EnableExcept
$EnableExcept	proc	far
		mov	$XEnabled, 1
		ret
$EnableExcept	endp

		public	$DisableExcept
$DisableExcept	proc	far
		mov	$XEnabled, 0
		ret
$DisableExcept	endp


		public	$GetXEnabled
$GetXEnabled	proc	far
		mov	ax, $XEnabled
		ret
$GetXEnabled	endp


		public	$Raise
$Raise		proc	far
		jmp	$CurExpHndlr
$Raise		endp

BadRaise	proc	far
		call	$print	
		byte	"Exceptions package is not initialized, yet program raised "
		byte	"an exception.",nl
		byte	"Program logic error, terminating execution",nl,0
		ExitPgm
BadRaise	endp



$segExceptions	ends
		end
