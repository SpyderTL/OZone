	page	66,132
;******************************** STR32.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	strlen1:far
	extrn	strlen2:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_INSERT - inserts string1 in string2 at specified offset.
;
; inputs:    DS:[SI] pointing to string1
;            ES:[DI] pointing to string2
;            AX = offset in string2 to insert string1
;            
; output:  none
;
; note:  The buffer containing string2 must be large enough for
;        expansion to the size of string1 plus string2.
;* * * * * * * * * * * * * *

	PUBLIC	STR_INSERT,STR_INSERTC
STR_INSERT	PROC	FAR
        APUSH   AX,BX,CX,DX,SI,DI,BP
	call	strlen1		;
	jmp	str_entry
STR_INSERT	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( STRING  )
STR_INSERTC - inserts string1 in string2 at specified offset.
;
; inputs:    DS:[SI] pointing to string1
;            ES:[DI] pointing to string2
;            AX = offset in string2 to insert string1
;            CX = length of string1
;            
; output:  none
;
; note:  The buffer containing string2 must be large enough for
;        expansion to the size of string1 plus string2.
;* * * * * * * * * * * * * *


STR_INSERTC	proc	far
        APUSH   AX,BX,CX,DX,SI,DI,BP
str_entry:
	mov	dx,cx		;save length of string1
	call	strlen2
	mov	bp,cx		;save length of string2
;
; make a hole in string2
;
	push	ds		;save string1 seg
	push	si		;save string1 start

	push	es
	pop	ds
	
	add	di,bp		;di points at end of string2
	mov	si,di		;both si & di point at end of string2
	add	di,dx		;di points at end of new string
	std
	sub	cx,ax		;length of move 
	rep	movsb		;make hole, cx=len of string2
;
; ds:si now points at start of hole in string2
; dx= string1 length  bp=string2 length
;
	mov	di,si		;di now points at start of hole
	inc	di
	cld
	pop	si		;si now points at start of string1
	pop	ds		;ds now points at string1 seg
	mov	cx,dx		;get length of string1
	rep	movsb		;insert string1
    APOP    BP,DI,SI,DX,CX,BX,AX
    RETF
STR_INSERTC	ENDP


LIBSEG	ENDS
	end
