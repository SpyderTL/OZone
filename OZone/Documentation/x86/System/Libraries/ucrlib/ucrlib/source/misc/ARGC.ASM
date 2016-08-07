		.386
		option	segment:use16, proc:private

		include	misc.a
		include	memory.a
		include	consts.a

		echo	argc
	

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing

; Argc,
; ArgcCX-	Counts the number of command line arguments
;
; inputs:
;
; Outputs:
;
;	AX-	Contains the number of command line arguments. (Argc)
;	CX-	Contains the number of command line arguments. (ArgcCX)


		public	$ArgcCX
$ArgcCX		proc	far
		push	ds
		push	ax
		push	bx

		mov	ah, 62h			;Get PSP DOS call
		int	21h
		mov	ds, bx			;Point DS at PSP.

		mov	bx, 80h			;Pointer to start of cmd line-1
		mov	cx, 0			;Start cnt at zero
CntLoop:	inc	bx			;Move on to next char.
		cmp	byte ptr [bx], ' '	;Skip all spaces here.
		je	CntLoop
		mov	al, [bx]
		cmp	al, cr			;See if carriage return
		je	ArgcDone

; We just headed into a word of some sort. Skip all the chars in this argument.

		inc	cx			;First, count this argument

		cmp	al, '"'			;See if it's a string.
		je	GotString
		cmp	al, "'"
		je	GotString

; If not a string, skip to next space or CR.

SkipWord:	inc	bx
		cmp	byte ptr [bx], ' '
		je	CntLoop
		cmp	byte ptr [bx], cr
		je	ArgcDone
		jmp	skipWord

; If we've got a string, skip to the delimiter or to the end of the line.

GotString:	inc	bx
		cmp	al, [bx]		;See if the delimiter
		je	CntLoop
		cmp	byte ptr [bx], cr	;See if EOLN
		jne	GotString

; Come down here when we're done:

ArgcDone:	pop	bx
		pop	ax
		pop	ds
		ret
$ArgcCX		endp


		public	$Argc
$Argc		proc	far
		push	cx
		
		call	$ArgcCX
		mov	ax, cx
		
		pop	cx
		ret
$Argc		endp



; $ArgcCS-	The address of a word variable follows in the code
;		stream.  ArgcCS reads a word via a call to Argc and
;		stores this character at the address specified by the
;		dword following the call.

		public	$ArgcCS
$ArgcCS		proc	far
		push	bp
		mov	bp, sp
		push	cx
		push	ds
		push	si

		call	$ArgcCX

		lds	si, [bp+2]		;Get return address.
		lds	si, [si]		;Get ptr to char.
		mov	[si], cx		;Store the char.
		add	word ptr [bp+2], 4	;Skip ptr to char.

		pop	si
		pop	ds
		pop	cx
		pop	bp
		ret
$ArgcCS		endp



; $ArgcStk-	The address of a word variable is on the TOS.
;		ArgcStk reads a character via a call to Argc and
;		stores this character at the address specified by the
;		address on TOS.

		public	$ArgcStk
$ArgcStk	proc	far
		push	bp
		mov	bp, sp
		push	cx
		push	ds
		push	si

		call	$ArgcCX

		lds	si, [bp+6]		;Get ptr to char.
		mov	[si], cx		;Store the char.

		pop	si
		pop	ds
		pop	cx
		pop	bp
		ret	4
$ArgcStk	endp





ucrlib		ends
		end
