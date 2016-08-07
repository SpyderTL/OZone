	page	66,132
;****************************** SHRINK3.ASM  *********************************
		extrn	dos_mem_allocate:far
		extrn	dos_mem_release:far

		public	decompress


CLEAR		equ	256
EOF		equ	257
FIRST_FREE	equ	258
BUFFSIZE	equ	4096		;

hash_rec	struc
next	dw	?			; prefix code
char	db	?			; suffix char
hash_rec	ends

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
.list
;----------------------------------------------------------------------------

data_	struc
feed_process	dd	?
store_process	dd	?

cur_code	dw	?	;?
old_code	dw	?	;?
in_code		dw	?	;?
max_code	dw	?
fin_char	db	?	;?


feed_buffer	db	BUFFSIZE dup (?)
feed_ptr	dw	?
feed_available	dw	?
partial_bit_count dw	?
nbits		dw	?

store_buffer	db	BUFFSIZE dup (?)

hash		db	20480 dup (?)
data_	ends
;------------------------------------------------------------------------
LIBSEG           segment byte public 'LIB'
	assume	CS:LIBSEG,DS:nothing, ES:nothing

masks		dw	1ffh,3ffh,7ffh,0fffh

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(COMPRESS )
decompress - decompress data block using limpel-ziev algorithm
;
; inputs:  es:si = feed proceedure ptr
;          es:di = store proceedure ptr
;          dx,ax = size of block of data to be compressed
;
; output:  If carry returned then, insufficent
;          Normal operation is results in:
;
;          The feed proceedure is called with:  ds:dx = buffer area
;                                                  ax = request byte count
;          The feed proceedure returns:  ax = byte count of data placed in
;                                             buffer.
;
;          The store proceedure is called with:  ds:dx = buffer pointer
;                                                   ax = buffer size
;
; note:  The feed proceedure is called whenever the compress module runs
;        out of data.  The store module is called whenever more data is
;        needed.  Normally, the feed and store data uses a disk file, but
;        if room it could be placed in memory.
;        The feed and store modules must restore any registers they
;        modify.  Specifically, si,di,bp,ds,es
;
; note:  compress and decompress work together and the functions
;        shrink and expand work together.  Compress and decompress
;        are much faster and smaller code, but do not produce quite
;        as good compression.
;
;                       execution time          code size
;                       ---------------         ----------
;        compress            1.75                  430
;        decompress           .87                  381
;
;        shrink             10.05                  1447
;        expand              1.54                  1447       
;* * * * * * * * * * * * * *


decompress	proc	far
	push	es
	mov	dx,0
	mov	ax,size data_
	call	dos_mem_allocate
	mov	ax,es
	mov	ds,ax
	pop	es
	jc	error_exit
        mov	word ptr ds:[feed_process],si
        mov	word ptr ds:[store_process],di
        mov	word ptr ds:[feed_process+2],es
        mov	word ptr ds:[store_process+2],es
        mov	es,ax
;
; setup the buffer ptrs
;
	mov	ds:[feed_ptr],offset feed_buffer
	mov	ds:[feed_available],0
	mov	di,offset store_buffer
	mov	ds:[partial_bit_count],0
	call	init_tab
	jmp	lp1
;
; flush remaining data in buffer
;
compress_done:
	call	flush_outbuf
	call	dos_mem_release
	clc
error_exit:
    	retf				;done
;
; clear code was found, restart table
;
clear_found:
	call	init_tab		;Initialize table
	call	read_code		;Read next code
	mov	ds:[cur_code],ax		;Initialize variables
	mov	ds:[old_code],ax
	mov	ds:[fin_char],al

	stosb
	cmp	di,offset store_buffer + BUFFSIZE
	jb	lp1			;jmp if room in buffer
	call	flush_outbuf
	
lp1:   	call	read_code		;Get a code
	cmp	ax,EOF			;End of file?
	je	compress_done
	cmp	ax,CLEAR		;Clear code?
	je	clear_found		; jmp if clear code
	xor	cx,cx			;clear stacked char count
	mov	ds:[cur_code],ax		;Save new code
	mov	ds:[in_code],ax
	cmp	ax,bp			;bp=free_code,Code in table?
	jl	process_code		;yes
	 mov	dx,ds:[old_code]		;get previous code
	 mov	ds:[cur_code],dx		;make current
	 mov	al,ds:[fin_char]		;get old last char
	 push	ax			;push it
	 inc	cx			;stack_count
	 mov	ax,dx			;set ax=cur_code
process_code:
	cmp	ax,255			; Code or character?
	jle	process_char		;Char
	 mov	bx,ax			; Convert code to address
;
; index into hash table
;
	shl	bx,1			;bp = bx
	add	bx,ax			;bx = bx * 2 + bp
	add	bx,offset hash		; add in hashtable base offset

	 mov	al,[bx.char]		;Get suffix char
	 push	ax			;push it
	 inc	cx			;stack_count
	 mov	ax,[bx]			;Get prefix code
	 jmp	process_code		;Translate again

flush:	call	flush_outbuf
	jmp	wc_test
	
process_char:
	mov	ds:[fin_char],al	;Save as final
wc_lp:	stosb
	cmp	di,offset store_buffer + BUFFSIZE
	jae	flush			;jmp if buffer full

wc_test:jcxz	add_cod			;jmp if stack empty
	pop	ax
	dec	cx
	jns	wc_lp			;this should alway jump
;
; add_code - add code to table
;  inputs:  fin_char = data to add
;                bx = code
;
add_cod:mov	bx,bp			;bx = bx * 3 (3 byte entries)
	shl	bx,1			;
	add	bx,bp			;bx = bx * 2 + bp
	add	bx,offset hash		; add in hashtable base offset
	mov	al,ds:[fin_char]
	mov	[bx].char,al		;save it
	mov	ax,ds:[old_code]	;get prefix code
	mov	[bx].next,ax		;save it
	inc	bp			;bp=free_code,	;set next code

	mov	ax,ds:[in_code]		;Save input code
	mov	ds:[old_code],ax
	cmp	bp,ds:[max_code]	;bp=free_code, hit table limit?
	jl	lp1  			;Less means no
	cmp	ds:[nbits],12		;Still within twelve bits?
	je	lp1  			;no (next code should be clear)
	inc	ds:[nbits]		;Increase code size
	shl	ds:[max_code],1		;Double max code
      	jmp	lp1			;Get next code
decompress	endp	
;--------------------------------------------------------------------------
; read_code - get bits from input
;  inputs:  nbits = number of bits to get
;  output:  ax = data
;
read_code:
	cmp	ds:[feed_available],3
	jb	fill_inbuf
;
; compute ptr update
;
rc1:	mov	ax,ds:[partial_bit_count]
	add	ax,ds:[nbits]
	mov	cx,8
	xor	dx,dx				;clear dx
	div	cx
	mov	si,ds:[feed_ptr]			;get current feed_ptr
	add	ds:[feed_ptr],ax			;update feed ptr in memory
	sub	ds:[feed_available],ax
	xchg	ds:[partial_bit_count],dx
;
; get data from buffer
;
	lodsw
	mov	bx,ax
	lodsb
;
; position data
;
	mov	cx,dx
	jcxz	rd2			;jmp if no positioning needed
rd1:	shr	al,1
	rcr	bx,1
	loop	rd1
;
; used nbits to isolate correct number of bits
;
rd2:	mov	ax,bx
	mov	bx,ds:[nbits]
	sub	bx,9
	shl	bx,1
	and	ax,cs:masks[bx]
rc_exit:ret

; fill_inbuf - fill the input buffer

fill_inbuf:
	apush	bx,di
	mov	cx,ds:[feed_available]
	mov	di,offset feed_buffer
	mov	si,ds:[feed_ptr]
	mov	ds:[feed_ptr],di		;feed ptr = offset feed_buffer
	jcxz	fi_1				;jmp if buffer empty
	rep	movsb
fi_1:	mov	dx,di
	mov	ax,BUFFSIZE -3
	call	dword ptr ds:[feed_process]
fill_ok:add	word ptr ds:[feed_available],ax	
	apop	di,bx
	jmp	rc1
;--------------------------------------------------------------------------
; flush_outbuf - ship the full buffer off to caller
;  inputs: di = current store ptr
;  output: none
;
flush_outbuf:
	mov	ax,di				;store_ptr to -ax-
	mov	dx,offset store_buffer
	sub	ax,dx				;compute flush size
	jz	fo_done				;jmp if no data in buffer
	mov	di,dx
	call	dword ptr ds:[store_process]
fo_done:ret
;--------------------------------------------------------------------------
; init_tab - initialize table pointers
;
init_tab:
	mov	ds:[nbits],9			;Initialize variables
	mov	ds:[max_code],512
	mov	bp,FIRST_FREE		;free_code = FIRST_FREE
	ret
;-----------------------------------------------------------------------
LIBSEG	ENDS

;;	end
