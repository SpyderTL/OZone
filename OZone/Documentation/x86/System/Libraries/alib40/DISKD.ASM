	page	66,132
;******************************** DISKD.ASM  *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
CHANGE_PATH - switch to new directory, but save current path first
;
; inputs:  es:bx - points to new path
; 
; outputs: old_path has origional path
;	    carry set if dos error
;* * * * * * * * * * * * * *

old_path	label	byte
old_drive	db	0
		db	':'
old_sep		db	'\'
		db	40 dup (0)

new_path	label	byte
		db	40 dup (0)
;--------------------------------
	public	change_path		
CHANGE_PATH	PROC	FAR
	push	ds
	mov	ah,19h
	int	21h		;get current drive# in -al-
        add     al,'A'
	mov	cs:old_drive,al
;
; save current path
;	
	mov	ax,cs
	mov	ds,ax
	mov	si,offset old_sep+1
	mov	ah,47h
	mov	dl,0
	int	21h		;get current path -> ds:si
;
; check if drive present
;
	cmp	byte ptr es:[bx+1],':'
	je	cp_drv_fnd		;jmp if drive found
	mov	si,bx
        cmp     byte ptr es:[bx],'\'
	je	cp_path_fnd		;jmp if path without drive found
	clc				;do not return error, this is probably
					; the debugger RUN.COM
	jmp	change_path_exit	;exit if drive not present
;
; switch to new drive at es:bx
;
cp_drv_fnd:
	mov	dl,es:[bx]	;get drive letter
	sub	dl,'A'
	mov	ah,0eh
	int	21h		;switch to new drive
;
; switch to new path, but first extract info. from es:bx+1
;
	mov	si,bx
	add	si,2			;skip past drive
cp_path_fnd:
	mov	di,offset new_path
        cmp     byte ptr es:[si],'\'
	je	mp_loop			;jmp if directory present
	mov	word ptr ds:[di],004ch
	jmp	do_path_change
mp_loop:
	mov	al,byte ptr es:[si]
	mov	byte ptr ds:[di],al
	inc	si
	inc	di
	cmp	al,0
	jne	mp_loop
;
; now scan back and remove executable file name
;
mp_bak: dec	di
        cmp     byte ptr [di],'\'
	jne	mp_bak
	mov	byte ptr [di],0

do_path_change:
	mov	ah,3bh
	mov	dx,offset new_path
	int	21h
change_path_exit:
	pop	ds
	retf	
CHANGE_PATH	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
RESTORE_PATH - switch to directory saved by CHANGE_PATH
;
; inputs: none
; 
; output: carry set if dos error
;* * * * * * * * * * * * * *

	public	restore_path
RESTORE_PATH	PROC	FAR
	mov	dl,cs:old_path
	cmp	dl,0
	je	rp_path_switch		;jmp if drive not present
	sub	dl,'A'
	mov	ah,0eh
	int	21h			;switch drives
;
; switch paths
;
rp_path_switch:
	push	ds
	mov	ax,cs
	mov	ds,ax
	cmp	old_sep,0
	je	rp_exit			;jmp if no path avail
	mov	dx,offset old_sep
	mov	ah,3bh
	int	21h

rp_exit:
	pop	ds
	retf
RESTORE_PATH	 ENDP

LIBSEG	ENDS
	end
