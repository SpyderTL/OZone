
		.386
		option	segment:use16, proc:private

		include	memory.a
		include	excepts.a

		echo	Memory: MemInit2

ucrlib		segment	para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing, es:nothing


dp		textequ	<dword ptr>
wp		textequ	<word ptr>
byp		textequ	<byte ptr>




; MemInit2-	This version of the memory manager initialization code
;		lets you specify the starting location and size of the
;		heap.
;
; On Entry:	ES points at the start of the heap (paragraph address).
;		CX contains the size of the heap (in paragraphs).


		public	$MemInit2
$MemInit2	proc	far
		assume	ds:nothing
		push	ax
		mov	$StartOfHeap, es	;Save pointer to memory.
		mov	$FreeSpace, es		;Save pointer to 1st free blk.
		mov	$SizeOfHeap, cx		;Size of heap in paragraphs.

		mov	ax, es			;Now compute the address of
		add	ax, cx			; the end of the heap and
		mov	$EndOfHeap, ax		; save.

		xor	ax, ax
		mov	esptr.blksize, cx	;Size of this block (paras).
		mov	esptr.bwdptr, ax  	;Back pointer is NIL.
		mov	esptr.fwdptr, ax  	;Fwd pointer is NIL.
		mov	esptr.refcnt, ax  	;Reference Count is zero.
		mov	esptr.freebwdptr, ax 	;Free list bwd ptr is NIL.
		mov	esptr.freefwdptr, ax 	;Free list fwd ptr is NIL.
		pop	ax
		ret
$MemInit2	endp
ucrlib		ends

		end
