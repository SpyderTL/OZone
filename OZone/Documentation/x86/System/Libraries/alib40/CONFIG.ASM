	PAGE	66,132
;******************************** CONFIG.ASM *******************************
LIBSEG	SEGMENT BYTE PUBLIC "LIB"
	ASSUME	CS:LIBSEG,DS:LIBSEG

	EXTRN	DOS_MEM_ALLOCATE:FAR,DOS_MEM_RELEASE:FAR
	extrn	buffer_searchc:far
	extrn	find_home_path:far
	extrn	menu_system:far
	extrn	clear_screen:far
	extrn	display_string:far
	extrn	message:far
	extrn	str_copy:far
	extrn	str_cleanl:far
	extrn	BYTE_TO_HEX_STR:far
	extrn	WORD_TO_HEX_STR:far
	extrn	DWORD_TO_HEX_STR:far
	extrn	DWORD_TO_DEC_STR:far
	extrn	DEC_STR_TO_WORD:far
	extrn	DEC_STR_TO_DWORD:far
	extrn	HEX_STR_TO_BYTE:far
	extrn	HEX_STR_TO_WORD:far
	extrn	get_string:far
	extrn	key_put:far
	extrn	posn_to_adr:near
	extrn	$put_crt_blk:near
	extrn	put_crt_chr:far
	extrn	$put_crt_chr:near
	extrn	to_upper:far
	extrn	one_beep:far

	extrn	lib_info:byte
	extrn	bar_text_color:byte
	extrn	bar_select_color:byte
	extrn	bar_hotkey_color:byte
	extrn	submenu_text_color:byte
	extrn	submenu_select_color:byte
	extrn	msg_text_color:byte
	extrn	msg_hyper_color:byte
	extrn	pick_color:byte
	extrn	pick_select_color:byte
			
	INCLUDE	MAC.INC
	INCLUDE	COMMON.INC
;----------------------------------------------------------------------------
;------------------------------ data section --------------------------------
;----------------------------------------------------------------------------
top_data_line	equ	4
last_data_line	equ	top_data_line+19

;-----------
work_area	struc
default_ptr	dw	?	;ptr to default setup block
header_count	db	?	;number of headers in block
cursor_page_ptr	dw	?	;pointer into summary_table
cursor_line_ptr	dw	?	;pointer into page_detail
cursor_line	db	?	;display line

;--- summary_table ---  table end has headerx_ptr set to zero

header1_ptr	dw	?
h1_line1_ptr	dw	?
header1_entries	dw	?
header2_ptr	dw	?
h2_line1_ptr	dw	?
header2_entries	dw	?
header3_ptr	dw	?
h3_line1_ptr	dw	?
header3_entries	dw	?
header4_ptr	dw	?
h4_line1_ptr	dw	?
header4_entries	dw	?
header5_ptr	dw	?
h5_line1_ptr	dw	?
header5_entries	dw	?
header6_ptr	dw	?
h6_line1_ptr	dw	?
header6_entries	dw	?
header7_ptr	dw	?
h7_line1_ptr	dw	?
header7_entries	dw	?

;--- page_detail (lines)  --- table end has linexx_ptr set to zero

line01_ptr	dw	?
line02_ptr	dw	?
line03_ptr	dw	?
line04_ptr	dw	?
line05_ptr	dw	?
line06_ptr	dw	?
line07_ptr	dw	?
line08_ptr	dw	?
line09_ptr	dw	?
line10_ptr	dw	?
line11_ptr	dw	?
line12_ptr	dw	?
line13_ptr	dw	?
line14_ptr	dw	?
line15_ptr	dw	?
line16_ptr	dw	?
line17_ptr	dw	?
line18_ptr	dw	?
line19_ptr	dw	?
line20_ptr	dw	?
line21_ptr	dw	?
line22_ptr	dw	?

;--- line detail

cursor_column	db	?	;display column
ld_type		db	?	;1=bool 2=hex 3=decimal 4=color 5=string
ld_len		db	?	;1=byte 2=word 4=dword n=string len
ld_minimum	dd	?	;minimum setting
ld_max		dd	?	;maximum setting
ld_default_ptr	dw	?	;ptr to default/current setting
ld_descrip_ptr	dw	?	;ptr to descriptive text
ld_str_len	db	?	;length of get_string buffer & edit field
temp_string	db	80 dup (?)

;--- working_setup

working_setup	db	?

;--- default_setup

work_area	ends
;----------------------------------------
callers_setup_block_off	dw	0
callers_setup_block_seg	dw	0
setup_block_len		dw	0

allocated_mem_seg	dw	0

end_string	db	'<<end>>',0
setup_filename	db	13 dup (0)
file_found	db	0		;0=file not found  1=file found

off_string	db	'OFF',0
on_string	db	'ON ',0

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  CONFIG )
GET_SETUP - read setup file from disk
;
; inputs: ds:si = pointer to default setup block
;
; ouptut:  AL = 0 (setup block is ok, input block updated if file found)
;               1 (setup block is bad)
;          AH = 0 (setup file was not found, so it was created using defaults)
;               1 (setup file read from disk)
;
; processing: 0. allocate memory and copy default setup information.
;             1. build setup file name using executable plus ".CFG"
;             2. look for existing setup file & use if found
;             3. if setup not found write defaults to disk
;             4. parse setup block and build summary_table
;             5. feed color information to library
;
; notes:  GET_SETUP establishes the setup data block for program and
;         library code.  Each variable in the setup block is placed under
;         a header and is described by a structure.  The header format
;         is "<<header text>>" followed by a zero character.  Up to
;         six headers can be definded.  The variable data is described
;         by a structure with the following format:
;
;           struc  variable
;             db    ?	;data type 1=boolian,2=hex,3=decimal,4=color,5=string
;             db    ?   ;data length 1=byte,2=word,4=dword, or n for string len
;             xx    ?   ;minimum value,used for data types 1,2,3,4 (see note1)
;             xx    ?   ;maximum value,used for data types 1,2,3,4 (see note1)
;             xx    ?   ;default setting, all data types, strings end with zero
;             db    ?   ;description of this variable (string) ending with zero
;
;             note1 - the length of minimum value and maximum value fields
;                     depends upon the data types and data length.  It will
;                     be a byte for all types except 2 & 3.  For 2&3 the
;                     length will track the length field setting.
;
;         The setup block must have color descriptions in the first block
;         and these color descripitions must be in the order needed by
;         library functions.  A typical setup block consisting of two sections
;         would look like this:
;
;         setup_block	label	byte
;              db	"<<color settings>>",0
;              db	4,1,0,0ff,1bh,"menu bar text color",0
;              db       4,1,0,0ff,2bh,"menu bar select color",0
;                         .
;                         .
;              db       "<<setup block 2>>",0
;              db       1,1,0,1,0,"turn sound on",0              ;yes/no setup
;              db       2,1,0,0ff,0,"enter hex value",0          ;hex byte
;              db       3, 0,0, 8,0, 4,0, 'enter decimal word",0 ;decimal word
;              db       5,15,0,0,"default string",0,"enter string",0
;                         .
;              db       "<<end>>"
;
;              note2 - The length of strings include the zero byte at end.
;              note3 - For correct order and wording of color setup entries
;                      see sample file EDREC.ASM and EDREC.CFG.
;
;           
;* * * * * * * * * * * * * *

	public	GET_SETUP
GET_SETUP	proc	far
	apush	bx,cx,dx,si,di,bp,ds,es
	mov	cs:callers_setup_block_off,si
	mov	cs:callers_setup_block_seg,ds
	mov	cs:file_found,0
;
; scan input block to find length
;
	call	find_block_end
		
	jc	gss_err1			;jmp if <<end>> not found
;
; compute amount of memory needed
;
	sub	di,cs:callers_setup_block_off	;compute length of
	add	di,7				; setup block
	mov	cs:setup_block_len,di		;save length

	shl	di,1				;double it
	add	di,offset working_setup		;include table area
;
; allocate memory
;
	mov	ax,di
	mov	dx,0
	call	dos_mem_allocate
	jnc	gss_1			;jmp if memory allocated in -es-
	mov	al,1
	jmp	gss_exit
;
; compute pointer to default setup block area
;
gss_1:	mov	di,offset working_setup
	add	di,cs:setup_block_len
	mov	es:default_ptr,di		;save in allocated mem
;
; copy callers setup block into allocated memory (defaults)
;
	cld
	mov	cs:allocated_mem_seg,es
	lds	si,dword ptr cs:callers_setup_block_off
	mov	cx,cs:setup_block_len
	rep	movsb
;
; copy callers setup block into allocated memory (working)
;
	mov	si,cs:callers_setup_block_off
	mov	cx,cs:setup_block_len
	mov	di,offset working_setup
	rep	movsb
;
; build name of setup file on disk
;
	push	cs
	pop	ds
	call	build_filename
;
; read setup file into memory, first open file
;
	mov	dx,offset setup_filename
	mov	ax,3d00h
	int	21h			;open file
	jc	gss_fcreate		;jmp if file not found
	push	ax			;save file handle
;
; read the setup file into allocated memory
;
      	pop	bx			;get file handle
	mov	dx,offset working_setup	;buffer offset
	push	es			;set ds:dx
	pop	ds			;  to point at buffer
	mov	cx,cs:setup_block_len
	mov	ah,3fh			;read 
	int	21h			;read into buffer
	jc	gss_fcreate		; if bad read go to create
	mov	cs:file_found,1
	jmp	gss_parse		; jmp if good read
;
; if bad read, try to write setup block to memory
;
gss_fcreate:
	push	cs
	pop	ds
	mov	dx,offset setup_filename
	mov	cx,0			;file attributes
	mov	ah,3ch
	int	21h
	jc	gss_err1		;jmp if error
;
; write data to file
;
	lds	dx,dword ptr cs:callers_setup_block_off
	mov	bx,ax			;move file handle to -bx-
	mov	cx,cs:setup_block_len
	mov	ah,40h
	int	21h
;
; parse setup block and build summary_table
;
gss_parse:
	mov	ah,3eh
	int	21h			;close file	
	call	summary_parse		;parse file & build summary_table
	jc	gss_err1		; jmp if parse error
;
; feed color information into library
;
	call	feed_colors
;
; move working setup block to callers area
;
	call	working_to_caller	
	mov	al,0			;successful parse
	jmp	gss_exit
	
gss_err1:
	mov	al,1
gss_exit:
	mov	ah,cs:file_found	;get file or memory defaults used flag
	apop	es,ds,bp,di,si,dx,cx,bx
	retf
GET_SETUP	endp

comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  CONFIG )
CHANGE_SETUP - modify setup data in memory
;
; inputs:  none
; 
; ouptut:  none
; 
; processing: 1. displaly setup block and accept user changes.
;             2. write setup block to disk only if user requests it.
;
; Notes:  The input to this routine are the setup block which
;         has been processed by GET_SETUP.  CHANGE_SETUP can
;         not be called until GET_SETUP has set up the data it needs.
;
;* * * * * * * * * * * * * *

	PUBLIC	CHANGE_SETUP
CHANGE_SETUP	   proc    far
	apush	ax,bx,cx,dx,si,di,bp,ds,es
;
; initialize variables
;
cs_1:	mov	ax,cs:allocated_mem_seg
	mov	ds,ax
	mov	es,ax
	mov	ds:cursor_page_ptr,offset header1_ptr	;summary_table ptr
cs_2:	mov	ds:cursor_line_ptr,offset line01_ptr	;detail_table ptr
	mov	ds:cursor_line,top_data_line
;
; build page details
;
	call	build_page_detail
;
; clear the screen
;
	mov	ah,cs:submenu_text_color
	mov	al,' '
	call	clear_screen
;
; display header
;
	mov	si,ds:cursor_page_ptr
	mov	si,word ptr ds:[si]		;get header ptr
	
	mov	ax,ds:line01_ptr		;center
	sub	ax,si				;  the header
	mov	dx,80				;
	sub	dx,ax
	shr	dx,1				;dx now has starting column
	
	mov	dh,2				;display row
	mov	ah,cs:submenu_select_color
	call	display_string
;
; setup to display lines
;
	mov	si,offset line01_ptr
;
; display all lines
;
cs_lpp:	call	display_line
	add	ds:cursor_line,1		;move to next display column
	add	ds:cursor_line_ptr,2		;move to next line
	add	si,2
	cmp	word ptr ds:[si],0		;check if done
	jne	cs_lpp				; loop till done
     	mov	ds:cursor_line_ptr,offset line01_ptr	;detail_table ptr
	mov	ds:cursor_line,top_data_line

;
; get keyboard inputs from user
;
cs_5:	call	grab_keyboard_inputs
;
; decode user request, carry =abort key  else ax=process to perform
;
	jc	cs_abortx			;jmp if abort request
	jmp	ax
;
config_restore:
	mov	si,ds:default_ptr
	mov	di,offset working_setup
	mov	cx,cs:setup_block_len
	rep	movsb
	jmp	cs_1
	
config_save:
	mov	si,offset working_setup
	call	write_setup
	jmp	cs_5
	
config_next:
	mov	si,ds:cursor_page_ptr
	add	si,6					;move to next page
	cmp	word ptr ds:[si],0
	jne	cn_ok					;jmp if next page avail
	mov	si,offset header1_ptr			;move to top
cn_ok:	mov	ds:cursor_page_ptr,si
	jmp	cs_2
		
config_help:
	mov	ah,cs:msg_text_color
	mov	al,0				;seperator
	mov	cx,1				;record#
	mov	bx,1048h			;box size
	mov	dx,0404h			;box location
	mov	si,offset config_help_msg
	mov	bp,msg_save_win+msg_restore_win+msg_anykey+msg_ram+msg_disp
	call	message
	jmp	cs_5

config_help_msg label	byte
 db 'The NEXT-PAGE menu selection can be used to view each page '
 db 'of configuration information.  Changes can be made within '
 db 'a page by selecting the correct field using arrow keys, then '
 db 'entering the information.',0

config_exit:
	call	feed_colors
	call	working_to_caller			;give caller changes
cs_abortx:	
	apop	es,ds,bp,di,si,dx,cx,bx,ax
	retf
CHANGE_SETUP	   endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  CONFIG )
;WRITE_SETUP - write setup to disk
;
; inputs:   ds:si = setup block ptr
;	       cx = setup block length
;
; ouptut:   no carry = success
;	       carry = problem creating the file
;             register changed are:  bx,dx
;             
;* * * * * * * * * * * * * *

callers_setup_blk_off	dw	0
callers_setup_blk_seg	dw	0

	PUBLIC	WRITE_SETUP
WRITE_SETUP	  proc	  far
	apush	ax,cx,si,di,ds,es
	mov	cs:callers_setup_blk_off,si
	mov	cs:callers_setup_blk_seg,ds
;
; search for <<end>> string
;
	les	di,dword ptr cs:callers_setup_blk_off
	push	cs
	pop	ds
	mov	si,offset end_string
	mov	cx,2000
	call	buffer_searchc
	jc	wss_exit			;jmp if <<end>> not found
;
; compute length of setup block
;	
	sub	di,cs:callers_setup_blk_off
	add	di,7
	mov	cs:setup_block_len,di
;
; build name of setup file on disk
;
	push	cs
	pop	ds
	call	build_filename
;
; create the file
;
	mov	dx,offset setup_filename
	mov	cx,0			;file attributes
	mov	ah,3ch
	int	21h
	jc	wss_exit		;jmp if error
;
; write data to file
;
	mov	bx,ax			;move file handle to -bx-
	lds	dx,dword ptr cs:callers_setup_blk_off
	mov	cx,cs:setup_block_len
	mov	ah,40h
	int	21h
;
; close the write file
;
	mov	ah,3eh
	int	21h			;close file	
wss_exit:
	apop	es,ds,di,si,cx,ax
	retf
write_setup	  endp
comment 
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -(  CONFIG )
SET_LIB_COLORS - set colors to be used by the library
;
; inputs:  al = color attributes
;          bx = color number (position in table)
;
;            options available are:           defaults:
;              0 = menu bar text color          07h
;              1 = menu bar select color        70h
;              2 = menu bar hotkey color        0Fh         (1)
;              3 = submenu box color            0Fh
;              4 = submenu selection color
;              5 = msg text color
;              6 = msg_hyper_color
;              7 = pick color
;              8 = pick selection color
;
; outputs: none
; 
;* * * * * * * * * * * * * *

	PUBLIC	SET_LIB_COLORS
SET_LIB_COLORS	PROC	FAR
    APUSH   AX,BX
    cmp     bx,8
    ja      slc_exit			;jmp if out of range
    add	    bx,offset bar_text_color
    mov     byte ptr cs:[bx],al		;store new color
slc_exit:
    apop    bx,ax
    retf
SET_LIB_COLORS	ENDP
;---------------------------------------------------------------------------
; setup common subroutines
;---------------------------------------------------------------------------
; summary_parse - parse input block & build summary_table
;
;  inputs:  allocated_mem_seg:working_setup has input block
;           setup_block_len = block lenght
;
;  output:  if no carry - allocated_mem_seg:header1_ptr (summary_table) is built
;                       - header_count is initialized
;           if carry - parse error
;
summary_parse:
	mov	ax,cs:allocated_mem_seg
	mov	ds,ax
	mov	es,ax
	mov	ds:header_count,0

	mov	si,offset working_setup
	mov	di,offset header1_ptr
;
; ds:si = block  es:di=summary table ptr
;
sp_loop:
	cmp	byte ptr ds:[si],'<'
	je	sp_1			;jmp if header start
	inc	si
	jmp	sp_loop

sp_1:	cmp	word ptr ds:[si],'<<'
	jne	sp_err			;jmp if parse error
	cmp	word ptr ds:[si+2],'ne'
	jne	sp_2			;jmp if not "<<end>>"
	cmp	word ptr ds:[si+4],'>d'
	je	sp_end			;jmp if end of parse
;
; look for end of header
;
sp_2:	mov	ax,si
	stosw				;store 	header_ptr into summary
	inc	ds:header_count		;bump header count
sp_3:	lodsb
	cmp	al,'>'
	jne	sp_3			;loop till end of header
	lodsb
	cmp	al,'>'
	jne	sp_err			;jmp if no ">>" at end
	lodsb
	cmp	al,0
	jne	sp_err			;jmp if no zero at end
	mov	ax,si
	stosw				;store ptr to first line under header
	mov	cx,0			;set count =0
sp_4:	call	parse_line
	jc	sp_err			;jmp if line bad
	cmp	al,0
	jne	sp_5			;jmp if no more lines
	inc	cx
	jmp	sp_4			;loop till all lines counted
sp_5:	mov	ax,cx
	stosw				;store line count
	jmp	sp_loop	
	
sp_end:	mov	word ptr es:[di],0	;termainate parse table
	clc
	jmp	sp_exit
sp_err:	stc
sp_exit:ret
;---------------------------------------------------------------------------
; parse_line - parse one input block data item
;
;  inputs:  ds:si = pointer to start of data item
;
;  output:  if no carry - al = 0 found good line
;                         al = 1 found start of next header
;                       - si = pointer to next line or header
;                       - bx = pointer to max value
;                       - dx = pointer to default data
;                       - bp = pointer to descriptive string
;
;           if carry - parse error
;
parse_line:
	apush	cx,di
      	cmp	word ptr ds:[si],'<<'
	je	pl_header		;jmp if header next
	lodsb				;get data type
	cmp	al,5
	je	pl_string		;jmp if string data
	lodsb				;get data length
	cmp	al,1
	je	pl_byte			;jm if byte data
	cmp	al,2
	je	pl_word			;jmp if word data
	cmp	al,4
	jne	pl_err			;jmp if unknown data type
;
; a dword data type was found
;
	add	si,4			;move to maximum value
	mov	bx,si			;save ptr to max
	add	si,4
	mov	dx,si			;save ptr to default value
	add	si,4
	mov	bp,si			;save ptr to descriptive string
	jmp	pl_skip_string
;
; a byte data type was found
;
pl_byte:
	add	si,1			;move to maximum value
	mov	bx,si			;save ptr to max
	add	si,1
	mov	dx,si			;save ptr to default value
	add	si,1
	mov	bp,si			;save ptr to descriptive string
	jmp	pl_skip_string
;
; a word data type was found
;
pl_word:
	add	si,2			;move to maximum value
	mov	bx,si			;save ptr to max
	add	si,2
	mov	dx,si			;save ptr to default value
	add	si,2
	mov	bp,si			;save ptr to descriptive string
	jmp	pl_skip_string
;
; a string data type was found
;
pl_string:
	lodsb				;get string length
	sub	cx,cx
	mov	cl,al			;al = string length
	
	add	si,1			;move to maximum value
	mov	bx,si			;save ptr to max
	add	si,1
	mov	dx,si			;save ptr to default value
pl_string1:
	lodsb
	loop	pl_string1		;loop to end of string
	cmp	al,0			;check if expected zero at end
	jne	pl_err	
	mov	bp,si			;save ptr to descriptive string
;
; skip to end of descriptive string by looking for zero at end
;
pl_skip_string:
	lodsb
	cmp	al,0
	jne	pl_skip_string
	
pl_done:mov	al,0
	jmp	pl_exit1
	
pl_err:	stc
	jmp	pl_exit		
	
pl_header:
	mov	al,1
pl_exit1:	
	clc
pl_exit:apop	di,cx
	ret	
;---------------------------------------------------------------------------
; build_line_detail - expand line information for grab_keyboard_input
;
build_line_detail:
	mov	ds,cs:allocated_mem_seg
	mov	si,ds:cursor_line_ptr
	mov	si,word ptr ds:[si]		;get line ptr
	
	mov	al,byte ptr ds:[si]		;get data type
	mov	ds:ld_type,al

	mov	al,byte ptr ds:[si+1]		;get data len
	mov	ds:ld_len,al

	mov	ax,word ptr ds:[si+2]		;get data min
	mov	word ptr ds:ld_minimum,ax
	mov	ax,word ptr ds:[si+4]
	mov	word ptr ds:ld_minimum+2,ax

	call	parse_line

	mov	ax,word ptr ds:[bx]		;get max data
	mov	word ptr ds:ld_max,ax
	mov	ax,word ptr ds:[bx+2]
	mov	word ptr ds:ld_max+2,ax

	mov	ds:ld_default_ptr,dx		;save default data ptr
	mov	ds:ld_descrip_ptr,bp
	mov	ds:cursor_column,1
	ret
;----------------------------------------------------------------------------
; fill_temp_string - fill in temp string
;  inputs:  line_detail
;  output:  
;
fill_temp_string:
	apush	si,di
	mov	al,ds:ld_type         	;get data type
	cmp	al,5
	je	fts_string		;jmp if data_type = string
	cmp	al,4
	je	fts_color		;jmp if data_type = color
	cmp	al,1
	je	fts_boolean		;jmp if yes/no flag
	cmp	al,2
	jne	fts_1			;jmp if not hex
	mov	al,byte ptr ds:ld_len	;get length
	cmp	al,1
	je	fts_hex_byte
	cmp	al,2
	je	fts_hex_word
;	cmp	al,4
	jmp	fts_hex_dword
fts_1:	mov	al,byte ptr ds:ld_len	;get length
	cmp	al,1
	je	fts_dec_byte
	cmp	al,2
	je	fts_dec_word
;	cmp	al,4
	jmp	fts_dec_dword
	
fts_string:
	mov	si,ds:ld_default_ptr
	mov	di,offset temp_string
	push	ds
	pop	es
	call	str_copy
	mov	ds:ld_str_len,cl		;save string length
	jmp	fts_exit
	
fts_color:
	mov	si,ds:ld_default_ptr
	mov	al,byte ptr ds:[si]		;get color
	mov	ah,0
	mov	word ptr ds:temp_string,ax
	mov	ds:ld_str_len,1
	jmp	fts_exit
	
fts_boolean:
	mov	si,ds:ld_default_ptr
	cmp	byte ptr ds:[si],0		;check if "off"
	mov	si,offset off_string
	je	fts_b2
	mov	si,offset on_string
fts_b2:	push	cs
	pop	ds
	mov	es,cs:allocated_mem_seg
	mov	di,offset temp_string
	call	str_copy
	mov	ds,cs:allocated_mem_seg
	mov	ds:ld_str_len,cl		;save string length
	jmp	fts_exit
	
fts_hex_byte:
	mov	si,ds:ld_default_ptr
	mov	al,byte ptr ds:[si]	;get hex byte
	mov	si,offset temp_string
	call	BYTE_TO_HEX_STR
	mov	byte ptr ds:[si],0	;terminate string
	mov	ds:ld_str_len,2
	jmp	fts_exit
		
fts_hex_word:
	mov	si,ds:ld_default_ptr
	mov	ax,word ptr ds:[si]	;get hex word
	mov	si,offset temp_string
	call	WORD_TO_HEX_STR
	mov	byte ptr ds:[si],0	;terminate string
	mov	ds:ld_str_len,4
	jmp	fts_exit
	
fts_hex_dword:
	mov	si,ds:ld_default_ptr
	mov	ax,word ptr ds:[si]	;get hex word
	mov	dx,word ptr ds:[si+2]	;get hex dword
	mov	si,offset temp_string
	call	DWORD_TO_HEX_STR
	mov	byte ptr ds:[si],0	;terminate string
	mov	ds:ld_str_len,8
	jmp	fts_exit
	
fts_dec_byte:
	mov	si,ds:ld_default_ptr
	mov	al,byte ptr ds:[si]	;get dec byte
	mov	ah,0
	mov	dx,0
	mov	si,offset temp_string
	call	DWORD_TO_DEC_STR
	mov	ds:ld_str_len,3
	jmp	fts_scan

fts_dec_word:
	mov	si,ds:ld_default_ptr
	mov	ax,word ptr ds:[si]	;get dec word
	mov	dx,0
	mov	si,offset temp_string
	call	DWORD_TO_DEC_STR
	mov	ds:ld_str_len,5
	jmp	fts_scan

fts_dec_dword:
	mov	si,ds:ld_default_ptr
	mov	ax,word ptr ds:[si]	;get dec word
	mov	dx,word ptr ds:[si+2]
	mov	si,offset temp_string
	call	DWORD_TO_DEC_STR
	mov	ds:ld_str_len,10
fts_scan:
	call	str_cleanl
fts_exit:
	apop	di,si
	ret	

;---------------------------------------------------------------------------
; store_temp_string - move data from temp string to to working_setup
;  inputs:  none
;  outputs: carry set if conversion error
;
store_temp_string:
	apush	ax,cx,dx
	mov	ax,cs:allocated_mem_seg
	mov	ds,ax
	mov	es,ax
	
	mov	di,ds:ld_default_ptr
	mov	al,ds:ld_type         	;get data type
	cmp	al,5
	je	sts_string		;jmp if data_type = string
	cmp	al,4
	je	sts_color		;jmp if data_type = color
	cmp	al,1
	je	sts_boolean		;jmp if yes/no flag
	cmp	al,2
	jne	sts_1			;jmp if not hex
	mov	al,byte ptr ds:ld_len	;get length
	cmp	al,1
	je	sts_hex_byte
	cmp	al,2
	je	sts_hex_word
;	cmp	al,4
	jmp	sts_hex_dword
sts_1:	mov	al,byte ptr ds:ld_len
	cmp	al,1
	je	sts_dec_byte
	cmp	al,2
	je	sts_dec_word
;	cmp	al,4
	jmp	sts_dec_dword
	
sts_string:
	mov	si,offset temp_string
	call	str_copy
	jmp	sts_done
	
sts_color:
	mov	al,byte ptr ds:temp_string	;get color
	mov	byte ptr ds:[di],al		;store color
	jmp	sts_done
	
sts_boolean:
	mov	al,ds:temp_string
	cmp	al,'o'
	je	sts_bool1			;jmp if ok
	cmp	al,'O'
	jne	sts_err				;jmp if bad
sts_bool1:
	mov	al,ds:temp_string+1
	cmp	al,'n'
	je	sts_on				;jmp if 'on' found
	cmp	al,'N'
	je	sts_on				;jmp if 'ON' found
	cmp	al,'f'
	je	sts_off				;jmp if 'of' found
	cmp	al,'F'				
	jne	sts_err				;jmp if bad
sts_off:
	mov	al,ds:temp_string+2
        cmp     al,'f'
        je      sts_off1                        ;jmp if "off"
        cmp     al,'F'
	jne	sts_err
sts_off1:
	mov	byte ptr ds:[di],0		;set off
	jmp	sts_done
sts_on: mov	al,ds:temp_string+2
        cmp     al,' '
        je      sts_on1                         ;jmp if 'on'
	cmp	al,0
	jne	sts_err
sts_on1:mov	byte ptr ds:[di],1
	jmp	sts_done	
	
sts_hex_byte:
	mov	si,offset temp_string
	call	HEX_STR_TO_BYTE
	jc	sts_err
	cmp	al,byte ptr ds:ld_minimum
	jb	sts_err
	cmp	al,byte ptr ds:ld_max
	ja	sts_err
	mov	byte ptr ds:[di],al
	jmp	sts_done
		
sts_hex_word:
	mov	si,offset temp_string
	call	HEX_STR_TO_WORD
	jc	sts_err
	cmp	ax,word ptr ds:ld_minimum
	jb	sts_err
	cmp	ax,word ptr ds:ld_max
	ja	sts_err
	mov	word ptr ds:[di],ax
	jmp	sts_done
	
sts_hex_dword:
	mov	si,offset temp_string
	call	HEX_STR_TO_WORD
	xchg	ax,dx
	add	si,4
	call	HEX_STR_TO_WORD
	jc	sts_err
; skip min & max checks for dwords	
	mov	word ptr ds:[di],ax
	mov	word ptr ds:[di+2],dx
	jmp	sts_done
	
sts_dec_byte:
	mov	si,offset temp_string
	call	DEC_STR_TO_WORD
	jc	sts_err
	cmp	al,byte ptr ds:ld_minimum
	jb	sts_err
	cmp	al,byte ptr ds:ld_max
	ja	sts_err
	mov	byte ptr ds:[di],al
	jmp	sts_done

sts_dec_word:
	mov	si,offset temp_string
	call	DEC_STR_TO_WORD
	jc	sts_err
	cmp	ax,word ptr ds:ld_minimum
	jb	sts_err
	cmp	ax,word ptr ds:ld_max
	ja	sts_err
	mov	word ptr ds:[di],ax
	jmp	sts_done

sts_dec_dword:
	mov	si,offset temp_string
	call	DEC_STR_TO_DWORD
	jc	sts_err
	cmp	dx,word ptr ds:ld_minimum+2
	jb	sts_err
	jne	sts_dec1			;jmp if check done
	cmp	ax,word ptr ds:ld_minimum
	jb	sts_err
sts_dec1:
	cmp	dx,word ptr ds:ld_max+2
	ja	sts_err
	jne	sts_dec2			;jmp if check done
	cmp	ax,word ptr ld_max
	ja	sts_err
sts_dec2:	
	mov	word ptr ds:[di],ax
	mov	word ptr ds:[di+2],dx
	
sts_done:
	clc	
	jmp	sts_exit
sts_err:
	stc	
sts_exit:
	apop	dx,cx,ax
	ret	
	
;---------------------------------------------------------------------------
; build_page_detail - fill in detail table
;  inputs:  data area variables
;  output:  detail_table
;
build_page_detail:
	mov	ax,cs:allocated_mem_seg
	mov	ds,ax
	mov	es,ax
	mov	si,ds:cursor_page_ptr
	mov	si,word ptr ds:[si+2]		;get ptr to first line
	mov	di,offset line01_ptr
bdt_loop:
	mov	ax,si
	stosw					;put data into detail_table
	call	parse_line
	cmp	al,0
	je	bdt_loop			;loop till end

	sub	di,2				;move back one and zero it
	mov	ax,0
bdt_1:	stosw					;put zero at end
	cmp	di,offset line22_ptr+2
	jne	bdt_1				;loop till remainder zeroed
	ret
	
;---------------------------------------------------------------------------
; grab_keyboard_inputs - check for pulldown keys and decode them
;
;   inputs:    none (database variables used as inputs)
;
;   output:    no carry  ax = processing ptr (restore,save,next,help,exit)
;                 carry     = abort
;
grab_keyboard_inputs:
	mov	ax,cs:allocated_mem_seg
	mov	ds,ax
	mov	es,ax	
	call	build_line_detail
	call	fill_temp_string
	mov	al,ds:ld_type
	cmp	al,1
	je	string_disp
	cmp	al,4
	je	color_disp	

;--------  string entry ---------
string_disp:
	mov	al,cs:pick_color
	mov	ah,cs:pick_select_color
	mov	ch,ds:ld_str_len		;get length of input window
	mov	cl,ch				;get length of buffer

	mov	dh,ds:cursor_line		;get display row
	
	mov	dl,1             		;get display column
	mov	di,offset temp_string
	mov	bl,gs_init
	
	call	get_string
str_1:	push	cs
	pop	es				; es = local seg, ds=allocated
	
	call	do_pulldown			;get input
;
; restore seg reg's
;	
	mov	ds,cs:allocated_mem_seg
	push	ds
	pop	es
;
;  dx=location  ax=key cl=flag ch= (0-abort) (1-process) (2-up) (3=down) (4=??)
;
	cmp	ax,0149h
	je	str_5				;jmp if not pgdn
	cmp	ax,0151h
	jne	str_6				;jmp if not pgup
str_5:	call	store_temp_string
	mov	ch,1
	mov	ax,offset config_next
	jmp	dp_exit1
	
str_6:	cmp	ch,4
	je	string_decode			;jmp if unknown key

str_2:	mov	bl,gs_close
	call	get_string
	
	cmp	ch,0				;check if abort
	jne	str_3				;  jmp if not abort
	stc
	jmp	dp_exit2
;
; check if process(1) up arrow(2)  down arrow(3)
;
str_3:	call	store_temp_string
	jnc	str_4				;jmp if inputs ok
	call	one_beep
	jmp	grab_keyboard_inputs
str_4:	cmp	ch,1
	je	dp_exit1			;jmp if ax=process request
;
; must be up or down arrow, check if color pointers present
;
	cmp	ds:ld_type,4
	jne	move_cursor			;jmp if not color
	mov	dl,ds:cursor_column		;get display column (input area)
	mov	dh,ds:cursor_line
	dec	dl
	mov	al,' '
	call	put_crt_chr
	add	dl,2
	mov	al,' '
	call	put_crt_chr
move_cursor:
	call	display_line			;remove highlight
	cmp	ch,2
	je	sts_up
;
; down arrow
;
	add	ds:cursor_line_ptr,2
	add	ds:cursor_line,1
	jmp	grab_keyboard_inputs
;
; up arrow
;
sts_up: sub	ds:cursor_line_ptr,2
	sub	ds:cursor_line,1
	jmp	grab_keyboard_inputs	
;
; unknown key was pressed, see if it can be added to the string		
;	
string_decode:
	cmp	cl,3				;check if mouse click
	jne	string_key0			; jmp if keystroke
	jmp	str_1           		;ignore all mouse clicks
	
string_key0:
	push	ax				;save key
	call	KEY_PUT				;setup key for get_string
	mov	bl,gs_key_check
	call	get_string
	cmp	cx,-1
	pop	cx				;restore origional key
	je	str_end
	cmp	ax,0				;check if no keys available
	je	str_lp				; jmp if no keys unprocessed
	cmp	ax,cx				;check if different key
	je	str_end				;jmp if same key
	call	KEY_PUT				;	
str_lp:	jmp	str_1           		;let pulldown look at this key
str_end:
	mov	bl,gs_close
	call	get_string
	call	store_temp_string
	jmp	grab_keyboard_inputs
;
; ---------- color entry -----------
;
color_disp:
	call	store_temp_string		;needed if loop back from below
	mov	dh,ds:cursor_line		;get display line
	mov	dl,ds:cursor_column		;get display column (input area)
	mov	ah,ds:temp_string		;get color from raw data
	mov	al,''				;get character
	call	put_crt_chr
;
; put pointers around selected color
;	
	dec	dl
	mov	al,'>'
	call	put_crt_chr
	add	dl,2
	mov	al,'<'
	call	put_crt_chr
		
cd_1:	call	do_pulldown			;check pulldown keys
;
;  dx=location  ax=key cl=flag ch= (0-abort) (1-process) (2-up) (3=down) (4=??)
;
	cmp	ch,0
	jne	cd_2				;jmp if not abort
	stc
	jmp	dp_exit2

cd_2:	call	store_temp_string
	jc	cd_1				;jmp if string bad
	cmp	ch,1
	je	dp_exit1			;jmp process (ax) request
	cmp	ax,0149h
	jne	cd_3				;jmp if not pgdn
	mov	ch,1
	mov	ax,offset config_next 
	jmp	dp_exit1
cd_3:	cmp	ax,0151h
	jne	cd_4				;jmp if not pgup
	mov	ch,1
	mov	ax,offset config_next
	jmp	dp_exit1
cd_4:		
	cmp	ch,4
	je	color_decode			;jmp if color change?
;
; must be up or down arrow
;
	call	display_line			;remove highlights
	cmp	ch,2
	je	cd_up
;
; down arrow
;
	add	ds:cursor_line_ptr,2
	add	ds:cursor_line,1
	jmp	grab_keyboard_inputs
;
; up arrow
;
cd_up:	sub	ds:cursor_line_ptr,2
	sub	ds:cursor_line,1
	jmp	grab_keyboard_inputs	
		
color_decode:
	cmp	cl,3				;check if mouse click
	jne	color_key0			; jmp if keystroke
;
; mouse click, check if right/left color change
;
	cmp	dl,5
	je	color_right
	cmp	dl,7
	je	color_left
	jmp	cd_1
	
color_key0:	
	cmp	ax,014dh			;check if right arrow
	jne	color_key1			; jmp if not right arrow
color_right:	
	add	ds:temp_string,10h		;bump background color
	and	ds:temp_string,7fh		;remove high bit
	jmp	color_disp
	
color_key1:
	cmp	ax,014bh			;check if left arrow
	jne	cd_1      			; jmp if not left arrow (ignore)
color_left:	
	mov	al,ds:temp_string		;get color
	mov	ah,al
	and	ah,0f0h
	inc	al
	and	al,0fh
	or	al,ah
	mov	ds:temp_string,al
	jmp	color_disp
;
; normal exit, ax=process (restore,save,next,help,exit)
;
dp_exit1:
	clc
dp_exit2:
	ret
;--------------------------------------------------------------------------
; do_pulldown - check for pulldown keys and decode them
;   inputs: none
;   output: es:   = raw data segment
;              dx = click/key location
;              cl = pulldown decode flag
;              ax = key if -ch- =0,1,2
;              ch = 0(abort or exit request)
;                   1(process request, ax=process from menu)
;                   2(legal up key)
;                   3(legal down key)
;                   4(unknown key/click in ax,dx,cl
;

do_pulldown:	
	push	cs
	pop	ds
;	
; put up the menu bar
;
	mov	bx,offset config_menu
	mov	ah,bar_display+return_bad_key+no_mouse_sim+no_mouse_show
	call	MENU_SYSTEM
	mov	ds,cs:allocated_mem_seg
	mov	bx,ds:cursor_line_ptr		;ptr to current line
	cmp	cl,1				;check if process hit
	jne	dp_02				; jmp if not process hit
	mov	ch,1
	jmp	dp_exit
dp_02:
	cmp	cl,4
	jne	dp_3
	mov	ch,0
	jmp	dp_exit				;exit if abort key found
;
; an unknown key or mouse click occured, check if up/down arrow first
;
dp_3:	cmp	cl,2				;check if unknown keystroke
	jne	dp_08				; jmp if mouse click
	cmp	ax,0148h			;check if up arrow
	jne	dp_05				; jmp if not up-arrow
;
; up arrow - check if we are at top of section
;	
	cmp	bx,offset line01_ptr
	jne	dp_03				; jmp if we can move up
	jmp	do_pulldown			;jmp if we illegal key
dp_03:
	mov	ch,2
	jmp	dp_exit

dp_05:
	cmp	ax,0150h			;check if down arrow
	jne	dp_07				;  jmp if not down_arrow
;
; down arrow - check if we are at bottom already
;	
	cmp	word ptr ds:[bx+2],0		;check if another line
	je	do_pulldown			; jmp if at last line
	mov	ch,3
	jmp	dp_exit
;
; unknown key press
;
dp_07:	mov	ch,4
	jmp	dp_exit
;
; check if click on option, mouse checks
;
dp_08:	cmp	dh,ds:cursor_line		;check if click in same row
	je	dp_07				;jmp if same row
;
; we have a click on non-selected row, try to move to this row
;	
	mov	bl,dh
	sub	bh,bh
	shl	bx,1
	add	bx,offset line01_ptr
	cmp	word ptr ds:[bx],0
	je	do_pulldown			;jmp if click out of range
	mov	ch,3				;pre load down arrow code
	cmp	dh,ds:cursor_line
	jb	dp_exit				;jmp if down arrow sim
	mov	ch,2
dp_exit:
	ret

;----------------------------------------------------------------------------
; display_line - display one line of config data
;  inputs: ds & es point at allocated memory
;               si = ptr into page_detail (lines)
;

display_line:
	apush	cx,si
;
; parse the current line
;
	call	build_line_detail
	call	fill_temp_string

	mov	si,offset temp_string
	mov	dl,1
	mov	dh,ds:cursor_line
	call	posn_to_adr
	cmp	ds:ld_type,4		;check if color
	jne	dl_1
	sub	di,2			;move back one char
	mov	ah,cs:submenu_text_color
        mov     al,' '
	call	$put_crt_chr
	mov	ah,ds:temp_string	;get color
	mov	al,''
	call	$put_crt_chr
	mov	ah,cs:submenu_text_color
        mov     al,' '
	call	$put_crt_chr
	add	di,4
	jmp	dl_4
		
dl_1:	mov	ah,cs:submenu_text_color
	mov	cx,-1			;set display length to max
	call	$put_crt_blk
	mov	dh,ds:cursor_line
	cmp	ds:ld_type,5		;check if string
	je	dl_2			;  jmp if string
	mov	dl,13
	call	posn_to_adr
	jmp	dl_4
;
; find text location for string description
;
dl_2:	mov	dl,ds:ld_str_len
	add	dl,4
	call	posn_to_adr
;
; display descsriptive string
;
dl_4:	mov	ah,cs:submenu_text_color
	mov	cx,-1			;set display length to max
	mov	ds,cs:allocated_mem_seg
	mov	si,ds:ld_descrip_ptr
	call	$put_crt_blk
	apop	si,cx
	ret
;----------------------------------------------------------------------------
; build setup file name
;  inputs:  ds = library segment
;  output:  setup_filename is created.
;
build_filename:
	apush	cx,si,di,es
	mov	es,lib_info.psp_seg
	call	find_home_path		;returns ES:DI pointing at full path
;
; scan to end of name
;
	mov	si,di
bf_lp1:	inc	si
	cmp	byte ptr es:[si],0
	jne	bf_lp1			;loop till end found
bf_lp2:	dec	si
	cmp	byte ptr es:[si-1],'\'
	je	bf_copyf
	cmp	byte ptr es:[si-1],':'
	je	bf_copyf
	cmp	di,si
	jne	bf_lp2
bf_copyf:
	mov	di,offset setup_filename
bf_loop:	
	mov	al,es:[si]
	cmp	al,0
	je	bf_done			;jmp if name moved
	mov	ds:[di],al
	inc	si
	inc	di
	loop	bf_loop
bf_done:
	sub	di,3
        mov     word ptr [di],'FC'
	add	di,2
        mov     byte ptr [di],'G'
	add	di,1
	mov	byte ptr [di],0
	apop	es,di,si,cx
	ret
;------------------------------------------------------------------------------
; find_block_end - find length of setup block
;  inputs:  address of setup block stored at cs:callers_setup_block_off
;  output:  di = match pointer if no carry
;           if carry then block too big or no <<end>> statement
;         
find_block_end:
	push	cs
	pop	ds
	mov	si,offset end_string
	les	di,dword ptr cs:callers_setup_block_off
	mov	cx,2000				;maximum setup block size
	call	buffer_searchc			;look of end string
fbe_exit:	
	ret
;----------------------------------------------------------------------------
; working_to_caller - copy working setup block to callers area
;  inputs:  cs:callers_setup_block_off = destination
;           cs:allocated_mem_seg:working_setup = source
;           cs:setup_block_len = length
;
working_to_caller:
	apush	ds,es
	les	di,dword ptr cs:callers_setup_block_off
	mov	ds,cs:allocated_mem_seg
	mov	si,offset working_setup
	mov	cx,cs:setup_block_len
	cld
	rep	movsb
	apop	es,ds
	ret
;
;----------------------------------------------------------------------------
feed_colors:
	apush	 bx,si,di,ds

	mov	ds,cs:allocated_mem_seg

	mov	ds:cursor_page_ptr,offset header1_ptr
	call	build_page_detail

	mov	si,offset line01_ptr		;get ptr to line 1
	mov	bx,0				;color store #

fc_loop:mov	di,word ptr ds:[si]		;get line ptr
	mov	al,ds:[di+4]			;get color
	call	set_lib_colors
	inc	bx				;move to next color
	add	si,2				;move to next setup line
	cmp	bx,8
	jb	fc_loop				;loop till done

	apop	 ds,di,si,bx
	ret
;----------------------------------------------------------------------------
; CONFIG data section
;----------------------------------------------------------------------------
; The summary_table built by GET_SETUP and a copy of setup is kept in
; memory.
;---------------------------
; config menu (top menu bar)
;
config_menu	label	byte
	db	0			;m_flag
	db	0			;top row
	db	0			;left column
	db	1			;total rows
	db	80			;total columns
	db	5			;menu options
	dw	0			;main selection
	dw	0			;sub selection
; config option #0 -RESTORE_DEFAULTS-
	db	0			;e_count
	db	0			;e_sub_length
	db	19			;e_hot_key (alt-t)
	db	16			;e_length
	dw	config_opt0_text	;e_text_ptr
	dw	config_restore 		;e_process
	db	1			;e_column
      	db	0			;e_row
; config option #1 -SAVE_DATA-
	db	0			;e_count
	db	0			;e_sub_length
	db	31			;e_hot_key (alt-a)
	db	09			;e_length
	dw	config_opt1_text	;e_text_ptr
	dw	config_save		;e_process
	db	19			;e_column
      	db	0			;e_row
; config option #2 -NEXT_PAGE-
	db	0			;e_count
	db	0			;e_sub_length
	db	49			;e_hot_key (alt-b)
	db	09			;e_length
	dw	config_opt2_text	;e_text_ptr
	dw	config_next		;e_process
	db	30			;e_column
      	db	0			;e_row
; config option #3 -HELP-
	db	0			;e_count
	db	0			;e_sub_length
	db	35			;e_hot_key (alt-b)
	db	04			;e_length
	dw	config_opt3_text	;e_text_ptr
	dw	config_help		;e_process
	db	41			;e_column
      	db	0			;e_row
; config option #4 -EXIT-config-
	db	0			;e_count
	db	0			;e_sub_length
	db	18			;e_hot_key (alt-b)
	db	11			;e_length
	dw	config_opt4_text	;e_text_ptr
	dw	config_exit		;e_process
	db	47			;e_column
      	db	0			;e_row
; config option end, dummy option
	db	0			;e_count
	db	0			;e_sub_length
	db	00			;e_hot_key (alt-b)
	db	0			;e_length
	dw	0             		;e_text_ptr
	dw	0			;e_process
	db	0			;e_column
	db	0			;e_row

config_opt0_text     db 'Restore_defaluts',0
config_opt1_text     db 'Save_data',0
config_opt2_text     db 'Next_page',0
config_opt3_text     db 'Help',0
config_opt4_text     db 'Exit-config',0
config_opt5_text     label	byte	;dummy for menu placement calc

;------------------------------------------------------------------------------

LIBSEG	ENDS
	END
