	page	66,132
;******************************** TIME3.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
GET_TIME - Returns the current SYSTEM time.
;
; input:  None
;
; output: DH		hours (0-23)
;	  DL		minutes (0-59)
;	  AH		seconds (0-59)
;	  AL		hundredths of seconds (0-99)
;* * * * * * * * * * * * * *

	public		get_time
get_time	proc	far
		push	cx
		mov	ah,2Ch		;dos function to get time
		int	21h		;returns time in CX:DX
		xchg	ax,dx		;move time to DX:AX...
		mov	dx,cx
		pop	cx
		retf
get_time	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  TIME  )
ASC_TIME - Creates a time string of the form HH:MM Xm.
;
; input: DS:SI		destination string ("string")
;	Time in dword format ("time"):
;	  DH		hours (0-23)
;	  DL		minutes (0-59)
;	  
; output: SI points past last store point	  
;* * * * * * * * * * * * * *

	public		asc_time
asc_time	proc	far
		apush	ax,dx,di

		push	es
		push	ds
		pop	es		;ensure ES = DS in large data models

		mov	di,si		;DI = SI
		mov	al,dh		;Al = hours (24 hr clock)
		mov	dh,"p"		;set DH for pm
		cmp	al,12		;is it pm?
		 jae	asc_time_100	;  y: leave DH setup for pm
		mov	dh,"a"		;  n: set DH for am
asc_time_100:	cmp	al,13		;is time 1pm or later?
		 jb	asc_time_120	;  n: skip 24 to 12 hr clock adjust
		sub	al,12		;AL = hours (12 hr clock)
asc_time_120:	cmp	al,0		;is time 12 am?
		 jne	asc_time_140	;  n: skip 12am adjust
		mov	al,12		;  y: make hour 0 = 12am
asc_time_140:	aam			;AX = hours in BCD format
		add	ax,"00"		;AX = hours in decimal digits
		xchg	al,ah
		stosw			;write hours to string
		mov	al,":"
		stosb			;write ":" to string
		mov	al,dl		;AL = minutes
		aam			;AX = minutes in BCD format
		add	ax,"00"		;AX = minutes in decimal digits
		xchg	al,ah
		stosw			;write minutes to string
		mov	al," "
		stosb			;write space character to string
		mov	ah,"m"
		mov	al,dh		;AX = am/pm indicator
		stosw			;write am/pm indicator
		xor	al,al
		stosb			;write NULL to end of string

		pop	es

		apop	ax,dx,di
		retf
asc_time	endp


LIBSEG	ENDS
	end
