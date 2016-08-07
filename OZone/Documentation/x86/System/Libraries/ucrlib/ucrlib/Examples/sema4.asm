		.xlist
                include         ucrlib.a
                includelib      ucrlib.lib
		.listall

sseg2		segment	para public 'stack2'
stk2		word	256 dup (?)
endstk2		word	?
sseg2		ends



var

MyPCB		pcb	{0,offset endstk2, seg endstk2, offset MyProc, seg MyProc}


stdlib		semaphore {}

endvar




cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg



MyProc		proc	far
		mov	bx, 10
MPLp:		lesi	stdlib
		WaitSemaph
		mov	cx, 240
PrtLp:		putc	'2'
		loop	PrtLp
		lesi	stdlib
		RlsSemaph
		mov	edx, 1000000
DelayLp:	dec	edx
		jne	DelayLp
		dec	bx
		jne	MPLp
		die
		ExitPgm
MyProc		endp



Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax

		MemInit
		InitExcept
		PrcsInit

		try
		lesi	MyPCB
		fork
		cmp	ax,0
		je	ParentProcess
		call	MyProc
		nop

ParentProcess:	

MPLp:		lesi	stdlib
		WaitSemaph

		mov	cx, 240
PrtLp:		putc	'1'
		loop	PrtLp
		lesi	stdlib
		RlsSemaph

		mov	edx, 1000000
lp:		dec	edx
		jne	lp

		jmp	MPLp

		Except	$Break
		jmp	Done
		endtry


Done:		CleanUpEx
		PrcsQuit
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
