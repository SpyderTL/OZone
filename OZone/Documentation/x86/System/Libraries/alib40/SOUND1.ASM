	page	66,132
;******************************** SOUND1.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list

	public	sound_flag
sound_flag	db	1	;0=sound off  1=sound on

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SOUND  )
SOUND_ON - Enable sounds from BEEP and ONE_BEEP
;
; inputs: none
; output: none
;* * * * * * * * * * * * * *

	public	sound_on
sound_on	proc	far
	mov	cs:sound_flag,1
	retf
sound_on	endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  SOUND  )
SOUND_OFF - Disable sounds from BEEP and ONE_BEEP
;
; inputs: none
; output: none
;* * * * * * * * * * * * * *

	public	sound_off
sound_off	proc	far
	mov	cs:sound_flag,0
	retf
sound_off	endp

LIBSEG	ENDS
	end
