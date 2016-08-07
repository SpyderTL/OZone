	page	66,132
;******************************** MKEY19.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
is_stdout_console - check if stdout redirected to file.
;
; inputs:    none
; 
; output:    al =  2  stdout is console
;                  0  stdout is file, printer, or other
;* * * * * * * * * * * * * *

	PUBLIC	is_stdout_console
is_stdout_console		PROC	FAR
	apush	bx,dx
	mov	bx,1		;handle 0=stdin 1=stdout 2=con 3=aux 4=prn
	mov	ax,4400h	;ioctrl (get device data)
	int	21h		;dx is returned with device/file info
	mov	al,0
	test	dh,80h		;check if file or device
	jz	stdout_file	;jmp if file (redirected)
	mov	al,dl
	and	al,02h		;isolate stdout bit
stdout_file:
	apop	dx,bx
	retf	
is_stdout_console ENDP

LIBSEG	ENDS
	end
