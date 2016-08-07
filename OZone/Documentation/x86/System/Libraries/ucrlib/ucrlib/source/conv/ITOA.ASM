		include	conv.a

		echo	ItoA, ItoAx, ItoaStk
	
ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing

; ITOA-	Converts the signed integer value in AX to a string of characters.
;	ES:DI must point at an array big enough to hold the result (7 chars
;	max.).
;
; ITOAx-Does not preserve DI.  Returns with DI pointing at the zero
;	terminating byte.


		public	$itoax
$itoax		proc	far
		push	eax
		movsx	eax, ax
		call	$Ltoax
		pop	eax
		ret
$itoax		endp


		public	$itoa
$itoa		proc	far
		push	di
		call	$itoax
		pop	di
		ret
$itoa		endp




; $itoaCS-	The address of a string variable follows in the code
;		stream.  ItoaCS converts the integer in ax to a string 
;		via a call to itoax and stores this string at the 
;		address specified by the dword following the call.

		public	$itoaCS
$itoaCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to str buf.		
		add	word ptr [bp+2], 4	;Skip ptr to integer.

		call	$itoax

		pop	di
		pop	es
		pop	ax
		pop	bp
		ret
$itoaCS		endp


; itoaStk-	Address of integer variable is on TOS.
;		Address of a string buffer is on NOS.

		public	$itoaStk
$itoaStk        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+6]
		mov	ax, es:[di]
		les	di, [bp+10]
		call	$itoax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$itoaStk	endp


; itoaTOS-	Integer value is on TOS.
;		Address of a string buffer is on NOS.

		public	$itoaTOS
$itoaTOS        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		mov	ax, [bp+6]
		les	di, [bp+8]
		call	$itoax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	6
$itoaTOS	endp




ucrlib		ends
		end
