	page	66,132
;******************************** MKEY10.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
KEY_PUT - put key back into BIOS buffer
;
; inputs:  ax = key
; output:  none
; 
; Note: If keyboard buffer is full then the key will be ignored.
;* * * * * * * * * * * * * *

;-----------------------
key_head	equ	1ah		;next get location
key_tail	equ	1ch		;next put location
key_buf_top_ptr	equ	80h		;location of key buffer in seg 40h
key_buf_end_ptr	equ	82h		;location of key buffer end
;-----------------------
	public	key_put
KEY_PUT	proc	far
	apush	bx,ds
	mov	bx,40h				;setup
	mov	ds,bx				;  the segment
;
; check if room for another key, will key_tail + 2 = key_head?
;	
	mov	bx,word ptr ds:[key_tail]
	add	bx,2
	cmp	bx,word ptr ds:[key_buf_end_ptr]
	jb	KEY_PUT_1			;jmp if no overflow
	mov	bx,word ptr ds:[key_buf_top_ptr]
KEY_PUT_1:
	cmp	bx,word ptr ds:[key_head]	;check if head=tail (no room)
	je	KEY_PUT_exit			; jmp if no room
	push	bx				;save stuff ptr
;
; convert this key to bios format
;
	cmp	ah,0				;check if normal ascii key
	je	KEY_PUT_2			; jmp if normal ascii
	mov	ah,al				;put scan code back in -ah-
	mov	al,0				;put flag in -al-
KEY_PUT_2:		
;
; put this key at current tail location
;
	mov	bx,word ptr ds:[key_tail]
	mov	word ptr ds:[bx],ax		;store this key
	pop	bx
	mov	word ptr ds:[key_tail],bx	;store new tail
KEY_PUT_exit:
	apop	ds,bx
	retf	
KEY_PUT	endp		

LIBSEG	ENDS
	end
