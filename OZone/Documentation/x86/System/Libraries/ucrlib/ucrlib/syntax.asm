; Syntax.asm
;
; This file contains all the stdlib routines with all their
; legal varations.
;
; This file is intended for assembly only (to verify the correct
; operation of the standard library macros).  It will not execute
; and produce reasonable results.
;
;
		.xlist
		include         ucrlib.a
                includelib      ucrlib.lib
		.list



; Test the creation of a new data type.


		DclType	Colors, byte

$$Colors	=	1

$$PV_Colors	macro	Int2Prt
		mov	al, Int2Prt
		puth
		endm

$$PP_Colors	macro	Int2Prt
		les	di, Int2Prt
		mov	al, es:[di]
		puth
		endm

$$GV_Colors	macro	Int2Get
		geth
		mov	Int2Get, al
		endm


$$GP_Colors	macro	Int2Get
		geti
		les	di, Int2Get
		mov	es:[di], al
		endm







		var

FltString	byte	"1.0",0

bVar		byte	0
wVar		word	0
dVar		dword	0
fVar		real4	0.0

; Test declarations of existing pre-defined types

		integer	i,j,k

		integer	i0
		integer	i1, *i2x, i3[10], i4[2][4], i5[2][4][8]
		integer	i6=10
		integer	i7=InitList(1,2,3,4,5,6,7,8)

		unsigned	u0
		unsigned	u1, *u2, u3[10], u4[2][4], u5[2][4][8]
		unsigned	u6=10
		unsigned	u7=InitList(1,2,3,4,5,6,7,8)

		long	l0
		long	l1, *i2, l3[10], l4[2][4], l5[2][4][8]
		long	l6=10
		long	l7=InitList(1,2,3,4,5,6,7,8)

		ulong	ul0
		ulong	ul1, *ul2, ul3[10], ul4[2][4], ul5[2][4][8]
		ulong	ul6=10
		ulong	ul7=InitList(1,2,3,4,5,6,7,8)

		char	c0
		char	c1, *c2, c3[10], c4[2][4], c5[2][4][8]
		char	c6=10
		char	c7=InitList(1,2,3,4,5,6,7,8)

		string	s0
		string	s1, *s2, s3[10], s4[2][4], s5[2][4][8]
		string	s6=10
		string	s7=InitList(1,2,3,4,5,6,7,8)

		hex	h0
		hex	h1, *h2, h3[10], h4[2][4], h5[2][4][8]
		hex	h6=10
		hex	h7=InitList(1,2,3,4,5,6,7,8)

		shex	sh0
		shex	sh1, *sh2, sh3[10], sh4[2][4], sh5[2][4][8]
		shex	sh6=10
		shex	sh7=InitList(1,2,3,4,5,6,7,8)

		boolean	b0
		boolean	b1, *b2, b3[10], b4[2][4], b5[2][4][8]
		boolean	b6=10
		boolean	b7=InitList(1,2,3,4,5,6,7,8)

		float	f0
		float	f1, *f2, f3[10], f4[2][4], f5[2][4][8]
		float	f6=10.0
		float	f7=InitList(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0)

		double	d0
		double	d1, *d2, d3[10], d4[2][4], d5[2][4][8]
		double	d6=10.0
		double	d7=InitList(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0)

		extended	e0
		extended	e1, *e2, e3[10], e4[2][4], e5[2][4][8]
		extended	e6=10.0
		extended	e7=InitList(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0)

		colors	clr0
		colors	clr1, *clr2, clr3[10], clr4[2][4], clr5[2][4][8]
		colors	clr6=10
		colors	clr7=InitList(1,2,3,4,5,6,7,8)


		semaphore sem4
		PCBlock	  pcblk
	       
	       	endvar




cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg


Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax
		exitpgm

; Syntax check for atof.

		atof
		atofCS
		atofStk
		atofX


; Syntax check for toFlt:

		toFlt
		toFltCS
		toFltStk

; Syntax check for ftoa:

		ftoa
		ftoax
		ftoam

; Syntax check for etoa:

		etoa
		etoax
		etoam

; Syntax check for HexOutXX

		HexOutLC
		HexOutUC

; Syntax check for IsAlNum

		IsAlNumCS
		IsAlNumStk
		IsAlNumTOS
		IsAlNum
		IsAlNum	bvar
		IsAlNum	[wvar]
		IsAlNum	[dvar]
		IsAlNum	'a'
		IsAlNum	al
		IsAlNum	ah
		IsAlNum	bl
		IsAlNum	bh
		IsAlNum	cl
		IsAlNum	ch
		IsAlNum	dl
		IsAlNum	dh

; IsAlpha Syntax Check.

		IsAlphaCS
		IsAlphaStk
		IsAlphaTOS

		IsAlpha
		IsAlpha	bvar
		IsAlpha	[wvar]
		IsAlpha	[dvar]
		IsAlpha	'a'
		IsAlpha	al
		IsAlpha	ah
		IsAlpha	bl
		IsAlpha	bh
		IsAlpha	cl
		IsAlpha	ch
		IsAlpha	dl
		IsAlpha	dh

; IsUpper Syntax Check.

		IsUpperCS
		IsUpperStk
		IsUpperTOS

		IsUpper
		IsUpper	bvar
		IsUpper	[wvar]
		IsUpper	[dvar]
		IsUpper	'a'
		IsUpper	al
		IsUpper	ah
		IsUpper	bl
		IsUpper	bh
		IsUpper	cl
		IsUpper	ch
		IsUpper	dl
		IsUpper	dh


; IsLower Syntax Check.

		IsLowerCS
		IsLowerStk
		IsLowerTOS

		IsLower
		IsLower	bvar
		IsLower	[wvar]
		IsLower	[dvar]
		IsLower	'a'
		IsLower	al
		IsLower	ah
		IsLower	bl
		IsLower	bh
		IsLower	cl
		IsLower	ch
		IsLower	dl
		IsLower	dh




; Syntax check for IsXDigit

		IsXDigitCS
		IsXDigitStk
		IsXDigitTOS

		IsXDigit
		IsXDigit	bvar
		IsXDigit	[wvar]
		IsXDigit	[dvar]
		IsXDigit	'a'
		IsXDigit	al
		IsXDigit	ah
		IsXDigit	bl
		IsXDigit	bh
		IsXDigit	cl
		IsXDigit	ch
		IsXDigit	dl
		IsXDigit	dh

; Syntax check for IsDigit

		IsDigitCS
		IsDigitStk
		IsDigitTOS

		IsDigit
		IsDigit	bvar
		IsDigit	[wvar]
		IsDigit	[dvar]
		IsDigit	'a'
		IsDigit	al
		IsDigit	ah
		IsDigit	bl
		IsDigit	bh
		IsDigit	cl
		IsDigit	ch
		IsDigit	dl
		IsDigit	dh

; ToUpper Syntax Check.

		ToUpperCS
		ToUpperStk
		ToUpperTOS

		ToUpper
		ToUpper	bvar
		ToUpper	[wvar]
		ToUpper	[dvar]
		ToUpper	'a'
		ToUpper	al
		ToUpper	ah
		ToUpper	bl
		ToUpper	bh
		ToUpper	cl
		ToUpper	ch
		ToUpper	dl
		ToUpper	dh


; ToLower Syntax Check.

		ToLowerCS
		ToLowerStk
		ToLowerTOS

		ToLower
		ToLower	bvar
		ToLower	[wvar]
		ToLower	[dvar]
		ToLower	'a'
		ToLower	al
		ToLower	ah
		ToLower	bl
		ToLower	bh
		ToLower	cl
		ToLower	ch
		ToLower	dl
		ToLower	dh


; Syntax check for ISize, USize, LSize, and ULSize

		IsizeStk
		ISizeTOS

		ISize	wVar
		ISize	[wVar]
		ISize	[dVar]
		ISize	12345
		ISize	ax
		ISize	bx
		ISize	cx
		ISize	dx
		ISize	si
		ISize	di
		ISize	bp
		ISize	sp


		UsizeStk
		USizeTOS

		USize	wVar
		USize	[wVar]
		USize	[dVar]
		USize	12345
		USize	ax
		USize	bx
		USize	cx
		USize	dx
		USize	si
		USize	di
		USize	bp
		USize	sp


		ULsizeStk
		ULSizeTOS
		 
		ULSize	wVar
		ULSize	[wVar]
		ULSize	[dVar]
		ULSize	12345
		ULSize	ax
		ULSize	bx
		ULSize	cx
		ULSize	dx
		ULSize	si
		ULSize	di
		ULSize	bp
		ULSize	sp


		LsizeStk
		LSizeTOS
		 
		LSize	wVar
		LSize	[wVar]
		LSize	[dVar]
		LSize	12345
		LSize	ax
		LSize	bx
		LSize	cx
		LSize	dx
		LSize	si
		LSize	di
		LSize	bp
		LSize	sp



; Syntax check for atoh, atolh, atoi, atou, atol, and atoul

		atoh
		atohCS
		atohStk
		atohTOS
		atohX

		atoh		bvar

		atoh		bvar, wvar
		atoh		bvar, [wvar]
		atoh		bvar, [dvar]

		atoh		[wvar], wvar
		atoh		[wvar], [wvar]
		atoh		[wvar], [dvar]

		atoh		[dvar], wvar
		atoh		[dvar], [wvar]
		atoh		[dvar], [dvar]



		atolh
		atolhCS
		atolhStk
		atolhTOS
		atolhX

		atolh		bvar

		atolh		bvar, dvar
		atolh		bvar, [wvar]
		atolh		bvar, [dvar]

		atolh		[wvar], dvar
		atolh		[wvar], [wvar]
		atolh		[wvar], [dvar]

		atolh		[dvar], dvar
		atolh		[dvar], [wvar]
		atolh		[dvar], [dvar]




		atoi
		atoiCS
		atoiStk
		atoiTOS
		atoiX

		atoi		bvar

		atoi		bvar, wvar
		atoi		bvar, [wvar]
		atoi		bvar, [dvar]

		atoi		[wvar], wvar
		atoi		[wvar], [wvar]
		atoi		[wvar], [dvar]

		atoi		[dvar], wvar
		atoi		[dvar], [wvar]
		atoi		[dvar], [dvar]





		atou
		atouCS
		atouStk
		atouTOS
		atouX

		atou		bvar

		atou		bvar, wvar
		atou		bvar, [wvar]
		atou		bvar, [dvar]

		atou		[wvar], wvar
		atou		[wvar], [wvar]
		atou		[wvar], [dvar]

		atou		[dvar], wvar
		atou		[dvar], [wvar]
		atou		[dvar], [dvar]





		atoul
		atoulCS
		atoulStk
		atoulTOS
		atoulX

		atoul		bvar

		atoul		bvar, dvar
		atoul		bvar, [wvar]
		atoul		bvar, [dvar]

		atoul		[wvar], dvar
		atoul		[wvar], [wvar]
		atoul		[wvar], [dvar]

		atoul		[dvar], dvar
		atoul		[dvar], [wvar]
		atoul		[dvar], [dvar]





		atol
		atolCS
		atolStk
		atolTOS
		atolX

		atol		bvar

		atol		bvar, dvar
		atol		bvar, [wvar]
		atol		bvar, [dvar]

		atol		[wvar], dvar
		atol		[wvar], [wvar]
		atol		[wvar], [dvar]

		atol		[dvar], dvar
		atol		[dvar], [wvar]
		atol		[dvar], [dvar]



; Syntax check for htoa, wtoa, itoa, utoa, ltoa, ultoa

		htoa
		htoaCS
		htoaStk
		htoaTOS
		htoaX

		htoa		bvar

		htoa		bvar, bvar
		htoa		bvar, [wVar]
		htoa		bvar, [dVar]

		htoa		[wVar], bVar
		htoa		[wVar], [wVar]
		htoa		[wVar], [dVar]

		htoa		[dVar], bVar
		htoa		[dVar], [wVar]
		htoa		[dVar], [dVar]




		wtoa
		wtoaCS
		wtoaStk
		wtoaTOS
		wtoaX

		wtoa		bvar

		wtoa		bvar, wvar
		wtoa		bvar, [wVar]
		wtoa		bvar, [dVar]

		wtoa		[wVar], wVar
		wtoa		[wVar], [wVar]
		wtoa		[wVar], [dVar]

		wtoa		[dVar], wVar
		wtoa		[dVar], [wVar]
		wtoa		[dVar], [dVar]




		itoa
		itoaCS
		itoaStk
		itoaTOS
		itoaX

		itoa		bvar

		itoa		bvar, wvar
		itoa		bvar, [wVar]
		itoa		bvar, [dVar]

		itoa		[wVar], wVar
		itoa		[wVar], [wVar]
		itoa		[wVar], [dVar]

		itoa		[dVar], wVar
		itoa		[dVar], [wVar]
		itoa		[dVar], [dVar]




		utoa
		utoaCS
		utoaStk
		utoaTOS
		utoaX

		utoa		bvar

		utoa		bvar, wvar
		utoa		bvar, [wVar]
		utoa		bvar, [dVar]

		utoa		[wVar], wVar
		utoa		[wVar], [wVar]
		utoa		[wVar], [dVar]

		utoa		[dVar], wVar
		utoa		[dVar], [wVar]
		utoa		[dVar], [dVar]




		ultoa
		ultoaCS
		ultoaStk
		ultoaTOS
		ultoaX

		ultoa		bvar

		ultoa		bvar, dvar
		ultoa		bvar, [wVar]
		ultoa		bvar, [dVar]

		ultoa		[wVar], dVar
		ultoa		[wVar], [wVar]
		ultoa		[wVar], [dVar]

		ultoa		[dVar], dVar
		ultoa		[dVar], [wVar]
		ultoa		[dVar], [dVar]



		ltoa
		ltoaCS
		ltoaStk
		ltoaTOS
		ltoaX

		ltoa		bvar

		ltoa		bvar, dvar
		ltoa		bvar, [wVar]
		ltoa		bvar, [dVar]

		ltoa		[wVar], dVar
		ltoa		[wVar], [wVar]
		ltoa		[wVar], [dVar]

		ltoa		[dVar], dVar
		ltoa		[dVar], [wVar]
		ltoa		[dVar], [dVar]



; Test the Getc, Geth, Peekc, RawGets, and Gets macros and text equates.

		getc
		getcCS
		getcStk

		getc	bVar
		getc	[wVar]
		getc	[dVar]

		geth
		gethCS
		gethStk

		geth	bVar
		geth	[wVar]
		geth	[dVar]



		Peekc
	        PeekcCS
		PeekcStk

		Peekc	bVar
		Peekc	[wVar]
		Peekc	[dVar]


		gets
		getsCS
		getsStk

		gets	bVar
		gets	[wVar]
		gets	[dVar]


		rawgets
		rawgetsCS
		rawgetsStk
		
		rawgets	bVar
		rawgets	[wVar]
		rawgets	[dVar]


; Test the GetcLen, Geti, Getu, and Getw macros and text equates.

		getcLen
		getcLenCS
		getcLenStk

		getcLen	wVar
		getcLen	[wVar]
		getcLen	[dVar]


		geti
		getiCS
		getiStk

		geti	wVar
		geti	[wVar]
		geti	[dVar]


		getu
		getuCS
		getuStk

		getu	wVar
		getu	[wVar]
		getu	[dVar]

		getw
		getwCS
		getwStk

		getw	wVar
		getw	[wVar]
		getw	[dVar]




; Test the GetL, GetUL, and GethL macros and text equates.

		getl
		getlCS
		getlStk

		getl	dVar
		getl	[wVar]
		getl	[dVar]


		getul
		getulCS
		getulStk

		getul	dVar
		getul	[wVar]
		getul	[dVar]


		gethl
		gethlCS
		gethlStk

		gethl	dVar
		gethl	[wVar]
		gethl	[dVar]


; Test the scanf and scanff macros and text equates.

		
		scanf
		scanf	"%d",wVar
		scanf	"%d %c %dl",wVar,bVar,dVar

		scanff
		scanff	"%f",fVar
		scanff	"%d %c %dl",wVar,bVar,dVar


; Test the putc and puth macros and text equates

		putc
		putcCS
		putcStk
		putcTOS
		putc	bVar
		putc	[wVar]
		putc	[dVar]

		puth
		puthCS
		puthStk
		puthTOS
		puth	bVar
		puth	[wVar]
		puth	[dVar]


; Test the puti, putu, and putw macros and text equates

		puti
		putiCS
		putiStk
		putiTOS
		puti	wVar
		puti	[wVar]
		puti	[dVar]
		puti	2, 2
		puti	wVar, 5
		puti	wVar, wVar
		puti	[wVar],5
		puti	[wVar],wVar
		puti	[dVar],5
		puti	[dVar],wVar

		putu
		putuCS
		putuStk
		putuTOS
		putu	wVar
		putu	[wVar]
		putu	[dVar]
		putu	2, 2
		putu	wVar, 5
		putu	wVar, wVar
		putu	[wVar],5
		putu	[wVar],wVar
		putu	[dVar],5
		putu	[dVar],wVar

		putw
		putwCS
		putwStk
		putwTOS
		putw	wVar
		putw	[wVar]
		putw	[dVar]


; Test the putL and putul macros and text equates


		putl
		putlCS
		putlStk
		putlTOS
		putl	dVar
		putl	[wVar]
		putl	[dVar]
		putl	2, 2
		putl	dVar, 5
		putl	dVar, wVar
		putl	[wVar],5
		putl	[wVar],wVar
		putl	[dVar],5
		putl	[dVar],wVar

		putul
		putulCS
		putulStk
		putulTOS
		putul	dVar
		putul	[wVar]
		putul	[dVar]
		putul	2, 2
		putul	dVar, 5
		putul	dVar, wVar
		putul	[wVar],5
		putul	[wVar],wVar
		putul	[dVar],5
		putul	[dVar],wVar


; Test the putisize and putusize macros and text equates

		putisize
		putisizeCS
		putisizeStk
		putisizeTOS
		putisize	2, 2
		putisize	wVar, 5
		putisize	wVar, wVar
		putisize	[wVar],5
		putisize	[wVar],wVar
		putisize	[dVar],5
		putisize	[dVar],wVar

		putusize
		putusizeCS
		putusizeStk
		putusizeTOS
		putusize	2, 2
		putusize	wVar, 5
		putusize	wVar, wVar
		putusize	[wVar],5
		putusize	[wVar],wVar
		putusize	[dVar],5
		putusize	[dVar],wVar



; Test the putlsize and putulsize macros and text equates

		putlsize
		putlsizeCS
		putlsizeStk
		putlsizeTOS
		putlsize	2, 2
		putlsize	dVar, 5
		putlsize	dVar, wVar
		putlsize	[wVar],5
		putlsize	[wVar],wVar
		putlsize	[dVar],5
		putlsize	[dVar],wVar

		putulsize
		putulsizeCS
		putulsizeStk
		putulsizeTOS
		putulsize	2,2
		putulsize	dVar, 5
		putulsize	dVar, wVar
		putulsize	[wVar],5
		putulsize	[wVar],wVar
		putulsize	[dVar],5
		putulsize	[dVar],wVar


; Test the puts and print macros and text equates here.

		puts
		puts	bVar
		puts	[wVar]
		puts	[dVar]
		puts	"Hello"
		puts	"Hello ","there"
		puts	"Hello there",nl
		puts	nl

		print	"Hello"
		print	"Hello ","there"
		print	"Hello there",nl
		print	nl


; Test the printf and printff macros and text equates here.

		printf
		printfr
		printfstk

		printf	"Hello"
		printf	"Hello ","there"


		printf	"Hello there",nl
		printf	nl
		printf	"%d",wVar
		printf	"%d","%c",wVar,bVar
		printf	"%d",nl,wVar

		printff
		printffr
		printffstk

		printff	"Hello"
		printff	"Hello ","there"
		printff	"Hello there",nl
		printff	nl
		printff	"%d",wVar
		printff	"%d","%c",wVar,bVar
		printff	"%d",nl,wVar



; Miscellaneous routines:

		putcr
		PutcStdOut
		PutcBIOS
		GetOutAdrs
		SetOutAdrs
		PushOutAdrs
		PopOutAdrs
		ResetStdOut
		HexOutLC
		HexOutUC
		putf
		pute


; The exception handling macros, textequs, and so on.

		InitExcept
		InitExcept $CritErr

		Raise
		Raise	$Conversion

		PassExcept
		PassExcept $Conversion

		try
		except	$Conversion
		endtry

		EnableExcept
		DisableExcept
		GetXEnabled

		InitEx24
		CleanUpEx
;		CritErrRtn


; Checks of some of the DCL macros:

		Index	h4, i, j
		Index	h4, i, j, si

		Index	b4, i, j
		Index	b4, i, j, si

		Index	d4, i, j
		Index	d4, i, j, si


; Check out the iostream macros:

		cout	i, i0, c0, d0, f0, b0, h0, l0, s0, u0, ul0, sh0, clr0
		cin	i, i0, c0, d0, f0, b0, h0, l0, s0, u0, ul0, sh0, clr0


; Memory manager tests:

		MemInit
		MemInit2
		Malloc
		Free
		Realloc
		DupPtr
		IsInHeap
		IsPtr
		HeapStart
		BlockSize
		MemAvail
		MemFree
		BasePtr


; Miscellaneous routine tests:

		Argv
		Argc
		Randomize
		Random
		CPUIdent

		GetEnv
		GetEnvCS
		GetEnvStk


; Test of process macros and text equates:


		PrcsInit
		PrcsQuit
		Kill
		Die
		Sleep
		YieldCPU
		Fork
		ForkCS
		ForkStk
		
		CoInit
		CoCall
		CoCallCS

		WaitSemaph
		WaitSemaphCS
		WaitSemaphStk

		RlsSemaPh
		RlsSemaPhCS
		RlsSemaPhStk







Quit:		ExitPgm
Main		endp

cseg            ends
		end	Main
