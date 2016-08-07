		include	stdout.a
		include	conv.a

		echo	ULSize, LSize, ISize, USize
		echo	ULSizeStk, LSizeStk, ISizeStk, USizeStk
	
ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing


; $ULSize-	Returns the number of print positions the 32-bit
;		unsigned integer in EAX will take to print.
;		This function returns the size in EAX.

		public	$ULSize
$ULsize		proc	far
		push	ecx

		mov	ecx, 10			;Worst case is
		cmp	eax, 1000000000		; 10 digits.
		jae	ulDone

		dec	cx
		cmp	eax, 100000000
		jae	ulDone

		dec	cx
		cmp	eax, 10000000
		jae	ulDone

		dec	cx
		cmp	eax, 1000000
		jae	ulDone

		dec	cx
		cmp	eax, 100000
		jae	ulDone

		dec	cx
		cmp	ax, 10000
		jae	ulDone

		dec	cx
		cmp	ax, 1000
		jae	ulDone

		dec	cx
		cmp	ax, 100
		jae	ulDone

		dec	cx
		cmp	ax, 10
		jae	ulDone

		dec	cx

ulDone:		mov	eax, ecx
		pop	ecx
		ret
$ULSize		endp




; $LSize-	Returns the number of print positions required by
;		the 32-bit signed integer in EAX.

		public	$LSize
$LSize		proc	far
		test	eax, eax
		jns	near ptr $ULSize

		neg	eax
		call	$ULSize
		inc	ax		;One more position for sign.
		ret
$LSize		endp



; $ISize-	Returns the number of print positions required by
;		the 16-bit signed operand in AX.  This routine
;		cheats by sign extending AX into EAX and then calling
;		LSize.

		public	$isize
$ISize		proc	far
		movsx	eax, ax
		call	$LSize
		ret
$ISize		endp




; $USize-	Returns the number of print positions required by
;		the unsigned integer in AX.  Returns the count in
;		EAX since it calls $ULSize to get the job done.

		public	$usize
$USize		proc	far
		movzx	eax, ax
		call	$ULSize
		ret
$USize		endp



; $ISizeTOS-	Returns (in EAX) the size of the 16-bit signed
;		integer whose value is on the top of the stack.
;		Returns the value on the TOS.
;
; $ISizeStk-	Ditto, except the address of the integer is on the stack
;		and it returns the value in AX.
;
; $ISizeCS-	Pointer to integer follows in the code stream. Returns
;		size in AX.

		public	$isizeTOS
$ISizeTOS	proc	far
		push	bp
		mov	bp, sp
		push	ax
		mov	ax, [bp+6]
		call	$ISize
		mov	[bp+6], ax
		pop	ax
		pop	bp
		ret	
$ISizeTOS	endp


		public	$ISizeStk
$ISizeStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	bx

		lds	bx, [bp+6]
		mov	ax, [bx]
		call	$ISize

		pop	bx
		pop	ds
		pop	bp
		ret	4
$ISizeStk	endp


		public	$ISizeCS
$ISizeCS	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	bx

		lds	bx, [bp+6]
		lds	bx, [bx]
		add	wp [bp+6], 4	;Skip ptr to integer.
		mov	ax, [bx]
		call	$ISize

		pop	bx
		pop	ds
		pop	bp
		ret	
$ISizeCS	endp





; $USizeTOS-	Returns (in EAX) the size of the 16-bit unsigned
;		integer whose value is on the top of the stack.
;
; $USizeStk-	Ditto, except the address of the unsigned integer is on the
;		stack and it returns the value in AX.
;
; $USizeCS-	Pointer to unsigned integer follows in the code stream. Returns
;		size in AX.

		public	$usizeTOS
$USizeTOS	proc	far
		push	bp
		mov	bp, sp
		mov	ax, [bp+6]
		call	$USize
		pop	bp
		ret	2
$USizeTOS	endp


		public	$USizeStk
$USizeStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	bx

		lds	bx, [bp+6]
		mov	ax, [bx]
		call	$USize

		pop	bx
		pop	ds
		pop	bp
		ret	4
$USizeStk	endp




		public	$USizeCS
$USizeCS	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	bx

		lds	bx, [bp+6]
		lds	bx, [bx]
		add	wp [bp+6], 4	;Skip ptr to integer.
		mov	ax, [bx]
		call	$USize

		pop	bx
		pop	ds
		pop	bp
		ret	
$USizeCS	endp





; $ULSizeTOS-	Returns (on TOS) the size of the 32-bit unsigned
;		integer whose value is on the top of the stack.
;
; $ULSizeStk-	As above, except pointer to value is on TOS and
;		it returns result in AX.
;
; $ULSizeCS-	Pointer to unsigned integer follows in the code stream. Returns
;		size in AX.


		public	$ulSizeTOS
$ULSizeTOS	proc	far
		push	bp
		mov	bp, sp
		push	eax
		mov	eax, [bp+6]
		call	$ULSize
		mov	[bp+6], ax
		pop	eax
		pop	bp
		ret	2
$ULSizeTOS	endp




		public	$ULSizeStk
$ULSizeStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	bx

		lds	bx, [bp+6]
		mov	eax, [bx]
		call	$ULSize

		pop	bx
		pop	ds
		pop	bp
		ret	4
$ULSizeStk	endp




		public	$ULSizeCS
$ULSizeCS	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	bx

		lds	bx, [bp+6]
		lds	bx, [bx]
		add	wp [bp+6], 4	;Skip ptr to integer.
		mov	eax, [bx]
		call	$ULSize

		pop	bx
		pop	ds
		pop	bp
		ret	
$ULSizeCS	endp





; $LSizeTOS-	Returns (in EAX) the size of the 32-bit signed
;		integer whose value is on the top of the stack.
;
; $LSizeStk-	As above, except pointer to value is on TOS and
;		it returns result in AX.
;
; $LSizeCS-	Pointer to integer follows in the code stream. Returns
;		size in AX.


		public	$LSizeTOS
$LSizeTOS	proc	far
		push	bp
		mov	bp, sp
		push	eax

		mov	eax, [bp+6]
		call	$LSize
		mov	[bp+6], ax

		pop	eax
		pop	bp
		ret	2
$LSizeTOS	endp

		public	$LSizeStk
$LSizeStk	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	bx

		lds	bx, [bp+6]
		mov	eax, [bx]
		call	$LSize

		pop	bx
		pop	ds
		pop	bp
		ret	4
$LSizeStk	endp




		public	$LSizeCS
$LSizeCS	proc	far
		push	bp
		mov	bp, sp
		push	ds
		push	bx

		lds	bx, [bp+6]
		lds	bx, [bx]
		add	wp [bp+6], 4	;Skip ptr to integer.
		mov	eax, [bx]
		call	$LSize

		pop	bx
		pop	ds
		pop	bp
		ret	
$LSizeCS	endp





ucrlib		ends
		end
