	page	66,132
;******************************** DISKC.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	strlen2:far
	extrn	lib_info:byte
	extrn	buffer_searchc:far
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
GET_PATH - search enviornment for start of path information string
;
; inputs:    nothing
; 
; output:     ES:DI = pointer to "PATH=" portion of path string.
;                CX = length of path
;
; note:  The path string consists of "PATH=" followed by path entries.
;        Each path entry is separated with ";" and the last one is
;        followed by a null character (00h).  ES:DI points at
;        the start of "PATH=".                 
;* * * * * * * * * * * * * *

path_string     db      'PATH=',0

	public	GET_PATH
GET_PATH	PROC	FAR
	mov	es,lib_info.psp_seg
	apush	ax,ds
	mov	es,word ptr es:[2ch]	;get enviornment seg
	mov	di,0

	push	cs
	pop	ds
	mov	si,offset path_string
			
	mov	cx,-1
	call	buffer_searchc		;scan for path, sets DI if found
	push	es
	pop	ds
	call	strlen2			;find string length -> cx	   
	apop	ds,ax
	retf
GET_PATH	ENDP

;------------------------------------------------------------------------

LIBSEG	ENDS
	end
