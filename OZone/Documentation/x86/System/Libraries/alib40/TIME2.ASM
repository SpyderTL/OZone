	page	66,132
;******************************** TIME2.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
MONTH_TO_ASCII - get ASCII string for specified month
;
; inputs:    CX = month (1 - 12, January = 1)
; 
; output:    ES:[DI] = pointer to month name string
;            CX = length of month string
;
; Note: the day name string is not zero-terminated
;* * * * * * * * * * * * * *

	public	MONTH_TO_ASCII
MONTH_TO_ASCII	PROC	FAR
	mov	di,offset months
	call	lookup
	retf
MONTH_TO_ASCII	ENDP	

months	label	byte
	DB	'January  '
	db	'February '
	db	'March    '
	db	'April    '
	db	'May      '
	db	'June     '
	db	'July     '
	db	'August   '
	db	'September'
	db	'October  '
	db      'November '
	db	'December '
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
DAY_TO_ASCII - get string for specified day of the week
;
; inputs:    CX = day of week (1 - 7, Sunday = 1)
; 
; output:    ES:[DI] = pointer to day name string
;            CX = length of new string
;            
; Note: the day name string is not zero-terminated
;* * * * * * * * * * * * * *

	public	DAY_TO_ASCII
DAY_TO_ASCII	proc	far
	mov	di,offset days
	call	lookup
	retf
DAY_TO_ASCII	ENDP	
	
days	label	byte		
	db	'Sunday   '
	db	'Monday   '
	db	'Tuesday  '
	db	'Wednesday'
	db	'Thursday '
	db	'Friday   '
	db	'Saturday '
;--------------------------------------------------------
; local subroutine to index into a table
;  inputs:  cs:di points at table
;              cx is increment into table (1-12)
;  output:  es:di points at table entry
;              cx is length of table entry
;
lookup:	cld
	push	cs
	pop	es		;setup es
	dec	cx
	jcxz	lookup_exit	;jmp if done
lookup_lp:	
	add	di,9		;move to next table entry
	loop	lookup_lp	;loop till done
lookup_exit:
	push	di
	mov	al,' '
	mov	cx,9
	repnz	scasb		;find length of table entry
	je	lookup_set	;jmp if lenght found
	mov	cx,-1
lookup_set:	
	sub	cx,9
	neg	cx
	dec	cx
	pop	di		;get ptr to table entry
	ret	


;-----------------------------------------------------

LIBSEG	ENDS
	end
