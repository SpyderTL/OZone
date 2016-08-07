		.386
		option	segment:use16, proc:private

		include	misc.a
		include strings.a
		include	memory.a

		echo	GetEnv
	

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing



; GetEnv-  On entry, ES:DI points at an environment variable name.
;	   This routine copies that string, converts it to upper case
;	   and then searches for that string in the environment space.
;
;	   Returns pointer to environment variable in ES:DI if it finds
;	   said variable.  Also returns carry clear in this case.
;	   Returns the carry set if it could not find the environment
;	   variable or if there was a memory allocation error.
;
; GetEnvStk-	Like GetEnv above except on entry the pointer to the
;		string appears on the stack.
;
; GetEnvCS-	Like GetEnv above, except the environment variable's
;		name (string) follows in the code stream.


		public	$GetEnvStk
$GetEnvStk	proc	far
		push	bp
		mov	bp, sp
		les	di, [bp+6]
		call	$GetEnv
		pop	bp
		ret	4
$GetEnvStk	endp


		public	$GetEnvCS
$GetEnvCS	proc	far
		push	bp
		mov	bp, sp
		push	ax

		les	di, [bp+2]
		call	$strlen
		inc	ax
		add	word ptr [bp+2], ax	;Fix return address.
		call	$GetEnv
		pop	ax
		pop	bp
		ret
$GetEnvCS	endp


		public	$GetEnv
$GetEnv		proc	far
		pushf
		push	ds
		push	si
		push	bp
		push	cx
		push	ax
		cld

; First, convert all the characters in this string to upper case
; (since environment variables are always all upper case).  Note
; that this code also creates a new copy of the string, it does
; not modify the original string passed to us.

		call	$struprm
		jnc	GoodCopy
		pop	ax		;If an error occured,
		pop	cx		; bail out and set
		pop	bp		; the carry flag.
		pop	si		; (This assumes that
		pop	ds		;  malloc didn't raise
		popf			;  an exception.)
		stc
		ret

; Get the length of the string into cx:

GoodCopy:	call	$StrLenCX
		jcxz	NotFound2	;Bail if empty string.

; Save ptr to name in DS:SI for later use:

		mov	si, es
		mov	ds, si
		mov	si, di

; Get the address of the environment string space:

		mov	ah, 62h			;Get PSP value
		int	21h
		mov	es, bx
		mov	es, es:[2ch]		;Get adrs of env blk.

; Okay, search the environment string space for our string

		push	cx
		push	ds
		push	si
		mov	bp, sp			;Save ptr to vars on stk.
		xor	di, di			;Start at ES:[0]
CmpsLp:	repe	cmpsb				;Does this entry match?
		je	GotMatch

; Restore pointers to the string we're searching for-

		mov	si, 0[bp]
		mov	ds, 2[bp]
		mov	cx, 4[bp]

; The current entry did not match, try the next one:

		mov	cx, 8000h		;Save for next zero.
		mov	al, 0
	repne	scasb

		cmp	byte ptr es:[di], 0	;End of Env?
		jne	CmpsLp


; Return to the caller with carry set if we couldn't find the string.

NotFound:	add	sp, 6			;Pop junk off stack
NotFound2:	mov	di, ds			;Move pointer in DS:SI
		mov	es, di			; (the uppercase str) to
		mov	di, si			; ES:DI so we can free it.
		call	$free			;Free uppercased string.
		pop	ax
		pop	cx
		pop	bp
		pop	si
		pop	ds
		popf
		stc
		ret


; Return to the caller with carry clear if no error.

GotMatch:	mov	ax, es			;Save ptr to stuff after
		mov	cx, di			; the env string.

		pop	di			;Free up the string.
		pop	es
		add	sp, 2			;Pop junk (length) off stack.
		call	$free		

		mov	es, ax			;Restore pointer to the
		mov	di, cx			; environment string.
		pop	ax
		pop	cx
		pop	bp
		pop	si
		pop	ds
		popf
		clc
		ret
$getenv		endp

ucrlib		ends
		end
