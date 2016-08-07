		.386
		option	segment:use16, proc:private


		include	consts.a
		include	process.a
		include	excepts.a

		echo	PrcsInit, PrcsQuit, YieldCPU, Kill, Die, Fork
	

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing

wp		equ	<word ptr>

DefaultPCB	pcb	<>
ProcessID	word	0
ReadyQ		dword	DefaultPCB
LastRdyQ	dword	DefaultPCB


TimerIntVect	dword	?

TimerTickCnt	dword	0,0		;64-bit counter!


;============================================================================
; Process package.
; These routines handle multitasking/multiprogramming in the standard
; library.
;============================================================================
;
;
; prcsinit-	Initializes the process manager.  By default, this guy
;		assumes the use of the 1/18 second timer.  At some future
;		date I may add support for the AT msec timer.
;
;		Warning: This code patches into several interrupts.  If
;		you call this routine in your program, you must call the
;		prcsquit routine before your program terminates.  Other-
;		wise the system will crash shortly thereafter.

		public	$PrcsInit
$prcsinit	proc	far
		assume	ds:ucrlib

		push	ds
		push	es
		push	ax
		push	bx
		push	cx
		push	dx

		mov	ax, cs
		mov	ds, ax

; Okay, set up this code as the first (and only) process currently in the
; ready queue:

		mov	ax, offset DefaultPCB
		mov	wp ReadyQ, ax
		mov	wp LastRdyQ, ax
		mov	ax, ds
		mov	wp ReadyQ+2, ax
		mov	wp LastRdyQ+2, ax

		xor	ax, ax
		mov	ProcessID, ax			;Start process IDs at 0

		mov	wp DefaultPCB.NextProc, ax
		mov	wp DefaultPCB.NextProc[2], ax
		mov	wp DefaultPCB.CPUTime+2, ax
		mov	wp DefaultPCB.CPUTime+2, 1

		mov	ah, 2ah				;Get the date.
		int	21h
		mov	wp DefaultPCB.StartingDate, cx
		mov	wp DefaultPCB.StartingDate+2, dx

		mov	ah, 2ch				;Get the time.
		int	21h
		mov	wp DefaultPCB.StartingTime, cx
		mov	wp DefaultPCB.StartingTime+2, dx


		mov	ax, 3508h		;Timer interrupt vector.
		int	21h
		mov	wp TimerIntVect, bx
		mov	wp TimerIntVect+2, es

		mov	ax, 2508h		;Patch the dispatcher into the
		mov	dx, seg TimerISR	; timer interrupt.
		mov	ds, dx
		mov	dx, offset TimerISR
		int	21h


		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	es
		pop	ds
		ret
$prcsinit	endp
		assume	ds:nothing


; prcsquit-	This code restores the interrupt vectors patched by the
;		prcsinit routine.  This routine *must* be called before
;		you exit your program or the system will crash shortly
;		thereafter.

		public	$PrcsQuit
$prcsquit	proc	far
		assume	ds:ucrlib

		push	ds
		push	es
		push	ax
		mov	ax, cs
		mov	ds, ax

		mov	ax, 0
		mov	es, ax

; Cannot call DOS to restore this vector because this call might
; occur in a critical error or break handler routine.

		pushf
		cli
		mov	ax, wp TimerIntVect
		mov	es:[8*4], ax
		mov	ax, wp TimerIntVect+2
		mov	es:[8*4 + 2], ax
		popf

		pop	ax
		pop	es
		pop	ds
		ret
$prcsquit	endp
		assume	ds:nothing



; fork-		Starts a new process.  On entry, ES:DI points at a PCB.
;		This routine initializes that process and adds it to the
;		ready queue.
;
;		WARNING: This routine assumes that the only information to
;		copy off the stack is a far return address (to FORK). When
;		fork returns there will be nothing sitting on the stack of
;		the new process.  Therefore, you should not call fork from
;		inside a procedure if you expect the child process to return
;		to the called procedure.
;
;		This code assumes that you've initialized the ssSave and
;		spSave fields of the new PCB with the address of a stack
;		for that new process.
;
;		This guy returns with AX=0 and BX=<ChildProcessID> to the
;		parent process.  It returns AX=<ChildProcessID> and BX=0
;		to the child process.
;
; ForkCS-	Address of PCB immediately follows the call in the code
;		stream.
;
; ForkStk-	Address of PCB appears on the stack.


		public	$ForkStk
$ForkStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+6]	;Get ptr to PCB
		call	$fork
		pop	di
		pop	es
		pop	bp
		ret	4
$ForkStk	endp


		public	$ForkCS
$ForkCS		proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+2]	;Get return address.
		les	di, es:[di]	;Get adrs of PCB from code stream.
		call	$Fork		;Do the fork.

; Fix the return address (point it past the PCB's address).

		add	wp [bp+2], 4
		pop	di
		pop	es
		pop	bp
		ret	4
$ForkCS		endp



		public	$fork
$fork		proc	far
		assume	ds:nothing

		push	bp
		mov	bp, sp
		push	cx
		push	dx
		push	ds
		push	es


; Initialize various fields in the new PCB:
; Start with the registers.  Remember, AX contains the process ID for the
; child process, BX contains zero for the child process.  AX contains zero
; for the parent process, and BX contains the child process ID for the
; parent process.
;
; SS:SP should already be set up on entry (by the caller).

		push	ds		;Save for new PCB
		push	es
		pop	ds		;For efficiency

		inc	ProcessID		;Grab a new process ID.
		movzx	eax, ProcessID
		mov	[di].pcb.regeax, eax
		mov	[di].pcb.PrcsID, ax
		xor	eax, eax
		mov	[di].pcb.regebx, eax
		mov	[di].pcb.regecx, eax
		mov	[di].pcb.regedx, eax
		mov	[di].pcb.regebp, eax
		mov	[di].pcb.regesi, eax
		mov	[di].pcb.regedi, eax
		pop	[di].pcb.regds		;Value we saved above.
		mov	[di].pcb.reges, ds	;ES' value is in DS now.
		mov	[di].pcb.regfs, fs
		mov	[di].pcb.reggs, gs
		sti				;Must have interrupts on!
		pushf
		cli				;But the rest is a critical
		pop	[di].pcb.regflags

; The return address should be the return address for fork:

		mov	ax, 2[bp]		;Get return offset
		mov	[di].pcb.regip, ax
		mov	ax, 4[bp]		;Get return segment
		mov	[di].pcb.regcs, ax


; Set up accounting information (CPU time):

		mov	[di].pcb.CPUTime, 0

		mov	ah, 2ah				;Get the date.
		int	21h
		mov	wp [di].pcb.StartingDate, cx
		mov	wp [di].pcb.StartingDate+2, dx

		mov	ah, 2ch				;Get the time.
		int	21h
		mov	wp [di].pcb.StartingTime, cx
		mov	wp [di].pcb.StartingTime+2, dx


; Okay, now move the new PCB onto the ready queue (interrupts must be off
; while we're doing this!).  Place this guy in the ready queue after the
; current process so it gets a time slice real soon.

		cli
		push	es
		push	di
		les	di, ReadyQ
		mov	cx, wp es:[di].pcb.NextProc
		mov	dx, wp es:[di+2].pcb.NextProc
		pop	wp es:[di].pcb.NextProc
		pop	wp es:[di+2].pcb.NextProc
		les	di, es:[di].pcb.NextProc	;Pt ES:DI @ new prcs.
		mov	wp es:[di].pcb.NextProc, cx	;Link in prev 2nd
		mov	wp es:[di+2].pcb.NextProc, dx	; process.

; If there was only one process on the ready queue prior to adding this
; process, point the LastRdyQ pointer at the new process.

		mov	eax, ReadyQ
		cmp	eax, LastRdyQ
		jne	RdyNELast
		mov	wp LastRdyQ, di
		mov	wp LastRdyQ+2, es


; Okay, return back to the calling code with AX=0 to denote that this is
; the parent routine returning.  It also returns the child process ID in
; the BX register.

RdyNELast:	xor	eax, eax
		mov	ebx, eax
		mov	bx, ProcessID
		pop	es
		pop	ds
		pop	dx
		pop	cx
		pop	bp
		sti		;Reenable interrupts!
		ret
$fork		endp
		assume	ds:nothing



; Die-		Terminate the current process.  If this is not the only
;		process in the ready queue, then this code removes the current
;		process from the ready queue and transfers control to the
;		next process in the Ready Queue.  Since the current process
;		is not the the ready queue, this action effectively kills
;		the current process.
;
;		This routine will *not* delete the current process from the
;		ready queue if it is the *only* process in the ready queue.
;		In such an event, this code returns to the caller with the
;		carry flag set (it returns this way because Kill can call
;		this routine and Kill requires the carry set if an error
;		occurs).


		public	$Die
$Die		proc	far
		assume	ds:ucrlib

		pushf			;Push registers onto the stack just
		push	ds		; in case there is an error return.
		push	di

		mov	di, cs
		mov	ds, di
		cli				;Critical region ahead!


		les	di, ReadyQ
		cmp	wp es:[di].pcb.NextProc+2, 0
		jne	GoodDIE

; YIKES! The caller is trying to delete the only process in the ReadyQ.
; We can't let that happen, so return an error down here.

		call	$GetXEnabled
		cmp	ax, 0
		je	JustReturn
		mov	ax, $LastProcess
		call	$Raise

JustReturn:	pop	di
		pop	ds
		stc
		ret

; Okay, this DIE operation can proceed.  Handle that down here.

GoodDIE:	mov	eax, es:[di].pcb.NextProc
		mov	ReadyQ, eax

; The following code, which passes control to the new "current process"
; must look exactly like the code at the tail end of the dispatcher!
; In particular, the values pushed at the beginning of this routine are
; history.  They are on a different stack, which will not be accessed again,
; so we do not need to worry about them.

		les	di, ReadyQ
		inc	es:[di].pcb.CPUTime

		lss	sp, es:[di].pcb.regsssp
		push	es:[di].pcb.regflags
		push	es:[di].pcb.regcs
		push	es:[di].pcb.regip
		mov	eax, es:[di].pcb.regeax
		mov	ebx, es:[di].pcb.regebx
		mov	ecx, es:[di].pcb.regecx
		mov	edx, es:[di].pcb.regedx
		mov	ebp, es:[di].pcb.regebp
		mov	esi, es:[di].pcb.regesi
		mov	ds, es:[di].pcb.regds
		mov	fs, es:[di].pcb.regfs
		mov	gs, es:[di].pcb.reggs

		push	es:[di].pcb.regedi
		mov	es, es:[di].pcb.reges
		pop	edi
		iret
$DIE		endp






; kill-		Terminates some other process.  If this call kills the current
;		process, it effectively becomes a "die" call.  On entry, AX
;		must contain the process ID of the process to kill.
;		Returns carry set if no such process exists.  Returns carry
;		clear if it killed the process.  It is your responsibility
;		to ensure all resources in use by the killed process are
;		freed.
;
;		Note that this routine may  *not*  return if it kills
;		itself (see Die for more details).


		public	$Kill
$kill		proc	far
		assume	ds:ucrlib

		pushf
		push	ds
		push	es
		push	ax
		push	bx
		push	cx
		push	di

		mov	di, ucrlib
		mov	ds, di
		cli				;Critical region ahead!


		les	di, ReadyQ		;See if this is a die oper-
		cmp	ax, es:[di].pcb.PrcsID	; ation.
		jne	DoKill
		pop	di
		pop	cx
		pop	bx
		pop	ax
		pop	es
		pop	ds
		popf
		jmp	$Die

; If it's not the current process, search for the process in the ready queue.

DoKill:		cmp	wp es:[di].pcb.NextProc+2, 0 	;Error if not
		je	BadKill				; present in rdy Q.
		mov	bx, di
		mov	cx, es
		les	di, es:[di].pcb.NextProc
		cmp	ax, es:[di].pcb.PrcsID
		jne	DoKill

; Okay, remove the PCB pointed at by ES:DI from the ready queue.  Note that
; CX:BX points at the previous entry in the queue.

StopHere:
		mov	ax, wp es:[di].pcb.NextProc+2
		mov	di, wp es:[di].pcb.NextProc
		xchg	di, bx
		mov	es, cx
		mov	wp es:[di].pcb.NextProc, bx
		mov	wp es:[di].pcb.NextProc+2, ax
		pop	di
		pop	cx
		pop	bx
		pop	ax
		pop	es
		pop	ds
		popf
		clc
		ret

BadKill:        call	$GetXEnabled
		cmp	ax, 0
		je	JustReturn
		mov	ax, $NoSuchProcess
		call	$Raise

JustReturn:	pop	di
		pop	cx
		pop	bx
		pop	ax
		pop	es
		pop	ds
		popf
		stc
		ret
$Kill		endp


;============================================================================
;
; Sleep-	EAX contains a number of clock ticks to sleep on.  The current
;		process suspends until (at least) that many clock ticks have
;		expired.

		public	$Sleep
$Sleep		proc	far
		assume	ds:nothing, es:nothing

		push	eax
		push	edx
		xor	edx, edx
		add	eax, TimerTickCnt	;Compute time to wake up.
		adc	edx, 0
SleepLp:	cmp	edx, TimerTickCnt+4
		jb	WakeUp
		cmp	eax, TimerTickCnt
		jb	WakeUp
		call	$YieldCPU		;Give away this time slice.
		jmp	SleepLp			;See if our time expired.

WakeUp:		pop	edx
		pop	eax
		ret
$Sleep		endp

;============================================================================
;
; YieldCPU-	Cause the current process to give up the remainder of its
;		time slice.
;
; *** This is the Dispatcher ***
;
;   This guy is also responsible for switching to a new process whenever a
; timer interrupt comes along.


		public	$YieldCPU
$YieldCPU	proc	far
		assume	ds:ucrlib, es:ucrlib

		pushf
		cli
		push	ds
		push	edi

; Save the state of the current process.


		mov	di, ucrlib
		mov	ds, di
		lds	di, ReadyQ		;Get ptr to current PCB.
		mov	[di].pcb.regeax, eax
		mov	[di].pcb.regebx, ebx
		mov	[di].pcb.regecx, ecx
		mov	[di].pcb.regedx, edx
		mov	[di].pcb.regebp, ebp
		mov	[di].pcb.regesi, esi
		mov	[di].pcb.reges, es
		pop	[di].pcb.regedi
		pop	[di].pcb.regds
		pop	[di].pcb.regflags
		pop	[di].pcb.regip
		pop	[di].pcb.regcs
		mov	wp [di].pcb.regsssp, sp
		mov	wp [di].pcb.regsssp+2, ss

; Adjust the CPU time for the process we've just stopped.

		inc	[di].pcb.CPUTime


; The following kludge takes care of the case where there is only one process
; active in the ready queue:

		cmp	wp [di].pcb.NextProc+2, 0
		je	RequeueDone


; If not the only entry, move it to the end of the ready queue here.
; Begin by storing a pointer to the current process in the NextProc field
; of the last process in the queue:

		mov	di, ucrlib
		mov	ds, di

		les	di, LastRdyQ
		mov	eax, ReadyQ
		mov	LastRdyQ, eax
		mov	es:[di].pcb.NextProc, eax

; Now get the next process in the chain after the current process and make
; it the new process to execute by placing it at the front of the ready queue:

		les	di, ReadyQ
		mov	eax, es:[di].pcb.NextProc
		mov	ReadyQ, eax
		mov     es:[di].pcb.NextProc, 0

RequeueDone:

; Okay, transfer control to the (possibly new) procedure at the front of the
; ready queue:

		mov	di, ucrlib
		mov	ds, di
		lds	di, ReadyQ
		lss	sp, [di].pcb.regsssp
		push	[di].pcb.regflags
		push	[di].pcb.regcs
		push	[di].pcb.regip
		push	[di].pcb.regedi
		mov	eax, [di].pcb.regeax
		mov	ebx, [di].pcb.regebx
		mov	ecx, [di].pcb.regecx
		mov	edx, [di].pcb.regedx
		mov	ebp, [di].pcb.regebp
		mov	esi, [di].pcb.regesi
		mov	es, [di].pcb.reges
		mov	ds, [di].pcb.regds
		pop	edi
		iret
$YieldCPU	endp
		assume	ds:nothing, es:nothing



;****************************************************************************
;
; WaitSemaph- Waits on a given semaphore.  If there is only one process in
;	      the ready queue, this will cause a deadlock!  But that's the
;	      programmer's fault, not ours.
;
; WaitSemaph- 		ES:DI points at the semaphore.
; WaitSemaphStk-	Address of semaphore is on the stack.
; WaitSemaphCS-		Address of semaphore follows in the code stream.



		public	$WaitSemaPhStk
$WaitSemaPhStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+6]	;Get ptr to PCB
		call	$WaitSemaph
		pop	di
		pop	es
		pop	bp
		ret	4
$WaitSemaphStk	endp


		public	$WaitSemaPhCS
$WaitSemaphCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+2]	;Get return address.
		les	di, es:[di]	;Get adrs of PCB from code stream.
		call	$WaitSemaPh	;Do the wait.

; Fix the return address (point it past the PCB's address).

		add	word ptr [bp+2], 4
		pop	di
		pop	es
		pop	bp
		ret	
$WaitSemaphCS	endp




		public	$WaitSemaph
$WaitSemaph	proc	far
		assume	ds:ucrlib


		dec	es:[di].sema4.SemaCnt
		jns	NoWait



		pushf
		push	ds
		push	esi
		cli

; Save the state of the current process so we can remove it from the
; Ready Queue:

		mov	si, ucrlib
		mov	ds, si
		lds	si, ReadyQ		;Get ptr to current PCB.
		mov	[si].pcb.regeax, eax
		mov	[si].pcb.regebx, ebx
		mov	[si].pcb.regecx, ecx
		mov	[si].pcb.regedx, edx
		mov	[si].pcb.regebp, ebp
		mov	[si].pcb.regedi, edi
		mov	[si].pcb.reges, es
		mov	[si].pcb.regfs, fs
		mov	[si].pcb.reggs, gs
		pop	[si].pcb.regesi
		pop	[si].pcb.regds
		pop	[si].pcb.regflags
		pop	[si].pcb.regip
		pop	[si].pcb.regcs
		mov	wp [si].pcb.regsssp, sp
		mov	wp [si].pcb.regsssp+2, ss

; Adjust the CPU time for the process we've just stopped.

		inc	[si].pcb.CPUTime

; Okay, now that we've saved away the info for this process, let's move
; it off the ready queue and onto the semaphore queue.  Start by checking
; to see if there is anything currently on the semaphore queue:

		mov	ax, ucrlib
		mov	ds, ax
		cmp	wp es:[di+2].sema4.smaphrlst, 0	;Empty list?
		jne	JustSetEnd

; If the semaphore list is empty, move the current process from the ready
; queue to the semaphore list and make it the beginning and ending entry.

		mov	eax, ReadyQ				;Point both
		mov	es:[di].sema4.smaphrlst, eax	; the head
		mov	es:[di].sema4.endsmaphrlst, eax	; and tail
		jmp	RmvFromRdy


; If there are other items in this semaphore list, just place the current
; process at the end of the queue.

JustSetEnd:	push	es
		push	di
		les	di, es:[di].sema4.endsmaphrlst	;Link in the
		mov	eax, ReadyQ				; current
		mov	es:[di].pcb.NextProc, eax		; process to
		pop	di					; the sema-
		pop	es					; phore chain.

; Point semaphore end pointer to current process.

		mov	eax, ReadyQ
		mov	es:[di].sema4.endsmaphrlst, eax

; Now, remove this process from the ready queue.  Note there is no test to
; see if this is the last item on the ready queue.  It is the programmer's
; responsibility to prevent this (It could only happen if the programmer is
; playing with the private fields of the semaphore data structure or if
; s/he makes two successive calls to WaitSemaph).

RmvFromRdy:	les	di, ReadyQ
		mov	eax, es:[di].pcb.NextProc
		mov	ReadyQ, eax
		xor	eax, eax			;Store NULL into the
		mov	es:[di].pcb.NextProc, eax	; link address.


; Okay, transfer control to the (possibly new) procedure at the front of the
; ready queue:

		lds	si, ReadyQ
		mov	ss, wp [si].pcb.regsssp+2
		mov	sp, wp [si].pcb.regsssp
		push	[si].pcb.regflags
		push	[si].pcb.regcs
		push	[si].pcb.regip
		push	[si].pcb.regesi
		mov	eax, [si].pcb.regeax
		mov	ebx, [si].pcb.regebx
		mov	ecx, [si].pcb.regecx
		mov	edx, [si].pcb.regedx
		mov	ebp, [si].pcb.regebp
		mov	edi, [si].pcb.regedi
		mov	gs, [si].pcb.reggs
		mov	fs, [si].pcb.regfs
		mov	es, [si].pcb.reges
		mov	ds, [si].pcb.regds
		pop	esi
		iret
NoWait:		ret
$WaitSemaph	endp




; RlsSemaph-	Releases a semaphore.  If there are any items on the semaphore
;		list waiting for the semaphore, this guy moves the first such
;		item to the ready queue, immediately behind the current
;		process so that it will run next.
;
; RlsSemaph-	Address of semaphore to release is passed in ES:DI


		public	$RlsSemaPhStk
$RlsSemaPhStk	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+6]	;Get ptr to PCB
		call	$WaitSemaph
		pop	di
		pop	es
		pop	bp
		ret	4
$RlsSemaphStk	endp


		public	$RlsSemaphCS
$RlsSemaphCS	proc	far
		push	bp
		mov	bp, sp
		push	es
		push	di
		les	di, [bp+2]	;Get return address.
		les	di, es:[di]	;Get adrs of PCB from code stream.
		call	$RlsSemaPh	;Do the wait.

; Fix the return address (point it past the PCB's address).

		add	word ptr [bp+2], 4
		pop	di
		pop	es
		pop	bp
		ret	
$RlsSemaphCS	endp



		public	$RlsSemaph
$RlsSemaph	proc	far


		inc	es:[di].sema4.SemaCnt
		cmp	es:[di].sema4.SemaCnt, 0
		jg	SmphIsFree

; If the semaphore count is less than or equal to zero, then there are some
; processes still on this semaphore queue.  Move the first one onto the
; ready queue.

		pushf
		push	ds
		push	es
		push	ax
		push	bx
		push	di
		cli

; First, remove this guy from the semaphore list.

		lds	bx, es:[di].sema4.smaphrlst
		mov	eax, ds:[bx].pcb.NextProc
		mov	es:[di].sema4.smaphrlst, eax

; If last item in semaphore list, clear the end pointer.

		or	eax, eax
		jnz	NotAtEnd
		mov	es:[di].sema4.endsmaphrlst, eax
NotAtEnd:

; Now add it to the ready queue

		mov	ax, ds		;Point ES:BX at current PCB
		mov	es, ax

		assume	ds:ucrlib

		mov	ax, ucrlib
		mov	ds, ax
		lds	di, LastRdyQ
		assume	ds:nothing

; Point the new pcb's NextProc field to the same place the current pcb's
; next field points:

		mov	es:[bx].pcb.NextProc, 0

; Point the last PCB's NextProc field at the new process.

		mov	wp ds:[di].pcb.NextProc, bx
		mov	wp ds:[di+2].pcb.NextProc, es

; Point LastRdyQ at the process we just added to the ready queue:

		mov	ax, ucrlib
		mov	ds, ax
		assume	ds:ucrlib
		mov	wp LastRdyQ, bx
		mov	wp LastRdyQ+2, es
QuitRls:
		pop	di
		pop	bx
		pop	ax
		pop	es
		pop	ds
		popf

SmphIsFree:	ret
$RlsSemaph	endp




;*******************************************************************
; ISRs for interrupts that the process manager patches into:

TimerISR	proc
		assume	ds:nothing, es:nothing
		pushf 				;Call the previous timer ISR
		call	TimerIntVect
		call	$YieldCPU		;Do a context switch.
		inc	TimerTickCnt		;Increment 64-bit counter.
		jne	TISRDone
		inc	TimerTickCnt+4
TISRDone:	iret
TimerISR	endp



ucrlib		ends
		end
