; STDOUT.ASM
;
; This program tests the standard output routines and their corresponding macros:
;
; Routines:	putcstk, putcr, PutcStdOut, PutcBIOS, SetOutAdrs, GetOutAdrs
;		PushOutAdrs, PopOutAdrs, PutISize, PutISizeStk, PutUSize
;		PutUSizeStk, PutLSize, PutLSizeStk, PutULSize, PutULSizeStk
;		putistk, putu, putustk, putlstk
;		putulstk, putsstk, printf, printff
;		LSize, ULSize, ISize, USize
;
; Macros:	Puts, Putc, puth, putw, puti, putu, putl, putul


		.xlist
                include         ucrlib.a
                includelib      ucrlib.lib
		.list

dseg		segment	para public 'data'

s1		byte	"String 1",nl,0
s2		byte	"String 2",nl,0
npS1		word	s1
fpS1		dword	s1


CharVar		byte	'C'
HexVar		word	4321h
DecVar		sword	-4321
UnsVar		word	40000
LongVar		sdword	-654321
LongUns		dword	654321

dseg		ends


cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg


Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax


		print
		byte	"======================",nl
		byte	" P U T S    T E S T S",nl
		byte	"======================",nl,lf,0

		lesi	s1
		puts

		puts	s1
		puts	npS1
		puts	fpS1
		puts	"String 3",nl
	

		print
		byte	nl,lf
		byte	"========================",nl
		byte	" P R I N T    T E S T S",nl
		byte	"========================",nl,lf,0

		print
		byte	"Print 1",nl,0

		print	"Print 2",nl
	

		print
		byte	cr,lf,lf
		byte	"======================",nl
		byte	" P U T C    T E S T S",nl
		byte	"======================",nl,lf,0

		mov	al, 'A'
		putc
		putc	'B'
		putc	CharVar

		mov	ah, al
		putc	ah

		mov	bl, al
		putc	bl

		mov	bh, al
		putc	bh

		mov	cl, al
		putc	cl

		mov	ch, al
		putc	ch

		mov	dl, al
		putc	dl

		mov	dh, al
		putc	dh



		putcr
		putcr


		print
		byte	cr,lf,lf
		byte	"======================",nl
		byte	" P U T H    T E S T S",nl
		byte	"======================",nl,lf,0

		mov	al, 'A'
		puth
		putc	' '
		puth	CharVar
		putcr
		putcr


		print
		byte	cr,lf,lf
		byte	"======================",nl
		byte	" P U T W    T E S T S",nl
		byte	"======================",nl,lf,0

		mov	ax, 1234h
		putw
		putc	' '
		putw	HexVar

		putc	' '
		putw	<ax>

		putc	' '
		mov	bx, ax
		putw	<bx>

		putc	' '
		mov	cx, ax
		putw	<cx>

		putc	' '
		mov	dx, ax
		putw	<dx>

		putc	' '
		mov	si, ax
		putw	<si>

		putc	' '
		mov	di, ax
		putw	<di>

		putc	' '
		mov	bp, ax
		putw	<bp>

		putcr
		putcr


		print
		byte	cr,lf,lf
		byte	"======================",nl
		byte	" P U T I    T E S T S",nl
		byte	"======================",nl,lf,0

		mov	ax, 1234
		puti
		putc	' '
		puti	DecVar

		putc	' '
		puti	<ax>

		putc	' '
		mov	bx, ax
		puti	<bx>

		putc	' '
		mov	cx, ax
		puti	<cx>

		putc	' '
		mov	dx, ax
		puti	<dx>

		putc	' '
		mov	si, ax
		puti	<si>

		putc	' '
		mov	di, ax
		puti	<di>

		putc	' '
		mov	bp, ax
		puti	bp

		putcr
		mov	cx, 6
		puti	ax, cx
		print	nl,"^^^^^^",nl,lf

		mov	ax, 6
		puti	1234, ax
		print	nl,"^^^^^^",nl,lf

		mov	ax, 6
		puti	bp, ax
		print	nl,"^^^^^^",nl,lf

		mov	ax, 1234
		puti	ax, 5
		print	nl,"^^^^^^",nl,lf

		putcr
		putcr



		print
		byte	cr,lf,lf
		byte	"======================",nl
		byte	" P U T U    T E S T S",nl
		byte	"======================",nl,lf,0

		mov	ax, 1234
		putu
		putc	' '
		putu	UnsVar

		putc	' '
		putu	<ax>

		putc	' '
		mov	bx, ax
		putu	<bx>

		putc	' '
		mov	cx, ax
		putu	<cx>

		putc	' '
		mov	dx, ax
		putu	<dx>

		putc	' '
		mov	si, ax
		putu	<si>

		putc	' '
		mov	di, ax
		putu	<di>

		putc	' '
		mov	bp, ax
		putu	<bp>

		putcr
		putcr



		print
		byte	cr,lf,lf
		byte	"======================",nl
		byte	" P U T L    T E S T S",nl
		byte	"======================",nl,lf,0

		mov	eax, 123456
		putl
		putc	' '
		putl	LongVar

		putc	' '
		putl	<eax>

		putc	' '
		mov	ebx, eax
		putl	<ebx>

		putc	' '
		mov	ecx, eax
		putl	<ecx>

		putc	' '
		mov	edx, eax
		putl	<edx>

		putc	' '
		mov	esi, eax
		putl	<esi>

		putc	' '
		mov	edi, eax
		putl	<edi>

		putc	' '
		mov	ebp, eax
		putl	<ebp>

		putcr
		putcr



		print
		byte	cr,lf,lf
		byte	"========================",nl
		byte	" P U T U L    T E S T S",nl
		byte	"========================",nl,lf,0

		mov	eax, 123456
		putul
		putc	' '

		putul	LongUns

		putc	' '
		putul	<eax>

		putc	' '
		mov	ebx, eax
		putul	<ebx>

		putc	' '
		mov	ecx, eax
		putul	<ecx>

		putc	' '
		mov	edx, eax
		putul	<edx>

		putc	' '
		mov	esi, eax
		putul	<esi>

		putc	' '
		mov	edi, eax
		putul	<edi>

		putc	' '
		mov	ebp, eax
		putul	<ebp>

		putcr
		putcr


		print
		byte	cr,lf,lf
		byte	"============================",nl
		byte	" T E X T E Q U    T E S T S",nl
		byte	"============================",nl,lf,0

		print	"PutcStk:",nl
		push	'A'
		putcstk

		print	nl,nl,"PutcStdOut:",nl
		mov	al, 'A'
		PutcStdOut

		print	nl,nl,"PutcBIOS:",nl
		mov	al, 'A'
		PutcBIOS

		putcr

		print	nl,nl,"PutISize:",nl
		mov	ax, -123
		mov	cx, 5
		putisize
		putcr
		push	ax
		push	cx
		putisizestk
		print	nl,"^^^^^",nl,nl

		print	nl,nl,"PutUSize:",nl
		mov	ax, 123
		mov	cx, 5
		putusize
		putcr
		push	ax
		push	cx
		putusizestk
		print	nl,"^^^^^",nl,nl


		print	nl,nl,"PutLSize:",nl
		mov	eax, -123
		mov	cx, 5
		putlsize
		putcr
		push	eax
		push	cx
		putlsizestk
		print	nl,"^^^^^",nl,nl

		print	nl,nl,"PutULSize:",nl
		mov	eax, 123
		mov	cx, 5
		putulsize
		putcr
		push	eax
		push	cx
		putulsizestk
		print	nl,"^^^^^",nl,nl


		

Quit:		mov	ah, 4ch
		int	21h
Main		endp

cseg            ends

sseg		segment	para stack 'stack'
stk             db      1024 dup (?)
sseg		ends


zzzzzzseg	segment	para public 'zzzzzz'
LastBytes	db	16 dup (?)
zzzzzzseg	ends
		end	Main
