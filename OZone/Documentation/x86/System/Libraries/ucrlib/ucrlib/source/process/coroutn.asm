		.386
		option	segment:use16, proc:private


		include	consts.a
		include	process.a

		echo	CoInit, CoCall, CoCalll
	

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing

wp		textequ	<word ptr>


DefaultCortn	pcb	<>
CurCoroutine	dword	DefaultCortn	;Points at the currently executing
					; coroutine.

;============================================================================
;
; Coroutine support.
;
; COINIT- ES:DI contains the address of the current (default) process.
; COINIT will store away this address into the local CurCoroutine variable.
; Strictly speaking, you do not need to call this code as the system will
; use the "DefaultCortn" if you do not supply a PCB for the 1st process.
; However, this variable is not visible outside this file so all future
; references would have to be through the ES:DI value returned by COCALL.


		public	$CoInit
$CoInit		proc	far
		assume	ds:nothing

		push	ax
		mov	wp CurCoroutine, di
		mov	wp CurCoroutine+2, es
		pop	ax
		ret
$CoInit		endp


; COCALL- transfers control to a coroutine.  ES:DI contains the address
; of the PCB.  This routine transfers control to that coroutine and then
; returns a pointer to the caller's PCB in ES:DI.


		public	$cocall
$cocall		proc	far
		assume	ds:ucrlib

		pushf
		push	ds
		push	es			;Save these for later
		push	edi
		push	eax

		mov	ax, ucrlib
		mov	ds, ax
		cli				;Critical region ahead.

; Save the current process' state:

		les	di, CurCoroutine
		pop	es:[di].pcb.regeax
		mov	es:[di].pcb.regebx, ebx
		mov	es:[di].pcb.regecx, ecx
		mov	es:[di].pcb.regedx, edx
		mov	es:[di].pcb.regesi, esi
		pop	es:[di].pcb.regedi
		mov	es:[di].pcb.regebp, ebp
		pop	es:[di].pcb.reges
		pop	es:[di].pcb.regds
		mov	es:[di].pcb.regfs, fs
		mov	es:[di].pcb.reggs, gs
		pop	es:[di].pcb.regflags
		pop	es:[di].pcb.regip
		pop	es:[di].pcb.regcs
		mov	wp es:[di].pcb.regsssp, sp
		mov	wp es:[di].pcb.regsssp+2, ss

		mov	bx, es			;Save so we can return in
		mov	cx, di			; ES:DI later.
		mov	dx, wp es:[di].pcb.regedi
		mov	es, es:[di].pcb.reges
		mov	di, dx			;Point es:di at new PCB

		mov	wp CurCoroutine, di
		mov	wp CurCoroutine+2, es

		mov	wp es:[di].pcb.regedi, cx ;The ES:DI return values.
		mov	es:[di].pcb.reges, bx

; Okay, switch to the new process:

		lss	sp, es:[di].pcb.regsssp
		mov	eax, es:[di].pcb.regeax
		mov	ebx, es:[di].pcb.regebx
		mov	ecx, es:[di].pcb.regecx
		mov	edx, es:[di].pcb.regedx
		mov	esi, es:[di].pcb.regesi
		mov	ebp, es:[di].pcb.regebp
		mov	ds, es:[di].pcb.regds
		mov	fs, es:[di].pcb.regfs
		mov	gs, es:[di].pcb.reggs

		push	es:[di].pcb.regflags
		push	es:[di].pcb.regcs
		push	es:[di].pcb.regip
		push	es:[di].pcb.regedi
		mov	es, es:[di].pcb.reges
		pop	edi
		iret
$cocall		endp




; CoCallCS works just like cocall above, except the address of the pcb
; follows the call in the code stream rather than being passed in ES:DI.
; Note: this code does *not* return the caller's PCB address in ES:DI.
;


		public	$cocallCS
$cocallCS	proc	far
		assume	ds:ucrlib

		pushf
		push	ds
		push	es
		push	edi
		push	eax

		mov	ax, ucrlib
		mov	ds, ax
		cli				;Critical region ahead.


; Save the current process' state:

		les	di, CurCoroutine
		pop	es:[di].pcb.regeax
		mov	es:[di].pcb.regebx, ebx
		mov	es:[di].pcb.regecx, ecx
		mov	es:[di].pcb.regedx, edx
		mov	es:[di].pcb.regesi, esi
		mov	es:[di].pcb.regebp, ebp
		mov	es:[di].pcb.regfs, fs
		mov	es:[di].pcb.reggs, gs

		pop	es:[di].pcb.regedi
		pop	es:[di].pcb.reges
		pop	es:[di].pcb.regds
		pop	es:[di].pcb.regflags
		pop	es:[di].pcb.regip
		pop	es:[di].pcb.regcs
		mov	wp es:[di].pcb.regsssp, sp
		mov	wp es:[di].pcb.regsssp+2, ss

		mov	dx, es:[di].pcb.regip	;Get return address (ptr to
		mov	cx, es:[di].pcb.regcs	; PCB address.
		add	es:[di].pcb.regip, 4	;Skip ptr on return.
		mov	es, cx			;Get the ptr to the new pcb
		mov	di, dx			; address, then fetch the
		les	di, es:[di]		; pcb val.
		mov	wp CurCoroutine, di
		mov	wp CurCoroutine+2, es

; Okay, switch to the new process:

		lss	sp, es:[di].pcb.regsssp
		mov	eax, es:[di].pcb.regeax
		mov	ebx, es:[di].pcb.regebx
		mov	ecx, es:[di].pcb.regecx
		mov	edx, es:[di].pcb.regedx
		mov	esi, es:[di].pcb.regesi
		mov	ebp, es:[di].pcb.regebp
		mov	ds, es:[di].pcb.regds
		mov	fs, es:[di].pcb.regfs
		mov	gs, es:[di].pcb.reggs

		push	es:[di].pcb.regflags
		push	es:[di].pcb.regcs
		push	es:[di].pcb.regip
		push	es:[di].pcb.regedi
		mov	es, es:[di].pcb.reges
		pop	edi
		iret
$cocallCS	endp
ucrlib		ends
		end
