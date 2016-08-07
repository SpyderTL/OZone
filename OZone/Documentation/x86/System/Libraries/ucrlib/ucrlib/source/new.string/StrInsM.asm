		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrInsM, STrInsMCsi, StrInsMStk
	

$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; StrInsM -	Inserts one string within another.
;
; inputs:
;		ES:DI - Points at destination string, the one into which
;		        the source string will be appended.
;		FS:SI - Points at the string to insert.
;		CX    -	Index into source string (ES:DI) to begin insertion.
; outputs:
;		ES:DI-	Points at new string on the heap.
;		Carry-	Zero if no error, One if memory allocation error.


srcseg		textequ	<[bp-2]>
source		textequ	<[bp-4]>
destseg		textequ	<[bp-6]>
dest		textequ	<[bp-8]>
insindx		textequ	<[bp-10]>

$StrInsM	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si
		push	es
		push	di
		push	cx
		pushf
		push	ax
                push	bx
		push	ds
		push	dx

		cld

; Compute the length of the destination string.

		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb

; Compute the length of the string to insert.

		mov	di, si
		mov	es, srcseg
		mov	al, 0
	repne	scasb
		neg	cx
		dec	cx
;;;;;;;;;;;;;;	dec	cx			;Plus one for the zero byte.
;
; Allocate memory for the new string:
;
		call	sl_malloc
		jnc	GoodMalloc

		pop	dx
		pop	ds
		pop	bx
		pop	ax
		popf
		pop	cx
		pop	di
		pop	es
		pop	si
		pop	fs
		pop	bp
		stc				;Out of memory
		ret


; If we were able to malloc the string, drop down here:

GoodMalloc:	mov	dx, es			;Save ptr to new string
		mov	bx, di
		lds	si, dword ptr Dest

; Copy the first part of the destination string to the new string.

		mov	cx, insindx
CpyDest1:	lodsb
		stosb
		cmp	al, 0
		loopne	CpyDest1
		jnz	SkipDec
		dec	di			;Back up a character if we
		dec	si			; hit a zero byte.

SkipDec:	push si				;Save ptr to middle of dest.

; Copy the source string into the middle.

		lds	si,source
CpySrc:		lodsb
		stosb
		cmp	al, 0
		jnz	CpySrc
		dec	di

; Copy the remainder of the destination string to the new string.

		pop	si			;Retrieve ptr into dest.
		mov	ds, DestSeg
CpyDest:	lodsb
		stosb
		cmp	al, 0
		jnz	CpyDest
		mov	es, dx			;Retrieve ptr to new string.
		mov	di, bx

		pop	dx
		pop	ds
		pop	bx
		pop	ax
		popf
		pop	cx
		pop	si			;Don't restore es:di
		pop	si
		pop	si
		pop	fs
		pop	bp
		clc				;Allocated string okay.
		ret
$StrInsM	endp


Csirtnadrs	textequ	<[bp+2]>
Csisrcseg	textequ	<[bp-2]>
Csisource	textequ	<[bp-4]>
Csidestseg	textequ	<[bp-6]>
Csidest		textequ	<[bp-8]>
Csiinsindx	textequ	<[bp-10]>

$StrInsMCsi	proc	far
		push	bp
		mov	bp, sp
		push	dx		;Dummy spot
		push	si		;Dummy spot
		push	es
		push	di
		push	cx
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

; Compute the length of the destination string.

		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb

; Compute the length of the string to insert.

		mov	di, si
		mov	es, dx			;(srcseg)
		mov	al, 0
	repne	scasb
		mov	Csirtnadrs, di		;Restore return address.
		neg	cx
		dec	cx
;;;;;;;;;;;;;;	dec	cx			;Plus one for the zero byte.
;
; Allocate memory for the new string:
;
		call	sl_malloc
		jnc	GoodMallocCsi

		pop	si
		pop	dx
		pop	ds
		pop	bx
		pop	ax
		popf
		pop	cx
		pop	di
		pop	es
		add	sp, 4			;Remove junk bytes
		pop	bp
		stc				;Out of memory
		ret


; If we were able to malloc the string, drop down here:

GoodMallocCsi:	mov	dx, es			;Save ptr to new string
		mov	bx, di
		lds	si, dword ptr CsiDest

; Copy the first part of the destination string to the new string.
;
		mov	cx, Csiinsindx
CpyDest1Csi:	lodsb
		stosb
		cmp	al, 0
		loopne	CpyDest1Csi
		jnz	SkipDecCsi
		dec	di			;Back up a character if we
		dec	si			; hit a zero byte.

SkipDecCsi:	push si				;Save ptr to middle of dest.

; Copy the source string into the middle.

		lds	si, Csisource
CpySrcCsi:		lodsb
		stosb
		cmp	al, 0
		jnz	CpySrcCsi
		dec	di

; Copy the remainder of the destination string to the new string.

		pop	si			;Retrieve ptr into dest.
		mov	ds, CsiDestSeg
CpyDestCsi:	lodsb
		stosb
		cmp	al, 0
		jnz	CpyDestCsi
		mov	es, dx			;Retrieve ptr to new string.
		mov	di, bx

		pop	si
		pop	dx
		pop	ds
		pop	bx
		pop	ax
		popf
		pop	cx
		add	sp,8			;Don't restore es:di or junk.
		pop	bp
		clc				;Allocated string okay.
		ret
$StrInsMCsi	endp


$StrInsMStk	proc	far
		push	bp
		mov	bp, sp
		push	fs
		push	si

		les	di, [bp+10]	; Dest. String.
		lfs	si, [bp+6]	; String to Insert.
		call	$StrInsM

		pop	si
		pop	fs
		pop	bp
		ret	8
$StrInsMStk	endp


$SegStrings	ends
		end