	page	66,132
;******************************** ERROR5.ASM *********************************

LIBSEG           segment byte public "LIB"
		assume cs:LIBSEG , ds:nothing

;----------------------
	public	error_number,error_flags,entry_seg,entry_bp
	public	err_asciiz
	public	err_tbl_off,err_tbl_seg
;----------------------
; primed error info.
;
err_asciiz	db	13 dup (0)
err_tbl_off	dw	0
err_tbl_seg	dw	0
;----------------------
error_number	db	0
error_flags	db	0
entry_seg	dw	0
entry_bp	dw	0
;----------------------------------------------------------------------------
; pre definded error messages used by LIB_ERROR_HANDLER1
;
	public	error_index
error_index	dw	error01
		dw	error02
		dw	error03
		dw	error04
		dw	error05
		dw	error06
		dw	error07
		dw	error08
		dw	error09
		dw	error10
		dw	error11
		dw	error12
		dw	error13
		dw	error14
		dw	error15
		dw	error16
		dw	error17
		dw	error18

error01	label byte
 db 'Incompatable display mode',0
error02	label byte
 db 'Code error, Contact program author for possible problem resolution',0dh,0ah
 db 0
error03	label byte
 db 0dh,0ah,'Disk read error, Press any key to contine',0
error04	label byte
 db 'Fatal disk error, Press any key',0
error05	label byte
 db 'Out of memory, Press any key to abort current operation',0
error06 label byte
 db 'Path change failed, Press any key',0
error07	label byte
 db 'insufficient DOS memory to run program,  Press any key to abort.',0
error08	label byte
 db 'Error in finding/reading quote file QUOTE.DAT',0
error09	label byte
 db 'Memory manager transfer error.  This is usually an programming error'
 db '.  Contact the author for assistance.',0
error10	label byte
 db 'Open of above file failed, possibly the file does not exist or is'
 db 'not in correct directory.',0
error11 label byte
 db 'The program configuration (.CFG) file is missing an <end> statement.'
 db ' press any key to continue',0
error12	label byte

error13	label byte

error14	label byte

error15	label byte

error16	label byte

error17	label byte

error18	label byte

LIBSEG	ENDS
	end
