		.386
		option	segment:use16, proc:private

		include	file.a
		include	excepts.a

		echo	fopen, fopenstk, fopenl
	

$segFile	segment	para public 'Files'
		assume	cs:$segFile, ds:nothing


dp		textequ	<dword ptr>
wp		textequ	<word ptr>
byp		textequ	<byte ptr>


; fopen- Opens a file.
;	On entry:
;			AX contains mode (0=read, 1=write)
;			FS:SI points at a file variable.
;			ES:DI points at a file name.
;	On Exit:
;			Carry is clear if no error.
;			AX contains (DOS) error code if carry is set.
;
; FOPENCS-	A dword pointer to the file variable, the file open mode,
;		and a zero terminated filename immediately follow the call to 
;		FOPENL in the code stream.
;
; FOpenStk-	A far ptr to the filename appears on TOS, a word containing the
;		file open open appears on NOS, and a far pointer to the
;		file variable appears above that.
;
;
; FOPENSTK(fVar, fMode, fName);

		public	$fOpenStk
$FopenStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	fs
		push	si
		push	ax

		les	di, [bp+6]
		mov	ax, [bp+10]
		lfs	si, [bp+12]
		call	$FOpen

		pop	ax
		pop	si
		pop	fs
		pop	di
		pop	es
		pop	bp
		ret	10
$FOpenStk	endp



;	FOPENCS
;	dword	fVar
;	byte	FileOpenMode
;	byte	"fName",0

		public	$fOpenCS
$FOpenCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	fs
		push	si
		push	ax
		push	cx

		les	di, [bp+2]	;Get ptr to file variable ptr.
		lfs	si, es:[di]	;Point FS:SI at file var.

		mov	al, es:[di+4]	;Get file open mode.
		cbw
		add	di, 5		;Skip file var and open mode.

		call	$FOpen		;Do the open.

; Skip past the file variable and filename in the code stream.

		pushf			;Save Dflag and error status.
		cld
		les	di, [bp+2]
		add	di, 5
		mov	al, 0
		mov	cx, 0FFFFh
        repne   scasb
		mov	[bp+2], di
		popf			;Restore DFlag and error status.

		pop	cx
		pop	ax
		pop	si
		pop	fs
		pop	di
		pop	es
		pop	bp
		ret
$FOpenCS	endp



		public	$fOpen
$fopen     	proc	far
		push	ds
		push	dx
		push	ax

		push	es
		pop	ds
		mov	dx, di

		mov	fs:[si].FileVar.fvMode, ax	;Save away R/W mode.
		mov	fs:[si].FileVar.fvIndex, 0	;Init Index and # of
		mov	fs:[si].FileVar.fvByteCount, 0	; bytes in buffer.

		cmp	ax, 1
		ja	BadMode
		je	WriteMode

; Handle the read open here.
; If it's read mode, we've got to figure out how many bytes
; are in the file so we can check for EOF during read
; operations.

		mov	ah, 3dh		;DOS Open call.
		int	21h
		jc	fopenError
		mov	fs:[si].FileVar.fvHandle, ax

; Determine the size of the file:

		push	bx
		push	cx

		mov	bx, ax
		xor	cx, cx
		xor	dx, dx
		mov	ax, 4202h	;Scan to EOF.
		int	21h		;Assume no error occurs.


		mov	wp fs:[si].FileVar.fvFileSize, ax
		mov	wp fs:[si].FileVar.fvFileSize+2, dx
		mov	fs:[si].FileVar.fvBytesRead, 0

		mov	ax, 4200h	;Move back to beginning of file.
		int	21h

		pop	cx
		pop	bx
		jmp	FOpenDone
		



WriteMode:	mov	fs:[si].FileVar.fvIndex, 0	;It's write mode.
		mov	ah, 3dh				;DOS Open call.
		int	21h
		jc	fopenError
		mov	fs:[si].FileVar.fvHandle, ax
		mov	fs:[si].FileVar.fvBytesRead, 0
                mov     fs:[si].FileVar.fvFileSize, 0

FOpenDone:	pop	ax
		pop	dx
		pop	ds
		clc
		ret


fOpenError:	push	ax
		GetXEnabled
		cmp	ax, 0
		je	RtnError
		pop	ax
		cmp	ax, 2
		jne	tstPathNotFnd

		mov	ax, $FileNotFnd
		Raise

TstPathNotFnd:	cmp	ax, 3
		jne	tstTooMany
		mov	ax, $PathNotFnd
		Raise

tstTooMany:	cmp	ax, 4
		jne	tstDenied
		mov	ax, $TooManyOpen
		Raise

tstDenied:	cmp	ax, 5
		jne	tstInv
		mov	ax, $AccessDenied
		Raise

tstInv:		cmp	ax, 12
		jne	UnknownErr
		mov	ax, $InvalidAccess
		Raise

UnknownErr:	mov	ax, $FileIO
		Raise
		

BadMode:	GetXEnabled
		cmp	ax, 0
		je	RtnBadMode
		mov	ax, $BadFileMode
		Raise

RtnBadMode:	push	1		;Invalid function error code if
RtnError:	pop	ax		; bad r/w access specified.
		pop	es		;Return error in AX!
		pop	dx
		pop	ds
		stc
		ret
$fopen		endp




$SegFile	ends
		end
