		.386
		option	segment:use16, proc:private

		include	strings.a

		echo	StrSetM


$SegStrings	segment	para public 'Strings'
		assume	cs:$SegStrings, ds:nothing


; StrSetM - 	Allocates a string containing CX+1 characters and initializes
;		all but the last byte to the character passed in AL.  Zero
;		terminates the entire string.
;
; inputs:
;		AL - Character to copy.
;		CX - # of characters in new string.
;
; outputs:
;		es:di -	Points at newly created string (if allocated).
;
;		carry=0 if no error creating string.
;		carry=1 if insufficient memory to allocate storage for string.


$StrSetM	proc	far
		pushf
		push	ax
		push	cx

		cld
                inc	cx			;Include zero byte at EOS.
		call	sl_malloc		;Allocate space for string
		jc	ss2sc			;Branch if insufficent memory.

		pop	cx			;Retrieve count.
		push	cx
		push	di			;Save ptr to free memory
	rep	stosb				;Fill string with char in AL.
		mov	byte ptr es:[di], 0	;Zero terminate
		pop	di

ss2cc:		pop	cx
		pop	ax
		popf
                clc
		ret

ss2sc:		pop	cx
		pop	ax
		popf
		stc
		ret
$StrSetM	endp


$SegStrings	ends
		end