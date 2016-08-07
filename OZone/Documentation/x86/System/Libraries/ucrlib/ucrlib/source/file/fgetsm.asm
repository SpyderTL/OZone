		include	consts.a
		include	file.a
		include memory.a
		include	strings.a

		echo	fgetsm
	
$segFile	segment	para public 'Files'
		assume	cs:$segFile, ds:nothing



; FGETSM-	Reads a line of text from the file whose file buffer
;		variable FS:SI points at.  Allocates enough storage 
;		to hold the current input line on the heap and then 
;		copies that line to the heap.
;
;		On Entry:
;
;			FS:SI-	Points at file variable.
;
;		On Exit:
;
;			ES:DI-	Points at new string allocated on heap.
;				(C=1 if malloc error occurs and exceptions
;				 are not enabled).
;
; FGETSMCS-	Pointer to file variable is passed in the code stream.
; FGETSMStk-	Pointer to file variable is passed on the stack.

InputLine	byte	128 dup (?)

		public	$fGetsm
$fgetsm		proc	far
		lesi	InputLine
		call	$fgets
		call	$strdup
		ret
$fgetsm		endp


		public	$fGetsmStk
$FGetsmStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+6]	;Get ptr to file variable.
		call	$fgetsm

		pop	si
		pop	fs
		pop	bp
		ret	4
$FGetsmStk	endp


		public	$fGetsmCS
$FGetsmCS	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		lfs	si, [bp+2]	;Get rtn adrs (ptr to fvar)
		lfs	si, fs:[si]	;Get ptr to fv.
		call	$fgetsm

		add	wp [bp+2], 8	;Skip over parameters.
		pop	si
		pop	fs
		pop	bp
		ret
$FGetsmCS	endp

$segFILE	ends
		end
