	PAGE	66,132
;******************************** PARSE.LIB ***********************************
;
; PARSE_FIRST  - Parse first argument from command line
; PARSE_NEXT   - Parse next argument from command line
;
;------------------------------------------------------------------------------

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	extrn	DEC_STR_TO_DWORD:far
	extrn	lib_info:byte
;----------------------------------------------------------------------------

parse_ptr	dw	81h
parameter_length dw	0	;length of last parameter found

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  PARSE  )
PARSE_FIRST - parse first arguement from command line
;
; inputs: es:di = location to store parsed string
; 
; output: es:di = (unchanged) parsed string ptr
;	      cx = length of parsed string (0=no more parameters available)
;	bh,dx,ax   are set as specified by the flag value in -bh-
;	      bh = 0 - end of parameters
;                 1 - single alpha parameter was found of form "\x". The
;                     "x" character was placed in register -bl-
;                2 - single numeric parameter was found of form "\n". The
;                     "n" binary value was placed in register -bl-
;                3 - compound alpha parameter of form "\x:yyyy" was found.
;                     register -bl- has "x" character.
;                 4 - compound numeric parameter of form "\x:nnnn" was found.
;                     register -bl- has "x" character, dx,ax has value of nnnn
;                 5 - found alpha string of form "\xxxxx"
;                 6 - found value of form "\nnnn".  The decimal value of
;		       nnnn was placed in registers dx,ax
;                 7 - found alpha string of form "xxxx"
;                 8 - found numeric string of form "nnnn".  The decimal
;		       value of nnnn was placed in registers dx,ax
;
;* * * * * * * * * * * * * *

	PUBLIC	PARSE_FIRST
PARSE_FIRST	PROC	FAR
	mov	cs:parse_ptr,81h	;start parse at beginning
PARSE_FIRST	ENDP

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  PARSE  )
PARSE_NEXT - parse next command line parameter
;
; inputs:  (see PARSE_FIRST)
; 
; outputs: (see PARSE_FIRST)
;* * * * * * * * * * * * * *

	PUBLIC	PARSE_NEXT
PARSE_NEXT	PROC	FAR
	apush	si,di,bp,ds,es
	cld
	mov	ds,cs:lib_info.psp_seg
	mov	si,cs:parse_ptr
	mov	cx,0				;set parameter lenght to zero
;
; registers: es:di = callers storage buffer
;	     ds:si = command line parameter ptr
;		cx = 0
;
parse_01:
	lodsb					;get next parameter
	cmp	al,0dh
	je	parse_no_more			;jmp if no parameters
        cmp     al,' '
	je	parse_01			;jmp if leading space (ignore)
	cmp	al,09
	je	parse_01			;jmp if tab (ignore)
;
; the character in -al- is valid, move string to callers buffer.
;
	push	si
	push	di
parse_02:
	stosb
	inc	cx
	lodsb
        cmp     al,' '
	je	parse_10			;jmp if end of string found
	cmp	al,0dh
	je	parse_10			;jmp if end of string found
        cmp     al,'\'                          ;
	je	parse_10			;jmp if next string found
	cmp	al,09h				;tab?
	jne	parse_02			;jmp if string is still valid
;
; the next string has now been placed in the callers buffer, next begin decode
;
parse_10:
	mov	cs:parse_ptr,si
	mov	cs:parameter_length,cx
	mov	byte ptr es:[di],0		;put zero at end of string
	pop	di
	pop	si
	dec	si				;move back to string start
;
; registers = ds:si - start of parameter
;
	mov	al,byte ptr [si]		;get initial char. again
        cmp     al,'\'                          ;check if flag type char.
	je	parse_slash			;jmp if slash first char
;
; this string is either an alpha string or numeric string, determine which
;
	call	DEC_STR_TO_DWORD
	jc	parse_alpha		       ;jmp if alpha found
;
; we have a numeric string of form "nnnn'.  The value is in dx,ax
;
	mov	bh,8
	jmp	parse_exit
;
; we have a alpha string of form "xxxx".
;
parse_alpha:
	mov	bh,7
	jmp	parse_exit
;
; we have found an "\" at the beginning of this parameter, decode
;  ds:si - point at "\"
;
parse_slash:
        inc     si                      ;move past "\"
;
; check if single character after slash
;
	mov	al,byte ptr [si+1]	;get second char. of string
        cmp     al,' '
        je      single_char             ;jmp if parsing "\x"
	cmp	al,09
        je      single_char             ;jmp if parsing "\x"
	cmp	al,0dh
        je      single_char             ;jmp if parsing "\x"
        cmp     al,'\'
        je      single_char             ;jmp if parsing "\x"
;
; this parameter is of form "\xxxx" or "\x:yyyy"
;
        cmp     al,':'
        je      flag_plus               ;jmp if parsing "\x:xxxx"
;
; this parameter is of form "\xxxx", check if numeric or alpha
;
	call	DEC_STR_TO_DWORD
        jc     slash_alpha             ;jmp if parsing alpha "\xxxx"
;
; this parameter numeric of form "\nnnn".  dx,ax has value of nnnn
;
	mov	bh,6
	jmp	parse_exit
;
; this parameter is alpha of form "\xxxx"
;
slash_alpha:
	mov	bh,5
	jmp	parse_exit
;
; this parameter is of form "\x:xxxx" check if alpha or numeric
;
flag_plus:
	mov	bl,byte ptr [si]	;put flag in register -bl-
        add     si,2                    ;move past "x:"
	call	DEC_STR_TO_DWORD
	jc	colin_alpha
;
; this parameter is of form "\x:nnnn".  The value nnnn is in dx,ax
;
	mov	bh,4
	jmp	parse_exit
;
; this parameter is of form "\x:yyyy".  The yyyy is an alpha string
;
colin_alpha:
	mov	bh,3
	jmp	parse_exit
;
; we are parsing "\x".  Check if alpha or binary
;
single_char:
	call	DEC_STR_TO_DWORD
	jc	single_alpha
;
; we are parseing "\n"
;
	mov	bl,al				;put value in register -bl-
	mov	bh,2
	jmp	parse_exit
;
; we are parsing "\x"
;
single_alpha:
	mov	bl,byte ptr [si]
	mov	bh,1
	jmp	parse_exit

parse_no_more:
	mov	bh,0
parse_exit:
	mov	cx,cs:parameter_length
	apop	es,ds,bp,di,si
	retf
PARSE_NEXT	ENDP
;------------------------------------------------------------------------------

LIBSEG	ENDS
	end
