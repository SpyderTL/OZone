	page	66,132
;******************************** TIME5.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
ASC_DATE - Creates a date string of the form MM/DD/YY.
;
; input:  DX		year (1980-2099)
;	  AH		month (1-12)
;	  AL		day (1-31)
;	DS:SI		destination string ("string")
;
; output: si points past last character stored.  	
;* * * * * * * * * * * * * *

	PUBLIC	asc_date
asc_date	proc	far
		apush	ax,bx,dx,di

		push	es
		push	ds
		pop	es		;ensure ES = DS in large data models

		mov	di,si		;DI = SI
		xchg	ax,bx		;BX = month and day
		mov	al,bh		;AL = month
		aam			;AX = month in BCD format
		add	ax,"00"		;AX = month in decimal digits
		xchg	al,ah
		stosw			;write month to string
		mov	al,"/"
		stosb			;write "/" to string
		xchg	ax,bx		;AL = day
		aam			;AX = day in BCD format
		add	ax,"00"		;AX = day in decimal digits
		xchg	al,ah
		stosw			;write day to string
		mov	al,"/"
		stosb			;write "/" to string
		xchg	ax,dx		;AX = year
		mov	dl,100
		div	dl		;DL = last two digits of year
		mov	al,ah		;AL = last two digits of year
		aam			;AX = year in BCD format
		add	ax,"00"		;AX = year in decimal digits
		xchg	al,ah
		stosw			;write year to string
		xor	al,al
		stosb			;write NULL to end of string

		pop	es

		apop	ax,bx,dx,di
		retf
asc_date	endp


LIBSEG	ENDS
	end
