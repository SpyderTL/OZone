		.386
		option	segment:use16, proc:private

		include	strings.a
		include	memory.a

		echo	strdup, strdupstk, strdupl
	

$SegStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing

; strdup- Duplicates a string on the heap.
;
; inputs:
;
;	ES:DI- Points at string to copy.
;
; output:
;
;	ES:DI-	Points at new string on the heap.
;
;	Also returns carry set if a malloc error occurs (and exceptions
;	are not active).
;
; strdupstk- 	Address of source is passed on the stack rather than in ES:DI
;		Still returns new string pointer in ES:DI
;
; StrDupCS-	String literal is passed in the code stream rather than
;		in ES:DI.  Address of new string on heap is returned in ES:DI


		public	$StrDupStk
$StrDupStk	proc	far
		push	bp
		mov	bp, sp
		les	di, [bp+6]
		call	$strdup
		pop	bp
		ret	4
$StrDupStk	endp




		public	$StrDupCS
$StrDupCS	proc	far
		push	bp
		mov	bp, sp
		push	cx

		les	di, [bp+2]	;Return address
		call	$strlencx	;Get string length
		inc	cx
		add	[bp+2], cx	;Point past zero byte.
		call	$strdup		;Copy the string.
		pop	cx
		pop	bp
		ret
$StrDupCS	endp


		public	$StrDup
$strdup		proc	far
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
		call	$malloc		;Get space for new string.
		pop	cx		;Retrieve length to copy.
		jc	BadStrDup	;If malloc error.

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

BadStrDup:	popf
		stc
		pop	si
		pop	ds
		pop	cx
		pop	ax
		ret
$strdup		endp
$SegStrings	ends
		end
