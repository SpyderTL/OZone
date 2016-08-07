	page	66,132
;******************************** TIME4.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	EXTRN	DATE_TO_DAYS:FAR
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
GET_DATE - Returns the current SYSTEM date and day of the week.
;
; input:  None
; 
; output: Current SYSTEM date, in dword format:
;	  DX		year (1980-2099)
;	  AH		month (1-12)
;	  AL		day (1-31)
;         CL		day-of-the-week (number of days since Sunday)
;* * * * * * * * * * * * * *

	public		get_date
get_date	proc	far
		push	bx		;save temporary register
		mov	bh,ch		;BH holds original CH
		mov	ah,2Ah		;DOS function to get date
		int	21h
		xchg	ax,cx		;CL=day-of-week (AX=year)
		xchg	ax,dx		;DX=year; AX=month and day
		mov	ch,bh		;restore CH
		pop	bx
		retf
get_date	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
GET_DAY - Returns the day of the week for a given date.
;
; input: Date for which day of week should be determined, in dword
;	  DX		year (1980-2099)
;	  AH		month (1-12)
;	  AL		day (1-31)
;
; output: CL		day of the week (0-6)
;* * * * * * * * * * * * * *

	public		get_day
get_day	proc	far
		apush	ax,bx,dx
		call    date_to_days	;AX = days since 01-01-80 
		add	ax,2		;because 01-01-80 was Tuesday
		xor	dx,dx		;DX = 0
		mov	bx,7		;mod 7...
		div	bx		;DX = day of week
		mov	cl,dl		;CL = day of week
		apop	dx,bx,ax
		retf
get_day		endp


LIBSEG	ENDS
	end
