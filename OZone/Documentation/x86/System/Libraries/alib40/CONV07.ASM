	page	66,132
;******************************** CONV07.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
DWORD_TO_DEC_STRX - convert dword to decimal ascii with formating
; inputs: dx,ax = binary dword, dx=high word, ax=low word
;         ds:di = pointer to end of storage buffer.
; output:   di = pointer to start (left side) of decimal string.
;
; note:  The storage buffer must be initialized with all spaces if
;        leading blanks are utilized.
;
;        This routine right justifies the decimal ascii in a buffer
;        and adds commas between each grouping of three digits.
;        Normally, this routine is used to display numbers in columns
;        with right edge lined up.
;
;        Beware, the input buffer pointer must point to the end of the
;        buffer and not the start.
;
;        This routine can be used to display numbers right justified or
;        left justified, depending upon whether the buffer start is used
;        or returned DI is used.
;* * * * * * * * * * * * * *

	public	DWORD_TO_DEC_STRX
DWORD_TO_DEC_STRX	PROC	FAR
	call	dword_convert
	retf
DWORD_TO_DEC_STRX	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
DWORD_TO_DEC_CRTX - convert dword to decimal ascii and display
; inputs: dx,ax = binary dword, dx=high word, ax=low word
; output: none
;
; note:  Display cursor should be at right end of area for decimal value.
;        The value is displayed from right to left and commas added to
;        separate every 3 characters.
;* * * * * * * * * * * * * *

	public	DWORD_TO_DEC_CRTX
DWORD_TO_DEC_CRTX	PROC	FAR
		cld
		apush	ax,di,dx,ds

		push	cs
		pop	ds
		mov	di,offset text_store
;
; clear the text build area
;
db_clear:	mov	byte ptr ds:[di],' '
		inc	di
		cmp	di,offset text_end -1
		jne	db_clear

		call	dword_convert
				
		mov	dx,offset text_store
		mov	ah,9
		int	21h
		apop	ds,dx,di,ax
		retf
DWORD_TO_DEC_CRTX	ENDP
;----------------------------------------------------------------------------

ten		dw	10
comma_count	db	0
text_store	db	10 dup (20h)
text_end	db	'$'
;----------------------------------------------------------------------------
; dword_convert - convert dword to decimal ascii and store using ES:DI
;   inputs:  dx,ax = binary value
;            es:di = storage point
;  output:  di = pointer to start of decimal string
;
dword_convert:
		apush	ax,bx,dx
		mov	cs:comma_count,4  
;
; convert one character each loop.  The least segnificant ditits are
; converted first.
;
dd_loop:	push	ax
		mov	ax,dx
		xor	dx,dx
		div	cs:ten
		mov	bx,ax
		pop	ax
		div	cs:ten
		xchg	bx,dx

; dx,ax = quotient
;    bx = remainder

		dec	comma_count
		jnz	not_yet1		;jmp if not time for comma
		mov	comma_count,3
		mov	byte ptr es:[di],','
		dec	di
not_yet1:	add	bl,30h
		mov	byte ptr es:[di],bl
		dec	di
;
; dx,ax = quotient
;    bx = remainder

		or	ax,ax
		jnz	dd_loop
		or	dx,dx
		jnz	dd_loop
		inc	di			;point at last char. stored.
		apop	dx,bx,ax
		ret

LIBSEG	ENDS
	end
