	page	66,132
;******************************** TIME9.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
	extrn	days_to_date:far
	
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
DATE_TO_ASC2 - DATE (DX,AH,AL) to ascii string
;
; input:  DX		year (1980-2099)
;	  AH		month (1-12)
;	  AL		day (1-31)
;         ES:DI         storage buffer for ascii

; output: ES:DI         "yyyy/mm/dd" ascii string

;
;* * * * * * * * * * * * * *

	public		date_to_asc2
date_to_asc2	proc	far
	apush	ax,bx,cx,dx
	push	ax
	mov	ax,dx
	mov	cx,4
	call	recursion		;do year
	mov	al,'/'
	stosb
	pop	ax
	push	ax
	xchg	ah,al
	mov	ah,0
	mov	cx,2
	call	recursion		;do month
	mov	al,'/'
	stosb
	pop	ax
	mov	ah,0
	mov	cx,2
	call	recursion		;do day
	apop	dx,cx,bx,ax
	retf
date_to_asc2	endp

;-----------------------------
; local routine to convert number to ascii
;    inputs:  ax = binary number
;           es:di = storage buffer
;    output:  es:di pointer updated
;

tn_10		dw	10

recursion:	xor	dx,dx
		div	cs:tn_10		;divide curent binary val by 10
		dec	cx
		jz	db_stuff		;jmp if done
		push	dx			;save remainder
		call	recursion   		;recursion
		pop	dx
db_stuff:	mov	al,dl
		add	al,30h
		stosb
		ret



comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
BIN_DATE_TO_ASC2 - binary date to ascii
;
; input:  AX		days elapsed since January 1, 1980
;         ES:DI         storage point for ascii (yyyy/mm/dd)

; output: ES:DI		"yyyy/mm/dd" ascii string
;
;* * * * * * * * * * * * * *

	public		bin_date_to_asc2
bin_date_to_asc2	proc	far
	call	days_to_date
	call	date_to_asc2
	retf
bin_date_to_asc2	endp


LIBSEG	ENDS
;;	end
