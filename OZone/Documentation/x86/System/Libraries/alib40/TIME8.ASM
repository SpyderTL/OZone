	page	66,132
;******************************** TIME8.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
	extrn	date_to_days:far

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
ASC2_TO_DATE - get number of days between Jan 1, 1980 and a date.
;
; input:  ES:DI         "yyyy/mm/dd" ascii string

; output: DX		year (1980-2099)
;	  AH		month (1-12)
;	  AL		day (1-31)
;
; Notes:  This routine does not check for errors in the input data.
;         It assumes the year is 1000 or later.
;
;* * * * * * * * * * * * * *

ten_10	dw	10

	public		asc2_to_date
asc2_to_date	proc	far
	apush	cx,di,bp
;
; do year first
;
	sub	ax,ax			;set sum to zero
	sub	cx,cx			;
	mov	bp,4
yr_lp:	mov	cl,byte ptr es:[di]
	sub	cl,'0'
	mul	cs:ten_10
	add	ax,cx			;add current char.
	inc	di
	dec	bp
	jnz	yr_lp			;loop till done
	push	ax			;save binary for year
;
; do month next
;
	inc	di			;move to month ascii
	mov	ax,word ptr es:[di]
	xchg	ah,al
	and	ax,0f0fh		;strip off ascii
	aad
	push	ax
;
; do day
;
	add	di,3
	mov	ax,word ptr es:[di]
	xchg	ah,al
	and	ax,0f0fh
	aad
;
; set parameters
;
	pop	dx
	mov	ah,dl			;set month
	pop	dx			;get year

	apop	bp,di,cx
	retf

asc2_to_date	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
ASC2_TO_BIN - get number of days between Jan 1, 1980 and a date.
;
; input:  ES:DI		"yyyy/mm/dd" ascii string
;
; output: AX		days elapsed since January 1, 1980
;* * * * * * * * * * * * * *

	public		asc2_to_bin
asc2_to_bin	proc	far
		call	asc2_to_date
		call	date_to_days
		retf
asc2_to_bin	endp


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
ASC2_TO_BYTE - convert two ascii digets to binary byte
;
; input:  ES:DI		"nn" ascii string
;
; output: AL		days elapsed since January 1, 1980
;* * * * * * * * * * * * * *

	public		asc2_to_bin
asc2_to_byte	proc	far
	mov	ax,word ptr es:[di]
	xchg	ah,al
	and	ax,0f0fh		;strip off ascii
	aad
	retf
asc2_to_byte	endp


LIBSEG	ENDS
;;	end
