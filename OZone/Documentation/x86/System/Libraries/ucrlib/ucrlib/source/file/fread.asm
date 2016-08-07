		.386
		option	segment:use16, proc:private

		include	file.a
		include	excepts.a

		echo	fread, freadL, freadStk
	

$segFile	segment	para public 'Files'
		assume	cs:$segFile, ds:nothing


dp		textequ	<dword ptr>
wp		textequ	<word ptr>
byp		textequ	<byte ptr>




; fread-	Reads a block of bytes from the file.
;	On Entry:
;		CX contains the number of bytes to read.
;		FS:SI points at the file variable.
;		ES:DI points at the destination block.
;
;	On Exit:
;		EAX contains actual bytes read (0=EOF).
;		AX contains error code if error (C=1).
;		Raises an exception on error if the exceptions are
;		enabled.
;
; freadStk-	called as fread(filevar, buffer, count) with count at
;		bp+6, buffer at bp+8, and filevar at bp+12.
;		Returns actual count in EAX.
;
; freadL-	Address of filevar, address of buffer, and count follow
;		in the code stream (fv at cs:ip, buf at cs:ip+4, count
;		at cs:ip+8).
;		Returns actual count in EAX.

		public	$fReadStk
$freadStk	proc	far
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
		call	$fread			;Do the fread.

		pop	cx
		pop	di
		pop	si
		pop	fs
		pop	es
		pop	bp
		ret	10
$freadStk	endp


		public	$fReadCS
$freadCS	proc	far
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
		call	$fread

		pop	cx
		pop	di
		pop	si
		pop	fs
		pop	es
		pop	bp
		ret
$freadCS	endp
		


		public	$fRead
$fread		proc	far
		assume	si:ptr FileVar

		push	ds
		push	bx
		push	cx
		push	dx
		push	di


		cmp	fs:[si].fvMode, 0	;Read Mode?
		je	freadModeOK
		mov	ax, $BadFileMode
		call	TestExcepts
		stc
		jmp	freadErr


freadModeOK:	push	es
		pop	ds

; Check for end of file.

		mov	eax, fs:[si].fvBytesRead
		cmp	eax, fs:[si].fvFileSize
		jb	MoreData
		mov	eax, $EndOfFile
		call	TestExcepts
		xor	eax, eax		;Return zero for EOF error.
		stc
		jmp	freadErr

MoreData:	xor	eax, eax		;Clear H.O. word of EAX.
		call	BuffCXBytes		;Read up to CX bytes from buf.
		jcxz	NoMore			;Bail if we're read everything.
		call	FileCXBytes		;Read up to CX bytes from file.

NoMore:		clc
freadErr:	pop	di
		pop	dx
		pop	cx
		pop	bx
		pop	ds
		ret
$fread		endp





; BuffCXBytes-	Reads up to "CX" bytes from the internal file buffer.
;		Decrements CX by this amount before returning.  Also
;		bumps the fvBytesRead and fvIndex fields by appropriate
;		amounts.
;
;		On entry- CX contains the number of bytes to read.
;			  DS:DI points at the data buffer.
;
;		On exit-  CX contains the number of bytes left to read.
;			     (CX will contain zero if all the data we
;			     wanted to read was in the buffer).
;			  AX contains the total number of bytes read
;			     from the buffer.

BuffCXBytes	proc	near

; Two cases: 	(1) all the bytes we want to read are in the buffer.
;		(2) we want to read more bytes than are available
;		    in the buffer.

		mov	ax, fs:[si].fvByteCount	;H.O. word of eax=0.
		sub	ax, fs:[si].fvIndex	;Compute bytes in buf.
		jz	NoneInBuffer		;Bail if buffer is empty.

		cmp	cx, ax			;Are all the bytes in
		ja	ReadPartial		; the buffer?

; Handle case (1) above here.  All the bytes we want to read can be
; found in the buffer.

		push	cx			;Total # bytes to read.
		push	0			;# of bytes not in buf.
		mov	ax, cx			;# of bytes to read now.
		jmp	ReadFromBuf

; Handle case (2) above here.  The buffer contains fewer bytes than
; we want to read, so we will empty the buffer and will need to read
; data from the file.

ReadPartial:	push	cx			;Total # bytes to read.
		sub	cx, ax			;Compute and save the 
		push	cx			; # of bytes not in buf.
		mov	cx, ax

; Okay, move the data from the internal buffer to whereever the caller
; wants it placed.

ReadFromBuf:	mov	bx, fs:[si].fvIndex
		add	fs:[si].fvBytesRead, eax
CopyLoop1:	mov	al, fs:[bx+si].FileVar.fvBuffer
		mov	ds:[di], al
		inc	di
		inc	bx
		loop	CopyLoop1

; Update the fvIndex field to account for the bytes
; we just removed from the buffer.
; Note that if we just emptied the buffer, BX should be equal to
; fvByteCount.

		mov	fs:[si].fvIndex, bx	;Save away new index value.
		pop	cx			;Retrieve remaining cnt.
		pop	ax			;Retrieve original total.
NoneInBuffer:	ret
BuffCXBytes	endp




; FileCXBytes-	Directly reads "CX" bytes from the file and stores them
;		to location DS:SI in memory.
;
;	On entry:
;
;		CX = # of bytes to read.
;		AX = # of bytes read so far.
;		DS:SI- points at file buffer.
;		ES:DI- points at file variable.
;
;	On Exit:
;
;		AX-	Total # of bytes read.
;		
;	Also wipes out DX, SI, CX, and BX.

FileCXBytes	proc	near
		mov	dx, di			;Need buf ptr in DX.
		mov	di, ax			;Save total count here.

; Before even bothering to read the data from the file, see if we're
; already at EOF:

		mov	eax, fs:[si].fvBytesRead
		cmp	eax, fs:[si].fvFileSize
		jb	NotEOF

; Okay, we've got an EOF condition.  See if we've read anything prior
; to this point.  If we have, then just return and leave it up to the
; application to check to see if it read everything it wanted.  If
; the caller attempted to read data starting at EOF, then raise
; an exception or return the EOF error.

		test	di, di			;Total count so far is
		jnz	FCXBDone		; in the DI register.

		GetXEnabled			;If we haven't read any-
		test	eax, eax		; thing yet, then we have
		je	JustRtn			; an EOF error.
		mov	ax, $EndOfFile
		Raise

NotEOF:		xor	eax, eax		;H.O. word of EAX=0.
		mov	bx, fs:[si].fvHandle
		mov	ah, 3fh
		int	21h
		jc	BadFRB

; The read was successful.  If we get to this point, we've got to
; update the fvBytesRead field with the actual number of bytes read 
; from the file.  (Note: fvBytesRead has already been adjusted for
; any bytes read directly from the internal buffer.)

		add	fs:[si].fvBytesRead, eax ;Add in bytes we just read.
		add	ax, di			 ;Compute true total for rtn.
FCXBDone:	clc
		ret

; Yikes! Some sort of error occurred.  If exceptions are enabled, raise the
; appropriate exception, otherwise return with the carry flag set.

BadFRB:		push	ax
		GetXEnabled
		test	ax, ax
		pop	ax
		je	JustRtn
		cmp	ax, 5
		jne	TryBadHndl
		mov	ax, $AccessDenied
		Raise

TryBadHndl:	cmp	ax, 6
		jne	DoBadIO
		mov	ax, $InvalidHandle
		Raise

DoBadIO:	mov	ax, $FileIO
		Raise

; If exceptions are not enabled, return the error code in the AX register.
; Note that AX=0 denotes EOF.

JustRtn:	stc
		ret
FileCXBytes	endp




; testExcepts-	If exceptions are enabled, this routine raises the exception
;		found in the AX register.  Otherwise it simply returns with
;		the carry flag set.

testExcepts	proc	near
		push	ax
		GetXEnabled
		test	ax, ax
		pop	ax
		jz	TERtn
		Raise
TERtn:		stc
		ret
testExcepts	endp

$segFile	ends
		end
