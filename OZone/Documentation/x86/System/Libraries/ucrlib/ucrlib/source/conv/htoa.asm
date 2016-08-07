		include	stdout.a
		include	conv.a

		echo	HexOutLC, HexOutUC, HtoAx, HtoA, WtoAx, WtoA

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing



; Modification 10/22/91 due to comments by David Holm (dgh on BIX).
; Version 2.0 Modifications 5/13/96 by R. Hyde





HexLCConv	byte	0



; $HexOutLC-	Forces HtoA to output values in the range A..F as lower case

		public	$HexOutLC
$HexOutLC	proc	far
		mov	HexLCConv, 20h
		ret
$HexOutLC	endp


; $HexOutUC-	Forces HtoA to output values in the range A..F in upper case.

		public	$HexOutUC
$HexOutUC	proc	far
		mov	HexLCConv, 0
		ret
$HexOutUC	endp



; hextoa is a local routine that does the actual integer->hex conversion.

hextoa		proc	near
		push	ax
		mov	ah, al
		mov	ah, al		;Save L.O. nibble for now.
		shr	al, 4		;Extract H.O. nibble.
		cmp	al, 0ah		;Sequence provided by David Holm
		sbb	al, 69h		; which converts 0-F to "0"-"F"
		das			; ...
		add	al, HexLCConv	;Lets the user specify Lower Case a-f
		mov	es:[di], al	;Store away character.
		inc	di		;Move on to next position
		mov	al, ah		;Retrieve L.O. nibble.
		and	al, 0fh
		cmp	al, 0ah		; As above
		sbb	al, 69h		;
		das			;
		add	al, HexLCConv	;Lets the user specify Lower Case a-f
		mov	es:[di], al
		inc	di
		pop	ax
		ret
hextoa		endp



; HTOA- Converts value in AL to a string of length two containing two
;	hexadecimal characters.  Stores result into string at address
;	ES:DI.
;
; HTOAx-Just like HTOA except it does not preserve DI.

		public	$Htoax
$htoax		proc	far
		push	ax
		call	hextoa
		mov	byte ptr es:[di], 0
		clc				;Needed by $htoam
		pop	ax
		ret
$htoax		endp



		public	$Htoa
$htoa		proc	far
		push	di
		call	$htoax
		pop	di
		ret
$htoa		endp


; $htoaCS-	The address of a string variable follows in the code
;		stream.  HtoaCS converts the value in al to a string 
;		via a call to htoax and stores this string at the 
;		address specified by the dword following the call.

		public	$htoaCS
$htoaCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to str buf.		
		add	word ptr [bp+2], 4	;Skip ptr to char.

		call	$htoax

		pop	di
		pop	es
		pop	ax
		pop	bp
		ret
$htoaCS		endp


; htoaStk-	Address of byte variable is on TOS.
;		Address of a string buffer is on NOS.

		public	$htoaStk
$htoaStk        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+6]
		mov	al, es:[di]
		les	di, [bp+10]
		call	$htoax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$htoaStk	endp


; htoaTOS-	Byte value is on TOS.
;		Address of a string buffer is on NOS.

		public	$htoaTOS
$htoaTOS        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		mov	al, [bp+6]
		les	di, [bp+8]
		call	$htoax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	6
$htoaTOS	endp






; WTOA- Converts the binary value in AX to a string of four hexadecimal
;	characters.
;
; xWTOA-Like the above, except it does not preserve DI.


		public	$wtoax
$wtoax		proc	far
		push	ax
		xchg	al, ah
		call	hextoa
		xchg	al, ah
		call	hextoa
		mov	byte ptr es:[di], 0
		clc				;Needed by $wtoam
		pop	ax
		ret
$wtoax		endp




		public	$wtoa
$wtoa		proc	far
		push	di
		call	$wtoax
		pop	di
		ret
$wtoa		endp



; $wtoaCS-	The address of a string variable follows in the code
;		stream.  WtoaCS converts the value in ax to a string 
;		via a call to wtoax and stores this string at the 
;		address specified by the dword following the call.

		public	$wtoaCS
$wtoaCS		proc	far
		push	bp
		mov	bp, sp
		push	ax
		push	es
		push	di

		les	di, [bp+2]		;Get return address.
		les	di, es:[di]		;Get ptr to str buf.		
		add	word ptr [bp+2], 4	;Skip ptr to char.

		call	$wtoax

		pop	di
		pop	es
		pop	ax
		pop	bp
		ret
$wtoaCS		endp


; wtoaStk-	Address of word variable is on TOS.
;		Address of a string buffer is on NOS.

		public	$wtoaStk
$wtoaStk        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		les	di, [bp+6]
		mov	ax, es:[di]
		les	di, [bp+10]
		call	$wtoax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$wtoaStk	endp


; wtoaTOS-	Word value is on TOS.
;		Address of a string buffer is on NOS.

		public	$wtoaTOS
$wtoaTOS        proc    far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		
		mov	ax, [bp+6]
		les	di, [bp+8]
		call	$wtoax
		
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	6
$wtoaTOS	endp




ucrlib		ends
		end
