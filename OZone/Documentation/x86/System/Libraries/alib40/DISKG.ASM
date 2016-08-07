	page	66,132
;******************************** DISKB.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	find_home_path:far
	extrn	scan_last_char3:far
	extrn	strlen1:far
.list
;----------------------------------------------------------------------------
	extrn	strlen2:far
	extrn	lib_info:byte
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
INSERT_HOME_PATH - find the full path and filename of the executing program
;
; inputs:    ds:si = pointer to file name asciiz string.
;            es:di = pointer to buffer for constructed path.
; output:    none 
;
; note:      this function is useful to access files with are located
;            with an executable.  The path of the executable file is
;            inserted in front of the file name and placed in the buffer
;            provided.  If the disk drive letter is found, it is also
;            included.
;* * * * * * * * * * * * * *

	public	INSERT_HOME_PATH
INSERT_HOME_PATH	PROC	FAR
	apush	ax,bx,cx,si,di,ds,es
	apush	si,di
	call	find_home_path		;returns es:di = ptr cx=length
	push	di			;save path start
	mov	al,'\'
	call	scan_last_char3
	mov	bx,di			;save ptr to last '\'
	pop	si			;get ptr to path
	pop	di			;get storage buffer offset
	jcxz	ihp_1			;jmp if zero length path
ihp_lp:	mov	al,byte ptr es:[si]
	mov	byte ptr ds:[di],al
	inc	si
	inc	di
	cmp	si,bx			;move done?
	jbe	ihp_lp			;loop till done
ihp_1:	push	ds
	pop	es
	pop	si			;get filename asciiz
	call	strlen1
	rep	movsb
ihp_exit:
	apop	es,ds,di,si,cx,bx,ax
	retf
INSERT_HOME_PATH	ENDP

LIBSEG	ENDS
;;	end
