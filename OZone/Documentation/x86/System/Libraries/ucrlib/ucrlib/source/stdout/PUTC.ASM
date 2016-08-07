		include	stdout.a
		include	excepts.a

		echo	ResetStdOut, PUTC, PutcStk, Putcr, PutcStdOut, PutcBIOS
		echo	GetOutAdrs, SetOutAdrs, PushOutAdrs, PopOutAdrs, 

$segSTDIO	segment	para public 'ucrlib'
		assume	cs:$segSTDIO,ds:nothing

wp		textequ	<word ptr>
dp		textequ	<dword ptr>

PutcAdrs	dword	$putcstdout
PutcStkIndx	word	0
PutcStack	dword	16 dup ($putcstdout)
PSIsize		=	$-PutcStack


; $ResetStdOut-	Initializes the Putc pointer and the Putc Stack.
;		Sets up Putc so that it calls $PutcStdOut.

		public	$ResetStdOut
$ResetStdOut	proc	far
		push	ax
		mov	ax, seg $PutcStdOut
		mov	wp PutcAdrs, ax
		mov	ax, offset $PutcStdOut
		mov	wp PutcAdrs+2, ax
		mov	PutcStkIndx, 0
		pop	ax
		ret
$ResetStdOut	endp


; $Putc- 	Sends the character in AL to the current output 
;		routine.  By default, this is "putstdout".  
;		PutcAdrs contains the address of the current 
;		output routine.  By changing the value of this
;		pointer, the caller can overload this 

		public	$Putc
$putc		proc	far
		jmp	dp PutcAdrs
$putc		endp





; $PutcTOS-	The character to print is passed on the stack.
;		This routine removes that character from the
;		stack and calls $putc to print it.

		public	$PutcTOS
$PutcTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	al, [bp+6]
		call	$putc
		pop	ax
		pop	bp
		ret	2
$PutcTOS	endp


; $PutcStk-	The address of the character to print is 
;		passed on the stack. This routine fetches
;		the character at the address specified by
;		the pointer on the stack and calls $putc 
;		to print it.

		public	$PutcStk
$PutcStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	si
		push	ax
		
		lds	si, [bp+6]
		mov	al, [si]
		call	$putc
		
		pop	ax
		pop	si
		pop	ds
		pop	bp
		ret	4
$PutcStk	endp


; $PutcCS-	The address of a character variable follows in the code
;		stream.

		public	$PutcCS
$PutcCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	ds
		push	si

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	al, [si]		;Get the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		call	$putc

		pop	si
		pop	ds
		pop	ax
		pop	bp
		ret
$PutcCS		endp


; $PutCR-	Prints a new line to the standard output device.
;		On the PC, this consists of the two character
;		sequence CR/LF.

		public	$Putcr
$putcr		proc	far
		push	ax
		mov	al, 13		;Carriage return
		call	$putc
		mov	al, 10		;Line feed
		call	$putc
		pop	ax
		ret
$putcr		endp





; $PutStdOut-	Prints the character in AL to the standard output 
;		device by calling DOS to print the character.  
;		A call to this routine bypasses the output re-
;		direction done by PUTC.

		public	$PutcStdOut
$putcstdout	proc	far
		push	ax
		push	dx
		mov	dl, al
		mov	ah, 2
		int	21h
		pop	dx
		pop	ax
		ret
$putcstdout	endp





; $PutcBIOS-	Prints the character in AL by calling the BIOS output 
;		routine. This effectively sends the character to the
;		standard error device.  There is no way to redirect
;		this output (short of patching the BIOS int 10h routine).

		public	$PutcBIOS
$PutcBIOS	proc	far
		push	ax
		mov	ah, 14
		int	10h
		pop	ax
		ret
$PutcBIOS	endp







; GetOutAdrs-	Returns the address of the current output routine in ES:DI.

		public	$GetOutAdrs
$GetOutAdrs	proc	far
		les	di, PutcAdrs
		ret
$GetOutAdrs	endp


; SetOutAdrs-	Stores the address in ES:DI into PutcAdrs.  This must be the
;		address of a valid output routine which outputs the character
;		in the AL register.  This routine must preserve all registers.

		public	$SetOutAdrs
$SetOutAdrs	proc	far
		mov	wp PutcAdrs, di
		mov	wp PutcAdrs+2, es
		ret
$SetOutAdrs	endp



; PushOutAdrs-	Pushes the current output address onto the output stack
;		and then stores the address in es:di into the output address
;		pointer.  Returns carry clear if no problems.  Returns carry
;		set if there is an address stack overflow.  (Raises an 
;		exception if exceptions are enabled). Does NOT modify
;		anything if the stack is full.

		public	$PushOutAdrs
$PushOutAdrs	proc	far
		push	ax
		push	di

; Check for stack overflow:

		cmp	PutcStkIndx, PSIsize
		jae	BadPush

; Copy the current pointer to the top of the stack:

		mov	di, PutcStkIndx		;Get Current TOS.
		add	PutcStkIndx, 4		;Point SP at next entry.
		mov	ax, wp PutcAdrs		;Copy current address to
		mov	wp PutcStack[di], ax	; the old TOS.
		mov	ax, wp PutcAdrs+2
		mov	wp PutcStack+2[di], ax

; Store the new pointer (in ES:DI) into the PutcAdrs pointer.

		pop	di
		mov	wp PutcAdrs, di
		mov	wp PutcAdrs+2, es

		pop	ax
		clc					;No stack overflow.
		ret

; Come down here if a stack overflow occurred.

BadPush:	call	$GetXEnabled
		cmp	ax, 0
		je	POAError
		mov	ax, $PutcStkErr
		call	$Raise

POAError:	pop	di
		pop	ax
		stc
		ret
$PushOutAdrs	endp






; PopOutAdrs-	Pops an output address off of the stack and stores it into
;		the PutcAdrs variable.  If the user attempts to pop too
;		many pointers off the stack, this routine empties the
;		stack and then loads the output pointer with the address
;		of the standard output routine (PUTCSTDOUT) and returns
;		the carry flag set.  It raises an exception in this case
;		if exceptions are enabled.

		public	$PopOutAdrs
$PopOutAdrs	proc	far
		push	ax
		mov	di, PutcStkIndx
		sub	di, 4
		clc			;Assume return w/o error
		jns	GoodPop

; Stack just underflowed.  See if exceptions are active.

		call	$GetXEnabled
		cmp	ax, 0
		je	CleanUpStk
		mov	ax, $PutcStkErr
		call	$Raise

; If this guy just went negative, set it to zero and push the address
; of the stdout routine onto the stack.

CleanUpStk:	xor	di, di			
		mov	wp PutcStack, offset $PutcStdOut
		mov	wp PutcStack+2, $segSTDIO
		stc

GoodPop:	mov	PutcStkIndx, di

; Grab the pointer on the top of the address stack and move it to our
; PutcAdrs pointer.  Return the original PutcAdrs pointer in ES:DI
;
; WARNING: the following instructions must not modify the carry flag.

		mov	es, wp PutcAdrs+2	;Get seg ret val.
		mov	ax, wp PutcStack+2[di]	;Copy seg value
		mov	wp PutcAdrs+2, ax	; from stk to var.
		mov	ax, wp PutcStack[di]	;Get offset from
		xchg	wp PutcAdrs, ax		; stk and swap with
		mov	di, ax			; original value.
		pop	ax
		ret
$PopOutAdrs	endp

$segSTDIO	ends
		end
