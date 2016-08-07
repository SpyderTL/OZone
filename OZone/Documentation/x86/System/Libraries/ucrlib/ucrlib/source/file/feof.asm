		.386
		option	segment:use16, proc:private

		include	file.a

		echo	feof, feofl, feofStk
	

$segFile	segment	para public 'Files'
		assume	cs:$segFile, ds:nothing


dp		textequ	<dword ptr>
wp		textequ	<word ptr>
byp		textequ	<byte ptr>




; fEOF-	Checks to see if a file is at the end of file.
;	This call only makes sense if you are reading data from
;	the file.
;
;	On Entry:
;		FS:SI-	Points at file variable.
;
;	On Exit:
;		EAX contains one if at EOF, zero if not at EOF.
;
; FEOFstk-	File variable is on TOS.
; FEOFCS-	Address of file variable follows in the code stream.


		public	$FEOFCS
$fEOFCS		proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		lfs	si, [bp+2]
		lfs	si, fs:[si]
		add	dp [bp+2], 4
		call	$fEOF
		pop	si
		pop	fs
		pop	bp
		ret
$fEOFCS		endp


		public	$FEOFStk
$feofStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		lfs	si, [bp+6]
		call	$fEOF
		pop	si
		pop	fs
		pop	bp
		ret	4
$feofStk	endp



		public	$fEOF
$fEOF		proc	far
		mov	eax, fs:[si].FileVar.fvBytesRead
		cmp	eax, fs:[si].FileVar.fvFileSize
		jae	AtEOF
		xor	eax, eax
		ret

AtEof:		mov	eax, 1
		ret
$fEOF		endp



$segFile	ends
		end
