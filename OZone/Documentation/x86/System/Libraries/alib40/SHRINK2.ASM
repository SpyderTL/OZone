	page	66,132
;******************************* SHRINK2.ASM *********************************
		extrn	dos_mem_allocate:far
		extrn	dos_mem_release:far

		public	compress


CLEAR		equ	256		;Clear code
EOF		equ	257		;End of file marker
FIRST_FREE	equ	258		;First free code
MAXMAX		equ	4096		;Max code + 1
BUFFER_SIZE	equ	1024

hash_rec	struc
first	dw	?			; First entry with this value
next	dw	?			; Next entry along chain
char	db	?			; Suffix char
hash_rec	ends
;----------------------------------------------------------------------------
.xlist
	include  mac.inc
.list
;--------------------------------------------------------------------

data_	struc

hash		db	20480 dup (?)

feed_process	dd	?
store_process	dd	?

feed_buffer	db	BUFFER_SIZE dup (?)	;buffer filled externally
feed_ptr	dw	?
feed_available	dw	?

store_buffer	db	BUFFER_SIZE dup (?)	;buffer filled internally
store_ptr	dw	?
partial_bit_count dw	?			;bits beyond store_ptr

prefix_code	dw	?
free_code	dw	?
max_code	dw	?
max_bits	dw	?
k		db	?

data_	ends
;----------------------------------------------------------------------------

LIBSEG           segment byte public 'LIB'
	assume	CS:LIBSEG,DS:nothing,ES:nothing
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(COMPRESS )
compress - compress data block using limpel-ziev algorithm
;  inputs:  es:si = feed function ptr
;           es:di = store function ptr
;
;  output:  feed function is called when data to be compressed is
;           needed. Feed uses the following parameters:
;           in: ds:dx = buffer ptr of size (BUFFER_SIZE)
;                  ax = requested amount
;           out:   ax = number of bytes placed in buffer, 0=end of input
;          
;           store function is called when a block of compressed data
;           is prepared. Store uses the following parameters:
;           in:  ds:dx = buffer ptr
;	            ax = amount of data present in buffer
;           out:  none
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


compress	proc	far
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
	mov	ds:[store_ptr],offset store_buffer
	mov	ds:[partial_bit_count],0
	
   	call	init_table		;Initialize the table and some vars
	mov	ax,CLEAR		;Write a clear code
	call	write_code
	call	read_char		;Read first char
c_lp1:	xor	ah,ah			;Turn char into code
c_lp2:	mov	ds:[prefix_code],ax		;Set prefix code
	call	read_char		;Read next char
	jc	c_end1			;Carry means EOF
	mov	ds:[k],al			;Save char in k
	mov	bx,ds:[prefix_code]		;Get prefix code
	call	lookup_code		;See if this pair in table
	jnc	c_lp2			;nc means yes, new code in ax
	call	add_code		;Add pair to table
;;	push	bx			;Save new code
	mov	ax,ds:[prefix_code]		;Write old prefix code
	call	write_code
;;	pop	bx
	mov	al,ds:[k]			;Get last char
	cmp	bx,ds:[max_code]		;Exceed code size?
	jl	c_lp1			;less means no
	cmp	ds:[max_bits],12		;Currently less than 12 bits?
	jl	c_tail			;yes
	 mov	ax,CLEAR		;Write a clear code
	 call	write_code
	 call	init_table		;Reinit table
	 mov	al,ds:[k]			;get last char
	 jmp	c_lp1			;Start over

c_tail:	inc	ds:[max_bits]			;Increase number of bits
	shl	ds:[max_code],1		;Double max code size
	jmp	c_lp1			;Get next char

c_end1:	mov	ax,ds:[prefix_code]		;Write last code
	call	write_code
	mov	ax,EOF			;Write EOF code
	call	write_code
	cmp	ds:[partial_bit_count],0
	je	c_end2
	inc	ds:[store_ptr]		;flush partial bits
c_end2:	call	flush_outbuf
	call	dos_mem_release
	clc
error_exit:
       	retf
compress	endp
;-----------------------------------------------------------------------
; write_code - build code for output
;  inputs:  ax = data
;           partial_bit_count = partial bits in last byte of buffer
;           nbits = number of bits to add
;           store_ptr = ptr into store_buffer
;  output: ax,cx,dx,si,di modified
;
write_code:
	mov	di,ds:[store_ptr]
	xor	dx,dx
	mov	cx,ds:[partial_bit_count]
	mov	si,cx			;save partial_bit_count
	jcxz	wc_out			;jmp if on even byte boundry
bit_lp:	shl	ax,1
	rcl	dx,1			;position new data
	loop	bit_lp
	or	al,byte ptr [di]	;merge in new bits
wc_out:	stosw				;store new data
	mov	byte ptr es:[di],dl	;store partial byte
;
; update ptr's
;
	xor	dx,dx
	mov	ax,ds:[max_bits]
	add	ax,si			;nbits + partial_bit_count
	mov	cx,8
	div	cx			;compute # new bytes stored
	mov	ds:[partial_bit_count],dx
	add	ds:[store_ptr],ax
;
; check if time to flush buffer
;
	cmp	di,offset store_buffer + (BUFFER_SIZE -4)
	jb	wc_done			;jmp if buffer ok
;
; buffer is close to full, flush it
;
	call	flush_outbuf
wc_done:ret

;------------------------------------------------------------------------
; read_char - get next data byte
;  inputs: none
;  output: carry = eof
;          no carry, al=data
;                    si,di modified
;
read_char:	dec	ds:[feed_available]
		jns	loc_88x				;jmp if data avail
		call	fill_inbuf			;fill the buffer
		jc	rc_exit2			;jmp if out of data
		jmp	read_char
loc_88x:	mov	si,ds:[feed_ptr]
        	lodsb					;get next byte
		mov	ds:[feed_ptr],si
rc_exit1:       clc
rc_exit2:       ret
;-------------------------------------------------------------------------
; lookup_code - convert data to code
;  inputs:  bx = data
;  output:  carry = no code
;           no carry, ax=code
;                     di=flag
;                     si modified
;
lookup_code:
	call	index			;convert code to address
	xor	di,di	    		;flag
	cmp	[si].first,-1		;Has this code been used?
	je	gc4			;equal means no
	inc	di			;set flag
	mov	bx,[si].first		;Get first entry
gc2:	call	index			;convert code to address
	cmp	[si].char,al		;is char the same?
	jne	gc3			;ne means no
;;	clc				;success
	mov	ax,bx			;put found code in ax
	ret				;done

gc3:	cmp	[si].next,-1		;More left with this prefix?
	je	gc4			;equal means no
	mov	bx,[si].next		;get next code
	jmp	gc2			;try again

gc4:	stc				;not found
	ret				;done
;---------------------------------------------------------------------
; index - index into hash table
;  inputs: bx = code
;  output: si = hash ptr
;
index:	mov	si,bx			;si = bx * 5 (5 byte hash entries)
	shl	si,1			;si = bx * 2 * 2 + bx
	shl	si,1
	add	si,bx
	ret
;-----------------------------------------------------------------------
; add_code to table
;  inputs:  di = flag, first use of prefix
;           si = hash table ptr
;
add_code:
	mov	bx,ds:[free_code]		;Get code to use
	or	di,di	   		;First use of this prefix?
	je	ac1			;equal means yes
	mov	[si].next,bx		;point last use to new entry
	jmp	short ac2

ac1:	mov	[si].first,bx		;Point first use to new entry
ac2:	cmp	bx,MAXMAX		;Have we reached code limit?
	je	ac3			;equal means yes, just return
	call	index			;get address of new entry
	mov	[si].first,-1		;initialize pointers
	mov	[si].next,-1
	mov	[si].char,al		;save suffix char
	inc	ds:[free_code]		;adjust next code
ac3:	ret
;--------------------------------------------------------------------------
; fill_inbuf - fill the input buffer
;  inputs: none
;  output: carry set if end of data
;
fill_inbuf:				;!!! warning instruction mod here
	apush	bx
	mov	dx,offset feed_buffer
	mov	ds:[feed_ptr],dx		;restart the ptr
	mov	ax,BUFFER_SIZE		;get requested amount
	call	dword ptr ds:[feed_process]
	or	ax,ax
	jnz	fill_ok
	stc
	jmp	fill_exit
fill_ok:clc
	mov	word ptr ds:[feed_available],ax	;zero only if data was found
fill_exit:
	apop	bx
	ret
;--------------------------------------------------------------------------
; flush_outbuf - ship the full buffer off to caller
;  inputs: none
;  output: none
;
flush_outbuf:
	mov	ax,ds:[store_ptr]
	mov	dx,offset store_buffer
	sub	ax,dx				;compute flush size
	call	dword ptr ds:[store_process]
	mov	di,offset store_buffer		;move partial
	mov	si,ds:[store_ptr]			;  data back
	mov	ds:[store_ptr],di
	movsb
	ret
;--------------------------------------------------------------------
; init_table - setup table 
;   inputs: none
;
init_table:
	mov	ds:[max_bits],9			;Set code size to 9
	mov	ds:[max_code],512		;Set max code to 512
	mov	ax,-1			;Unused flag
	mov	cx,(size hash_rec)*256	;Clear first 256 entries
	mov	di,offset hash		;Point to first entry
	rep	stosw			;Clear it out
	mov	ds:[free_code],FIRST_FREE	;Set next code to use
	ret				;done

LIBSEG	ends

;	end	start
