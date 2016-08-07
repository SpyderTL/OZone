		.386
		option	segment:use16, proc:private

		include	strings.a
		include	memory.a

		echo	strBDelM, StrBDelMcs, StrBDelMStk
	

$SegStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; StrBDelm -	Removes leading blanks from a string and stores this string
;		on the heap.
;
; inputs:
;		es:di-	Zero-terminated source string.
;
; outputs:	es:di-	Points at destination string (allocated on heap).
;		carry-	Set if memory manager error, clear otherwise.
;
; StrBDelMStk -	The address of the string is passed on the stack.
;
; StrBDelMcs - 	The address of the string is passed in the code stream.


$StrBDelM	proc	far
		dec	di
WhlBlank:	inc	di
		cmp	byte ptr es:[di], ' '
		je	WhlBlank
		call	$StrCpyM

		ret
$StrBDelM	endp


$StrBDelMStk	proc	far
		push	bp
		mov	bp, sp

		les	di, [bp+6]

		dec	di
WhlBlank:	inc	di
		cmp	byte ptr es:[di], ' '
		je	WhlBlank
		call	$StrCpyM

		pop	bp
		ret	4
$StrBDelMStk	endp


$StrBDelMcs	proc	far
		push	bp
		mov	bp, sp

		les	di, [bp+2]
		les	di, es:[di]
		add	word ptr [bp+2], 4


		dec	di
WhlBlankCs:	inc	di
		cmp	byte ptr es:[di], ' '
		je	WhlBlankCs
		call	$StrCpyM

		pop	bp
		ret
$StrBDelMcs	endp


$SegStrings	ends
		end