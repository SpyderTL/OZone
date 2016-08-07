	page	66,132
;******************************** DISKE.ASM  *********************************

		public	walk_path

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	extrn	expand_filename:far
.list
;----------------------------------------------------------------------------
LocalAlloc	equ	2ch		;size of DTA for stack allocation

filename	db	128 dup (0)
UpOneLevel	db	"..",0
FileMask	db	13 dup (0)
process		label	dword
process_offset	dw	0
process_seg	dw	0

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  DISK   )
;walk_path - compress data block
;
; inputs:  ds:si = pointer to asciiz file mask
;          ax    = pointer to processing for each file match.
;                  This must be a FAR routine with same CS as calling
;                  program.
;          cx    = file attributes to match.
;                  0000 - match normal data files
;                  0001 - find read only files
;                  0002 - find hidden files
;                  0004 - find system files and directories
;                  0008 - find volume labels
;                  0010 - walk subdirectories also
;
;                  note: attributes may be combined in some cases.
;
; output:  The feed proceedure is called with:  es:di = ptr to file found.
;          The file name found is fully quailfied and includes drive.
;          The current directory is where the match file was found.
;
;          After all files are processed walk_path exits with all regiseters
;          restored.
;
; note:  The path walk starts with the current directory and includes each
;        subdirectory found.
;* * * * * * * * * * * * * *

walk_path         proc     far
	apush	ax,bx,cx,dx,si,di,bp,ds,es
	mov	bp,sp
	mov	cs:process_offset,ax
	mov	ax,word ptr [bp+20]		;get callers cs
	mov	cs:process_seg,ax
;
; copy file mask from ds:si to cs:FileMask
;
	cld
	push	cs
	pop	es
	mov	di,offset FileMask
wp_lp1:
	lodsb
	stosb
	test	al,al
	jnz	wp_lp1
	push	cs
	pop	ds
	call	recursive_walk
	apop	es,ds,bp,di,si,dx,cx,bx,ax
        retf
walk_path         endp
;
;--------------------------------------------------------------------------
; recursive_walk - walk till out of files/directories.
;  inputs:  ds,es = our code/data segment
;           FileMask =  match mask in asciiz form.
;           Process  =  far ptr to processing routine           
;
recursive_walk:
	push	bp
        mov     ah,2Fh                  ;Get DTA address
        int     21h
        push    bx                      ;Save it on the stack
        push    es
        sub     sp,LocalAlloc           ;Allocate stack space
        mov     bp,sp                   ;Stack pointer in BP
        push	ss
        pop	ds
        mov     ah,1Ah                  ;Change DTA to location
        mov     dx,bp                   ;on the stack
        int     21h
;
	mov	ah,4eh			;DOS function (find first)	
rs_loop:				;mov cx,10h ;attribute = files & dir's
	mov	dx,offset FileMask
	push	cs
	pop	ds
	int	21h
	jc	exit			;jmp if end of this dir
	cmp	byte ptr [bp+1eh],'.'	;check if directory header
	je	tail			;jmp if header file
	test	byte ptr [bp+15h],10h	;check if directory entry
	jz	file_fnd		;jmp if not dir, and is file
;
; we have encountered a directory, switch to it and look for files
;
	mov	ah,3bh
	mov	dx,bp
	add	dx,30
	push	ss
	pop	ds	
	int	21h	

	push	bp
	call	recursive_walk
	pop	bp
;
; we are back from directory processing, restore origional dir.
;
	mov	ah,3bh
	mov	dx,offset UpOneLevel
	push	cs
	pop	ds
	int	21h
	jmp	tail
;
; we have found a file the caller wants to process
;
file_fnd:
	mov	si,bp
	add	si,30
	push	ss
	pop	ds

	push	cs
	pop	es	
	mov	di,offset filename
move_it:
	lodsb
	stosb
	cmp	al,0
	jne	move_it

	mov	si,offset filename
	push	es
	pop	ds
	call	expand_filename
	mov	di,si

	call	process

tail:	mov	ah,4fh
	jmp	rs_loop	
;
; restore origional DTA from stack.
;
exit:	add	sp,LocalAlloc	;deallocate stack space
	
	mov	bx,ds
	mov	ah,1ah		;restore previous DTA
	pop	ds
	pop	dx
	int	21h
	mov	ds,bx
	pop	bp
	ret
	
	
LIBSEG	ENDS
;;	end	