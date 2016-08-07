		.xlist
                include         ucrlib.a
                includelib      ucrlib.lib
;		.listall


maxArgs		=	50
wp		textequ	<word ptr>

var
	
	string *args[maxArgs]
	integer ArgCnt

endvar




cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg

Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax

		MemInit
		InitExcept
		EnableExcept


		mov	ax, 0
		mov	bx, ax
		argcCX
		jcxz	NoParms
CXLP:		inc	ax
		argv
		mov	wp args[bx], di
		mov	wp args[bx+2], es
		add	bx, 4
		loop	CXLP
NoParms:	mov	ArgCnt, ax


		mov	bx, 0
		mov	ax, 1
		mov	cx, ArgCnt
		jcxz	Done
	.listall
Lp2:		print	"Parameter "
		puti
		print	" = "
		les	di, args[bx]
		puts
		putcr
		add	bx, 4
		inc	ax
		loop	Lp2
Done:

		CleanUpEx

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
