		.386
		option	segment:use16, proc:private

		include	strings.a

                echo    Concat, ConcatCsi, ConcatStk, ConcatStkCsi
	

$SegStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; Concat    -   Concatenate two strings placing the result in the destination
;               pointed at by gs:bx.
;
; Inputs:
;               ES:DI - Points at the first source string.
;               FS:SI - Points at the second source string.
;               GS:BX - Points at the destination.
;
; Outputs:
;               GS:BX - points at ES:DI + FS:SI. 
;
; ConcatCsi  -  Second source string passed as a literal in the code stream
;               rather than in fs:si.
;
; ConcatStk  -  Addresses both strings are passed on the stack.
;
; ConcatStkCsi- Second source string passed as a literal in the code stream
;               rather than on the stack.
;
;
; Note:         The destination (GS:BX) buffer must be sufficiently large to
;               hold the result of the Concatentation of the two strings.
;


$Concat         proc    far
		push	es
		push	di
		push	fs
		push	si
                call    $ConcatStk

		ret
$Concat         endp


$ConcatCsi      proc    far
		push	bp
		mov	bp, sp
		push	ds
		push	cx
		push	ax
		pushf
		push	si
		push	di

		cld
;
; Find the end of the destination string:
;
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
;
; Copy the second string to the end of the current string.
;
		lds	si, [bp+2]		;Get Return Address
		dec	di
CpyLpCsi:	lodsb
		stosb
		cmp	al, 0
		jnz	CpyLpCsi

		mov	[bp+2], si		;Save new return address.
		pop	di
		pop	si
		popf
		pop	ax
		pop	cx
		pop	ds
		pop	bp
		ret
$ConcatCsi      endp


ConcatStk_Src1  textequ <[bp+10]>
ConcatStk_Src2  textequ <[bp+6]>

$ConcatStk      proc    far
                push    ax
                push    cx
                push    es
                push    ds                                    
                push    di
                push    si
		pushf
                cld

;
; Setup the destination.
;
                push    gs
                pop     es
                mov     di, bx
;
; Copy the first string:
;
                lds     si, ConcatStk_Src1

CpyLpStk:	lodsb
		stosb
		cmp	al, 0
		jnz	CpyLpStk

                dec     di
;
; Copy the second string:
;
                lds     si, ConcatStk_Src2

CpyLpStk2:	lodsb
		stosb
		cmp	al, 0
		jnz	CpyLpStk2


                push    es
                pop     gs

		popf
                pop     si
                pop     di
                pop     ds
                pop     es
                pop     cx
                pop     ax
                ret     8
$ConcatStk      endp


$ConcatStkCsi   proc    far
		push	bp
		mov	bp, sp
		push	es
		push	fs
		push	di
		push	si

		les	di, [bp+6]	; Destination
                call    $ConcatCsi

		pop	si
		pop	di
		pop	fs
		pop	es
		pop	bp
		ret	4
$ConcatStkCsi     endp


$SegStrings     ends
                end