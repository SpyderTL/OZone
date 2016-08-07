	page	66,132
;****************************** SHRINK1.ASM  *********************************
		extrn	dos_mem_allocate:far
		extrn	dos_mem_release:far

		public	shrink
		public	expand

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
.list
;----------------------------------------------------------------------------
NN		EQU	4096			;buffer size
FF		EQU	60			;lookahead buffer size
THRESHOLD	EQU	2
NIL		EQU	NN			;leaf of tree

N_CHAR		equ	256 - THRESHOLD + FF	;kinds of char codes 0->N_CHAR
TT		equ	(N_CHAR * 2)-1		;size of table
RR		equ	TT - 1			;position of root
MAX_FREQ	equ	8000h			;update tree when root frequency
;						;reaches this value

disk_buf_size	equ	512*1

;-------------------------------------------------------------- seg_d  ----
	public	_rson
_data           struc
_p_len		db	?,?,?,?
		db	8 dup (?)
		db	12 dup (?)
		db	24 dup (?)
		db	16 dup (?)
_p_code		db	64 dup (?)
_d_code		db	32 dup (?)
		db	16 dup (?)
		db	16 dup (?)
		db	16 dup (?)
		db	8 dup (?)
		db	8 dup (?)
		db	8 dup (?)
		db	8 dup (?)
		db	8 dup (?)
		db	8 dup (?)
		db	8 dup (?)
		db	8 dup (?)
		db	10*6 dup (?)
		db	14 dup (?)
		db	20 dup (?)
		db	18 dup (?)
_d_len		db	32 dup (?)
		db	48 dup (?)
		db	64 dup (?)
		db	48 dup (?)
		db	48 dup (?)
		db	16 dup (?)
_getbuf		dw	?
_putbuf		dw	?
_getlen		db	?
_putlen		db	?

_textsize	dw	?
_textsize2	dw	?

feed_process	dd	?

store_process	dd	?

feed_buffer	db	disk_buf_size dup (?)	;buffer filled externally
feed_ptr	dw	?
feed_available	dw	?

store_buffer	db	disk_buf_size dup (?)	;buffer filled internally
store_ptr	dw	?
store_freespace dw	?

_match_length	dw	?
_match_position  dw	 ?
_freq		dw	(TT+1) dup (?)
_lson		dw	(NN+1) dup (?)
		dw	?
_prnt		dw	(TT+N_CHAR) dup (?)
_text_buf	db	(NN+FF-1) dup (?)
		db	?				;even
_rson		dw	(NN+257) dup (?)
		dw	?
_son		dw	TT dup (?)
_dad		dw	(NN+1) dup (?)
;---------------------------
recon_8		dw	0
recon_c		dw	0
;----------------------------
shrink_2	dw	0
shrink_4	dw	0
shrink_6	dw	0
shrink_8	dw	0
shrink_a	dw	0
;---------------------------
;
data_seg_end	db	?
_DATA		ends

;-------------------------------------------------------------- seg_a  ----
xp_len		db	3,4,4, 4
		db	8 dup (5)
		db	12 dup (6)
		db	24 dup (7)
		db	16 dup (8)
xp_code		db	00,20h,30h,40h,50h,58h,60h,68h,70h
		db	78h, 80h, 88h, 90h, 94h, 98h, 9Ch
		db	0A0h, 0A4h, 0A8h, 0ACh, 0B0h, 0B4h
		db	0B8h, 0BCh, 0C0h, 0C2h, 0C4h, 0C6h
		db	0C8h, 0CAh, 0CCh, 0CEh, 0D0h, 0D2h
		db	0D4h, 0D6h, 0D8h, 0DAh, 0DCh, 0DEh
		db	0E0h, 0E2h, 0E4h, 0E6h, 0E8h, 0EAh
		db	0ECh, 0EEh, 0F0h, 0F1h, 0F2h, 0F3h
		db	0F4h, 0F5h, 0F6h, 0F7h, 0F8h, 0F9h
		db	0FAh, 0FBh, 0FCh, 0FDh, 0FEh, 0FFh
xd_code		db	32 dup (0)
		db	16 dup (1)
		db	16 dup (2)
		db	16 dup (3)
		db	8 dup (4)
		db	8 dup (5)
		db	8 dup (6)
		db	8 dup (7)
		db	8 dup (8)
		db	8 dup (9)
		db	8 dup (0Ah)
		db	8 dup (0Bh)
		db	0Ch, 0Ch, 0Ch, 0Ch, 0Dh, 0Dh
		db	0Dh, 0Dh, 0Eh, 0Eh, 0Eh, 0Eh
		db	0Fh, 0Fh, 0Fh, 0Fh, 10h, 10h
		db	10h, 10h, 11h, 11h, 11h, 11h
		db	12h, 12h, 12h, 12h, 13h, 13h
		db	13h, 13h, 14h, 14h, 14h, 14h
		db	15h, 15h, 15h, 15h, 16h, 16h
		db	16h, 16h, 17h, 17h, 17h, 17h
		db	18h, 18h, 19h, 19h, 1Ah, 1Ah
		db	1Bh, 1Bh, 1Ch, 1Ch, 1Dh, 1Dh
                db      1Eh, 1Eh, 1Fh, 1Fh,'  !!""##$$'
                db      '%%&&', 27h, 27h, '(())**++,,--..'
                db      '//0123456789:;<=>?'
xd_len		db	32 dup (3)
		db	48 dup (4)
		db	64 dup (5)
		db	48 dup (6)
		db	48 dup (7)
		db	16 dup (8)

data_seg	dw	0	;data segment

;--------------------------------------------------------------------------
setup_data:	apush	si,di,es
		mov	cx,cs
		mov	ds,cx
		
		mov	dx,0
		mov	ax,data_seg_end
		call	dos_mem_allocate
errxx:		jc	errxx
		mov	cs:data_seg,es
		cld
		mov	cx,offset _getbuf
		mov	si,OFFSET xp_len
		mov	di,0
		rep	movsb

		mov	cx,offset data_seg_end - offset _getbuf
		mov	al,0
		rep	stosb
		push	es
		pop	ds

		mov	word ptr cs:fill_inbuf,5350h	;push ax, push bx
		
		apop	es,di,si

                mov	word ptr ds:[feed_process],si
                mov	word ptr ds:[store_process],di
                mov	word ptr ds:[feed_process+2],es
                mov	word ptr ds:[store_process+2],es

                push	ds
                pop	es

		mov	di,offset _text_buf
        	cld
		mov	cx,NN-FF
		mov	al,' '
		rep	stosb
		
		ret
		
;--------------------------------------------------------------------------
release_data:	push	ds
		pop	es
		call	dos_mem_release
		ret

;--------------------------------------------------------------------------
; fill_inbuf - fill the input buffer
;  inputs: none
;  output: carry set if end of data
;
fill_inbuf:				;!!! warning instruction mod here
	apush	ax,bx,dx
	mov	dx,offset feed_buffer
	mov	ds:[feed_ptr],dx		;restart the ptr
	mov	ax,disk_buf_size		;get requested amount
	call	dword ptr ds:[feed_process]
	or	ax,ax
	jnz	fill_ok
	stc
	mov	word ptr cs:fill_inbuf,0c3f9h	;force stc,ret
	jmp	fill_exit
fill_ok:clc
	mov	word ptr ds:[feed_available],ax	;zero only if data was found
fill_exit:
	apop	dx,bx,ax
	ret
;--------------------------------------------------------------------------
; flush_outbuf - ship the full buffer off to caller
;  inputs: none
;  output: none
;
flush_outbuf:
	apush	ax,bx,dx
	mov	dx,offset store_buffer
	mov	ds:[store_ptr],dx
	mov	ax,disk_buf_size
	sub	ax,ds:store_freespace
	mov	ds:[store_freespace],disk_buf_size
	call	dword ptr ds:[store_process]
	apop	dx,bx,ax
	ret
;‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹

_inittree	proc	near
		cld
		mov	cx,258
		mov	di,offset _rson +(2*(NN))
		mov	ax,NIL
		rep	stosw

		mov	cx,NN
		mov	di,offset _dad
		rep	stosw
		ret
_inittree	endp

;--------------------------------------------------------------------------
; inputs:  dx = in_r
;
;---------------------------
_insertnode     proc    near
                push    di
                push    si
                mov     bx,dx				;get in_r
                add     bx,offset _text_buf             ;                    02
                mov     es,bx
                mov     al,[bx]
                sub     ah,ah
                mov     di,ax                           ;                    03
                add     di,NN+1                         ;                    03
                mov     bx,dx				;get in_r
                shl     bx,1
                mov     ax,NIL                          ;                    04
                mov     ds:_lson[bx],ax
                mov     ds:_rson[bx],ax                 ;                    04
                mov     ds:[_match_length],0		;                    05
                clc
                jmp	forever_lp1
forever_set:	rcl	al,1				;if carry set al-bit0
forever_lp1:
                mov     bx,di                           ;                    08
                shl     bx,1
		test	al,1				;check if carry
		jnz	loc_8				; jmp if carry
		
                mov     bp,_rson[bx]
                cmp     bp,NIL
                jne     loc_9

break1:		mov	si,dx
		shl	si,1
		mov	_dad[si],di
                mov     _rson[bx],dx
                pop	si
                pop	di
                ret

loc_8:          mov     bp,_lson[bx]
                cmp     bp,NIL
                je	break2

loc_9:	mov	di,bp
	mov	bx,es
	add	bp,offset _text_buf
	mov	si,1
insert_lp:
	mov	ax,[bx+si]
	mov	cx,ds:[bp+si]
	sub	al,cl
	jnz	forever_set
	inc	si				;si is odd
insert_lp1:
	cmp	ah,ch
	jnz	forever_set
	inc	si				;si is even (si=2)
	
insert_lp2:
	mov	ax,[bx+si]
	mov	cx,ds:[bp+si]
	sub	al,cl
	jnz	loc_12a
	inc	si				;si will be odd (si=3+)
insert_lp3:
	cmp	ah,ch
	jnz	loc_12a
	inc	si				;si is even
	cmp	si,FF				;ff = 60 (even)
	jge	loc_12a

insert_lp4:
	mov	ax,[bx+si]
	mov	cx,ds:[bp+si]
	sub	al,cl
	jnz	loc_12a
	inc	si				;si is odd
insert_lp5:
	cmp	ah,ch
	jnz	loc_12a
	inc	si				;si is even

insert_lp6:
	mov	ax,[bx+si]
	mov	cx,ds:[bp+si]
	sub	al,cl
	jnz	loc_12a
	inc	si				;si is odd
insert_lp7:
	cmp	ah,ch
	jnz	loc_12a
	inc	si				;si is even
	cmp	si,FF				; ff = 60 (even)
	jl	insert_lp2
;
; assume the carry is set correctly here
;
loc_12a:	rcl	al,1			;use carry to set al-bit 0
loc_12:	
                cmp     ds:[_match_length],si
                je	loc_14
                jg	forever_lp1
                mov     bx,dx				;cs:[in_r]
                sub     bx,di
                and     bh,0Fh
                dec     bx
                mov     ds:[_match_position],bx
                mov     ds:[_match_length],si
                cmp     si,FF
                jl	forever_lp1
                jmp	insertn_finish

loc_14:         mov     bx,dx				;cs:[in_r]
                sub     bx,di
                and     bh,0Fh
                dec     bx
                cmp     bx,ds:[_match_position]
                ja	forever_lp1
                mov     ds:[_match_position],bx
                jmp     forever_lp1

break2:		mov	si,dx
		shl	si,1
		mov	ds:_dad[si],di
                mov     ds:_lson[bx],dx
                pop	si
                pop	di
                ret

insertn_finish:
                mov     bx,di                            ;                   40
                shl     bx,1
                mov     ax,bx
                add     bx,offset _dad
                mov     bp,bx				;cs:[in_dad_p],bx
                mov     cx,[bx]
                mov	si,dx
                shl	si,1
                mov     ds:_dad[si],cx

                mov     bx,ax
                mov     ax,ds:_lson[bx]
                mov     ds:_lson[si],ax

                mov     cx,ds:_rson[bx]
                mov     ds:_rson[si],cx

		mov	si,ax			;_lson[bx]
                shl     si,1
                mov     _dad[si],dx		;store in_r

                mov     bx,cx			;_rson[bx]
                shl     bx,1
                mov     _dad[bx],dx		;store in_r

                mov     bx,ds:[bp]
                shl     bx,1
                cmp     _rson[bx],di
                jne     loc_17
                mov     _rson[bx],dx		;store in_r
                mov     word ptr ds:[bp],NIL
                pop     si
                pop     di
                retn
loc_17:
                mov     _lson[bx],dx		;store in_r
                mov     word ptr ds:[bp],NIL
                pop     si
                pop     di
close_ret:      retn
_insertnode     endp
;--------------------------------------------------------------------------
;  inputs:  cx = p
;  output:  none
;
_deletenode:    mov     bx,cx
                shl     bx,1
                cmp     _dad[bx],NIL
                je	close_ret
                push    di
                mov     di,bx			;di = input (p) * 2
                push    si
loc_23:         cmp     _rson[bx],NIL
		je	loc_23x
                cmp     _lson[bx],NIL
                je	loc_24
                mov	bx,ds:_lson[bx]
                mov	si,bx
                shl     si,1
                cmp     _rson[si],NIL
                je      loc_27

           	shl	bx,1
deleten_lp:	mov	bx,_rson[bx]
		shl	bx,1
		mov	bp,_rson[bx]
		cmp	bp,NIL
		je	deleten_lp_end

		mov	bx,bp
		shl	bx,1
		cmp	_rson[bx],NIL
		jne	deleten_lp
deleten_lp_end:
                mov     ax,_dad[bx]
                lea     si,_lson[bx]
                shr	bx,1
		mov	bp,si
                mov     si,[si]
                mov     dx,si
                mov     si,ax
                shl     si,1
                mov     _rson[si],dx
                mov     si,dx
                shl     si,1
                mov     _dad[si],ax
		mov	si,_lson[di]
		mov	ds:[bp],si
                shl     si,1
                mov     _dad[si],bx
loc_27:
                mov     bp,_rson[di]		;di = inpup (p) * 2
                mov     si,bx
                shl     si,1
                mov     _rson[si],bp
		shl	bp,1
                mov     ds:_dad[bp],bx
loc_28:
                mov     ax,_dad[di]		;di= input (p) * 2
                mov	si,bx
                shl     si,1
                mov     _dad[si],ax
		mov	si,ds:_dad[di]
                shl     si,1
                mov     _dad[di],NIL
                cmp     _rson[si],cx		;input parameter p
                jne     loc_29
                mov     _rson[si],bx
                pop	si
                pop	di
                ret

loc_29:         mov     _lson[si],bx
                pop     si
                pop	di
                retn
		
loc_23x:        mov     bx,_lson[bx]
                jmp     loc_28

loc_24:
                mov     bx,_rson[bx]
                jmp     short loc_28

;‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
; _putcode - store code for output
;  inputs: ch = length, can be up to 16 bits long
;          dx = put code
;
_putcode:
		mov	ax,dx			;save copy of code
		mov	cl,ds:[_putlen]
		shr	dx,cl			;position new bits
		or	dx,ds:[_putbuf]		;merge new code in
		add	ch,cl			;compute total# bits
		cmp	ch,8			;check if full byte is avail
		jb	loc_46			; jmp if not full byte yet
;
; store byte in output buffer.  dx = merged code
;                               ch = length
;
loc_43x:       	mov	bx,ds:[store_ptr]
        	mov	byte ptr ds:[bx],dh
		inc	bx
		mov	ds:[store_ptr],bx
		dec	ds:[store_freespace]
		jnz	loc_43				;jmp if buffer has room
		call	flush_outbuf
;
; remove one byte from _putbuf and update
;		
loc_43:		mov	dh,dl
		mov	dl,0
		sub	ch,8
		cmp	ch,8
		jb	loc_46		
;
; whoops we have another byte to store. restore the bits which overflowed
;    ch=bit count   dh=full byte of code
;
		sub	cl,8
		neg	cl
		shl	ax,cl
		or	dx,ax
		jmp	loc_43x
		
loc_46:		mov	ds:[_putbuf],dx		;store merged code
		mov	ds:[_putlen],ch		;store merged length
		ret		
;‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
_starthuff      proc    near
                sub     bx,bx			;(i+TT)=0
                mov     dx,bx			;i=0
loc_51:         mov     ds:_freq[bx],1
                mov     ax,dx
                add     ax,TT
                mov     _son[bx],ax
                mov     _prnt+(2*TT)[bx],dx
                inc     bx
                inc     bx
                inc     dx
                cmp     bx,(2 * N_CHAR)
                jl      loc_51

                mov     dx,N_CHAR
                sub     bx,bx
                mov     cx,bx
                mov     di,(2 * N_CHAR)
loc_53:         mov     ax,_freq+2[bx]
                add     ax,_freq[bx]
                mov     _freq[di],ax
                mov     _son[di],cx
                inc     cx
                inc     cx
                mov     _prnt+2[bx],dx
                mov     _prnt[bx],dx
                add     bx,4
                inc     di
                inc     di
                inc     dx
                cmp     di,(RR*2)
                jle     loc_53

                mov     ds:_freq+(2*TT),0FFFFh
                mov     ds:_prnt+(2*RR),0
                retn
_starthuff      endp

;--------------------------------------------------------------------------
;  inputs:  none
;  outputs: none
;
_reconst        proc    near
                push    bp
                mov     bp,sp
                sub     sp,12h
                push    di
                push    si

                mov	bx,ds
                mov	es,bx
                
                sub     bx,bx
                mov     di,bx
                jmp     short loc_56                            
loc_54:
                cmp     _son[bx],TT
                jl      loc_55
                mov     ax,_freq[bx]
                inc     ax
                shr     ax,1
                mov     _freq[di],ax
                mov     ax,_son[bx]
                mov     _son[di],ax
                inc     di
                inc     di
loc_55:
                inc     bx
                inc     bx
loc_56:
                cmp     bx,(2*TT)		;if son[i] >= TT
                jl      loc_54
;
; loop2 --- setup
;                
                mov     word ptr [bp-8],0
                mov     si,N_CHAR
                mov     word ptr [bp-0Ah],offset _freq+(TT+1)
                mov     word ptr [bp-0Ch],offset _freq+2
                jmp     loc_60
;
; loop2 --- begin
;                
loc_57:
                mov     bx,[bp-0Ch]
                mov     ax,[bx-2]
                add     ax,[bx]
                mov     bx,[bp-0Ah]
                mov     [bx],ax
                mov     [bp-6],ax
                lea     ax,[si-1]
                mov     [bp-4],ax
                mov     ax,[bp-0Ah]
                dec     ax
                dec     ax
                mov     [bp-2],ax
                mov     [bp-0Eh],si
                mov     di,[bp-4]
                jmp     short loc_59                            
loc_58:
                sub     word ptr [bp-2],2
                dec     di
loc_59:
                mov     ax,[bp-6]
                mov     bx,[bp-2]
                cmp     [bx],ax
                ja      loc_58
;
; setup for memory move
;
                mov     cx,si			;[bp-0Eh]
                inc     di
                sub     cx,di			;compute move count
		shl	cx,1

                shl	di,1
                mov	si,di
                add	si,offset _freq		;from ptr
                push	si
                
                mov     [bp-12h],di
                add	di,offset _freq+2	;to ptr
                
                mov     [bp-10h],cx		;move count
                std
                mov	ax,cx
                dec	ax
                add	si,ax
                add	di,ax
                rep	movsb
;
; setup for move
;               
		pop	di 
                mov     ax,[bp-6]
                mov     [di],ax

                mov	cx,word ptr [bp-10h]	;move count

                mov	si,[bp-12h]
                add	si,offset _son		;from ptr
                push	si			;save from ptr
		
                mov	di,[bp-12h]
                add	di,offset _son+2	;to ptr
                mov	ax,cx
                dec	ax
                add	si,ax
                add	di,ax
                rep	movsb
		cld
		pop	di			;restore prev. -from- ptr
                
                mov     ax,[bp-8]
                mov     [di],ax
                add     word ptr [bp-0Ch],4
                add     word ptr [bp-8],2
                add     word ptr [bp-0Ah],2

                mov	si,word ptr [bp-0eh]
                inc     si
loc_60:
                cmp     word ptr [bp-0Ah],offset _freq+(2*TT)
                jae     loc_61
                jmp     loc_57                                  
;
; loop 3 setup ----
;                
loc_61:
                sub     dx,dx
                mov     di,offset _son			
                jmp     short loc_65                            
;
; loop 3 begin ----
;                
loc_62:
                mov     bx,[di]
                cmp     bx,273h
                jl      loc_63
                mov     si,bx
                shl     si,1
                mov     _prnt[si],dx
                jmp     short loc_64                            
loc_63:
                shl     bx,1
                mov     _prnt+2[bx],dx
                mov     _prnt[bx],dx
loc_64:
                inc     di
                inc     di
                inc     dx
loc_65:
                cmp     di,offset _dad			;6F44h
                jb      loc_62
                pop     si
                pop     di
                mov     sp,bp
                pop     bp
                retn
_reconst        endp
;--------------------------------------------------------------------------
; update - update frequency of code & fix tree
;   inputs:  bp = code
;---------------------------
do_recon:
	push	bp
	call	_reconst
	pop	bp
	jmp	loc_66
;---------------------------
_update         proc    near
                push    di
                push    si
                push	bp
                cmp     ds:_freq+(2*RR),MAX_FREQ
                je	do_recon
loc_66:
                shl     bp,1
                mov     bp,ds:_prnt+(2*TT)[bp]

update_lp1:     mov     bx,bp
                shl     bx,1
                mov     es,bx			;
                inc     _freq[bx]
                mov     dx,_freq[bx]
                mov     bx,bp
                inc     bx
                mov     si,bx
                shl     si,1
                cmp     _freq[si],dx
                jae	loc_72
                add     si,offset _freq

update_lp2:
		add	si,2
		cmp	[si],dx
		jae	lp2_exit
		add	si,2
		cmp	[si],dx
		jae	lp2_exit
		add	si,2
		cmp	[si],dx
		jae	lp2_exit
                add	si,2
                cmp	[si],dx
                jb      update_lp2
lp2_exit:
		sub	si,offset _freq+2
		mov	bx,si
		shr	bx,1
		
                mov     ax,_freq[si]
                mov     di,es			;
                mov     _freq[di],ax
                mov     _freq[si],dx
                mov     cx,_son[di]
                mov     si,cx
                shl     si,1
                mov     _prnt[si],bx
                cmp     cx,TT
                jge     loc_70
                mov     _prnt+2[si],bx
loc_70:
                mov     si,bx
                shl     si,1
                lea     ax,[si+_son]
                mov     di,ax
                mov     si,[di]
                mov     [di],cx
                mov     di,si
                shl     di,1
                mov     _prnt[di],bp
                cmp     si,TT
                jge     loc_71
                mov     _prnt+2[di],bp
loc_71:
                mov     di,es			;
                mov     _son[di],si
                mov     bp,bx
loc_72:
                mov     bx,bp
                shl     bx,1
                mov     bp,_prnt[bx]
                or      bp,bp
                jnz	update_lp1
loc_73:
		pop	bp
                pop     si
                pop     di
                retn
_update         endp

;--------------------------------------------------------------------------
; encodechar - convert char. to code
;   inputs:  ax = char
;
_encodechar     proc    near
                sub     dx,dx				;initial code=0
		mov	ch,0				;set char length = 0
                mov     bx,ax				;get input char
                shl     bx,1
                mov     bx,_prnt+(2*TT)[bx]

enc_lp:         shr     dx,1
                test    bx,1
                jz      loc_75
                add     dx,8000h
loc_75:		inc	ch				;bump char. length
		shl	bx,1
		mov	bx,_prnt[bx]
                cmp     bx,RR
                jne     enc_lp

		mov	bp,ax
		call	_putcode		;dx=code ch=len -> output
                call    _update               ;update code frequency
                retn
_encodechar     endp
;‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹

_encodeend	proc	near
		cmp	byte ptr ds:_putlen,0
		je	loc_79
		mov	al,byte ptr ds:_putbuf+1	;get output byte
		mov	bx,ds:[store_ptr]
		mov	byte ptr ds:[bx],al		;store byte
		inc	bx
		mov	ds:[store_ptr],bx
		dec	ds:[store_freespace]
loc_79:		cmp	ds:[store_freespace],disk_buf_size
		je	loc_79x		
		call	flush_outbuf			;go write the buffer
loc_79x:	retn
_encodeend	endp


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(COMPRESS )
shrink - compress data block
;
; inputs:  es:si = feed proceedure ptr
;          es:di = store proceedure ptr
;          dx,ax = size of block of data to be compressed
;
; output:  The feed proceedure is called with:  ds:dx = buffer area
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

shrink         proc     far
                apush	ds,es
                apush	ax,dx		;save data block size
                call	setup_data
		apop	dx,ax
;
; write the file size to output
;
		mov	word ptr ds:[store_buffer],ax
		mov	word ptr ds:[store_buffer+2],dx
;
; setup the buffer ptrs
;
		mov	ds:[feed_ptr],offset feed_buffer
		mov	ds:[feed_available],0
		mov	ds:[store_ptr],offset store_buffer+4
		mov	ds:[store_freespace],disk_buf_size-4		

                call    _starthuff
                call    _inittree
                mov     word ptr ds:[shrink_8],NN-FF
                sub     ax,ax
                mov     ds:[shrink_a],ax

                sub     di,di
shrink_lp2:	dec	ds:[feed_available]
		jns	loc_88x				;jmp if data avail
		call	fill_inbuf			;fill the buffer
		jc	loc_91				;jmp if out of data
		jmp	shrink_lp2
loc_88x:	mov	bx,ds:[feed_ptr]
        	mov	al,byte ptr ds:[bx]		;get next byte
		inc	bx
		mov	ds:[feed_ptr],bx
                sub     ah,ah
                mov     _text_buf+(NN-FF)[di],al
                inc     di
                cmp     di,FF
                jl      shrink_lp2

loc_91:         mov     si,1
                mov     ds:[shrink_6],di

shrink_lp3:     mov     dx,NN-FF
                sub     dx,si
                call    _insertnode
                inc     si
                cmp     si,FF
                jle     shrink_lp3

                mov     dx,NN-FF
                call    _insertnode

shrink_lp4:     mov     ax,ds:[shrink_6]
                cmp     word ptr ds:[_match_length],ax
                jle     loc_95
                mov     word ptr ds:[_match_length],ax
loc_95:         cmp     word ptr ds:[_match_length],2
                jg      loc_96
                mov     word ptr ds:[_match_length],1
                mov     bx,ds:[shrink_8]
                mov     al,ds:_text_buf[bx]
                sub     ah,ah
                call    _encodechar
                jmp     short loc_97x
loc_96:         mov     ax,word ptr ds:[_match_length]
                add     ax,255-THRESHOLD
                call    _encodechar
;
; _encodeposition - name says it all
;  inuts:  [_match_position]
;  outputs: none
;
;_encodeposition proc    near
                mov     cl,6
                mov     bx,ds:[_match_position]	
                shr     bx,cl

                mov     dh,byte ptr ds:[_p_code][bx]
                sub     dl,dl
		mov	ch,ds:_p_len[bx]
		call	_putcode

		mov	cx,060ah
                mov     dx,ds:[_match_position]
                shl     dx,cl
                call	_putcode
;                retn
;_encodeposition endp

loc_97x:        mov     ax,word ptr ds:[_match_length]
                mov     ds:[shrink_4],ax
                mov     word ptr ds:[shrink_2],0
                mov     di,ds:[shrink_a]
                jmp     short loc_102

loc_98x:	call	fill_inbuf
		jc	loc_103
		
shrink_lp5:	dec	ds:[feed_available]		;check if data avail
		js	loc_98x				;jmp if no data
		mov	bx,ds:[feed_ptr]
		mov	al,byte ptr ds:[bx]		;get byte from buf
		sub	ah,ah
		inc	bx
		mov	ds:[feed_ptr],bx		;update ptr
                mov     si,ax
		mov	cx,di
                call    _deletenode
                mov     ax,si
                mov     ds:_text_buf[di],al
                cmp     di,FF-1
                jge     loc_101
                mov     byte ptr ds:[_text_buf+NN][di],al
loc_101:        lea     ax,[di+1]
                and     ah,0Fh
                mov     di,ax
                mov     dx,ds:[shrink_8]
                inc     dx
                and     dh,0Fh
                mov     ds:[shrink_8],dx
                call    _insertnode
                inc     word ptr ds:[shrink_2]
loc_102:        mov     ax,ds:[shrink_2]
                cmp     ds:[shrink_4],ax
                jg      shrink_lp5

loc_103:        mov     ds:[shrink_a],di
                jmp     short loc_106

shrink_lp6:	mov	cx,word ptr ds:[shrink_a]
                call    _deletenode
                mov     ax,ds:[shrink_a]
                inc     ax
                and     ah,0Fh
                mov     ds:[shrink_a],ax
                mov     dx,ds:[shrink_8]
                inc     dx
                and     dh,0Fh
                mov     ds:[shrink_8],dx
                dec     word ptr ds:[shrink_6]
                jz      loc_106
                call    _insertnode
loc_106:        mov     ax,ds:[shrink_2]
                inc     word ptr ds:[shrink_2]
                cmp     ax,ds:[shrink_4]
                jl      shrink_lp6

                cmp     word ptr ds:[shrink_6],0
                jle     loc_107
                jmp     shrink_lp4

loc_107:        call    _encodeend
		call	release_data
                apop	es,ds
                retf
shrink         endp


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(COMPRESS )
expand - expand compressed data back to origional state
;
;  inputs:  es:si  = feed proceedure (provides compressed data)
;           es:di  = store proceedure
;
; output:  The feed proceedure is called with:  ds:dx = buffer area
;                                                  ax = request byte count
;          The feed proceedure returns:  ax = byte count of data placed in
;                                             buffer.
;
;          The store proceedure is called with:  ds:dx = buffer pointer
;                                                   ax = buffer size
;
; note:  The feed proceedure is called whenever the expand module runs
;        out of data.  The store module is called whenever more data is
;        needed.  Normally, the feed and store data uses a disk file, but
;        if room it could be placed in memory.
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

decode_flush1:	call	flush_outbuf
		jmp	loc_116
;------------------------------
expand         proc    far
                apush	ds,es
                call	setup_data
;
; get the initial 4 bytes of data (size of origional uncompressed data block)
;
		call	fill_inbuf
		mov	ax,word ptr ds:[feed_buffer]
		mov	ds:_textsize,ax
		mov	ax,word ptr ds:[feed_buffer+2]
		mov	ds:_textsize2,ax

		sub	ds:[feed_available],4
		add	ds:[feed_ptr],4

		mov	ds:[store_ptr],offset store_buffer
		mov	ds:[store_freespace],disk_buf_size

		call	_starthuff
		mov	si,NN-FF
		jmp	decode_loop
		
;
; refill the byte buffer
;
loc_33x:	call	fill_inbuf
		jc	loc_32x
;
; refill bit buffer
;
loc_34x:	dec	ds:[feed_available]	;dec byte buffer count
		js	loc_33x			; jmp if no more bytes
		mov	bx,ds:[feed_ptr]
		mov	al,byte ptr ds:[bx]	;get next byte
		inc	bx
		mov	ds:[feed_ptr],bx	;update byte ptr
		mov	byte ptr ds:_getbuf+1,al ;put byte in bit buffer
		mov	ds:[_getlen],7
		jmp	loc_32x
;
; top level decode loop
;
decode_loop:    mov     di,ds:_son+(2*RR)

dc_lp1:		dec	ds:[_getlen]		;dec number of bits in bit buf
		js	loc_34x			; jmp if no more bits in buf
loc_32x:	shl	ds:[_getbuf],1
		adc	di,0
		shl	di,1
		mov	di,ds:_son[di]
                cmp     di,TT
                jb      dc_lp1

                lea     bp,[di-TT]	
                mov	di,bp
                call    _update
;
		cmp	di,100h
		jge	loc_122
		mov	ax,di
        	mov	bx,ds:[store_ptr]
		mov	byte ptr ds:[bx],al		;store byte in buffer
		inc	bx
		mov	ds:[store_ptr],bx
		dec	ds:[store_freespace]
		jz	decode_flush1
loc_116:	mov	ds:_text_buf[si],al
		inc	si
		and	si,0FFFh
		sub	ds:_textsize,1
		sbb	ds:_textsize2,0
		jnz	decode_loop
		mov	ax,ds:_textsize2
		or	ax,ds:_textsize
		jnz	decode_loop
		
loc_127:	cmp	ds:[store_freespace],disk_buf_size
		je	loc_128			;jmp if buffer empty
		call	flush_outbuf
loc_128:	call	release_data
		apop	es,ds
		retf

loc_112:	cmp	ds:_textsize2,0
		jl	loc_127
		jg	decode_loop
		cmp	ds:_textsize,0
		je	loc_127
		jmp	decode_loop
		
; refill the byte buffer
;
loc_37:		call	fill_inbuf
		jc	loc_39
;
; get the next byte ------- Decode Loop2 Setup ------
;
loc_122:	dec	ds:[feed_available]	;dec byte buffer count
		js	loc_37			; jmp if no more bytes
		mov	bx,ds:[feed_ptr]
		mov	al,byte ptr ds:[bx]	;get next byte
		inc	bx
		mov	ds:[feed_ptr],bx	;update byte ptr
		mov	ah,0
;
; merge the new byte with bits in _getbuf
;		
		mov	cl,8
		sub	cl,ds:[_getlen]
		shl	ax,cl
		or	ax,ds:[_getbuf]		;merge _getbuf + new byte
		mov	byte ptr ds:_getbuf+1,al ;save extra bits
		mov	al,ah
		mov	ah,0
		
loc_39:         mov     bp,ax
                mov     al,ds:_d_code[bp]
                mov     cl,6
                shl     ax,cl
		mov	dx,ax			;save -ax-
                mov     al,ds:_d_len[bp]
                sub     ah,ah
                mov     cx,ax
                sub	cx,3
                jmp	dp_lp1
;
; refill the byte buffer
;
loc_33y:	call	fill_inbuf
		jc	gb_exity
;
; refill bit buffer
;
loc_34y:	dec	ds:[feed_available]	;dec byte buffer count
		js	loc_33y			; jmp if no more bytes
		mov	bx,ds:[feed_ptr]
		mov	al,byte ptr ds:[bx]	;get next byte
		inc	bx
		mov	ds:[feed_ptr],bx	;update byte ptr
		mov	byte ptr ds:_getbuf+1,al ;put byte in bit buffer
		mov	ds:[_getlen],7
		jmp	loc_32y

dp_lp1:		dec	ds:[_getlen]		;dec number of bits in bit buf
		js	loc_34y			; jmp if no more bits in buf
loc_32y:	shl	ds:[_getbuf],1		;move next bit to carry
gb_exity:	rcl	bp,1
                dec     cx
		jns	dp_lp1

                mov     ax,bp
                and     ax,3Fh
		or	ax,dx

		mov	cx,si
		sub	cx,ax
		dec	cx
		and	ch,0Fh
		lea	dx,[di-(255-THRESHOLD)]
		mov	bp,0				;decode_k
		mov	di,ds:[store_ptr]
		
decode_loop2:	cmp	bp,dx				;cs:[decode_k],ax
		jge	loc_112
		mov	bx,bp				;cs:[decode_k]
		add	bx,cx
		and	bh,0Fh
		mov	al,ds:_text_buf[bx]		;get output char
		mov	byte ptr ds:[di],al		;store byte in buffer
		inc	di
		mov	ds:[store_ptr],di
		dec	ds:store_freespace
		jz	decode_flush2
loc_124:	mov	ds:_text_buf[si],al
		inc	si
		and	si,0FFFh
		sub	ds:_textsize,1
		sbb	ds:_textsize2,0
		inc	bp				;cs:[decode_k]
		jmp	decode_loop2

decode_flush2:	call	flush_outbuf
		mov	di,offset store_buffer
		jmp	loc_124
		
expand         endp

LIBSEG	ENDS
	end
	