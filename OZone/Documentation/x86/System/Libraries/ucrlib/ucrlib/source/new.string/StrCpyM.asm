		.386
		option	segment:use16, proc:private


		include	memory.a

                echo    StrCpyM, StrCpyMCsi, StrCpyMStk


$SegStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing

; StrCpyM    -  Duplicates a string on the heap.
;
; inputs:
;		ES:DI-	Points at string to copy.
;
; output:
;		ES:DI-	Points at new string on the heap.
;
;		Also returns carry set if a malloc error occurs
;		(and exceptions are not active).
;
; StrCpyMCsi -  String literal is passed in the code stream rather than
;		in ES:DI.  Address of new string on heap is returned in ES:DI
;
; StrCpyMStk -  Address of source is passed on the stack rather than in ES:DI
;		Still returns new string pointer in ES:DI


$StrCpyM        proc    far
		push	ax
		push	cx
		push	ds
		push	si
		pushf

		mov	ax, es		;Copy source address to DS:SI
		mov	si, di
		mov	ds, ax

		call	$strlencx	;First, get the string's length.
		inc	cx		;Add one for the zero byte.
		push	cx		;Save for later.
		malloc			;Get space for new string.
		pop	cx		;Retrieve length to copy.
		jc	BadStrCpy	;If malloc error.

		push	di		;Save ptr to new string.
		cld
	rep	movsb			;Copy source to dest.
		pop	di

		popf
		clc
		pop	si
		pop	ds
		pop	cx
		pop	ax
		ret

BadStrCpy:	popf
		stc
		pop	si
		pop	ds
		pop	cx
		pop	ax
		ret
$StrCpyM        endp


$StrCpyMCsi       proc    far
		push	bp
		mov	bp, sp
		push	cx

		les	di, [bp+2]	;Return address
		call	$strlencx	;Get string length
		inc	cx
		add	[bp+2], cx	;Point past zero byte.
                call    $StrCpyM        ;Copy the string.
		pop	cx
		pop	bp
		ret
$StrCpyMCsi       endp



$StrCpyMStk     proc    far
		push	bp
		mov	bp, sp
		les	di, [bp+6]
                call    $StrCpyM
		pop	bp
		ret	4
$StrCpyMStk     endp


$SegStrings	ends
		end

