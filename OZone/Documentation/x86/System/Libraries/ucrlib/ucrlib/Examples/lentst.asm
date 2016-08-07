		.xlist
                include         ucrlib.a
                includelib      ucrlib.lib
		.listall


maxArgs		=	50
wp		textequ	<word ptr>

var
	
len0a		byte	0
len0b		byte	0
len0c		byte	0
len0d		byte	0

len1a		byte	1,0,0
len1d		byte	1,0,0
len1c		byte	1,0,0
len1b		byte	1,0,0

len2a		byte	1,2,0
len2d		byte	1,2,0
len2c		byte	1,2,0
len2b		byte	1,2,0

len3a		byte	1,2,3,0,0
len3b		byte	1,2,3,0,0
len3c		byte	1,2,3,0,0
len3d		byte	1,2,3,0,0

len4a		byte	1,2,3,4,0
len4b		byte	1,2,3,4,0
len4c		byte	1,2,3,4,0
len4d		byte	1,2,3,4,0

len5a		byte	1,2,3,4,5,0,0
len5d		byte	1,2,3,4,5,0,0
len5c		byte	1,2,3,4,5,0,0
len5b		byte	1,2,3,4,5,0,0

len6a		byte	1,2,3,4,5,6,0
len6d		byte	1,2,3,4,5,6,0
len6c		byte	1,2,3,4,5,6,0
len6b		byte	1,2,3,4,5,6,0

len7a		byte	1,2,3,4,5,6,7,0,0
len7b		byte	1,2,3,4,5,6,7,0,0
len7c		byte	1,2,3,4,5,6,7,0,0
len7d		byte	1,2,3,4,5,6,7,0,0

len8a		byte	1,2,3,4,5,6,7,8,0
len8b		byte	1,2,3,4,5,6,7,8,0
len8c		byte	1,2,3,4,5,6,7,8,0
len8d		byte	1,2,3,4,5,6,7,8,0

len9a		byte	1,2,3,4,5,6,7,8,9,0,0
len9d		byte	1,2,3,4,5,6,7,8,9,0,0
len9c		byte	1,2,3,4,5,6,7,8,9,0,0
len9b		byte	1,2,3,4,5,6,7,8,9,0,0

len10a		byte	1,2,3,4,5,6,7,8,9,10,0
len10d		byte	1,2,3,4,5,6,7,8,9,10,0
len10c		byte	1,2,3,4,5,6,7,8,9,10,0
len10b		byte	1,2,3,4,5,6,7,8,9,10,0

len11a		byte	1,2,3,4,5,6,7,8,9,10,11,0,0
len11b		byte	1,2,3,4,5,6,7,8,9,10,11,0,0
len11c		byte	1,2,3,4,5,6,7,8,9,10,11,0,0
len11d		byte	1,2,3,4,5,6,7,8,9,10,11,0,0

len12a		byte	1,2,3,4,5,6,7,8,9,10,11,12,0
len12b		byte	1,2,3,4,5,6,7,8,9,10,11,12,0
len12c		byte	1,2,3,4,5,6,7,8,9,10,11,12,0
len12d		byte	1,2,3,4,5,6,7,8,9,10,11,12,0

len13a		byte	1,2,3,4,5,6,7,8,9,10,11,12,13,0,0
len13d		byte	1,2,3,4,5,6,7,8,9,10,11,12,13,0,0
len13c		byte	1,2,3,4,5,6,7,8,9,10,11,12,13,0,0
len13b		byte	1,2,3,4,5,6,7,8,9,10,11,12,13,0,0

len14a		byte	"12345678901234",0
len14d		byte	"12345678901234",0
len14c		byte	"12345678901234",0
len14b		byte	"12345678901234",0

len15a		byte	"123456789012345",0
len15b		byte	"123456789012345",0
len15c		byte	"123456789012345",0
len15d		byte	"123456789012345",0

len16a		byte	"1234567890123456",0
len16b		byte	"1234567890123456",0
len16c		byte	"1234567890123456",0
len16d		byte	"1234567890123456",0

len17a		byte	"12345678901234567",0,0
len17d		byte	"12345678901234567",0,0
len17c		byte	"12345678901234567",0,0
len17b		byte	"12345678901234567",0,0

len18a		byte	"123456789012345678",0
len18d		byte	"123456789012345678",0
len18c		byte	"123456789012345678",0
len18b		byte	"123456789012345678",0

len19a		byte	"1234567890123456789",0,0
len19b		byte	"1234567890123456789",0,0
len19c		byte	"1234567890123456789",0,0
len19d		byte	"1234567890123456789",0,0

len20a		byte	"12345678901234567890",0
len20b		byte	"12345678901234567890",0
len20c		byte	"12345678901234567890",0
len20d		byte	"12345678901234567890",0



endvar




cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg

; "Traditional" strlen function.

sl_strlen	proc	far
		push	ax
		pushf
		push	si
		push	di
;
		cld
		mov	al, 0
		mov	cx, 0ffffh
	repne	scasb
		neg	cx
		dec	cx
		dec	cx
;
		pop	di
		pop	si
		popf
		pop	ax
		ret
sl_strlen	endp

strlen3		proc	far
		push	eax
		push	ebx
		push	di

lp:		mov	ebx, es:[di]
		add	di, 4
		mov	eax, ebx
		not	ebx
		sub	eax, 01010101h
		and	eax, ebx
		and	eax, 80808080h
		jz	lp

		pop	di
		pop	ebx
		pop	eax
		ret
strlen3		endp



Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax

		MemInit


		for	i,<0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20>
		print	"Length = "
		mov	di, seg len&i&a
		mov	es, di
		mov	di, offset len&i&a
		strlen
		mov	ax, cx
		puti
		putc	' '

		mov	di, seg len&i&b
		mov	es, di
		mov	di, offset len&i&b
		strlen
		mov	ax, cx
		puti
		putc	' '

		mov	di, seg len&i&c
		mov	es, di
		mov	di, offset len&i&c
		strlen
		mov	ax, cx
		puti
		putc	' '

		mov	di, seg len&i&d
		mov	es, di
		mov	di, offset len&i&d
		strlen
		mov	ax, cx
		puti
		putcr
		endm



		print	"Press any key to begin timing:"
		rawgetc
		putcr

		mov	edx, 100000
lp0:
		for	i,<0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20>
		lesi	len&i&a
		strlen
		lesi	len&i&b
		strlen
		lesi	len&i&c
		strlen
		lesi	len&i&d
		strlen
		endm

		dec	edx
		jne	lp0

		print	bell,"...Done",nl
		print	"Press any key to begin timing:"
		rawgetc
		putcr

		mov	edx, 100000
lp1:
		for	i,<0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20>
		lesi	len&i&a
		call	sl_strlen
		lesi	len&i&b
		call	sl_strlen
		lesi	len&i&c
		call	sl_strlen
		lesi	len&i&d
		call	sl_strlen
		endm

		dec	edx
		jne	lp1



		print	bell,"Done...",nl
		print	bell,"...Done",nl
		print	"Press any key to begin timing:"
		rawgetc
		putcr

		mov	edx, 100000
lp2:
		for	i,<0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20>
		lesi	len&i&a
		call	strlen3
		lesi	len&i&b
		call	strlen3
		lesi	len&i&c
		call	strlen3
		lesi	len&i&d
		call	strlen3
		endm

		dec	edx
		jne	lp2

		print	bell,"Done...",nl

		ExitPgm			;DOS macro to quit program.
Main		endp

cseg            ends

sseg		segment	para stack 'stack'
stk             db      16384 dup (?)
sseg		ends


zzzzzzseg	segment	para public 'zzzzzz'
LastBytes	db	16 dup (?)
zzzzzzseg	ends
		end	Main
