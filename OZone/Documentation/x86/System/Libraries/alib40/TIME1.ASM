	page	66,132
;******************************** TIME1.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------

$day_in_month	db	31		;days in March
		db	30		;days in April
		db	31		;days in May
		db	30		;days in June
		db	31		;days in July
		db	31		;days in August
		db	30		;days in September
		db	31		;days in October
		db	30		;days in November
		db	31		;days in December
		db	31		;days in January
		db	-1		;the rest are in February

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
DAYS_TO_DATE - build date for the number of days since Jan 1, 1980.
;
; input:  AX = 	days elapsed since January 1, 1980 ("numdays")
;
; output: DX		year (1980-2099)
;	  AH		month (1-12)
;	  AL		day (1-31)
;
;* * * * * * * * * * * * * *

	public		days_to_date
days_to_date	proc	far
		apush	bx,si
		add	ax,1401		;adjust year to 03-01-1976
		xor	dx,dx		;DX = 0
		mov	bx,1461
		div	bx		;AX = leap years, DX = remaining days
		mov	si,ax		;SI = leap years
		xchg	ax,dx		;AX = remaining days from last ly
		xor	dx,dx		;DX = 0
		mov	bx,365
		div	bx		;AX = years since ly, DX = rem days
		cmp	ax,4		;is this the leap day?
		 jne	dys_dte_050	;  n: skip day/year adjust
		dec	ax		;  y: actual year = year - 1
		mov	dx,bx		;     day of year = 365
dys_dte_050:	shl	si,1		;mul leap year by 4...
		shl	si,1
		add	ax,si		;AX = years since 03-01-1976
		xchg	dx,ax		;DX = years since 03-01-1976, AX =days
		xchg	bx,ax		;BX = remaining days in adjusted year
		mov	si,offset $day_in_month
dys_dte_100:	lods	byte ptr cs:[si] ;get days/month starting with March
		cbw
		sub	bx,ax		;all days accounted for?
		 jnc	dys_dte_100	;  n: get next month's days, else...
		add	ax,bx		;AX = day of month - 1
		inc	ax		;AX = day of month
		sub	si,offset $day_in_month ;SI = month (1=March)
		mov	bx,si		;BX = month (1=March)
		inc	bx
		inc	bx		;BX = month (3=March, 14=Feb)
		mov	ah,bl		;AL = day of month, AH = month (14=Feb)
		add	dx,1976		;DX = year
		cmp	ah,12		;is month greater than 12?
		 jbe	days_date_050	;  n: skip month/year adjust
		inc	dx		;  y: adjust year and
		sub	ah,12		;	month, (Jan = 1, Dec = 12)
days_date_050:	apop	bx,si
		retf
days_to_date	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
MONTH_DAYS - return number of days in a month
;
; input:  BX = 	month number 01=january
;         AX =  year
;
; output: BX =  days in month
;
;* * * * * * * * * * * * * *


mdays	label	byte
	db	31	;jan
	db	28	;feb
	db	31	;mar
	db	30	;apr
	db	31	;may
	db	30	;jun
	db	31	;jul
	db	31	;aug
	db	30	;sept
	db	31	;oct
	db	30	;nov
	db	31	;dec
	
	public		month_days
month_days	proc	far
	dec	bl	
	mov	bl,cs:[mdays.bx]
	cmp	bl,28		;is this feb
	jne	md_exit
	call	is_leap		;adjust for leap year
	jnc	md_exit
	inc	bx
md_exit:
	retf

month_days	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
IS_LEAP - check if leap year
;
; input:  AX = 	year (binary)
; output: carry set if leap year
;
;* * * * * * * * * * * * * *

	public		is_leap
is_leap	proc	far
	apush	dx,cx
	cmp	ax,400
	jb	is_exit		;exit if error
	push	ax
	mov	cx,400
	xor	dx,dx		;clear dx
	div	cx
	cmp	dx,0		;check if centenial leap
	pop	ax
	je	got_leap	;jmp if leap
	mov	cx,4
	xor	dx,dx
	div	cx
	cmp	dx,0
	jne	not_leap	;jmp if not leap
got_leap:
	stc
	jmp	is_exit
not_leap:clc
is_exit:apop	cx,dx
	retf
is_leap	endp

LIBSEG	ENDS
	end
