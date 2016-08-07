org 256
	mov	word [FileNameStr],254
	mov	ax,0b101h
	int	1ah
	test    ah,ah
	jnz	NoPCIBIOS
	cmp	edx,20494350h
	jne	NoPCIBIOS
	mov	ax,0b102h
	mov	dx,8086h
	mov	cx,2415h
	xor     si,si
	int     1ah
	jc      GetDeviceError
	test    ah,ah
	jnz     GetDeviceError
	mov     word [BusDevFunc],bx
	mov     ax,0b10ah
	mov     di,10h
	int     1ah
	jc      INT1AError
	test    ah,ah
	jnz     INT1AError
	test    cl,1
	jz      ConfigError
	mov     cl,0
	mov     word [NAMBAR],cx
	mov     di,14h
	mov     ax,0b10ah
	int     1ah
	jc      INT1AError
	test    ah,ah
	jnz     INT1AError
	test    cl,1
	jz      ConfigError
	and     cl,0c0h
	mov     word [NABMBAR],cx
	mov     dx,cx
	add     dx,2ch  ;Global Control register=NABMBAR+2C
	in      eax,dx
	or      al,2    ;Take AC'97 from cold reset state
	and     al,0e3h ;Disable Primary Resume Interrupt and enable ACLINK
	out     dx,eax
	add     dl,4    ;Global Status register=NABMBAR+30
	mov     cx,20   ;20 cycles to wait
	mov     word [GlobStat],dx
WaitForPrimaryCodec:
	in      eax,dx
	test    ah,1    ;Bit 8 of GlobalStatus - Primary Codec ready
	jnz     PrimaryCodecReady
	sti
	call	Delay40MuS
	loop    WaitForPrimaryCodec
	mov     dx,PrimaryCodecTimeOutMessage
	jmp     ErrorExit
PrimaryCodecReady:
	add     dl,4    ;Codec Access Semaphore register=NABMBAR+34
	mov     cx,100
	mov     word [CAS],dx
WaitForSemaphore0:
	in	al,dx
	in      al,dx
	test    al,1    ;Bit 0 of CAS - Codec Access Semaphore
	call    Delay40MuS
	loopz	WaitForSemaphore0
	jz	AcquireSemaphoreError
	mov     dx,word [NAMBAR]
	out     dx,ax   ;Any value to reset all registers
	add     dl,26h  ;Power Down Ctrl/Stat register=NAMBAR+26
	call    AcquireSemaphore
	xor     ax,ax
	out     dx,ax
	mov     cx,20
WaitForPowerUp:
	mov	word [DelayTime],59659
	call	Delay40MuS ;DelayTime changed to 50000 MuS (50 ms)
	mov	word [DelayTime],48 ;restore the original value
	call    AcquireSemaphore
	in      ax,dx
	call	CheckForTimeOut
	and     al,0fh
	cmp     al,0fh
	je      CodecStarted
	loop    WaitForPowerUp
	mov     dx,CouldNotPowerUpMessage
	jmp     ErrorExit
CodecStarted:
	sub     dl,24h  ;Master Volume register=NAMBAR+2
	call    AcquireSemaphore
	xor	ax,ax
	out     dx,ax   ;Unmute and set some volume
	add     dl,16h  ;PCM Out Volume register=NAMBAR+18
	call    AcquireSemaphore
	xor     ax,ax
	out     dx,ax
	sub     dl,0ah  ;Mic Volume register=NAMBAR+E
	call    AcquireSemaphore
	xor     ax,ax
	out     dx,ax   ;Unmute and set max volume
	xor     eax,eax
	add	dl,28h-0eh	;Extended Audio ID Register=NAMBAR+28
	call    AcquireSemaphore
	in      ax,dx
	call	CheckForTimeOut
	test    al,1
	push	dx
	mov	dx,VRAUnsupportedMessage
	jz      ErrorExit
	pop	dx
	add     dl,2	;Extended Audio Status & Control register=NAMBAR+2A
	call    AcquireSemaphore
	in      ax,dx
	call	CheckForTimeOut
	or      al,1	;Setting bit 0 of EAS&C register enables VRA
	push    ax
	call    AcquireSemaphore
	pop     ax
	out     dx,ax
;	add     dl,2	;PCM Front DAC rate register=NAMBAR+2C
;	call    AcquireSemaphore
;	mov     ax,0ac44h
;	out     dx,ax

	mov	al,byte [80h]
	cmp	al,1
	jbe	CmdLineEmpty
GetCmdLoop:
	mov	al,20h
	mov	cx,80h
	mov	di,81h
	repe	scasb
	je	CmdLineEmpty
	dec	di
	cmp	byte [di],0dh
	je	CmdLineEmpty
	mov	dx,di
	mov	al,0dh
	repne	scasb
	jne	CmdLineEmpty
	dec	di
	mov	byte [di],0
	jmp	OpenFile
CmdLineEmpty:
	mov	ah,9
	mov	dx,PromptStr
	int	21h
	mov	ah,0ah
	mov	dx,FileNameStr
	mov	si,dx
	inc	si
	int	21h
	mov	ah,9
	mov	dx,CrLf
	int	21h
	mov	bl,byte [si]
	test	bl,bl
	jz	FileOpenError
	mov	bh,0
	inc	si
	cmp	byte [bx+si],0dh
	jne	FileOpenError
	mov	byte [bx+si],0
	mov	dx,fileName
OpenFile:
	mov     ax,3d00h
	int     21h
	jc	FileOpenError
	mov     bx,ax

	mov	ah,3fh
	mov	cx,24h
	mov	dx,fileBuffer
	int	21h
	cmp	dword [fileBuffer],"RIFF"
	jne	FormatError
	cmp	dword [fileBuffer+8],"WAVE"
	jne	FormatError
	cmp	dword [fileBuffer+0ch],"fmt "
	jne	FormatError
	cmp	word [fileBuffer+14h],1
	jne	FormatNotSupported
	cmp	word [fileBuffer+22h],16
	jne	FormatNotSupported
	cmp	word [fileBuffer+16h],2
	je	TwoChannels
	cmp	word [fileBuffer+16h],1
	jne	FormatNotSupported
	shr	word [BufSize],1
	shr	word [BufSize+2],1
	mov	byte [SingleChannelFlag],1
TwoChannels:
	mov	dx,word [NAMBAR]
	add	dl,2ch
	call	AcquireSemaphore
	mov	ax,word [fileBuffer+18h]
	out	dx,ax
	call	AcquireSemaphore
	in	ax,dx
	cmp	ax,word [fileBuffer+18h]
	jne	FormatNotSupported

	mov	ah,3fh
	mov	dx,fileBuffer
	mov	cx,8
	int	21h
	jc	FormatNotSupported
	cmp	dword [fileBuffer],"data"
	je	DataFound
	mov	dx,word [fileBuffer+4]
	mov	cx,word [fileBuffer+6]
ReReadFile:
	mov	ax,4201h
	int	21h
	jc	FormatNotSupported
	mov	ah,3fh
	mov	cx,8
	mov	dx,fileBuffer
	int	21h
	jc	FormatNotSupported
	cmp	dword [fileBuffer],"data"
	je	DataFound
	mov	dx,word [fileBuffer+4]
	mov	cx,word [fileBuffer+6]
	jmp	ReReadFile

;	mov     ax,4201h
;	xor     cx,cx
;	mov     dx,1000h
;	int     21h
DataFound:
	mov     dx,word [NABMBAR]
	add     dl,1bh  ;POCR=NABMBAR+1B
	mov     al,0    ;Clear Run/Pause Bus master bit
	out     dx,al
	mov     al,2    ;Reset Bus Master Registers
	out     dx,al
	call    Delay40MuS
	add     dl,-0bh  ;POBDBAR=NABMBAR+10
	mov     ax,ds
	shl     eax,4
	add     eax,BDL
	out     dx,eax
	xor     eax,eax
	mov     ax,cs
	shl     eax,4
	mov	edx,eax
	add     eax,fileBuffer
	mov     ecx,62*4
	add	edx,7ff0h
FillBDLLp:
	test	cx,8
	jne	CXNZ
	mov	dword [BDL+ecx],eax
	jmp	CXZ
CXNZ:
	mov	dword [BDL+ecx],edx
CXZ:
	sub     cx,2*4
	jns     FillBDLLp
	mov	ah,3fh
	mov	cx,word [BufSize]
	mov	dx,fileBuffer
	int	21h
	cmp	byte [SingleChannelFlag],1
	jne	DualChannel0
	sub	ax,2
	mov	si,ax
	add	si,fileBuffer
	mov	di,si
	add	di,ax
ConvertToDualLoop0:
	mov	dx,word [si]
	mov	word [di],dx
	mov	word [di+2],dx
	sub	di,4
	sub	si,2
	cmp	si,fileBuffer
	jnb	ConvertToDualLoop0
	add	ax,ax
DualChannel0:
	movzx	si,byte [LVI]
	inc     byte [LVI]
	and	byte [LVI],31
	shl	si,3
	shr	ax,1
	movzx	eax,ax
	mov	[BDL+4+si],eax
OutPutLp:
	mov	si,word [Counter]
	mov     ah,3fh
	mov     cx,word [BufSize+si]
	mov     dx,word [fileBuf+si]
	int	21h
	test	ax,ax
	jz	exit
	cmp	byte [SingleChannelFlag],1
	jne	DualChannel
	mov	si,ax
	add	si,dx
	mov	di,si
	add	di,ax
ConvertToDualLoop:
	mov	bp,word [si]
	mov	word [di],bp
	mov	word [di+2],bp
	sub	di,4
	sub	si,2
	cmp	si,dx
	jnb	ConvertToDualLoop
	add	ax,ax
DualChannel:
	push	bx
	mov	bx,BDL
	add	bx,4
	movzx	si,byte [LVI]
	shl	si,3
	shr	ax,1
	movzx	eax,ax
	mov	[bx+si],eax
	pop	bx
	mov     dx,word [NABMBAR]
	add     dl,15h  ;POLVI=NABMBAR+15
	mov     al,byte [LVI]
	and     al,31
	inc     byte [LVI]
	and	byte [LVI],31
	out	dx,al
	add	dl,1bh-15h	;POCR=NABMBAR+1B
	mov	al,1
	out	dx,al
	add	dl,14h-1bh	;POCIV=NABMBAR+14
UpdateLp:
	mov	ah,1
	int	16h
	jz	ContinueExecution
	mov	ah,0
	int	16h
	cmp	ax,3567h
	jne	NotPauseKey
SpaceKey:
	add	dl,1bh-14h
	in	al,dx
	xor	al,1
	out	dx,al
	add	dl,14h-1bh
	jmp	ContinueExecution
NotPauseKey:
	cmp	al,20h
	je	SpaceKey
	cmp	al,1bh
	je	OutOfMLoop
	cmp	ax,356ah
	je	OutOfMLoop
	cmp	ax,3564h
	jne	NotMuteKey
EnterKey:
	push	dx
	mov	dx,word [NAMBAR]
	add	dl,2
	call	AcquireSemaphore
	in	ax,dx
	xor	ax,8000h
	push	ax
	call	AcquireSemaphore
	pop	ax
	out	dx,ax
	pop	dx
NotMuteKey:
	cmp	al,0dh
	je	EnterKey
	cmp	ax,3563h
	jne	NotVolumeDownKey
MinusKey:
	push	dx
	mov	dx,word [NAMBAR]
	add	dl,2
	call	AcquireSemaphore
	in	ax,dx
	push	ax
	and	ax,3f3fh
	cmp	ax,3f3fh
	pop	ax
	je	VolumeDownKeyHandled
	add	ax,0101h
	push	ax
	call	AcquireSemaphore
	pop	ax
	out	dx,ax
VolumeDownKeyHandled:
	pop	dx
NotVolumeDownKey:
	cmp	al,2dh
	je	MinusKey
	cmp	ax,3562h
	jne	NotVolumeUpKey
PlusKey:
	push	dx
	mov	dx,word [NAMBAR]
	add	dl,2
	call	AcquireSemaphore
	in	ax,dx
	push	ax
	and	ax,3f3fh
	pop	ax
	jz	VolumeUpKeyHandled
	sub	ax,0101h
	push	ax
	call	AcquireSemaphore
	pop	ax
	out	dx,ax
VolumeUpKeyHandled:
	pop	dx
NotVolumeUpKey:
	cmp	al,2bh
	je	PlusKey
ContinueExecution:
	in      al,dx
	inc	al
	and	al,31
	cmp	al,byte [LVI]
	jnz	UpdateLp
	xor	word [Counter],2
	jmp     OutPutLp
exit:
	mov	dx,[NABMBAR]
	add	dl,18h	;POPICB=NABMBAR+18
WaitForFinish:
	in	ax,dx
	test	ax,ax
	jnz	WaitForFinish
	mov	dx,word [NABMBAR]
	add	dl,1bh
	mov	al,0
	out	dx,al	;Stop Bus Mastering
	retn
OutOfMLoop:
	mov	dx,word [NABMBAR]
	add	dl,1bh
	xor	ax,ax
	out	dx,al	;Stop Bus Mastering
;	int	16h
	retn
AcquireSemaphore:
	push    dx
	pushf
	mov     cx,100
	mov     dx,word [CAS]
	in	al,dx
WaitForSemaphore:
	in	al,dx
	call	Delay40MuS
	test	al,1
	loopz	WaitForSemaphore
	jz	AcquireSemaphoreError
	popf
	pop	dx
	retn
Delay40MuS:
	push    ax
	push    dx
	pushf
	mov     al,0
	out     43h,al
	in      al,40h
	mov     ah,al
	in      al,40h
	xchg    al,ah
	mov     dx,ax
	cli
DelayLoop:
	mov     al,0
	out     43h,al
	in      al,40h
	xchg    al,ah
	sub     ax,word [DelayTime]
	cmp     ax,dx
	jng     DelayLoop
	popf
	pop     dx
	pop     ax
	retn
CheckForTimeOut:
	push	ax
	push	dx
	pushf
	mov	dx,word [GlobStat]
	in	eax,dx
	test	ah,80h
	out	dx,eax
	jnz	IOTimeOut
	popf
	pop	dx
	pop	ax
	retn
NoPCIBIOS:
	mov     dx,NoPCIBIOSMessage
	jmp     ErrorExit
GetDeviceError:
	cmp     ah,86h
	jne     INT1AError
	mov     dx,DeviceNotFoundMessage
	jmp     ErrorExit
INT1AError:
	mov     dx,INT1AErrorMessage
	jmp     ErrorExit
AcquireSemaphoreError:
	mov     dx,AcquireSemaphoreErrorMessage
	jmp     ErrorExit
FileOpenError:
	mov	dx,FileOpenErrorMessage
	jmp	ErrorExit
IOTimeOut:
	mov	dx,IOTimeOutMessage
	jmp	ErrorExit
FormatError:
	mov	dx,FormatErrorMessage
	jmp	ErrorExit
FormatNotSupported:
	mov	dx,FormatNotSupportedMessage
	jmp	ErrorExit
ConfigError:
	mov     dx,ConfigErrorMessage
ErrorExit:
	mov     ah,9
	int     21h
	int	20h
PromptStr:
	db	"Enter the PCM WAV file name:"
CrLf:
	db	13,10,24h
NoPCIBIOSMessage:
	db      "PCI BIOS not supported - unable to find AC'97.",13,10,24h
INT1AErrorMessage:
	db      "INT 1A Error.",13,10,24h
DeviceNotFoundMessage:
	db      "No supported AC'97 controller found.",13,10,24h
ConfigErrorMessage:
	db      "PCI configuration error.",13,10,24h
PrimaryCodecTimeOutMessage:
	db      "Primary codec timed out.",13,10,24h
CouldNotPowerUpMessage:
	db      "Could not power up codec.",13,10,24h
IOTimeOutMessage:
	db      "I/O Time Out while reading codec register",13,10,24h
AcquireSemaphoreErrorMessage:
	db      "Could not acquire codec access semaphore.",13,10,24h
FileOpenErrorMessage:
	db	"Could not open file.",13,10,24h
FormatErrorMessage:
	db	"The file is not a valid WAV file, or the format is unsupported.",13,10,24h
FormatNotSupportedMessage:
	db	"File format is not supported.",13,10,24h
VRAUnsupportedMessage:
	db	"VRA is not supported by the hardware",13,10,24h
LVI:
	db	0
BufSize:
	dw	7ff0h-fileBuffer,7000h
fileBuf:
	dw	fileBuffer,7ff0h
DelayTime:
	dw	48
Counter:
	dw	2
SingleChannelFlag:
	db	2	;Will be number of channels
BusDevFunc:
	org     $+2
NAMBAR:
	org     $+2
NABMBAR:
	org     $+2
GlobStat:
	org     $+2
CAS:
	org	$+2
align 8
BDL:
org $+64*4
fileBuffer:
FileNameStr:
	org	$+2
fileName: