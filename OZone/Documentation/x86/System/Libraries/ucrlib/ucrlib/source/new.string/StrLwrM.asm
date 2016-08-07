		.386
		option	segment:use16, proc:private

		include	strings.a
		include	memory.a

		echo	StrLwrM, StrLwrMStk, StrLwrMCs


$SegStrings	segment	para public 'Strings'
		assume	cs:$SegStrings, ds:nothing


; StrLwrM - 	Creates a new strings, then converts to lower case all
;		upper case characters in the string pointed at by es:di.
;
; inputs:
;		es:di-  Buffer for destination string.
;
; outputs:
;		es:di-  Points at converted string.
;
; StrLwrMStk - 	Address of the string to convert is passed on the stack.
;
; StrLwrMCs - 	Address of the string to convert is passed in the
;		code stream.



$StrLwrM	proc	far
		call	$StrCpyM
		jc	RetFar			;Return if error.
		call	$StrLwr
RetFar:		ret
$StrLwrM	endp


$StrLwrMStk	proc	far
		push	bp
		mov	bp,sp
		push	es
		push	di

		les	di, [bp+6]
		call	$StrCpyM
		jc	RetErrorStk
		call	$StrLwr
RetErrorStk:
		pop	di
		pop	es
		pop	bp
		ret	4
$StrLwrMStk	endp


$StrLwrMCs	proc	far
		push	bp
		mov	bp,sp
		push	es
		push	di

		les	di, [bp+2]
		les	di, es:[di]
		add	word ptr [bp+2], 4
		call	$StrCpyM
		jc	RetErrorCs
		call	$StrLwr
RetErrorCs:
		pop	di
		pop	es
		pop	bp
		ret
$StrLwrMCs	endp


$SegStrings	ends
		end
