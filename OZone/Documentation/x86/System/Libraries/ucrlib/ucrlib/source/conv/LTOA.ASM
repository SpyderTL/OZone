		include	conv.a

		echo	LToA, ltoax, ltoaStk
	
ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing


; LTOAx-	Like the LTOA routine, except it does not preserve DI.  
;		Leaves DI pointing at the terminating zero byte.

		public	$ltoax
$ltoax		proc	far
		push	eax

		test	eax, eax
		jns	Doit
		mov	byte ptr es:[di], '-'
		inc	di
		neg	eax

DoIt:		call	$ultoax
		pop	eax
		ret
$ltoax		endp


; LTOA-	converts the value in EAX to a string.  ES:DI points at the target
;	location.

		public	$ltoa
$ltoa		proc	far
		push	di
		call	$ltoax
		pop	di
		ret
$ltoa		endp


; $LtoaCS-	The address of a string variable follows in the code
;		stream.  LtoaCS converts the integer in eax to a string 
;		via a call to Ltoax and stores this string at the 
;		address specified by the dword following the call.

		public	$LtoaCS
$LtoaCS		proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to str buf.		
		add	word ptr [bp+2], 4	;Skip ptr to integer.

		call	$Ltoax

		pop	di
		pop	es
		pop	eax
		pop	bp
		ret
$LtoaCS		endp



; LTOAStk-	Converts the signed 32-bit value on NOS to a string and stores this
;		string at the address specified by the 32-bit pointer on TOS.

		public	$LtoaStk
$LtoaStk	proc	far
		push	bp
		mov	bp, sp
		push	eax
		push	es
		push	di

		mov	eax, [bp+10]
		les	di, [bp+6]
		call	$ltoax

		pop	di
		pop	es
		pop	eax
		pop	bp
		ret	8
$LtoaStk	endp



; LtoaTOS-	32-bit Integer value is on TOS.
;		Address of a string buffer is on NOS.

		public	$LtoaTOS
$LtoaTOS        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	eax
		
		mov	eax, [bp+6]
		les	di, [bp+10]
		call	$Ltoax
		
		pop	eax
		pop	di
		pop	es
		pop	bp
		ret	8
$LtoaTOS	endp




ucrlib		ends
		end
