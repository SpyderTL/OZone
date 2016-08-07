	page	66,132
;******************************** DISKA.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	strlen3:far
	extrn	to_upper:far
	extrn	last_char:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
DECODE_FILENAME - return pointers to major portions of file name
;
;  inputs: ds:bx = pointer to file name, use EXPAND_FILENAME to format first
;  
;  output: if no carry then,
;           ds:si = pointer to path
;           ds:di = pointer to filename
;              cx = path length
;              dx = filename length
;              ah = drive letter
;              al = drive number
;          if carry, then filename is bad.
;
; Note: The input string should be:  <drive letter>:/<path>/<filename>0
;* * * * * * * * * * * * * *

	PUBLIC	DECODE_FILENAME
DECODE_FILENAME		PROC	FAR
	mov	al,'\'
	call	last_char		;find start of filename
	inc	ax
	add	ax,bx
	mov	di,ax			;save ptr to filename
	
	sub	ax,bx			;compute length of
	sub	cx,ax			;  filename portion
	mov	dx,cx			;    and put in DX
;
; registers:  ds:bx = input string  di=filename ptr  dx=filename length
;
	cmp	byte ptr [bx+1],':'	;check if drive in expected location
	jne	df_error		;  jmp if error
	mov	si,bx			;compute path
	add	si,3			;  offset
	
	call	strlen3			;compute
	sub	cx,dx			;  length of
	sub	cx,3			;    path portion

	mov	al,byte ptr [bx]	;get drive letter
	mov	ah,0
	call	to_upper
	sub	al,'A'
	mov	ah,byte ptr [bx]
	clc
	jmp	df_exit
df_error:
	stc
df_exit:		
	retf
DECODE_FILENAME		ENDP
;                

LIBSEG	ENDS
	end
