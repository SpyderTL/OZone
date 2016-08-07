		.386
		option	segment:use16, proc:private

		include	conv.a
		include	memory.a

		echo	Itoam, Utoam, Ltoam, ULtoam
	
ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing

;		These routines convert the value in AX to a string
;		of digits.  They automatically allocate storage on the
;		heap for their results and return a pointer to the new
;		string in ES:DI.
;
;		These routines return the carry set if there was a memory
;		allocation error (insufficient room on heap).
;
;
; ITOAM-	Processes 16-bit signed value in AX.
; UTOAM-	Processes 16-bit unsigned value in AX.
; LTOAM-	Processes 32-bit signed value in EAX.
; ULTOAM-	Processes 32-bit unsigned value in EAX.
;
; ItoaTOSm-	Integer value to convert is on TOS (16-bits).
; UtoaTOSm-	  "	 "	  "	  "	  "	  "
; LtoaTOSm-	Integer value to convert is on TOS (32-bits).
; ULtoaTOSm-	  "	 "	  "	  "	  "	  "
;
; ItoaStkm-	DWord pointer to integer is on TOS.
; UtoaStkm-	  "	 "	  "	  "
; LtoaStkm-	  "	 "	  "	  "
; ULtoaStkm-	  "	 "	  "	  "
;
; ItoaCSm-	DWord pointer to integer follows call in code stream.
; UtoaCSm-	  "	 "	  "	  "	  "	  "
; LtoaCSm-	  "	 "	  "	  "	  "	  "
; ULtoaCSm-	  "	 "	  "	  "	  "	  "
;



		public	$itoam
$itoam		proc	far
		push	cx
		mov	cx, 7		;Max 7 bytes.
		call	$malloc
		pop	cx
		jc	BadMalloc
		call	$itoa
BadMalloc:	ret
$itoam		endp



		public	$utoam
$utoam		proc	far
		push	cx
		mov	cx, 7		;Max 7 bytes.
		call	$malloc
		pop	cx
		jc	BadMalloc
		call	$utoa
BadMalloc:	ret
$utoam		endp




		public	$Ltoam
$Ltoam		proc	far
		push	cx
		mov	cx, 12		;Max 12 bytes.
		call	$malloc
		pop	cx
		jc	BadMalloc
		call	$ltoa
BadMalloc:	ret
$Ltoam		endp




		public	$ultoam
$ultoam		proc	far
		push	cx
		mov	cx, 12		;Max 12 bytes.
		call	$malloc
		pop	cx
		jc	BadMalloc
		call	$ultoa
BadMalloc:	ret
$ultoam		endp





; TOS variants- Value to convert is on TOS.


		public	$itoaTOSm
$itoaTOSm       proc    far
		push	bp
		mov	bp, sp
		push	ax
		
		mov	ax, [bp+6]
		call	$itoam
		
		pop	ax
		pop	bp
		ret	2
$itoaTOSm	endp




		public	$utoaTOSm
$utoaTOSm       proc    far
		push	bp
		mov	bp, sp
		push	ax
		
		mov	ax, [bp+6]
		call	$utoam
		
		pop	ax
		pop	bp
		ret	2
$utoaTOSm	endp




		public	$LtoaTOSm
$LtoaTOSm       proc    far
		push	bp
		mov	bp, sp
		push	eax
		
		mov	eax, [bp+6]
		call	$Ltoam
		
		pop	eax
		pop	bp
		ret	4
$LtoaTOSm	endp




		public	$ULtoaTOSm
$ULtoaTOSm	proc    far
		push	bp
		mov	bp, sp
		push	eax
		
		mov	eax, [bp+6]
		call	$ULtoam
		
		pop	eax
		pop	bp
		ret	4
$ULtoaTOSm	endp






; Stk variants- Pointer to value to convert is on the TOS.

		public	$utoaStkm
$utoaStkm       proc    far
		push	bp
		mov	bp, sp
		push	ax
		
		les	di, [bp+6]
		mov	ax, es:[di]
		call	$utoam
		
		pop	ax
		pop	bp
		ret	4
$utoaStkm	endp



		public	$itoaStkm
$itoaStkm       proc    far
		push	bp
		mov	bp, sp
		push	ax
		
		les	di, [bp+6]
		mov	ax, es:[di]
		call	$itoam
		
		pop	ax
		pop	bp
		ret	4
$itoaStkm	endp





		public	$LtoaStkm
$LtoaStkm       proc    far
		push	bp
		mov	bp, sp
		push	eax
		
		les	di, [bp+6]
		mov	eax, es:[di]
		call	$Ltoam
		
		pop	eax
		pop	bp
		ret	4
$LtoaStkm	endp




		public	$ULtoaStkm
$ULtoaStkm      proc    far
		push	bp
		mov	bp, sp
		push	eax
		
		les	di, [bp+6]
		mov	eax, es:[di]
		call	$ULtoam
		
		pop	eax
		pop	bp
		ret	4
$ULtoaStkm	endp





; CS variants-	Pointer to value to convert follows the call
;		in the code stream.

		public	$ULtoaCSm
$ULtoaCSm	proc    far
		push	bp
		mov	bp, sp
		push	eax
		
		les	di, [bp+2]	;Get return address.
		les	di, es:[di]	;Get pointer to value.
		mov	eax, es:[di]
		add	wp [bp+2], 4	;Skip return address.
		call	$ULtoam
		
		pop	eax
		pop	bp
		ret
$ULtoaCSm	endp



		public	$LtoaCSm
$LtoaCSm	proc    far
		push	bp
		mov	bp, sp
		push	eax
		
		les	di, [bp+2]	;Get return address.
		les	di, es:[di]	;Get pointer to value.
		mov	eax, es:[di]
		add	wp [bp+2], 4	;Skip return address.
		call	$Ltoam
		
		pop	eax
		pop	bp
		ret
$LtoaCSm	endp



		public	$UtoaCSm
$UtoaCSm	proc    far
		push	bp
		mov	bp, sp
		push	eax
		
		les	di, [bp+2]	;Get return address.
		les	di, es:[di]	;Get pointer to value.
		mov	eax, es:[di]
		add	wp [bp+2], 4	;Skip return address.
		call	$Utoam
		
		pop	eax
		pop	bp
		ret
$UtoaCSm	endp



		public	$ItoaCSm
$ItoaCSm	proc    far
		push	bp
		mov	bp, sp
		push	eax
		
		les	di, [bp+2]	;Get return address.
		les	di, es:[di]	;Get pointer to value.
		mov	eax, es:[di]
		add	wp [bp+2], 4	;Skip return address.
		call	$Itoam
		
		pop	eax
		pop	bp
		ret
$ItoaCSm	endp



ucrlib		ends
		end