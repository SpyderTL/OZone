		.386
		option	segment:use16, proc:private

		include	file.a
		include	excepts.a

		echo	fgetc, fgetcL, fgetcStk
	

$segFile	segment	para public 'Files'
		assume	cs:$segFile, ds:nothing


dp		textequ	<dword ptr>
wp		textequ	<word ptr>
byp		textequ	<byte ptr>




; fgetc-	Reads a single byte from a file.
;
;	On Entry:
;		FS:SI-	Points at file variable.
;
;	On Exit:
;		AL contains byte read (if no error).
;		AX contains error code (if error, C=1).
;
;
; fgetcStk-	File var is on TOS
; fgetcCS-	File var follows in code stream.

		public	$fGetcStk
$fgetcStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]		;Get ptr to file var.
		call	$fgetc			;Do the fread.

		pop	si
		pop	fs
		pop	bp
		ret	4
$fgetcStk	endp


		public	$fGetcCS
$fgetcCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]		;Ptr to return address
		add	byte ptr [bp+2], 4	;Skip parameters on return.
		lfs	si, fs:[si]		;Fetch ptr to file var from code.
		call	$fgetc

		pop	si
		pop	fs
		pop	bp
		ret
$fgetcCS	endp
		




		public	$fGetc
$fgetc		proc	far
		push	bx

		cmp	fs:[si].FileVar.fvMode, 0	;Read Mode?
		je	fgetcModeOK
		mov	ax, $BadFileMode
		call	TestExcepts
		stc
		pop	bx
		ret

; Check for end of file.

fgetcModeOK:	mov	eax, fs:[si].FileVar.fvBytesRead
		cmp	eax, fs:[si].FileVar.fvFileSize
		jb	MoreData
		mov	eax, $EndOfFile
		call	TestExcepts
		xor	eax, eax		;Return zero for EOF error.
		stc
		pop	bx
		ret


MoreData:	mov	bx, fs:[si].FileVar.fvIndex
		cmp	bx, fs:[si].FileVar.fvByteCount
		jb	DataInBlk
		call	ReadNewBlock
		jc	BadFGetc

DataInBlk:	mov	bx, fs:[si].FileVar.fvIndex
		mov	al, fs:[bx+si].FileVar.fvBuffer
		inc	fs:[si].FileVar.fvIndex
		inc	fs:[si].FileVar.fvBytesRead
		mov	ah, 0
		clc
BadFGetc:	pop	bx
		ret
$fgetc		endp



; ReadNewBlock-	Reads a new block of data from the file into
;		the file's internal buffer.

ReadNewBlock	proc	near
		push	ds
		push	cx
		push	dx

		mov	ah, 3fh
		mov	bx, fs:[si].FileVar.fvHandle
		mov	cx, 512
		lea	dx, [si].FileVar.fvBuffer
		push	fs
		pop	ds
		int	21h
		jc	BadRB
		test	ax, ax
		jz	EOFRB
		mov	fs:[si].FileVar.fvByteCount, ax
		mov	fs:[si].FileVar.fvIndex, 0

		pop	dx
		pop	cx
		pop	ds
		clc
		ret

EOFRB:		mov	ax, $EndOfFile
		call	TestExcepts
		xor	ax, ax
		jmp	getcErr2

BadRB:		cmp	ax, 5
		jne	TryInvH
		mov	ax, $AccessDenied
		call	TestExcepts
		mov	ax, 5
		jmp	getcErr2

TryInvH:	cmp	ax, 6
		jne	DoFileIOErr
		mov	ax, $InvalidHandle
		call	TestExcepts
		mov	ax, 6
		jmp	getcErr2

DoFileIOErr:	push	ax
		mov	ax, $FileIO
		call	TestExcepts
		pop	ax

getcErr2:	pop	dx
		pop	cx
		pop	ds
		stc
		ret
ReadNewBlock	endp







; $fpeekc-	Returns the next character in the file without actually reading
;		that character from the file.
;
;		On Entry:
;
;			FS:SI-	Points at file variable.
;
;		On Exit:
;
;			AL-	Contains next character in file (if C=0).
;			AX-	Contains error code (if C=1).
;
; fpeekcStk-	Pointer to file variable is on the stack.
; fpeekcL-	Pointer to file variable follows in the code stream.

		public	$fPeekc
$fpeekc		proc	far
		mov	eax, fs:[si].FileVar.fvBytesRead
		cmp	eax, fs:[si].FileVar.fvFileSize
		jb	MoreData
		xor	eax, eax		;Return zero for EOF error.
		stc
		ret

MoreData:	push	bx
		mov	bx, fs:[si].FileVar.fvIndex
		cmp	bx, fs:[si].FileVar.fvByteCount
		jb	NoNewData
		call	ReadNewBlock
		jc	BadPeek

NoNewData:	mov	bx, fs:[si].FileVar.fvIndex
		mov	al, fs:[bx+si].FileVar.fvBuffer
		mov	ah, 0
		clc
BadPeek:	pop	bx
		ret

$fpeekc		endp


		public	$fPeekcStk
$fPeekcStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]		;Get ptr to file var.
		call	$fpeekc			;Do the fread.

		pop	si
		pop	fs
		pop	bp
		ret	4
$fPeekcStk	endp


		public	$fPeekcCS
$fpeekcCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]		;Ptr to return address
		add	byte ptr [bp+2], 4	;Skip parameters on return.
		lfs	si, fs:[si]		;Fetch ptr to file var from code.
		call	$fpeekc

		pop	si
		pop	fs
		pop	bp
		ret
$fpeekcCS	endp
		





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
