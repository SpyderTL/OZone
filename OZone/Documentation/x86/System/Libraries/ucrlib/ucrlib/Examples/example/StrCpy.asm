;		.386
;		option	segment:use16, proc:private

;		include	strings.a

                echo    StrCpy, StrCpyCsi, StrCpyX, StrCpyXl, StrCpyStk, StrCpyStkCsi
	

;$SegStrings	segment	para public 'Strings'
;		assume	cs:$segStrings, ds:nothing


; StrCpy    -   Copies string pointed at by es:di to string pointed at by
;               fs:si. (Sorry for the backward use of registers, this
;		matches the rest of the standard library though).
;
; inputs:
;		es:di-	Zero-terminated source string.
;		fs:si-  Buffer for destination string.
;
; outputs:	es:di-	Points at destination string.
;
;
; StrCpyCsi  -  Source string is passed as a literal in the code stream
;               rather than in es:di.
;
; StrCpyX    -  es:di returns pointing at the end of the destination string
;               fs:si.
;
; StrCpyXCsi -  Source string is passed as a literal in the code stream
;               rather than in es:di. es:di returns pointing at the end of
;               the destination string fs:si.
;
; StrCpyStk  -  Address of dest and source is passed on the stack.
;		Preserves es:di.
;
; StrCpyStkCsi- Source string is passed as a literal in the code stream.
;		The dest. is passed on the stack. Preserves es:di.
;
; Note: 	The destination buffer must be large enough to hold the
;		string and zero terminating byte.


$StrCpy         proc    far
		push	ds
		push	cx
		push	ax
		pushf
		push	si

		cld
		mov	al, 0
		mov	cx, 0ffffh
		push	di
	repne	scasb
		pop	di
		neg	cx
		mov	ax, es
		mov	ds, ax

		push	fs
		pop	es

		xchg	si, di
		dec	cx
		shr	cx, 1
		jnc	CpyWrd
		lodsb
		stosb
CpyWrd:	rep	movsw

DidByte:	pop	si
		popf
		pop	ax
		pop	cx
		pop	ds

		push	fs
		pop	es
		mov	di, si
		ret
$StrCpy         endp


$StrCpyCsi      proc    far
		push	bp
		mov	bp, sp
		push	si

		les	di, [bp+2]	; Get ptr to source string.

StrCpyCsiLp:	mov	al, es:[di]	; Copy the string.
		mov	fs:[si], al
		inc 	si
		inc	di
		cmp	al, 0
		jne	StrCpyCsiLp

		mov	[bp+2], di	; Return past the zero byte.

		push	fs		; Return ptr to dest. string.
		pop	es
		pop	si
		mov	di, si

		pop	bp
		ret
$StrCpyCsi      endp


$StrCpyX        proc    far
		push	si

StrCpyXLp:	mov	al, es:[di]	; Copy the string.
		mov	fs:[si], al
		inc 	si
		inc	di
		cmp	al, 0
		jne	StrCpyXLp

		dec	si
		mov	di, si
		push	fs
		pop	es

		pop	si
		ret
$StrCpyX        endp
		

$StrCpyXCsi     proc    far
		push	bp
		mov	bp, sp
		push	si

		les	di, [bp+2]	; Get ptr to source string.

StrCpyXCsiLp:	mov	al, es:[di]	; Copy the string.
		mov	fs:[si], al
		inc	si
		inc	di
		cmp	al, 0
		jne	StrCpyXCsiLp

		dec	si
		mov	[bp+2], di	; Return past string literal

		push	fs		; Return ptr to dest. string.
		pop	es
		mov	di, si

		pop	si
		pop	bp
		ret
$StrCpyXCsi     endp


$StrCpyStk      proc    far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	di
		push	si

		lfs	si, [bp+10]	; Source
		les	di, [bp+6]	; Destination
                call    $StrCpy

		pop	si
		pop	di
		pop	fs
		pop	es
		pop	bp
		ret	8
$StrCpyStk      endp


$StrCpyStkCsi	proc    far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	di
		push	si

		les	di, [bp+2]	; Get ptr to source string.
		lfs	si, [bp+6]	; Destination

StrCpyStkCsiLp:	mov	al, es:[di]	; Copy the string.
		mov	fs:[si], al
		inc 	si
		inc	di
		cmp	al, 0
		jne	StrCpyStkCsiLp

		mov	[bp+2], di	; Return past the zero byte.

		pop	si
		pop	di
		pop	fs
		pop	es
		pop	bp
		ret	4
$StrCpyStkCsi   endp


;$SegStrings	ends
;		end
