		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	
	
$segStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing

		extern	$uprtbl:byte


; StrUprM-	Same as StrUpr except it creates a new string then converts the
;		characters in the new string.  The original string is unchanged.
;		Address of original string is in ES:DI.
;
; StrUprStkM-	Like StrUprM except original string's address is on the stack.
;
; StrUprCSm-	Like StrUprM except original string's address follows the call
;		in the code stream.
;
; inputs:
;		es:di-  Address of string to convert (struprm).
;		TOS-	Address of string to convert (struprstkm).
;		cs:ip-	Address of string to convert (StrUprCSm).
;
; outputs:
;		es:di-  Points at new copy of converted string.


		public	$Struprm
$struprm	proc	far
		call	$strdup
		jc	RetFar
		jmp	near ptr $strupr
RetFar:		ret
$struprm	endp



		public	$StrUprStkm
$StrUprStkm	proc	far
		push	bp
		mov	bp, sp
		les	di, [bp+6]	;Get string address.
		call	$strdup		;Copy the string.
		call	$StrUpr		;Convert it to upper case.
		pop	bp
		ret	4
$StrUprStkm	endp

		public	$StrUprCSm
$StrUprCSm	proc	far
		push	bp
		mov	bp, sp
		les	di, [bp+2]
		les	di, es:[di]
		add	wp [bp+2], 4

		call	$StrDup
		call	$StrUpr

		pop	bp
		ret
$StrUprCSm	endp

$SegStrings	ends
		end
