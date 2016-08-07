		include	conv.a

		echo	LToA
	
ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing


; ULTOAX-	Converts the unsigned integer in EAX to a zero terminated string
;		of digits and stores this string starting at location ES:DI.
; 		ULTOAX does not preserve DI, rather, it leaves DI pointing at the 
;		zero terminating byte.

		public	$ultoax
$ultoax		proc	far
		push	eax
		push	ebx
		push	edx
		push	cx
		pushf
		cld

		mov	ebx, 10
		xor	cx, cx
Div32Lp:	xor	edx, edx
		div	ebx
		add	dl, '0'
		push	dx
		inc	cx
		test	eax, eax
		jnz	Div32Lp

StoreEm:	pop	ax
		stosb
		loop	StoreEm
		mov	byte ptr es:[di], 0

		popf
		pop	cx
		pop	edx
		pop	ebx
		pop	eax
		clc
		ret
$ultoax		endp


; ULTOA converts the unsigned dword value in EAX to a zero-terminated string.
;	It stores this string to memory starting at location ES:DI.

		public	$ultoa
$ultoa		proc	far
		push	di
		call	$ultoax
		pop	di
		ret
$ultoa		endp



; $ULtoaCS-	The address of a string variable follows in the code
;		stream.  LtoaCS converts the 32-bit unsigned integer in eax to
;		a string via a call to Ltoax and stores this string at the 
;		address specified by the dword following the call.

		public	$ULtoaCS
$ULtoaCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to str buf.		
		add	word ptr [bp+2], 4	;Skip ptr to integer.
		call	$ULtoax

		pop	di
		pop	es
		pop	bp
		ret
$ULtoaCS		endp


; ULtoaStk-	Address of 32-bit integer variable is on TOS.
;		Address of a string buffer is on NOS.

		public	$ULtoaStk
$ULtoaStk	proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		les	di, [bp+6]
		mov	eax, es:[di]
		les	di, [bp+10]
		call	$ULtoax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret	8
$ULtoaStk	endp


; ULtoaTOS-	32-bit integer value is on TOS.
;		Address of a string buffer is on NOS.

		public	$ULtoaTOS
$ULtoaTOS	proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		mov	eax, [bp+6]
		les	di, [bp+10]
		call	$ULtoax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret	6
$ULtoaTOS	endp



ucrlib		ends
		end
