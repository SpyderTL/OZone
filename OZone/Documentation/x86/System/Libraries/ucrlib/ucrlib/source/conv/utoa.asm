		include	conv.a

		echo	UtoA, UtoAx
	
ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing




; UTOAx-Like UTOA, except this routine does not preserve the DI
;	register.  It returns DI pointing at the zero byte.

		public	$utoax
$utoax		proc	far
		push	eax
		movzx	eax, ax
		call	$ultoax
		pop	eax
		ret
$utoax		endp



; UTOA- Converts unsigned value in AX to a string of digits and stores
;	this string starting at the location pointed at by ES:DI.  Since
;	the maximum 16-bit unsigned value is 65535, this routine may store
;	up to six bytes at ES:DI (5 digits plus a zero byte).

		public	$utoa
$utoa		proc	far
		push	di
		call	$utoax
		pop	di
		ret
$utoa		endp


; $utoaCS-	The address of a string variable follows in the code
;		stream.  UtoaCS converts the integer in ax to a string 
;		via a call to utoax and stores this string at the 
;		address specified by the dword following the call.

		public	$utoaCS
$utoaCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to str buf.		
		add	word ptr [bp+2], 4	;Skip ptr to integer.

		call	$utoax

		pop	di
		pop	es
		pop	ax
		pop	bp
		ret
$utoaCS		endp


; utoaStk-	Address of integer variable is on TOS.
;		Address of a string buffer is on NOS.

		public	$utoaStk
$utoaStk        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+6]
		mov	ax, es:[di]
		les	di, [bp+10]
		call	$utoax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$utoaStk	endp


; utoaTOS-	Integer value is on TOS.
;		Address of a string buffer is on NOS.

		public	$utoaTOS
$utoaTOS        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		mov	ax, [bp+6]
		les	di, [bp+8]
		call	$utoax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	6
$utoaTOS	endp




ucrlib		ends
		end
