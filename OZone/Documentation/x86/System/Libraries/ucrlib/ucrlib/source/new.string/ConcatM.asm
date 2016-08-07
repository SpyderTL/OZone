		.386
		option	segment:use16, proc:private

		include	strings.a
		include	memory.a

		echo	ConcatM, ConcatMStk, ConcatMStkCsi

$SegStrings	segment	para public 'Strings'
		assume	cs:$segStrings, ds:nothing


; Concat    -	Computes the lengths of two strings pointed at by es:di and
;		fs:si then allocates storage for a string long enough to hold
;		the concatentation of these two strings.  Finally, it 
;		concatenates the two strings storing the resulting string into
;		the new buffer.	Returns ES:DI pointing at the new string.
;
; inputs:
;		ES:DI- Points at the first string.
;		FS:SI- Points at the string to append.
;
; outputs:
;
;		ES:DI- Points at new string containing the concatenation of the
;	       	two strings.
;
;		carry=0 if no error.
;		carry=1 if strcat2 could not allocate enough memory to hold
;		the resulting string.
;
; strcatmcsi -	Second string is passed as a literal in the code stream.
;
; strcatmstk -	Both strings are passed on the stack.


$strcatm	proc	far

		push	es
		push	di
		push	fs
		push	si
		call	$StrCatStkM

		ret
$strcatm	endp


StrCatML_SPtr2	textequ	<[bp+2]>
StrCatML_SPtr1	textequ	<[bp-2]>
StrCatML_SLen1	textequ	<[bp-6]>
StrCatML_RtnAdr	textequ	<[bp-8]>
StrCatML_SLen2	textequ	<[bp-10]>

$StrCatMcsi	proc	far
		push	bp
                mov	bp, sp
		sub	sp, 10			; Allocate Locals
		push	cx
		push	ax
		push	ds
		push	si
		pushf
		cld

;
; Save pointers to the string:
;
		mov	StrCatML_SPtr1, di
		mov	StrCatML_SPtr1+2, es
;
; Compute the length of the string following the call.
;
		mov	al, 0
		les	di, StrCatML_StrPtr2
		mov	cx, 0ffffh
	repne	scasb

		mov	StrCatML_RtnAdr, di		;Save return address
		neg	cx
		dec	cx
		mov	StrCatML_StrLen2, cx
;
; Find the end of the first string:
;
		les	di, StrCatML_StrPtr1
		mov	cx, 0ffffh
	repne	scasb
		neg	cx
		dec	cx
		dec	cx
		mov	StrCatML_StrLen1, cx
;
; Malloc the appropriate storage:
;
		add	cx, StrCatML_StrLen2
		call	sl_malloc
		jc	BadStrCat2
;
; Save ptr to dest
;
		push	es
		push	di		
;
; Copy the strings:
;
		lds	si, StrCatML_StrPtr1
		mov	cx, StrCatML_StrLen1
		shr	cx, 1
		jnc	cs1
		lodsb
		stosb
cs1:	rep	movsw
		lds	si, StrCatML_StrPtr2
		mov	cx, StrCatML_StrLen2
		shr	cx, 1
		jnc	cs2
		lodsb
		stosb
cs2:	rep	movsw

		mov	ax, StrCatML_RtnAdr
		mov	StrCatML_StrPtr2, ax
		pop	di
		pop	es
		popf
		pop	si
		pop	ds
		pop	ax
		pop	cx
		mov	sp, bp		; Deallocate locals
		pop	bp
		clc
		ret

BadStrCat2:	mov	es, StrCatML_StrPtr1+2
		mov	di, StrCatML_StrPtr1
		mov	ax, StrCalML_RtnAdr
		mov	StrCatML_StrPtr2, ax
		popf
		pop	di
		pop	ds
		pop	ax
		pop	cx
		mov	sp, bp		; Deallocate locals
		pop	bp
		stc
		ret
$strcatmcsi	endp


StrCat_SPtr2	textequ	<[bp+10]>
StrCat_SPtr1	textequ	<[bp+6]>
StrCat_StrLen1	textequ	<[bp-2]>
StrCat_StrLen2	textequ	<[bp-4]>

$StrCatStkM	proc	far
		push	bp
		mov	bp, sp
		sub	sp, 4		; Locals to hold the length.
		push	ds
		push	si
		push	cx
		push	ax
		pushf
		cld

;
; Compute the length of the second string.
;
		mov	al, 0
		les	di, StrCat_StrPtr2
		mov	cx, 0ffffh
	repne	scasb
		neg	cx
		dec	cx
		mov	StrCar_StrLen2, cx
;
; Find the end of the first string:
;
		les	di, StrCat_StrPtr1
		mov	cx, 0ffffh
	repne	scasb
		neg	cx
		dec	cx
		dec	cx
		mov	StrCat_StrLen1, cx
;
; Malloc the appropriate storage:
;
		add	cx, word ptr StrCat_StrLen2
		call	sl_malloc
		jc	BadStrCat2
;
; Save ptr to dest:
;
		push	es
		push	di		
;
; Copy the strings:
;
		lds	si, StrCat_StrPtr1
		mov	cx, StrCar_StrLen1
		shr	cx, 1
		jnc	cs1
		lodsb
		stosb
cs1:	rep	movsw
		lds	si, StrCat_StrPtr1
		mov	cx, StrCat_StrLen2
		shr	cx, 1
		jnc	cs2
		lodsb
		stosb
cs2:	rep	movsw

		pop	di
		pop	es
		popf
		pop	ax
		pop	cx
		pop	si
		pop	ds
		mov	sp, bp
		pop	bp
		clc
		ret	8

BadStrCat2:	les	di, StrCat_StrPrt1
		popf
		pop	ax
		pop	cx
		pop	si
		pop	ds
		mov	sp, bp
		pop	bp
		stc
		ret	8
$StrCatStkM	endp


stdlib		ends
		end