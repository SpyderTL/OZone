		include	stdout.a

		echo	tstKbd, tstInput
	

BIOS		segment	at 40h
		org	1ch
Head		word	?
Tail		word	?
Buffer		word	16 dup (?)
EndBuffer	equ	this word
BIOS		ends

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing


; TstKbd-	Returns zero in AX if there are no characters available
;		in the system type ahead buffer.  Returns one in AX if
;		keystrokes are available.  Note that a call to a buffered
;		I/O routine (e.g., GETC) may not immediately return even
;		if TstKbd indicates characters are available.  This is
;		because the xxxGets and buffered input routines all
;		throw away non-ASCII keycodes.  Also returns with the zero
;		flag set if there were no keys, with the zero flag clear
;		if there are keys in the buffer.

		public	$TstKbd
$TstKbd		proc	far
		mov	ah, 1
		int	16h
		jne	HasKey
		xor	ax, ax
		ret

HasKey:		mov	ax, 1
		ret
$TstKbd		endp


; TstInput-	Like tstKbd above, except it ensures there are ASCII characters
;		in the type ahead buffer before returning a one in AX.

		public	$tstInput
$tstInput	proc	far
		push	es
		push	di
		mov	di, seg BIOS
		mov	es, di
		mov	di, es:Head
		xor	ax, ax			;Assume no chars avail.
ChkASCII:	cmp	di, es:Tail
		je	NoASCII
		cmp	byte ptr es:[di], 0	;ASCII code <> 0?
		jne	HasASCII
		add	di, 2
		cmp	di, offset EndBuffer
		jb	ChkASCII
		mov	di, offset Buffer
		jmp	ChkASCII

HasASCII:	inc	ax			;There are keys available.
NoASCII:	pop	di
		pop	es
		cmp	ax, 0			;Return status in Zflag.
		ret
$tstInput	endp

ucrlib		ends
		end
