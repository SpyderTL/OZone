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





		var

w		word	0
bptr		byte	0
wptr		word	w
dptr		dword	w
	       
	       	endvar




cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg


Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax


		putisize w,2
		putisize w,wptr
		putisize 2,2
		putisize 2,wptr
		putisize [wptr],2
		putisize [wptr],wptr
		putisize [wptr],2
		putisize [dptr],wptr
		putisize [dptr],2


		putlsize 2, 2

Quit:		ExitPgm
Main		endp

cseg            ends
sseg		segment	para stack 'stack'
stk             db      16384 dup (?)
sseg		ends


zzzzzzseg	segment	para public 'zzzzzz'
LastBytes	db	16 dup (?)
zzzzzzseg	ends
		end	Main
