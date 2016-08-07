;               .386
;                option  segment:use16, proc:private

;                include strings.a

                echo    StrBDel, StrBDelStk, StrBDelCs
	

;$SegStrings     segment para public 'Strings'
;                assume  cs:$segStrings, ds:nothing


; StrBDel-      Removes leading blanks from a string.
;
; inputs:
;		es:di-	Zero-terminated source string.
;
; outputs:	es:di-	Points at destination string.
;
; StrBDelStk -  Address of string is passed on the stack.
;
; StrBDelCs -   Address of the string is passed in the code stream.


$StrBDel        proc    far
		push	ds
		push	ax
		push	di
		push	si
		mov	ax, es
		mov	ds, ax

		mov	al, ' '
		cmp	al, [di]		;Any leading blanks?
		jne	StrBDDone

		mov	si, di
WhlBlank:	lodsb
		cmp	al, ' '
		je	WhlBlank

WhlNotZero:	stosb
		cmp	al, 0
		lodsb
		jne	WhlNotZero

StrBDDone:	pop	si
		pop	di
		pop	ax
		pop	ds
		ret
$StrBDel        endp


$StrBDelStk     proc    far
		push	bp
		mov	bp, sp

		les	di, [bp+6]
                call    $StrBDel                 

		pop	bp	
		ret	4	
$StrBDelStk     endp


$StrBDelCs      proc    far
		push	bp
		mov	bp, sp

		les	di, [bp+2]
                les     di, es:[di]

;		print
;		byte	"In StrBDelCS - ", 0
;		puts
;		putcr

		add	word ptr [bp+2], 4

                call    $StrBDel

		pop	bp
		ret
$StrBDelCs      endp


;$SegStrings     ends
;                end
