		include	char.a

		echo	IsDigit

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib,ds:nothing


; IsDigit- 	Checks a character to see if it is a decimal digit.
;
; IsDigit-	Checks character in AL.
; IsDigitCS-	Dword pointer after call points at character.
; IsDigitStk-	Dword pointer to character is on TOS.
; IsDigitTOS-	Character to test is on TOS.

		public	$IsDigit
$IsDigit	proc	far

		cmp	al, '0'
		jb	NotDigit
		cmp	al, '9'
		ja	NotDigit
		cmp	al, al			;Sets zero flag.
NotDigit:	
		ret
$IsDigit	endp
ucrlib		ends
		end
