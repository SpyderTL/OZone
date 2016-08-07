	page	66,132
;******************************** TIME6.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
DATE_TO_DAYS - get number of days between Jan 1, 1980 and a date.
;
; input:  DX		year (1980-2099)
;	  AH		month (1-12)
;	  AL		day (1-31)
;
; output: AX		days elapsed since January 1, 1980
;* * * * * * * * * * * * * *

	public		date_to_days
date_to_days	proc	far
		apush	bx,cx,dx,si
		cmp	ah,2		;is month greater than Feb.?
		 ja	date_days_050	;  y: skip Jan/Feb adjust
		add	ah,12		;  n: offset Jan/Feb by 1 year
		dec	dx		;     and dec year
date_days_050:	sub	dx,1976		;now date is rel to 03-01-1976
		xor	cx,cx		;CX = 0
		mov	cl,al		;CX = day of month
		mov	si,dx		;SI = years since 03-01-76
		xchg	al,ah		;AL = month
		cbw			;AX = month
		inc	ax		;AX = adjusted month
		mov	bx,306		;div adjusted month by 30.6...
		mul	bx
		mov	bx,10
		div	bx		;AX = days in year due to months + 122
		add	cx,ax		;CX = days in year + 122
		mov	ax,si		;AX = years since 03-01-76
		shr	ax,1		;div years by 4...
		shr	ax,1		;AX = leap days
		add	cx,ax		;CX = days in year + 122 + leap days
		xchg	ax,si		;AX = years since 03-01-76
		mov	bx,365
		mul	bx		;AX = days due to years
		add	ax,cx		;CX = days + 122 + leap days
		sub	ax,1524		;adjust days: 1401 + 122 + 1
		apop	si,dx,cx,bx
		retf
date_to_days	endp


LIBSEG	ENDS
	end
