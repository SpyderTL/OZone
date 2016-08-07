		include	conv.a
		include	memory.a

		.386
		option	segment:use16, proc:private

		echo	FTOAM, ETOAM

ucrlib          segment para public 'ucrlib'
		assume	cs:ucrlib, ds:nothing


; FTOAM-	Converts floating point accumulator to a string on heap.
; ETOAM-	Ditto, just in scientific notation.


		public	$ftoam
$ftoam		proc	far
		push	cx
		mov	cl, al
		mov	ch, 0
		inc	cx
		call	$malloc
		pop	cx
		jc	Badftoam
		call	$ftoa
		clc
BadFtoam:	ret
$ftoam		endp


		public	$etoam
$etoam		proc	far
		push	cx
		mov	cl, al
		mov	ch, 0
		inc	cx
		call	$malloc
		pop	cx
		jc	BadEtoam
		call	$etoa
		clc
BadEtoam:	ret
$etoam		endp
ucrlib		ends
		end