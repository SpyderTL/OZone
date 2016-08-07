	PAGE	66,132
;****************************** MEMORY2.ASM *********************************
;
;----------------------------------------------------------------------------
LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
	extrn	 word_crc1:far
	extrn	 find_cpu_type:far
.list
;----------------------------------------------------------------------------
;
; structure of cmos
;
; To find fixed disk drive type information, look at locaton cm12.  The high
; nibble describes disk 1 and the low nibble describes disk 2.  If either
; nibble contains 'f' then look at locations 19h (disk 1) or location 1ah
; (disk 2) for drive type.  If either nibble is less than 'F' then it is
; the drive type.
;
; For PS/2 computers disk 1 type is stored at cm11 and disk 2 type at cm12.
; This information has not been verified accurate 100% of time.
;
; The bios uses cmos location cm12 on an AT to determine number of drives
; and type.  The PS/2 must use cmos locations cm11 & cm12 to find number
; of drives.
; IBM and most clones use the same method to determine number of drives
; and types, The cmos formats are identical.  Older IBM bios's only
; used location cm12 without extended drives, but new bios's allow the
; extended drive types stored at locations 19h & 1ah.
;
cmos	struc
 cm0	db	0	;0  seconds
 cm1	db	0	;1  seconds alarm
 cm2	db	0	;2  minutes
 cm3	db	0	;3  minutes alarm
 cm4	db	0	;4  hours
 cm5	db	0	;5  hours of alarm
 cm6	db	0	;6  day of week
 cm7	db	0	;7  day of month
 cm8	db	0	;8  month
 cm9	db	0	;9  year
 cm0a	db	0	;0a status a
 cm0b	db	0	;0b status b (alarm)
 cm0c	db	0	;0c status c (flags)
 cm0d	db	0	;0d status d (battery)
 cm0e	db	0	;0e post diag status results
 cm0f	db	0	;0f shutdown status
 cm10	db	0	;10 diskette drive type            checksumed
 cm11	db	0	;11 (PS/2 fixed disk 1 type)       checksumed
 cm12	db	0	;12 fixed disk type (PS/2 disk 2)  checksumed
 cm13	db	0	;13                                checksumed
 cm14	db	0	;14 equip word low byte            checksumed
 cm15	db	0	;15 low byte base memory size      checksumed
 cm16	db	0	;16 high byte base memory size     checksumed
 cm17	db	0	;17 low byte expansion memory      checksumed
 cm18	db	0	;18 high byte expansion memory     checksumed
 cm19	db	0	;19 fixed disk type "c"            checksumed
 cm1a	db	0	;1a fixed disk type "d"            checksumed
 cm1b	db	0       ;1b                                checksumed
 cm1c	db	0       ;1c                                checksumed
 cm1d	db	0       ;1d                                checksumed
 cm1e	db	0       ;1e                                checksumed
 cm1f	db	0       ;1f                                checksumed
 cm20	db	0       ;20                                checksumed
 cm21	db	0       ;21                                checksumed
 cm22	db	0       ;22                                checksumed
 cm23	db	0       ;23                                checksumed
 cm24	db	0       ;24                                checksumed
 cm25	db	0       ;25                                checksumed
 cm26	db	0       ;26                                checksumed
 cm27	db	0       ;27                                checksumed
 cm28	db	0       ;28                                checksumed
 cm29	db	0       ;29                                checksumed
 cm2a	db	0       ;2a                                checksumed
 cm2b	db	0       ;2b                                checksumed
 cm2c	db	0       ;2c                                checksumed
 cm2d	db	0       ;1d                                checksumed
 cm2e	db	0	;2e checksum high                  checksumed
 cm2f	db	0	;2f checksum low                   checksumed
 cm30	db	0	;30 usable mem above 1meg (low)
 cm31	db	0	;31 usable mem above 1meg (high)
 cm32	db	0	;32 century (bcd)
 cm33	db	0	;33 128k info. (status byte)
 cm34	db	0	;34 reserved
cmos	ends

comment 
  00h         Seconds
  01h         Second Alarm
  02h         Minutes
  03h         Minute Alarm
  04h         Hours
  05h         Hour Alarm
  06h         Day of the Week
  07h         Day of the Month
  08h         Month
  09h         Year
  0Ah         Status Register A
  0Bh         Status Register B
  0Ch         Status Register C
  0Dh         Status Register D
  0Eh         Diagnostic Status Byte
  0Fh         Shutdown Status Byte
  10h         Disk Drive Type for Drives A: and B:
              The drive-type bytes use bits 0:3 for the first
              drive and 4:7 for the other disk drive types.
  00h         no drive present
  01h         double sided 360k
  02h         high capacity (1.2 meg)
  03h-0Fh     reserved
  11h         (AT):Reserved    (PS/2):drive type for hard disk C:
  12h         (PS/2):drive type for hard disk D:
              (AT, XT/286):hard disk type for drives C: and D:
  Format of drive-type entry for AT, XT/286:
  0       number of cyls in drive (0-1023 allowed)
  2       number of heads per drive (0-15 allowed)
  3       starting reduced write compensation (not used on AT)
  5       starting cylinder for write compensation
  7       max. ECC data burst length, XT only
  8       control byte
  Bit
  7       disable disk-access retries
  6       disable ECC retries
  5-4     reserved, set to zero
  3       more than 8 heads
  2-0     drive option on XT (not used by AT)
  9       timeout value for XT (not used by AT)
  12      landing zone cylinder number
  14      number of sectors per track (default 17, 0-17 allowed)
  13h         Reserved
  14h         Equipment Byte (corresponds to sw. 1 on PC and XT)
  15h-16h     Base Memory Size      (low,high)
  17h-18h     Expansion Memory Size (low,high)
  19h-20h     Reserved
          (PS/2) POS information Model 50 (60 and 80 use a 2k
          CMOS RAM that is not accessible through software)
  21h-2Dh     Reserved (not checksumed)
  2Eh-2Fh     Checksum of Bytes 10 Through 20  (low,high)
  30h-31h     Exp. Memory Size as Det. by POST (low,high)
  32h         Date Century Byte
  33h         Information Flags (set during power-on)
  34h-3Fh     Reserved 


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
CMOS_TYPE - check cmos type
;  inputs: none
;  outputs: dl = 0 standart AT cmos
;                1 ps/2 style cmos
;               0ffh cmos is bad, checksum fails
;
;* * * * * * * * * * * * * *

	public	CMOS_TYPE
CMOS_TYPE	proc	far
	push	ax
	call	find_cpu_type
	cmp	al,1
	jbe	bad_cmos
	mov	dl,0				;set AT style cmos
	call	CMOS_CHECKSUM
	cmp	al,0
	je	cmos_exit
	mov	dl,1				;set ps/2 stlye cmos
	call	CMOS_CHECKSUM
	je	cmos_exit
bad_cmos:
	mov	dl,0ffh
cmos_exit:
	pop	ax
	retf
	
CMOS_TYPE	endp


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
CMOS_CHECKSUM - checksum a block of cmos memory
;  inputs:  dl = cmos type,  0(at) 1(ps/2)
;  outputs: bx = cmos crc calculation
;           al = 0 (checksum ok)  1 (checkusm bad)
;
;  note:  The computed checksum is compared to the one stored in
;         cmos and if bad the -al- register is set to 1.
;
;* * * * * * * * * * * * * *

	public	CMOS_CHECKSUM
CMOS_CHECKSUM	proc	far
	sub	bx,bx
	sub	cx,cx
	mov	cl,cm10			;diskette byte offset
	mov	ch,cm2e			;checksum high byte
	cmp	dl,1			;check if ps2
	jne	cmos2
	mov	bx,-1			;init crc to -1
	mov	ch,cm34			;ps2 end point

cmos2:	mov	ah,cl

	push	ax
	call	CMOS_READ_BYTE
	add	sp,2		;fix stack
	
	cmp	dl,1		;check if ps2
	jne	norm_cksm
;
; ps2 crc calc     al=raw data  bx=crc so far
;
	call	word_crc1
	jmp	norm_ck_cont
norm_cksm:
	xor	ah,ah
	add	bx,ax
norm_ck_cont:
	inc	cl
	cmp	ch,cl
	jnz	cmos2
	cmp	dl,1		;check if ps/2
	jne	normal_checksum
	or	bx,bx
	jnz	bad_checksum
;
; check  ps/2 checksum
;
	mov	ah,cm32		;address checksum high
	
	call	CMOS_READ_WORD
	xchg	al,ah
	mov	bx,ax
	sub	ax,ax
	jmp	cmos_ck_exit

normal_checksum:
	mov	ah,cm2e		;address checksum high
	call	CMOS_READ_WORD
	xchg	al,ah		;fix checksum	
	cmp	ax,bx
	jne	bad_checksum
	sub	ax,ax
	jmp	cmos_ck_exit
bad_checksum:
	mov	al,1
cmos_ck_exit:
	ret
CMOS_CHECKSUM	endp


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
CMOS_READ_BYTE - read one char from cmos memory
;  inputs:  ah = address
;  outputs: al = cmos data read
;
;* * * * * * * * * * * * * *

	public	CMOS_READ_BYTE
CMOS_READ_BYTE	proc	far
	pushf
	mov	al,ah
	rol	al,1
	stc
	rcr	al,1
	cli
	out	70h,al			;output address
	nop
	nop
	nop
	in	al,71h			;read data port
	push	ax
	mov	al,1ah			;get default address
	rcr	al,1			;add in nmi bit
	out	70h,al			;select default loc
;
; dummy read for reported problem with PS/2 computers
;
	in	al,71h			;read cmos
	
	sti
	pop	ax			;restore data read
	push	cs
	call	popf_sub
	retf
;
; this code restores flags, and nmi state
;
popf_sub:
	iret
CMOS_READ_BYTE	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
CMOS_READ_WORD - read one word from cmos memory
;  inputs:  ah = address
;  outputs: ax = cmos data read
;
;* * * * * * * * * * * * * *

	public	CMOS_READ_WORD
CMOS_READ_WORD	proc	far
	push	bx
	call	CMOS_READ_BYTE
	mov	bl,al
	inc	ah
	call	CMOS_READ_BYTE
	mov	ah,bl
	xchg	al,ah
	pop	bx
	retf
CMOS_READ_WORD	endp


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
CMOS_READ_BLOCK - read block of data from cmos memory
;  inputs:  ah = starting cmos address
;         es:di = storage location
;            cx = number of bytes to read
;  outputs: none
;
;* * * * * * * * * * * * * *

	public	CMOS_READ_BLOCK
CMOS_READ_BLOCK	proc	far
	cld
	apush	ax,cx
crb1:	call	CMOS_READ_BYTE
	stosb
	inc	ah
	loop	crb1
	apop	cx,ax
	retf
CMOS_READ_BLOCK	endp


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
CMOS_WRITE_BYTE - write one char to cmos memory
;  inputs:  ah = address
;           al = data to write
;  outputs: none
;
;* * * * * * * * * * * * * *

	public	CMOS_WRITE_BYTE
CMOS_WRITE_BYTE	proc	far
	out	70h,al			;select address
	jmp	$+2			;delay
	jmp	$+2			;delay
	xchg	al,ah
	out	71h,al
	xchg	al,ah
	retf
CMOS_WRITE_BYTE	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
CMOS_WRITE_WORD - write one word to cmos memory
;  inputs:  bl = cmos address to write
;           ax = data to write
;  outputs: none
;
;* * * * * * * * * * * * * *

	public	CMOS_WRITE_WORD
CMOS_WRITE_WORD	proc	far
	apush	ax,ax
	mov	ah,bl
	call	CMOS_WRITE_BYTE
	pop	ax
	xchg	al,ah
	mov	ah,bl
	inc	ah
	call	CMOS_WRITE_BYTE
	pop	ax
	retf
CMOS_WRITE_WORD	endp


comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  MEMORY )
CMOS_WRITE_BLOCK - write block of data to cmos memory
;  inputs:  ah = cmos address to start writing
;           ds:si = data to write
;           cx = length of write
;
;* * * * * * * * * * * * * *

	public	CMOS_WRITE_BLOCK
CMOS_WRITE_BLOCK	proc	far
	cld
	apush	ax,cx
cwb1:	lodsb
	call	CMOS_WRITE_BYTE
	inc	ah
	loop	cwb1
	apop	cx,ax
	retf
CMOS_WRITE_BLOCK	endp



LIBSEG	ENDS
;;	end
