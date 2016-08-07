	PAGE	66,132
;****************************** MEMORY3.ASM *********************************
;
;----------------------------------------------------------------------------
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	stdout_string:far
.list
;----------------------------------------------------------------------------

MCB	STRUC
  mcb_code1	db	0		;4d=start 5a=end
  prog_seg1	dw	0		;program segment
  mcb_len1	dw	0		;length of memory ctrl	block
MCB	ENDS

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
MCB_FIND_FIRST - scan for start of MCB chain
;  inputs: none
;  outputs: if no carry, then   es:0 points at MCB chain
;           if carry then mcb chain is bad
;
;  note:  This routine scan for the MCB chain, rather than look in
;         the DOS database.  For some implementations of brain
;         damaged DOS, the scan works better.
;* * * * * * * * * * * * * *

current_mcb_seg	dw	0

	public	MCB_FIND_FIRST
MCB_FIND_FIRST	proc	far
	apush	ax,bx,di
	mov	current_mcb_seg,50h			;start search at 50:0
	mov	es,current_mcb_seg
	sub	di,di
d_find1:
	cmp	es:[di.mcb_code1],4dh
	je	d_find3			;jump if possible start
d_find2:
	mov	ax,es
	inc	ax
	mov	es,ax			;move to next paragraph
	cmp	ax,0A000h
	jae	mcb_chain_bad
	jmp	d_find1			;loop till trial start found
d_find3:
	mov	current_mcb_seg,es	;save trial start
d_find4:
	mov	bx,es
	add	bx,es:[di.mcb_len1]	;conpute next mcb position
	cmp	ax,bx			;check if segment changed
	jae	d_find2			;try again if new segment is wrong
	inc	bx			;move	forward	one paragraph
	mov	es,bx
	cmp	es:[di.mcb_code1],4dh	;check if next mcb is ok
	je	d_find4			;jump if mcb ok
	cmp	es:[di.mcb_code1],5ah	;check if last mcb
	je	d_find5			;jump if end of chain found
;
; bad code found, this must not	be the real mcb	chain
;
d_find4a:
	mov	es,current_mcb_seg
	jmp	d_find2
;
; we could not find the MCB chain by searching, ask DOS
;
mcb_chain_bad:
	mov	ah,52h			;get ptr to DOS lists
	int	21h			;  in es:bx
	mov	es,es:[bx-2]		;get mcb pointer from list
	stc
	jmp	mff_exit
;
; end of chain found ok
;
d_find5:
	mov	es,current_mcb_seg	;restore ptr to start of mcb chain
	clc
mff_exit:
	apop	di,bx,ax
	retf
MCB_FIND_FIRST	endp


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
MCB_FIND_NEXT - scan for next MCB entry
;  inputs: ES:0 points at current MCB
;           if no carry then, es:0 point at next mcb
;           if carry then this is last mcb
;
;* * * * * * * * * * * * * *


	public	MCB_FIND_NEXT
MCB_FIND_NEXT	proc	far
	push	bx
	mov	bx,es
	add	bx,es:[mcb_len1]	;conpute next mcb position
	inc	bx			;move	forward	one paragraph
	mov	es,bx
	cmp	byte ptr es:[0],4dh	;signature ok
	je	good_mcb
	stc
	jmp	mfn_exit		;jmp if bad mcb or end of chain
good_mcb:
	clc
mfn_exit:
	pop	bx
	retf
MCB_FIND_NEXT	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
MCB_CHECK_NAME - compare current MCB name against list of names
;  inputs: ES:0 points at current MCB
;          DS:SI points at compare list, asciiz strings each terminated
;                with zero, the list is terminated with zero also.  Thus
;                end of list is two zeros in a row.
;  output: carry set if match, and ds:si point at match name
;
;* * * * * * * * * * * * * *

cmp_list	dd	0

	public	MCB_CHECK_NAME
MCB_CHECK_NAME	proc	far
	mov	word ptr cmp_list,si
	mov	word ptr cmp_list+2,ds
	
	call	mcb_find_name			;look in mcb for program name
	jnc	mcb_srch_cont			;jmp if name not found
	call	compare_name
mcb_srch_cont:
	retf
MCB_CHECK_NAME	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
MCB_FIND_NAME - scan current mcb to see if name is present
;  inputs:  es:0 is mcb
;  output:  carry set if name found and es:di points at name
;
;* * * * * * * * * * * * * *

;
	public	MCB_FIND_NAME
MCB_FIND_NAME	proc	far
	mov	ax,es:[mcb_len1]		;get paragraph size of mcb
	cmp	ax,4096/16			;check if mcb too big for envior
	jae	fn_no_name			;jmp if no name found
	mov	cl,4
	shl	ax,cl				;convert to byte size
	mov	cx,ax				;set loop count
	mov	di,16				;start scan from loc. 16
fn_scan_lp:
	cmp	word ptr es:[di],0
	jne	fn_nxt_loc
	cmp	word ptr es:[di+2],0001
	je	fn_name_ck			;jmp if possible name start
fn_nxt_loc:
	inc	di
	loop	fn_scan_lp			;loop till name start fnd
	jmp	fn_no_name			;jmp if name not found
;
; we have found 00,00,01,00 now verify a name is present
;
fn_name_ck:
	add	di,4				;move past 00,00,01,00
	cmp	byte ptr es:[di],20h
	jb	fn_no_name			;jmp if name is illegal
	cmp	byte ptr es:[di],80h
	jae	fn_no_name			;jmp if name is illegal
	
;
; verify a zero is at end of name
;
	mov	cx,45				;max path size
	dec	di				;adjust for pre increment
fn_zero_scan:
	inc	di
	cmp	byte ptr es:[di],0
	je	fn_fnd_zero			;jmp if expected zero found
	cmp	byte ptr es:[di],20h
	jb	fn_no_zero			;jmp if name is illegal
	cmp	byte ptr es:[di],80h
	jae	fn_no_zero			;jmp if name is illegal
	loop	fn_zero_scan
fn_no_zero:
	jmp	fn_no_name			;jmp if no zero at end of name
;
; we have found 00,00,01,00 followed by what appears to be a valid name
; scan back till start of name found
;
fn_fnd_zero:
	dec	di
	cmp	byte ptr es:[di],0
	je	fn_name_strt
	cmp	byte ptr es:[di],'\'
	je	fn_name_strt
	cmp	byte ptr es:[di],':'
	jne	fn_fnd_zero
;
; es:di now points at start of name -1
;
fn_name_strt:
	inc	di				;move to name start
	stc
	jmp	fn_exit
fn_no_name:
	clc
fn_exit:
	retf
MCB_FIND_NAME	endp
;---------------------------------------------------------------------------
; compare name in mcb to list at cmp_list
;  inputs: es:di points at mcb name
;  output: carry set if match, and ds:si point at match name
;
mcb_name_ptr	dw	0

compare_name:
	push	ds
	mov	mcb_name_ptr,di
	lds	si,cmp_list
	cld
cn_loop:
	mov	al,byte ptr es:[di]		;get mcb char.
	cmp	al,'Z'
	jb	cn_upper
	sub	al,20h				;convert to upper case
cn_upper:
	cmp	al,byte ptr ds:[si]
	jne	cn_miscompare			;jmp if different
	cmp	al,0
	je	cn_match			;jmp if name matches
	inc	si
	inc	di
	jmp	cn_loop				;loop till all of name compared
;
; we have a miscompare, check if more entries on list
;    ds:si points at compare table
;    es:di points at mcb name
;
cn_miscompare:
	mov	di,mcb_name_ptr			;restore di
	cmp	byte ptr ds:[si],0		;check if end of name
	je	cn_name_end
	inc	si
	jmp	cn_miscompare			;loop till end of name
cn_name_end:
;
; scan past second name of matched pair
;
cn_miscompare2:
	mov	di,mcb_name_ptr			;restore di
	cmp	byte ptr ds:[si],0		;check if end of name
	je	cn_name_end2
	inc	si
	jmp	cn_miscompare2			;loop till end of name
cn_name_end2:
;
; check if end of compare list
;
	inc	si				;move to start of next name
	cmp	byte ptr ds:[si],0
	jne	cn_loop				;loop if another name on list
	clc
	jmp	cn_exit				;jmp if no matches
cn_match:
	inc	si				;move to start of match name
	stc
cn_exit:
	mov	di,mcb_name_ptr			;restore -di-
	pop	ds
	ret

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
MCB_DISPLAY_NAME - display program name if associated with current mcb
;  inputs: ES:DI - points at name in MCB
;  outputs: none
;
; note: name is display at the cursor position.
;* * * * * * * * * * * * * *


	public	MCB_DISPLAY_NAME
MCB_DISPLAY_NAME	proc	far
	apush	si,ds
	mov	si,di
	push	es
	pop	ds
;
; display match name
;
	call	stdout_string
	apop	ds,si
	retf
MCB_DISPLAY_NAME	endp


LIBSEG	ENDS
;;	end
