		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	
	
$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; strupr- Converts to upper case all lower case characters in the string
;	  pointed at by es:di.
;
; StrUprStk-	Just like StrUpr except the address is on the stack rather
;		than in the ES:DI registers.
;
; inputs:
;		es:di-  Address of string to convert (strupr).
;		TOS-	Address of string to convert (StrUprStk).
;		cs:ip-	Address of string to convert (StrUprCS).
;
; outputs:
;		es:di-  Points at converted string (StrUpr only).
;
;		Note: StrUprStk converts the string whose address is on TOS
;		without affecting ES:DI.  Likewise, StrUprCS does not affect
;		ES:DI.

		public	$strupr
$strupr		proc	far
		push	es
		push	ds
		push	ax
		push	bx
		push	si
		push	di

		mov	si, es
		mov	ds, si
		mov	si, di
		lea	bx, $uprtbl
ToUprLp:	mov	al, ds:[si]
		inc	si
		xlat 	cs:$uprtbl
		mov	es:[di], al
		inc	di
		cmp	al, 0
		jne	ToUprLp

		pop	di
		pop	si
		pop	bx
		pop	ax
		pop	ds
		pop	es
		ret
$StrUpr		endp



		public	$StrUprStk
$StrUprStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+6]	;Get string address
		call	$StrUpr		;Convert to upper case.
		pop	di
		pop	es
		pop	bp
		ret	4
$StrUprStk	endp


		public	$StrUprCS
$StrUprCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+2]
		les	di, es:[di]
		add	wp [bp+2], 4

		call	$StrUpr

		pop	di
		pop	es
		pop	bp
		ret
$StrUprCS	endp




		public	$uprtbl
;
; Output all chars up to the upper case letters here.
;
$uprtbl		equ	this byte
i		=	0
		rept	'a'
		db	i
i		=	i + 1
		endm
;
; Output uc for lc here
;
i		=	'A'
		rept	26
		db	i
i		=	i+1
		endm
;
; Output all other characters here.
;
i		=	'z'+1
		rept	255-'z'
		db	i
i		=	i+1
		endm
$SegStrings	ends
		end
