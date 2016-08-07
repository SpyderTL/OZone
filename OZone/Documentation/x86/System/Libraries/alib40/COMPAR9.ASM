	page	66,132
;******************************* COMPAR9.ASM ********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -( COMPARE )
;COMPARE9 - compares two characters, either case matches
;
; inputs:   ah = character 1
;           al = character 2
; 
;  output:    flag registers set for "je" "jne"
;             al = case of character may be changed.
;
;* * * * * * * * * * * * * *

	PUBLIC	COMPARE9
COMPARE9	PROC	FAR
	push	dx
	mov	dl,20h			;case flag
	call	compare
	pop	dx
	retf
COMPARE9	ENDP
;------------------------------------------------------------------------
; compare characters ignoring case
;  inputs:    al = character 1
;             ah = character 2
;             dl = 20h
;
;  output:    flag registers set for "je" "jne"
;             al = case of character may be changed.
;             dx = changed.
;
	public	compare
compare:   cmp	   al, ah		;match?
	   je	   c_exit		;jmp if match
	   mov	   dh, al		;try matching other
	   or	   dh, dl		;  case if char
           sub     dh, 'a'		;     is an alpha
           cmp     dh, 'z' - 'a' + 1
	   jnc	   not_alpha
	   xor	   al,dl
not_alpha: cmp     al, ah
c_exit:	   ret
;------------------------------------------------------------------------
; compare_strings - compare strings ignoring case
;  inputs: ds:si = string 1 (zero terminated string recognized)
;          es:di = string 1
;             cx = max string length
;  output: si,di,cx updated
;          ax changed
;          flags set for "je" or "jne"
;
	public	compare_strings
compare_strings:
	jcxz	cs_exit		;exit if out of data
	cld
	lodsb
	test	al,al
	je	cs_exit
	mov	ah,es:[di]
	inc	di
	call	compare
	je	compare_strings	;jmp if strings match
cs_exit:ret	
;------------------------------------------------------------------------

LIBSEG	ENDS
	end
