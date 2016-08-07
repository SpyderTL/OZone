		.386
		option	segment:use16, proc:private

		.xlist

		include		strtest.a
		include		consts.a
		include		memory.a
		include		stdout.a
		includelib	stdlib.lib


dseg		segment	para public 'data'

StrBuf1		byte	256 dup (?)
StrBuf2		byte	256 dup (?)
StrBuf3		byte	256 dup (?)
StrBufPtr1	dword	StrBuf1
StrBufPtr2	dword	StrBuf2
StrBufPtr3	dword	StrBuf3
StrPtr1		dword	?
StrPtr2		dword	?
StrPtr3		dword	?

dseg		ends


cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg

;Include the string source

		include		StrBDel.asm
		include		StrBDelM.asm
		include		StrCpy.asm
		include		StrCpyM.asm
		include		StrLen.asm

Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax

		meminit

		printf
		byte	"\n\nTesting String Blank Delete\n\n", 0

		StrCpyMCsi
		byte	"     Blank String", 0
		jc	MallocError
		mov	word ptr StrPtr1, di
		mov	word ptr StrPtr1+2, es
		StrCpyM
		jc	MallocError
		mov	word ptr StrPtr2, di
		mov	word ptr StrPtr2+2, es

		les 	di, StrPtr1
		print
		byte	"  StrBDelM Before	- ", 0
		puts
		putcr
		StrBDelM
		print
		byte	"  StrBDelM After	- ", 0
		puts
		putcr

		les 	di, StrPtr1
		print
		byte	"  StrBDelMStk Before	- ", 0
		puts
		putcr
		pushd	StrPtr1
		StrBDelMStk
		print
		byte	"  StrBDelMStk After	- ", 0
		puts
		putcr

		les 	di, StrPtr1
		print
		byte	"  StrBDelMCs Before	- ", 0
		puts
		putcr
		StrBDelMCs
		dword	StrPtr1
		print
		byte	"  StrBDelMCs After	- ", 0
		puts
		putcr

		les	di, StrPtr1
		print
		byte	"  StrBDel Before	- ", 0
		puts
		putcr
		les	di, StrPtr2
		StrBDel
		print
		byte	"  StrBDel After  	- ", 0
		puts
		putcr

		les	di, StrPtr1
		lfs	si, StrPtr2
		StrCpy

		les	di, StrPtr1
		print
		byte	"  StrBDelStk Before	- ", 0
		puts
		putcr
		pushd	StrPtr2
		StrBDelStk
		print
		byte	"  StrBDelstk After	- ", 0
		puts
		putcr

		les	di, StrPtr1
		lfs	si, StrPtr2
		StrCpy

		les	di, StrPtr1
		print
		byte	"  StrBDelCs Before	- ", 0
		puts
		putcr
		StrBDelCs
		dword	StrPtr2
		print
		byte	"  StrBDelCs After	- ", 0
		puts
		putcr


MallocError:
Quit:		ExitPgm			;DOS macro to quit program.
Main		endp
cseg            ends


sseg		segment	para stack 'stack'
stk		db	1024 dup ("stack   ")
sseg		ends


zzzzzzseg	segment	para public 'zzzzzz'
LastBytes	db	16 dup (?)
zzzzzzseg	ends
		end	Main
