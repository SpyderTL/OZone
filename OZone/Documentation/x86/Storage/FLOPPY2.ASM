;
; floppy.asm
;
; Function: 1.44MB floppy driver ( 4 drives)
;   Handles floppy interrupt
;   Handles managing floppy controller and DMA system
;   Handles read/write format
;   Handles OS floppy calls
;
	IDEAL
	P386

include "segs.asi"
include "sys.mac"
include "floppy.asi"
include "pic.asi"
include "sems.ase"
include "os.asi"
include "dma.asi"
include "boot.ase"
include "dispatch.ase"
include "prints.ase"
include "remaps.ase"
include "descript.ase"


	public	FloppyTimerInt, FloppyInt, FloppyRundown
	public	FloppyHandler

SEGMENT seg386data
buffer	dd	?			; IO buffer
SemFloppy dd	1
done	    dd	0			; Set true when an interrupt completes
turnofftime dw	0			; Ticks till disk turnoff
countime    dw	0			; Ticks while delaying
motors	db	0			; Motor on specifier
responsebuf db	7 DUP (?)		; Controller response buffer
calibrated db	0			; Calibration control flags
cmd	db	0			; Cmd being executed
error	db	0			; Error found
tracks	db	4 DUP (?)		; Register current diskette tracks
parmtable dw	2a1h,2a1h,2a1h,2a1h	; Diskette params, see DISKPARAM struc
	db	0,0,0,0
	db	20,20,20,20
	db	81h,81h,81h,81h
	db	80,80,80,80
	dw	0903h,0903h,0903h,0903h
	dw	0c436h,0c436h,0c436h,0c436h
	db	0fh,0fh,0fh,0fh
	db	10,10,10,10
ENDS	seg386data

SEGMENT seg8086
;
; Reset the bios floppy subsystem on exit
;
PROC	FloppyRundown
	mov	dx,3			; 4 Drives
rdl:
	mov	ax,0			; BIOS function reset drive
	int	13h			; Do it
	dec	dx			; Next drive
	or	dx,dx			; See if positive
	jns	rdl			; Loop while so
	ret
ENDP	FloppyRunDown
ENDS	seg8086

SEGMENT seg386
;
; Tenths to ticks conversion
;
multiplier dw	DTIME_MUL
divisor	dw	DTIME_DIV
;
; Timer interrupt
;
PROC	FloppyTimerInt
	test	[turnofftime],-1	; See if turnofftime active
	jz	short noturnoff		; No
	dec	[turnofftime]		; Yes, decrement
	jnz	short noturnoff		; Not done
	push	edx			; Else save dx
	and	[motors],MTR_MASKOFF	; Kill all motors
	mov	al,[motors]		; Inform controller
	mov	dx,MOTORSELECT		;
	out	dx,al			;
	pop	edx			;
noturnoff:
	test	[countime],-1		; See if delaying
	jz	short notcount		;
	dec	[countime]		; Yes, decrement
	jnz	short notcount		; Not done
	bts	[done],0		; Else inform task
ifdef DEBUG
	push	edx			; Debugger, put a * for timeout
	mov	dl,'*'			;
	os	VF_CHAR			;
	pop	edx			;
endif
notcount:
	ret
ENDP	FloppyTimerInt
;
; Floppy controller interrupt, interrupts after certain commands
;
PROC	FloppyInt
	push	eax			; Get data seg
	push	ds			;
	push	DS386			;
	pop	ds			;
ifdef DEBUG
	push	edx			; If Debugging put out a char
	mov	dl,'@'			;
	os	VF_CHAR			;
	pop	edx			;
endif
	bts	[done],0		; Mark controller came
	PICACK				; Acknowledge interrupt
	pop	ds			; Restore seg
	pop	eax			; and eax
	iretd
ENDP	FloppyInt
;
; Stop the timer
;
PROC	StopTimer
	mov	[countime],0		; Kill count time
	btr	[done],0		; Reset done flag
	ret
ENDP	StopTimer
;
; Start the timer
;
PROC	StartTimer
	push	edx			; Convert to ticks
	mul	[multiplier]		;
	div	[divisor]		;
	pop	edx			;
SimpleStartTimer:
	inc	ax			; Make sure at least 1
	mov	[countime],ax		; Set timer
	btr	[done],0		; Reset done flag
	ret
ENDP	StartTimer
;
; Wait till done flag goes true
;
PROC	WaitDone
	mov	ebx,offset done		; Stop the task on a semaphore
	call	WaitSem			;
	os	TA_PAUSE		; Pause
	ret
ENDP	WaitDone
;
; Wait for controller to be ready
;
PROC	WaitControllerReady
	mov	ax,2			; Give it two clock ticks
	call	SimpleStartTimer	;
wcr_lp:
	mov	dx,DISKSTATUS		; Poll status reg
	in	al,dx			;
	test	al,CSR_READY		; See if ready bit set
	jnz	short wcr_ok		; Get out if so
	bt	[done],0		; Else see if timeout
	jnc	wcr_lp			; Loop if not
	call	StopTimer		; Timed out
	mov	al,DERR_CTRLFAIL	; Mark controller fail
	mov	[error],al		;
	stc
	ret
wcr_ok:
	call	StopTimer		; Stop timer
	clc				; Everything ok
	ret
ENDP	WaitControllerReady
;
; Read a byte from controller
;
PROC	ReadControllerData
	call	WaitControllerReady	; Wait for ready
	jc	short rcd_fail		; In case fail
	mov	dx,DISKDATA		; Get data reg
	in	al,dx			; Get data
	clc				; Life is ok
rcd_fail:
	ret
ENDP	ReadControllerData
;
; Read the standard response from the controller
;
PROC	ReadSevenResponse
	mov	cl,7			; 7 bytes to read
ReadResponse:
	mov	edi,offset responsebuf	; Get buffer
ReadRespLoop:
	call	ReadControllerData	; Read a byte
	jc	short rsr_fail		; if it is raining
	mov	[edi],al		; otherwise Save char in buf
	inc	edi			;
	dec	cl			; Next byte
	jnz	short ReadRespLoop	;
	clc				; Everything fine
rsr_fail:
	ret
ENDP	ReadSevenResponse
;
; Write data to controller
;
PROC	WriteControllerDataC
	jc	short wcd_fail		; Skip out if previous error
WriteControllerData:
ifdef DEBUG
	push	eax			; If debugging, print the byte
	call	printbyte		;
	call	printspace              ;
	pop	eax                     ;
endif
	mov	bl,al			; bl gets the char
	call	WaitControllerReady	; Wait for ready
	jc	short wcd_fail2		; bail out if fail
	test	al,CSR_READ		; Make sure direction = toward controller
	mov	al,bl			; Get the char
	jnz	short wcd_fail		; Bail out if wrong dir
	mov	dx,DISKDATA		; Get data register
	out	dx,al			; Output a byte
	clc				; no errors
wcd_fail2:
	ret
wcd_fail:
	call	ReadSevenResponse	; Wrong dir, empty controller output buf
	mov	al,DERR_CTRLFAIL	; Signal a fail
	mov	[error],al		;
	stc				;
	ret
ENDP	WriteControllerDataC
;
; Turn on motor
;
PROC	MotorOn
	mov	[turnofftime],0		; NEver turn off
	and	[motors],MTR_NOSELECT	; Kill select
	or	[motors],al		; Set new select
	or	[motors],MTR_DMA OR MTR_NORESET ; ints and dma enabled
	add	al,4			; Get motor bit to turn on
	bts	[dword ptr motors],eax	; Turn it on
	push	eax			; Tell the controller
	mov	al,[motors]		; Which motors
	mov	dx,MOTORSELECT		; Motor reg
	out	dx,al			;
	pop	eax			;
	jc	short alreadyon         ; No waiting if already on
	sub	al,4			; Else get drive pup value
	lea	edi,[eax+ DISKPARM.PUP]	;
	add	edi,offset parmtable	; In parm table
	movzx	eax,[byte ptr edi]	;
	call	StartTimer              ; Start the timer
	call	WaitDone		; Wait for timeout
alreadyon:
	clc				; Never an error with select
	ret
ENDP	MotorOn
;
; Check if disk change
;
PROC	Changed
	lea	edi,[eax + DISKPARM.HPTCHANGE] ; See if has a change line
	add	edi,offset parmtable	;
	test	[byte ptr edi],CHANGEABLE;
	jz	short notchanging       ; No, just exit
	push	eax			; Else read the digital input reg
	mov	dx,RATECONFIG		;
	in	al,dx			;
	or	al,al			;
	pop	eax                     ;
	jns	short notchanging       ; Bit 7 is change line, 0=not changed
	push	eax			; It changed, we have to have a head
	push	ecx			; move to reset the flipflop
	mov	ch,7			;
	call	seek			;
	pop	ecx			;
	pop	eax			;
	push	eax			;
	call	home			; Now bring us back home
	pop	eax			;
	mov	eax,4			; Delay just a bit
	call	SimpleStartTimer        ;
	call	WaitDone     		;
	mov	dx,RATECONFIG           ; Read change line again
	in	al,dx			;
	or	al,al			;
	mov	al,DERR_CHANGED		; Assume a disk present
	jns	short missing		; yes, get out
	mov	al,DERR_TIMEOUT		; Else no disk
missing:
	stc				; We have an error
	mov	[error],al		;
	ret				;
notchanging:
	clc				; Life is fine
	ret
ENDP	Changed
;
; Send the disk specify command
;
PROC	Specify
	lea	esi,[eax *2 + DISKPARM.STEPLOADUL]; parameters are in the parm table
	add	esi,offset parmtable	;
	mov	al,CMD_SPECIFY          ; Specify command
	call	WriteControllerData	;
	lodsb				; Step and load time
	call	WriteControllerDataC	;
	lodsb				; Unload time
	call	WriteControllerDataC	;
; No interrupt for this command
	ret
ENDP	Specify
;
; Find out if seek succeeded
;
PROC	SenseInterruptStatus
	mov	al,CMD_SENSE		; Sense command
	call	WriteControllerData
; No interrupt this command
	jc	short sis_fail
	call	ReadControllerData	; First response byte
	jc	short sis_fail
	mov	ah,al
	call	ReadControllerData	; Second response byte
sis_fail:
	ret
ENDP	SenseInterruptStatus
;
; Home the drive head
;
PROC	Home
	btr	[dword ptr calibrated],eax ; Mark uncalibrated
	push	eax
	mov	ah,al                   ; save drive number
	btr	[done],0		; We'll be waiting on interrupt
	mov	al,CMD_RECALIBRATE	; Send recal command
	call	WriteControllerData	;
	mov	al,ah			; Write drive number
	call	WriteControllerDataC	;
	jc	short hfail		;
	call	WaitDone		; Wait for interrupt
	call	SenseInterruptStatus	; Now see what happened
	mov	al,DERR_SEEKFAIL	; Assume so
	jc	short hfail
	test	ah,(1 shl SR0_ABTERM )	; See if aborted
	jnz	short hfail		; Branch if so
	test	ah,(1 SHL SR0_SEEK)	; Check if seek ok
	jnz	short hfail		; Branch if fail
	pop	eax			;
	mov	[tracks + eax],0	; Else mark us at track 0
	bts	[dword ptr calibrated],eax ; Mark us calibrated
	clc                             ; Life is dandy, just like candy
	ret
hfail:
	mov	[error],al		; Mark error
	pop	eax			; Failure
	stc
	ret
ENDP	Home
;
; Reset command
;
PROC	Reset
	mov	[calibrated],0		; Mark everything uncalibrated
	and	[motors],MTR_MASKOFF	; Turn off motors
	mov	al,[motors]		;
	mov	dx,MOTORSELECT		;
	out	dx,al			;
	mov	[turnofftime],0		; Don't need to turn off
	ret
ENDP	Reset
;
; Seek a track
;
PROC	Seek
	bt	[dword ptr calibrated],eax	; Check if calibrated
	jc	short nohome		; Yes, don't home
	push	eax			; Else go home
	call	home			;
	pop	eax			;
nohome:
	lea	edi,[eax + tracks]	; Now see if seeking current track
	cmp	[byte ptr edi],ch	;
	jz	short sthere		; Yes, get out
	push	eax
	btr	[done],0		; Else we're waiting for interrupt
	mov	al,CMD_SEEK		; Send seek command
	call	WriteControllerData	;
	mov	al,ah			; Send drive
	call	WriteControllerDataC	;
	mov	al,ch			; Send track
	call	WriteControllerDataC	;
	jc	short sdone2            ; Out if error
	call	WaitDone		; Wait for interrupt
	call	SenseInterruptStatus	; Check seek status
	mov	al,DERR_SEEKFAIL	;
	jc	short sdone
	test	ah,(1 SHL SR0_ABTERM)	; Error if aborted
	jnz	short sdone		;
	test	ah,(1 SHL SR0_SEEK)	; Error if can't seek
	jnz	short sdone		;
	pop	eax			;
	mov	[tracks + eax],ch	; Update track number
sthere:
	clc
	ret
sdone:	
	mov	[error],al		; Mark error
sdone2:
	stc
	pop	eax
sdone3:
      	ret
ENDP	Seek
;
; Set the KPS for media
;
PROC	SetMediaRate
	lea	edi,[eax + DISKPARM.MEDIA]	; Get value from parm table
	add	edi, offset parmtable	;
	mov	al,[edi]		;
	mov	dx,RATECONFIG		; Goes in rateconfig table
	out	dx,al			;
	ret
ENDP	SetMediaRate
;
; Initialize DMA
;
PROC	SetDMA
	mov	ah,[cmd]		; Get command
	DMA_CLEARBYTEFF			; Put us at low byte
	cmp	ah,DK_WRITE AND 255	; See if write
	DMA_GETMODE DMAMODE_SINGLE,DMAXFER_READ,FLOPPY_DMA ; Assume read from mem
	jz	short wtmode		; Write, go fill in params
	cmp	ah,DK_FORMAT AND 255	; See if format
	jz	short wtmode		; Write, go fill in params
	cmp	ah,DK_READ AND 255	; See if read
	DMA_GETMODE DMAMODE_SINGLE,DMAXFER_WRITE,FLOPPY_DMA ; Assume write to mem
	jz	short	wtmode		; Branch if so
	DMA_GETMODE DMAMODE_SINGLE,DMAXFER_VERIFY,FLOPPY_DMA ; Else must be verify
wtmode:
	DMA_SETMODE			; Set the mode
	dec	dx			; Count is last byte xferd
	DMA_WRITECOUNT	dl,dh,FLOPPY_DMA; WRite the count
	inc	dx			; Get original
	mov	ecx,[buffer]		; Get transfer buffer
	add	ecx,[zero]		; Make absolute
	DMA_WRITEBASE	cl,ch,FLOPPY_DMA; Write base address
	push	ecx			;
	shr	ecx,16			; Get page
	mov	ah,ch			; Get high byte of page
	DMA_SETPAGE	cl,FLOPPY_DMA	; Write page
	pop	ecx			;
	add	cx,dx			; See if overflow a page
	mov	al,DERR_DMABOUND	; Bound err if so
	jc	short dma_err		; Yes, mark it
	or	ah,ah			; See if within lower 16 MB
	stc				;
	jnz	short dma_err		; No, bounds error
	DMA_MASKOFF	FLOPPY_DMA	; Enable transfer
	clc				;
	sub	al,al			; No error
dma_err:
	mov	[error],al		; Mark error
	ret
ENDP	SetDMA
;
; XLATE a controller error to a bios error number
;
PROC	xlateerr
	push	eax			; Save ax
	mov	esi,offset responsebuf	; Get response
	mov	eax,[esi]		;
	test	al,(1 SHL SR0_ABTERM) + (1 SHL SR0_UNUSED); Any errors
	jz	noerr			; No, get out
	test	al,(1 SHL SR0_ABTERM)	; If we don't have abterm ctrlfail
	mov	al,DERR_CTRLFAIL	;
	jz	goterr
	test	ah,(1 SHL SR1_NOADDRESS); No address mark
	mov	al,DERR_NOADDRESS
	jnz	goterr
	test	ah,(1 SHL SR1_WRITEPROT); Write protect
	mov	al,DERR_WRITEPROT
	jnz	goterr
	test	ah,(1 SHL SR1_NODATA)	; Can't find sector
	mov	al,DERR_NOSECT
	jnz	goterr
	test	ah,(1 SHL SR1_OVERRUN)	; DMA too slow
	mov	al,DERR_DMAOVER
	jnz	goterr
	test	ah,(1 SHL SR1_CRC)	; CRC error
	mov	al,DERR_BADCRC
	jnz	goterr
	test	ah,( 1 SHL SR1_SECTOOBIG); Sector too big, so can't find it
	mov	al,DERR_NOSECT
	jnz	goterr
	mov	al,DERR_CTRLFAIL	; Otherwise controller failed
goterr:
	stc				; Mark error
	mov	[error],al		;
	pop	eax
	ret
noerr:
	pop	eax
	clc
	ret
	
	ret
ENDP	xlateerr
;
; Read, write or verify a sector
;
PROC	rwv
	push	eax
	push	ecx
	lea	edi,[eax + DISKPARM.BPSSPT];Get sector size
	add	edi,offset parmtable	;
	mov	cl,[byte ptr edi]	;
	mov	edx,1
	shl	edx,cl			;
	shl	edx,7			;
	pop	ecx
	push	ebx			; Set DMA up
	push	ecx			;
	call	SetDMA			;
	pop	ecx			;
	pop	ebx			;
	pop	eax
	jc	rwv_fail		; We only get an error if OS loaded too high
	push	eax			;
	mov	ah,[cmd]		; Check the command
	cmp	ah,DK_WRITE AND 255	; Is it write?
	mov	al,CMD_WRITE		; Assume so
	jz	short rwv_cmd		; Go do write
	mov	al,CMD_READ		; Otherwise it is read or verify
rwv_cmd:
	push	ebx			; Save head
	call	WriteControllerData	; Write command
	pop	ebx			;
	pop	eax
	pushfd				; Save status
	btr	[done],0		; We'll be waiting for int
	bt	ebx,0			; See if head two
	jnc	short rwv_head0		;
	bts	eax,HEADSEL_BIT		; Yes, set headsel bit of drive
rwv_head0:
	popfd				; Restore status
	push	eax			; Write drive and head
	push	ebx			;
	call	WriteControllerDataC	;
	pop	ebx
	mov	al,ch                   ; Now write track
	push	ebx			;
	call	WriteControllerDataC	;
	pop	ebx			;
	mov	al,bl			; Write head
	call	WriteControllerDataC	;
	mov	al,cl			; Write sector
	call	WriteControllerDataC	;
	
	pop	eax			;
	pushfd                          ; Reset head sel bit
	btr	eax,HEADSEL_BIT		;
	popfd				;
	lea	esi,[eax*2 + DISKPARM.BPSSPT]; Get bytes per sector
	add	esi,offset parmtable	;
	push	eax			;
	lodsb				; Write bytes per sector
	call	WriteControllerDataC	;
	mov	al,cl                   ; This is last sector for xfer
	call	WriteControllerDataC	;
	pop	eax                     ;
	lea	esi,[eax*2 + DISKPARM.FGLFILL]; Get gap len
	add	esi,offset parmtable	;
	lodsb				;
	call	WriteControllerDataC    ; Write gap len
	mov	al,255			; User specified data len = 255
	call	WriteControllerDataC	; Write it
	jc	short rwv_fail

	call	WaitDone		; Wait for interrupt
	call	ReadSevenResponse	; Read the response
rwv_fail:
	DMA_MASKON	FLOPPY_DMA	; Disable DMA
	ret
ENDP	rwv
;
; Format a track
;
PROC	formtrack
	push	es			; Get segment to write in
	push	ds			;
	pop	es			;
	push	eax			;
	lea	esi,[eax *2 + DISKPARM.BPSSPT] ; Get SPT
	add	esi,offset parmtable	;
	mov	bh,[esi + 1]		;
	mov	edi,[buffer]		; Get format buffer
	sub	cl,cl			; Start on sector 0
frm_setlp:
	push	ebx			; Save head
	push	ecx			; Save track & sector
	mov	al,ch			; First specify byte is track
	stosb
	mov	al,bl			; Second is head
	stosb
	mov	al,cl			; Third is sector
	stosb
	mov	al,[esi]		; Fourth is sector size
	stosb
	pop	ecx			; Restore current pos
	pop	ebx                     ;
	inc	cl			; Next sector
	dec	bh			; Dec number of sectors
	jnz	short frm_setlp		; Next sector
	sub	edi,[buffer]		; Get buffer len
	mov	edx,edi			;
	call	SetDMA                  ; Set DMA
	pop	eax
	jc	formerr                 ; Quit if os error
	push	eax
	mov	al,CMD_FORMAT		; Send format command
	push	ebx			;
	call	WriteControllerData	;
	pop	ebx                     ;
	pop	eax                     ;
	pushfd                          ; Save status
	btr	[done],0		; We'll be waiting on interrupt
	bt	ebx,0			; See if head 1
	jnc	short form_head0	; No, go do head 0
	bts	eax,HEADSEL_BIT		; Else mark select bit
form_head0:
	popfd				; Restore status
	push	eax			; Write head and drive
	call	WriteControllerDataC	;
	pop	eax			;
	pushfd				; Reset head bit
	btr	eax,HEADSEL_BIT		;
	popfd				;
	push	eax         		;
	lea	esi,[eax *2 + DISKPARM.BPSSPT]; Get BPS and SPT
	add	esi,offset parmtable	;
	lodsb				; Write BPS
	call	WriteControllerDataC	;
	lodsb				; Write SPT
	call	WriteControllerDataC	;
	pop	eax			;
	lea	esi,[eax*2 + DISKPARM.FGLFILL]; Get gap len and fill
	add	esi,offset parmtable	;
	lodsb				; Write gap length
	call	WriteControllerDataC	;
	lodsb				; Write fill value
	call	WriteControllerDataC	;
	jc	short formerr           ;
	call	WaitDone                ; Wait for interrupt
	call	ReadSevenResponse	; Read response
formerr:
	DMA_MASKON	FLOPPY_DMA	; Disable DMA
	pop	es
	ret
ENDP	formtrack
;
; Calculate track and sector and head from absolute sector number
;
PROC	caldiskinfo
	push	eax			; First make sure not past end of
	push	edx			; Disk
	call	ReturnSectors		;
	pop	edx			;
	cmp	edx,eax			;
	pop	eax			;
	jnc	cdi_err			; Invalid function err if so
	xchg	edx,eax			; Swap sector number & drive number
	lea	edi,[edx*2 + DISKPARM.HPTCHANGE]; Get headpertrack
	add	edi,offset parmtable	;
	test	[byte ptr edi],MULTIHEAD; Is it double sided
	mov	bl,0			; Assume not
	jz	short singleside	; No
	shr	eax,1			; Head is LSB of sector
	rcl	bl,1			;
singleside:
	push	edx			;
	lea	edi,[edx * 2 + DISKPARM.BPSSPT] ; Divide by SPT
	add	edi,offset parmtable	;
	div	[byte ptr edi + 1]	;
	mov	cl,ah			; Sector is remainder
	mov	ch,al			; Track is quotient
	pop	eax			;
ifdef DEBUG
	push	eax                     ; If debugging
	mov	eax,ecx			; print track, sector, head
	call	printword		;
	call	printspace		;
	mov	eax,ebx			;
	call	printword		;
	mov	dl,10			; LF
	os	vf_char			;
	pop	eax			;
endif
	clc
	ret
cdi_err:
	stc
	ret
ENDP	caldiskinfo
;
; Calculate total sectors on disk
;
PROC	ReturnSectors
	mov	ebx,eax
	sub	eax,eax
	inc	eax
	lea	edi,[ebx * 2 + DISKPARM.HPTCHANGE] ; HPT
	add	edi,offset parmtable
	test	[byte ptr edi],MULTIHEAD
	jz	short rs_singleside
	inc	eax
rs_singleside:
	lea	edi,[ebx *  2 + DISKPARM.BPSSPT]   ; * SPT
	add	edi,offset parmtable
	movzx	ecx,[byte ptr edi+1]
	mul	ecx
	lea	edi,[ebx + DISKPARM.TPD]     	   ; * TPD
	add	edi,offset parmtable
	movzx	ecx,[byte ptr edi]
	mul	ecx
	ret
ENDP	ReturnSectors
;
; Read, Write and verify a sector
;
PROC	ReadWriteVerify
	push	edx			; Get the motor on
	push	eax                     ;
	call	motoron                 ;
	pop	eax                     ;
	push	eax                     ;
	call	changed                 ; See if changed or missing
	pop	eax                     ;
	jc	short rw_done           ; Err if so
	push	eax                     ; Set the media rate
	call	SetMediaRate            ;
	pop	eax                     ; Send the disk specify bytes
	push	eax                     ;
	call	Specify                 ;
	pop	eax                     ;
	jc	short rw_done           ; Err if failed
	pop	edx                     ;
	push	edx                     ;
	call	calDiskInfo             ; Calculate track and sector
	jc	short rw_done           ; Err if too big
	push	eax                     ; Seek the track
	push	ebx                     ;
	push	ecx                     ;
	call	seek                    ;
	pop	ecx                     ;
	pop	ebx                     ;
	pop	eax                     ;
	jc	short rw_done           ; Err if failed
	call	rwv                     ; Read Write or Verify the sector
	jc	short rw_done           ; Err if failed
	call	xlateErr                ; Translate the response
rw_done:
	pop	edx                     ;
	ret                             ;
ENDP	ReadWriteVerify
;
; Format the disk
;
PROC	Format
	push	edx			; Motor on
	push	eax			;
	call	MotorOn			;
	pop	eax			;
	push	eax			; See if changed
	call	changed			;
	pop	eax			;
	jc	form_done               ; Err if so
	push	eax                     ; Set media rate
	call	SetMediaRate		;
	pop	eax			; Send specify command
	push	eax			;
	call	Specify			;
	pop	eax			;
	jc	form_done		; Err if failed
	pop	edx			; Get tracks to format
	push	edx			;
	lea	edi,[eax + DISKPARM.TPD];
	add	edi,offset parmtable	;
	movzx	esi,[byte ptr edi]      ;
	sub	ebx,ebx                 ; Clear head and track bytes
	sub	ecx,ecx                 ;
frmlp:
ifdef DEBUG
	push	eax			; If debugging do a line feed
	push	edx
	mov	dl,10
	os	vf_char
	pop	edx
	pop	eax
endif
	push	esi			; Seek the track
	push	eax			;
	push	ebx			;
	push	ecx			;
	call	seek			;
	pop	ecx			;
	pop	ebx			;
	pop	eax			;
	jc	short form_done         ; Quit if error
	push	eax			; Format side 1
	push	ebx                     ;
	push	ecx                     ;
	call	formtrack               ;
	pop	ecx                     ;
	pop	ebx                     ;
	pop	eax                     ;
	jc	short form_done         ; Quit if error
	call	xlateErr                ; Translate controller errors
	jc	short form_done		;
	lea	edi,[eax + DISKPARM.HPTCHANGE] ; See if double sided
	add	edi,offset parmtable	;
	test	[byte ptr edi],MULTIHEAD;
	jz	onesided                ; no - don't do second side
	push	eax			; Else format second side
	push	ebx			;
	push	ecx                     ;
	inc	bl                      ;
	call	formtrack               ;
	pop	ecx                     ;
	pop	ebx                     ;
	pop	eax                     ;
	jc	short form_done         ; branch if error
	call	xlateErr                ; Translate controller status bytes
	jc	short form_done		;
onesided:
	inc	ch			; Next track
	pop	esi			; See if done
	dec	esi			;
	jnz	frmlp			; Loop if not
	clc
form_done:
	pop	edx
	ret
ENDP	Format
;
; Procedure to read a disk address block
;
ifdef DEBUG
PROC	Replay
	sub	eax,eax			; Get motor on drive 0
	call	MotorOn			;
	sub	eax,eax			; Home drive 0
	call	home			;
	btc	[done],0                ; We'll be waiting on interrupt
	mov	al,4ah			; Command to read address info
	call	WriteControllerData	; Send to controller
	mov	al,0			; Drive and head to read
	call	WriteControllerData	;
	call	WaitDone         	; Wait for an interrupt
	call	ReadSevenResponse	; Read response packet
	mov	esi,offset responsebuf	; Put response out to screen
	mov	ecx,7			;
rploop:                                 ;
	lodsb                           ;
	call	printbyte               ;
	call	printspace              ;
	loop	rploop                  ;
	ret                             ;
ENDP	Replay              
endif
;
; Find the address in system space
;
PROC	UserAddress
	push	eax			; Save regs
	push	ebx			;
	push	esi			;
	mov	ax,es			; See if is call from system
	mov	bx,ds			;
	cmp	ax,bx			;
	mov	eax,esi			;
	jz	short systemadr		; Yes, branch
	mov	ebx,esi			; Get buffer offset
	sldt	ax			; Get LDT
	call	DescriptorAddress	;
	call	GetDescriptorBase
	ZA	edi
	mov	esi,cr3			; Get paging
	mov	eax,es
	call	RemapToSystem		; Remap the buffer
systemadr:
	mov	[buffer],eax		; Save it for later
	pop	esi			;Restore regs
	pop	ebx			;
	pop	eax			;
	ret				;
ENDP	UserAddress
	
;
; Floppy disk handler
;
PROC	FloppyHandler
	cmp	ebx,4			; Validate drive
	jc	short okdrive		; Branch if ok
	jmp	nofunction		; Branch if not ok
okdrive:
	push	es			; Save registers
	push	ds			;
	push	esi                     ;
	push	edi                     ;
	push	ebx                     ;
	push	ecx                     ;
	push	edx                     ;

	push	ds                      ; ES = user data seg
	pop	es                      ;

	push	DS386                   ; DS = system data seg
	pop	ds                      ;
	mov	[cmd],al		; Command we are executing

	call	useraddress		; Get the user buffer address
	mov	ah,al			;
	mov	al,DERR_DMABOUND	; Err if not available
	jc	GetOut
	mov	al,ah

	push	ebx                     ; Save drive num
	push	eax                     ; And function code
	mov	[error],00              ; Mark no errors

	
	push	offset SemFloppy	; Make sure nothing else is executing
	call	SemBlock		;  THis code
	push	ebx          		; AX will have drive on entry
	call	TableDispatch		; Dispatch function
ifdef DEBUG
	dd	06
else
	dd	05
endif
	dd	reset
	dd      format
	dd	ReadWriteVerify
	dd	ReadWriteVerify
	dd	ReadWriteVerify
	dd	ReturnSectors
ifdef DEBUG
	dd	Replay
endif
	pop	ecx			; Function in CX
	pop	ebx			; Drive in BX
	pushfd				; Save return status
	cmp	cl,DK_GETSECTORS AND 255; See if is get sectors command
	jz	returnvalue		; Yes, just get out
	lea	ebx,[ebx + DISKPARM.TURNOFF]; Else get the off timer byte
	add	ebx,offset parmtable	;
	movzx	eax,[byte ptr ebx]	;
	mul	[multiplier]		; Make it ticks
	div	[divisor]		;
	mov	[turnofftime],ax	; Set turnofftime
	mov	al,[error]		; Load up the error
	sub	ah,ah			;
	cwde                            ;
returnvalue:
	bts	[SemFloppy],0		; Mark code unused
	popfd                           ;
getout:
	pop	edx                     ; Restore return code
	pop	ecx                     ; And user regs
	pop	ebx                     ;
	pop	edi                     ;
	pop	esi                     ;
	pop	ds                      ;
	pop	es                      ;
	ret	                        ;
ENDP	FloppyHandler
ENDS	seg386
END