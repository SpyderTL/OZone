	page	66,132
;******************************** MKEY09.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	key_if_ready:far
	extrn	lib_info:byte
	extrn	breakflag:byte
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
FLUSH_KEYBOARD - clears the keyboard's 'type-ahead' buffer
;
; inputs:  none
; output:  none
;* * * * * * * * * * * * * *

	PUBLIC	FLUSH_KEYBOARD
FLUSH_KEYBOARD	PROC	FAR
    call    KEY_IF_READY	;returns 0=no key  1=KEY_CHECK
    OR      AX,AX
    JNZ     FLUSH_KEYBOARD
    RETF
FLUSH_KEYBOARD	ENDP


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
KEY_CHECK - check if a key is waiting in the keyboard buffer.
;
; inputs:    none
; 
; output:    AX = 0 if no key waiting
;            AX = 1 if key waiting
;            
; note:      if key is found in buffer it is left there and the AX register
;            is set to one.
;* * * * * * * * * * * * * *

	PUBLIC	KEY_CHECK
KEY_CHECK	PROC	FAR
	cmp	cs:breakflag,0
	je	kwa_cont
	mov	ax,3
	jmp	kwa_exit
kwa_cont:	
	mov	ah,11h			;preload code for enhanced keyboard
	cmp	lib_info.key_type,0	;check if old style keyboard
	jne	kwa_read		; jmp if enhanced keyboard
	mov	ah,01			;get code for old style keyboard
kwa_read:
	int	16h
	mov	ax,0
	jz	kwa_exit		;jmp if no key waiting
	inc	ax
kwa_exit:
	retf	
KEY_CHECK	ENDP
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(MOUSE/KEY)
KEY_READ - returns next key pressed
;
; inputs:  none
; output:    if AH = 0  AL = ASCII key code
;            if AH = 1  AL = scan code
;* * * * * * * * * * * * * *

	PUBLIC	KEY_READ
KEY_READ	PROC	FAR
key_wait:    
    call   KEY_CHECK
    cmp     cs:breakflag,0
    jne     break_occured		;jmp if break key
    or      ax,ax
    jz	key_wait			;jmp if no key found
    	
KEY_READ1:
	mov	ah,10h			;preload code for enhanced keyboard
	cmp	lib_info.key_type,0	;check if old style keyboard
	jne	KEY_READ2			; jmp if enhanced keyboard
	mov	ah,0
KEY_READ2:	
	int	16h			;read the keyboard
	cmp	al,0e0h			;check if extended key flag
	jne	KEY_READ3			;  jmp if not extended key flag
	mov	al,0
KEY_READ3:
	cmp	al,0			;check if ascii is available for key
	jne	KEY_READ5			; jmp if ascii code present
	mov	al,ah			;put scan code in -al-
	mov	ah,1			;put flag in -ah-, scan code in -al-
	jmp	KEY_READ_exit
	
break_occured:
    mov     ax,0103h	;get code for ctrl-c
    jmp     KEY_READ_exit
KEY_READ5:
	mov	ah,0			;normal ascii in -al-, set flag
KEY_READ_exit:
	retf				
KEY_READ	ENDP

LIBSEG	ENDS
	end
