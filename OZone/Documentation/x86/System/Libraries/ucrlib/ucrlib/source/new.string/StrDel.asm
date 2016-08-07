		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrDel, StrDelStk
	

$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing

;
; strdel- deletes characters from a string.
;
; inputs:
;		ES:DI - Points at the string to delete characters from.
;		CX - Index into source string (ES:DI) to begin deletion.
;		AX - Number of characters to delete.
;
; StrDelStk -	Number of character to delete, the index into the source
;		string, and the pointer to the string are passed on the
;		stack in that order.


$StrDel		proc	far
		or	ax, ax			;Any chars to delete?
		jnz	DoDelete
		ret

DoDelete:	push	es
		push	di
		push    si
		push	ds
		push	ax
		push	bx
		push	cx
		mov	bx, ax			;Save length

; First, search for the insertion point and make sure it doesn't occur
; beyond the end of the string:

		mov	al, 0
	repne	scasb
		jz	DelDone			;Quit if insertion after len.
		mov	ax, es
		mov	ds, ax
		mov	si, di			;Search for end of string.
		mov	cx, bx
SrchEOS:	lodsb
		cmp	al, 0
		jz	DelToEOS
		loop	SrchEOS

; At this point, we've covered "BX" characters (bx holds # of chars to delete)
; so copy the rest of the string to the deletion point.

CpyEOS:		lodsb
		stosb
		cmp	al, 0
		jnz	CpyEOS
		jmp	short DelDone

; Done here, we reached the end of the string before covering the # of chars
; to delete, so simply chop the string off at the deletion point.

DelToEOS:	mov	byte ptr [di], 0
DelDone:	pop	cx
		pop	bx
		pop	ax
		pop	ds
		pop	si
		pop	di
		pop	es
		ret
$StrDel		endp


$StrDelStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		push	ax
		push	cx

		mov	ax, [bp+12]
		mov	cx, [bp+10]
		les	di, [bp+6]
		call	$StrDel

		pop	cx
		pop	ax
		pop	di
		pop	es
		pop	bp
		ret	8
$StrDelStk	endp


stdlib		ends
		end