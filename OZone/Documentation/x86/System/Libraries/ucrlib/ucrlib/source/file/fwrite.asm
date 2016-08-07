		.386
		option	segment:use16, proc:private

		include	file.a
		include	excepts.a

		echo	fwrite, fWriteStk, fWriteL
	

$segFile	segment	para public 'Files'
		assume	cs:$segFile, ds:nothing


dp		textequ	<dword ptr>
wp		textequ	<word ptr>
byp		textequ	<byte ptr>




; fwrite-	Write a block of bytes to the file.
;	On Entry:
;		CX contains the number of bytes to write.
;		FS:SI points at the file variable.
;		ES:DI points at the data buffer to write.
;
;	On Exit:
;		AX contains error code if C=1.
;
; fwriteStk-	Called as fwrite(filevar, buffer, count) with count at BP+6,
;		buffer at BP+8, and FileVar at BP+12.
;
; fWriteCS-	Address of filevar, address of buffer, and count follow in
;		the code stream.

		public	$fWriteStk
$fwriteStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	si
		push	di
		push	cx

		mov	cx, [bp+6]		;Get the byte count.
		les	di, [bp+8]		;Get ptr to buffer.
		lfs	si, [bp+12]		;Get ptr to file var.
		call	$fwrite			;Do the fwrite.

		pop	cx
		pop	di
		pop	si
		pop	fs
		pop	es
		pop	bp
		ret	10
$fwriteStk	endp


		public	$fWriteCS
$fwriteCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	si
		push	di
		push	cx

		lfs	si, [bp+2]		;Ptr to return address
		add	byte ptr [bp+2], 10	;Skip parameters on return.
		mov	cx, fs:[si+8]		;Fetch byte count from code stream.
		les	di, fs:[si+4]		;Fetch ptr to buffer from code.
		lfs	si, fs:[si]		;Fetch ptr to file var from code.
		call	$fwrite

		pop	cx
		pop	di
		pop	si
		pop	fs
		pop	es
		pop	bp
		ret
$fwriteCS	endp
		


		public	$fWrite
$fwrite		proc	far
		push	ds
		push	bx
		push	ax
		push	dx
		push	cx

		cmp	fs:[si].FileVar.fvMode, 1
		jne	Badfwrite

		call	$fflush
		jc      BadFWB

		push	es
		pop	ds
		mov	dx, di
		mov	ah, 40h
		mov	bx, fs:[si].FileVar.fvHandle
		int	21h
		jc	BadFWB

		pop	cx
		push	cx
		cmp	ax, cx			;Check for disk full.
		jne	DiskFull

		pop	cx
		pop	dx
		pop	ax
                pop     bx
		pop	ds
		clc
		ret

DiskFull:	GetXEnabled
		test	ax, ax
		jz	NoExceptions		;Return error code=0 for 
		mov	ax, $DiskFull		; disk full (EOF on write).
		Raise

BadFWB:		push	ax
		GetXEnabled
		test	ax, ax
		pop	ax
		jz	NoExceptions

		cmp	ax, 5
		je	BadfWrite
		cmp	ax, 50h
		jne	TryBadHndl
Badfwrite:	mov	ax, $AccessDenied
		Raise

TryBadHndl:	cmp	ax, 6
		jne	FileIOErr
		mov	ax, $InvalidHandle
		Raise

FileIOErr:	mov	ax, $FileIO
		Raise

NoExceptions:	pop	cx
		pop	dx
		pop	bx			;Keep error code in AX
		pop	bx
		pop	ds
		stc
		ret
$fwrite		endp





$segFile	ends
		end
