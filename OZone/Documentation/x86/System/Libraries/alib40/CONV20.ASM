	page	66,132
;******************************** CONV20.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
SBYTE_TO_DEC_STDOUT - display short byte as decimal to stdout
;
; inputs  al = byte with value of less than 128 
; 
; output  two digits displayed
;* * * * * * * * * * * * * *

	extrn	stdout_char:far
;----------------------------------------------------------------------------
; inputs al = binary
;
	public	sbyte_to_dec_stdout
sbyte_to_dec_stdout	proc	far
	push	ax
	aam			;convert byte to bcd
	or	ax,3030h	;add in ascii
	xchg	al,ah
	call	stdout_char
	xchg	al,ah
	call	stdout_char
	pop	ax
	retf 
sbyte_to_dec_stdout	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
SBYTE_TO_DEC_STR - store short byte as decimal to memory
;
; inputs  al = byte with value of less than 128 
;       ds:si = storage location
; 
; output  two digits
;* * * * * * * * * * * * * *


;----------------------------------------------------------------------------
; inputs al = binary
;
	public	sbyte_to_dec_str
sbyte_to_dec_str	proc	far
	push	ax
	aam			;convert byte to bcd
	or	ax,3030h	;add in ascii
	mov	byte ptr [si],ah
	mov	byte ptr [si+1],al
	pop	ax
	retf 
sbyte_to_dec_str	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
BYTE_TO_DEC_STDOUT - display short byte as decimal to stdout
;
; inputs  al = byte
; 
; output  three digits displayed
;* * * * * * * * * * * * * *

	extrn	stdout_char:far
;----------------------------------------------------------------------------
; inputs al = binary
;
	public	BYTE_to_dec_stdout
BYTE_to_dec_stdout	proc	far
	push	ax
	aam			;convert byte to bcd
	push	ax
	mov	al,ah
	aam
	or	ax,3030h	;add in ascii
	xchg	al,ah
	call	stdout_char
	xchg	al,ah
	call	stdout_char
	pop	ax
	or	al,30h
	call	stdout_char
	pop	ax
	retf 
BYTE_to_dec_stdout	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( CONVERT )
BYTE_TO_DEC_STR - store short byte as decimal to memory
;
; inputs  al = byte with value of less than 128 
;       ds:si = storage location
; 
; output  three digits
;* * * * * * * * * * * * * *


;----------------------------------------------------------------------------
; inputs al = binary
;
	public	BYTE_to_dec_str
BYTE_to_dec_str	proc	far
	push	ax
	aam			;convert byte to bcd
	push	ax
	mov	al,ah
	aam
	or	ax,3030h	;add in ascii
	mov	byte ptr [si],ah
	mov	byte ptr [si+1],al
	pop	ax
	or	al,30h
	mov	byte ptr [si+2],al
	pop	ax
	retf 
BYTE_to_dec_str	endp

LIBSEG	ENDS
	end

