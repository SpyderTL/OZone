;****************************** common.inc **********************************
;
;-------------------- error_handler equates ---------------------------
;
fatal_error	equ	80h	;after display abort and exit
non_fatal1	equ	40h	;return if retry requested
non_fatal2	equ	20h	;return after any key press
fatal_return	equ	10h	;display then return after any key
disk_msg	equ	08h	;messages are stored in disk file
dos_display	equ	04h	;use dos to display error info
error_text	equ	02h	;display text at ds:bp
error_value	equ	01h	;display number in -bp-
;
; LIBRARY_SETUP returns a pointer to the following structure.
;
info	struc
 cpu_type	db	?	;0=88 1=186 2=286 3=386 4=486
 math_chip	db	?	;0=none 1=8087 2=287 3=387 4=487
 mouse_present	db	?	;0=no n=yes
 crt_type	db	?	;
 crt_mode	db	?
 mono_flag	db	?
 ansi_present	db	?	;0=no 1=yes
 users_color	db	?
 crt_seg	dw	?	;segment of crt buffer
 crt_rows	db	?	;
 crt_columns	db	?	;
 key_type	db	?	;0=old style 1=enhanced
 psp_seg	dw	?	;psp segment
info	ends
; 
; The following equates are inputs to the MESSAGE routine to contol its
; actions.  See flags in -BP-
;
msg_save_win	equ	001h	;save screen area before drawing box
msg_restore_win	equ	002h	;restore screen before exit
msg_hyper	equ	004h	;this is a hyper msg & key processing
msg_yesno	equ	008h	;this message needs yes/no response
msg_anykey	equ	010h	;this message waits for any key
msg_nokey	equ	020h	;this message does not pause for key
msg_close	equ	040h	;close message file before exit
msg_open	equ	080h	;open message file before attempting read
;       	equ	100h	;
msg_disp	equ	200h	;display the message
msg_ram		equ	400h	;message in memory (ds:si) rather than in file
;
;-------------------- mousekey (pulldown_menu) -------------------------
;
; this structures is part of following structure
;
menu_entry	struc
 e_count	db	?		;number of submenu items
 e_sub_length	db	?		;width of submenu box if needed
 e_hot_key	db	?		;assume extended key alt-??, 00=none
 e_length	db	?		;length of text,not including 0 at end
 e_text_ptr	dw	?		;ptr to text for this option
 e_process	dw	?		;processing info, or sub struc ptr
 e_column	db	?		;option column, for submenu use (main+1)
 e_row		db	?		;row for this option,start submenu at +1
menu_entry	ends

menu_def	struc
 m_flag		db	?		;see below (set by pulldown_menu)
 m_left_column	db	?		;starting column for menu bar
 m_top_row	db	?		;top row of window (menu row)
 m_rows		db	?		;total rows in window
 m_columns	db	?		;total columns in window
 m_options	db	?		;total # of main menu options
 m_selected_main dw	?		;set by pulldown_menu (0=none selected)
 m_selected_sub dw	?		;set by pulldown_menu (0=none selected)
; main headings descriptors (zero unused entries at end)
 m_main01	db	size menu_entry dup (?)      ;see menu_entry structure
 ;place additional main heading descriptions here, last one is null entry
 ;place menu bar text here
 ;place submenu structures here
 ;place submenu text here, each string separated with a zero.
menu_def	ends
;------------------------------------------------------------------------
; GET_STRING input flags
;
gs_numbers	equ	01h	;get numbers only
gs_upper	equ	02h	;get upper case characters
gs_lower	equ	04h	;get lower case characters
gs_file		equ	08h	;get filename characters only
gs_init		equ	10h	;initialize (do once per string entry)
gs_key_wait	equ	20h	;input keys till done or unknown key found
gs_key_check	equ	40h	;input key only if it is ready
gs_close	equ	80h	;remove cursor and deselect string 

;-------------------------------- PULLDOWN DATA  -----------------------------

; flag definitions for input to pulldown_menu

bar_save	equ	80h	;save display data under bar
bar_restore	equ	40h	;restore display data under bar before exit
bar_display	equ	20h	;display the menu bar
wait_valid_key	equ	10h	;wait forever till valid key found
return_bad_key	equ	08h	;wait for key and return unknown keys
no_mouse_sim	equ	04h	;do not simulate mouse with arrow keys
no_mouse_show	equ	02h	;do not display mouse cursor
