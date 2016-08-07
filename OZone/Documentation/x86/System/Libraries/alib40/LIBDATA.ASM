	PAGE	66,132
;*********************************** LIBDATA.LIB *****************************
;
; 1. All library functions and data will be placed in a separate segment.
;
; 2. All library fuctions will be FAR PROC's except for internal
;    library functions.
;
; 3. Local (near) library funcitions will have a "$" in name to
;    signify a local function.
;
; 4. This file will contain data which is common (global) within the library.
;
; 5. Most routines do not preserve the flag register and it must be saved
;    by caller if needed.
;    
;----------------------------------- MEMORY DATA -----------------------------


LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

 db 'ALIB 1.0 Copyright 1994, Owens Consulting'
;----------------------------------------------------------------------------
.xlist
	include  mac.inc
	include  common.inc
.list
;----------------------------------------------------------------------------
	public	psp_seg,breakflag
;--------------------------------- SYSTEM DATA -------------------------------

BREAKFLAG	DB	0	;set by ctrl break handlers (1d2h)

; LIBRARY_SETUP returns a pointer to the following structure.
;
;info	struc
; cpu_type	db	?	;0=88 1=186 2=286 3=386 4=486
; math_chip	db	?	;0=none 1=8087 2=287 3=387 4=487
; mouse_present	db	?	;0=no n=yes
; crt_type	db	?	;
; crt_mode	db	?
; mono_flag	db	?
; ansi_present	db	?	;0=no 1=yes
; users_color	db	?
; crt_seg	dw	?	;segment of crt buffer
; crt_rows	db	?	;
; crt_columns	db	?	;
; key_type	db	?	;0=old style 1=enhanced
; psp_seg	dw	?
;info	ends

	public	lib_info
lib_info	info	<>

;--------------------------------- MOUSEKEY DATA -----------------------------
;
; options set by menuoption in MOUSEKEY.LIB
;
	public	bar_text_color,bar_select_color,bar_hotkey_color
	public	submenu_text_color,submenu_select_color
	public	msg_text_color,msg_hyper_color,pick_color,pick_select_color
	public	frame_style
	
bar_text_color		Db	07
bar_select_color	db	70h
bar_hotkey_color	db	0fh
submenu_text_color	db	0fh
submenu_select_color	db	70h
msg_text_color		db	07h
msg_hyper_color		db	70h
pick_color		db	07h
pick_select_color	db	70h

frame_style		db	0h

	public	ten
ten		dw	10

LIBSEG	ENDS
	end
