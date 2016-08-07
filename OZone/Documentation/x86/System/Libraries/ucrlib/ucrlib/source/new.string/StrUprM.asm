			.386
		option	segment:use16, proc:private

		include	strings.a
		include	memory.a

                echo    StrUprM, StrUprStkM

$SegStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing

		extern	$uprtbl:byte


; StrUprM -	Same as StrUpr except it creates a new string then converts the
;		characters in the new string.  The original string is unchanged.
;		Address of original string is in ES:DI.
;
; inputs:
;		es:di-  Address of string to convert (struprm).
;		TOS-	Address of string to convert (struprstkm).
;
; outputs:
;		es:di-  Points at converted string (StrUpr only).
;
; StrUprStkM-	Like StrUprM except original string's address is on the stack.
;


$struprm	proc	far
		call	$strdup
		jc	RetFar
		jmp	near ptr $strupr
RetFar:		ret
$struprm	endp



$StrUprStkm	proc	far
		push	bp
		mov	bp, sp
		les	di, [bp+6]	;Get string address.
		call	$strdup		;Copy the string.
		call	$StrUpr		;Convert it to upper case.
		pop	bp
		ret	4
$StrUprStkm	endp


$ucrlib		ends
		end
