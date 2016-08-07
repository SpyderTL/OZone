	page	66,132
;******************************** STR01.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STRLEN1 - finds length of a ASCII string at DS:SI
;
; inputs:    DS:[SI] = address of the string
; 
; output:    CX = length of string excluding the terminating NUL
;* * * * * * * * * * * * * *

	PUBLIC	STRLEN1
STRLEN1	PROC	FAR
	apush	ax,di,es,ds
	pop	es			;set es = ds
	cld
	mov	di,si
	sub	al,al			;set al=0
	mov	cx,-1
	repnz	scasb
	not	cx
	dec	cx
	apop	es,di,ax
	retf
STRLEN1	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STRLEN2 - finds length of a ASCII string at DS:DI
;
; inputs:    DS:[DI] = address of the string
; 
; output:    CX = length of string excluding the terminating NUL
;* * * * * * * * * * * * * *

	PUBLIC	STRLEN2
STRLEN2	PROC	FAR
	apush	ax,di,es,ds
	pop	es			;set es = ds
	cld
	sub	al,al			;set al=0
	mov	cx,-1
	repnz	scasb
	not	cx
	dec	cx
	apop	es,di,ax
	retf
STRLEN2	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STRLEN3 - finds length of a ASCII string at DS:BX
;
; inputs:    DS:[BX] = address of the string
; 
; output:    CX = length of string excluding the terminating NUL
;* * * * * * * * * * * * * *

	PUBLIC	STRLEN3
STRLEN3	PROC	FAR
	apush	ax,di,es,ds
	pop	es			;set es = ds
	cld
	mov	di,bx
	sub	al,al			;set al=0
	mov	cx,-1
	repnz	scasb
	not	cx
	dec	cx
	apop	es,di,ax
	retf
STRLEN3	ENDP
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
