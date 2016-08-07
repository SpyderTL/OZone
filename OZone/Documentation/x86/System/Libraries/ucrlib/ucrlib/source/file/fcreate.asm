		.386
		option	segment:use16, proc:private

		include	file.a
		include	excepts.a

		echo	fcreate, fcreatel, fcreatestk
		echo	fcreateNew, fcreateNewL, fcreateNewStk
		echo	fcreateTmp, fcreateTmpL, fcreateTmpStk
	

$segFile	segment	para public 'Files'
		assume	cs:$segFile, ds:nothing


dp		textequ	<dword ptr>
wp		textequ	<word ptr>
byp		textequ	<byte ptr>



; fcreate- 	Creates a file (may be new or pre-existing, truncates
;		pre-existing file).
;
; fcreatenew-	Creates a new file.  Returns an error if the file
;		already exists.
;
; fCreateTmp-	Creates a temporary file using a system unique name.
;
;	On entry:
;			FS:SI	points at a file variable.
;			ES:DI	points at a file name (fCreate, fCreateNew).
;			ES:DI	(fCreateTmp) points at a path name that ends 
;				with a backslash and 14 zero bytes.
;	On Exit:
;			Carry is clear if no error.
;			AX contains (DOS) error code if carry is set.
;
;
; Note: The standard library file calls are intended for *sequential*
;	access only;  they do not support random access files.  Therefore,
;	the stdlib create calls effectively open the file for writing only,
;	not read/write access as per DOS.  If you need read/write access
;	you will probably have to call DOS directly.
;
;
;
; fcreateStk,	
; fcreateNewStk,
; fCreateTmpStk-Parameters are on stack rather than in registers.
;
; fCreateCS,
; fCreateNewCS,
; fCreateTmpCS-	Parameters follow in code stream.
;
;
;
;
;
; FCreateStk(dword *fVar, dword *fName);
;
;	fVar is at bp+10
;	fName is at bp+6

		public	$FCreateStk
$FCreateStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	fs
		push	si

		lfs	si, [bp+6]
		les	di, [bp+12]
		call	$FCreate

		pop	si
		pop	fs
		pop	di
		pop	es
		pop	bp
		ret	8
$FCreateStk	endp






; FCreateNewStk(fVar, fName);
;
;	fVar is at bp+10
;	fName is at bp+6

		public	$FCreateNewStk
$FCreateNewStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	fs
		push	si

		lfs	si, [bp+6]
		les	di, [bp+12]
		call	$FCreateNew

		pop	si
		pop	fs
		pop	di
		pop	es
		pop	bp
		ret	8
$FCreateNewStk	endp



; FCreateTmpStk(fVar, fNameBuf);
;
;	fVar is at bp+10
;	fNameBuf is at bp+6

		public	$FCreateTmpStk
$FCreateTmpStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	fs
		push	si

		lfs	si, [bp+6]
		les	di, [bp+12]
		call	$FCreateTmp

		pop	si
		pop	fs
		pop	di
		pop	es
		pop	bp
		ret	8
$FCreateTmpStk	endp



;	FCreateCS
;	dword	fVar
;	byte	"fName",0

		public	$FCreateCS
$FCreateCS	proc	far
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
		add	di, 4		;Skip file var, pt at fname.

		call	$FCreate	;Do the create

; Skip past the file variable and filename in the code stream.

		les	di, [bp+2]
		add	di, 4
		mov	al, 0
		mov	cx, 0FFFFh
        repne   scasb
		mov	[bp+2], di

		pop	cx
		pop	ax
		pop	si
		pop	fs
		pop	di
		pop	es
		pop	bp
		ret
$FCreateCS	endp



;	FCreateNewCS
;	dword	fVar
;	byte	"fName",0


		public	$FCreateNewCS
$FCreateNewCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	fs
		push	si
		push	ax
		push	cx

		les	di, [bp+2]	;Get ptr to file variable.
		lfs	si, es:[di]	;Point FS:SI at filevar.
		add	di, 4		;Skip file var, pt at fname.

		call	$FCreateNew	;Do the create

; Skip past the file variable and filename in the code stream.

		les	di, [bp+2]
		add	di, 4
		mov	al, 0
		mov	cx, 0FFFFh
        repne   scasb
		mov	[bp+2], di

		pop	cx
		pop	ax
		pop	si
		pop	fs
		pop	di
		pop	es
		pop	bp
		ret
$FCreateNewCS	endp




;	FCreateTmpCS
;	dword	fVar
;	dword	FNameBuf

		public	$FCreateTmpCS
$FCreateTmpCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	fs
		push	si
		push	ax
		push	cx

		lds	di, [bp+2]	;Get ptr to file variable.
		lfs	si, es:[di]	;Point FS:SI at file var.
		les	di, es:[di+4]	;Point ES:DI at filename buffer.


		call	$FCreateTmp	;Do the create

; Skip past the file variable and filename in the code stream.

		add	wp [bp+2], 8

		pop	cx
		pop	ax
		pop	si
		pop	fs
		pop	di
		pop	es
		pop	bp
		ret
$FCreateTmpCS	endp




; fCreate-	FS:SI contains pointer to file variable.
;		ES:DI contains pointer to file name.

		public	$FCreate
$fCreate	proc	far
		push	ax
		mov	ah, 3ch
		call	doCreate
		pop	ax
		ret
$fCreate	endp






; fCreateNew-	FS:SI contains pointer to file variable.
;		ES:DI contains pointer to file name.

		public	$FCreateNew
$fCreateNew	proc	far
		push	ax
		mov	ah, 5bh
		call	doCreate
		pop	ax
		ret
$fCreateNew	endp





; fCreateTmp-	FS:SI contains pointer to file variable.
;		ES:DI contains pointer to file name.

		public	$FCreateTmp
$fCreateTmp	proc	far
		push	ax
		mov	ah, 5ah		;Create Tmp opcode.
		call	doCreate
		pop	ax
		ret
$fCreateTmp	endp




; DoCreate-	AH contains creation type.
;		FS:SI points at file variable.
;		ES:DI points at file name (or buffer for filename if CreateTmp).

docreate     	proc	near
		push	ds
		push	es
		push	dx
		push	cx

		push	es		;Point DS:DX at filename.
		pop	ds
		mov	dx, di

		mov	fs:[si].FileVar.fvMode, 1	;Mode is write.
		mov	fs:[si].FileVar.fvIndex, 0	;Start at first byte.

		xor	cx, cx				;Normal file.
		int	21h
		jc	fcreateError
		mov	fs:[si].FileVar.fvHandle, ax	;Save DOS' file handle.

		pop	cx
		pop	dx
		pop	es
		pop	ds
		clc
		ret

fcreateError:	push	ax
		GetXEnabled
		cmp	ax, 0
		jne	RaiseExcept
		pop	ax		;Return error in AX!
		pop	cx
		pop	dx
		pop	es
		pop	ds
		stc
		ret

RaiseExcept:	pop	ax
		cmp	ax, 2
		jne	TryBadPath
		mov	ax, $FileNotFnd
		Raise

TryBadPath:	cmp	ax, 3
		jne	TryTooMany
		mov	ax, $PathNotFnd
		Raise

TryTooMany:	cmp	ax, 4
		jne	TryAccess
		mov	ax, $TooManyOpen
		Raise

TryAccess:	cmp	ax, 50h
		je	ADenied
		cmp	ax, 5
		jne	ExistsErr
ADenied:	mov	ax, $AccessDenied
		Raise

ExistsErr:	cmp	ax, 50h
		jne	Unknown
		mov	ax, $FileExists
		Raise

Unknown:	mov	ax, $FileIO
		Raise
docreate	endp

$segFile	ends
		end
