		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrIns, StrInsCsi, StrInsStk
	

$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; StrIns -	Inserts one string within another.
;
; inputs:
;		ES:DI - Points at destination string, the one into
;			which the source string will be appended.
;		FS:SI - Points at the string to insert.
;		CX    - Index into source string (ES:DI) to begin insertion.
;
; Note: 	The destination string's (ES:DI) buffer must be
;		sufficiently large to hold the result of the concatentation
;		of the two strings.
;
; StrInsCsi - 	String to insert is passed in the code stream.
;
; StrInsStk -	Both dest string and the string to insert are passed on the stack.


srcseg		equ	[bp-2]
destseg		equ     [bp-4]
insindx		equ	[bp-6]
source		equ	[bp-8]
dest		equ	[bp-10]

$StrIns		proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	es
		push	cx
		push	si
		push	di
		pushf
		push	ax
		push	bx
		push	ds
		push	dx

		cld

; Compute the length of the string to insert.

		xchg	si, di
		mov	es, srcseg
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
		neg	cx
		dec	cx
		dec	cx
		mov	bx, cx			;Save for later.

; Find the length of the dest string.

		xchg	si, di
		mov	es, destseg
		mov	cx, 0ffffh
	repne	scasb

; Compute the address of the insertion point:

		mov	dx, dest
		add	dx, insindx
		cmp	dx, di			;See if beyond end of string.
		jb	InsOkay
		lea	dx, [di-1]
InsOkay:

; Make room for the insertion.

		mov	ds, destseg
		mov	si, di
		add	si, bx
		xchg	si, di
		mov	cx, bx
		std
	rep	movsb

; Now perform the insertion.

		cld
		mov	si, source
		mov	di, dx
		mov	cx, bx
		mov	ds, srcseg
	rep	movsb


		pop	dx
		pop	ds
		pop	bx
		pop	ax
		popf
		pop	di
		pop	si
		pop	cx
		pop	es
		pop	fs
		pop	bp
		ret
$StrIns		endp


Csirtnadrs	textequ	<[bp+2]>
Csisrcseg	textequ	<[bp-2]>
Csidestseg	textequ	<[bp-4]>
Csiinsindx	textequ	<[bp-6]>
Csisource	textequ	<[bp-8]>
Csidest		textequ	<[bp-10]>

$StrInsCsi	proc	far
		push	bp
		mov	bp, sp
		push	dx		;Dummy spot
		push	es
		push	cx
		push	si		;Dummy spot
		push	di
		pushf
		push	ax
                push	bx
		push	ds
		push	dx
		push	si

		mov	si, Csirtnadrs
		mov	Csisource, si
		mov	dx, Csirtnadrs+2
		mov	Csisrcseg, dx
		cld

; Compute the length of the string to insert.

		xchg	si, di
		mov	es, dx			;(srcseg)
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
		mov	Csirtnadrs, di
		neg	cx
		dec	cx
		dec	cx
		mov	bx, cx			;Save for later.

; Find the length of the dest string.
                 
		xchg	si, di
		mov	es, Csidestseg
		mov	cx, 0ffffh
	repne	scasb

; Compute the address of the insertion point:

		mov	dx, dest
		add	dx, Csiinsindx
		cmp	dx, di			;See if beyond end of string.
		jb	InsCsiOkay
		lea	dx, [di-1]
InsCsiOkay:

; Make room for the insertion.

		mov	ds, Csidestseg
		mov	si, di
		add	si, bx
		xchg	si, di
		mov	cx, bx
		std
	rep	movsb

; Now perform the insertion.

		cld
		mov	si, Csisource
		mov	di, dx
		mov	cx, bx
		mov	ds, Csisrcseg
	rep	movsb

		pop	si
		pop	dx
		pop	ds
		pop	bx
		pop	ax
		popf
		pop	di
		pop	cx		;Dummy
		pop	cx
		pop	es
		pop	bp		;Dummy
		pop	bp
		ret
$StrInsCsi	endp


$StrInsStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	di
		push	si

		les	di, [bp+10]	; Dest. String.
		lfs	si, [bp+6]	; String to Insert.
		call	$StrIns

		pop	si
		pop	di
		pop	fs
		pop	es
		pop	bp
		ret	8	
$StrInsStk	endp

$SegStrings	ends
		end
