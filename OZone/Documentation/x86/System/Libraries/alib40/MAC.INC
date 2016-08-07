;****************************** MAC.INC *********************************
; The following macro allows local calls to FAR proc's in our
; segment.
;

callf		MACRO	xx
;		push	cs	;optasm automatically does this for us
		call	xx
		ENDM

apush		macro	a,b,c,d,e,f,g,h,i,j
		irp	x,<a,b,c,d,e,f,g,h,i,j>
		ifnb	<x>
		push	x
;		pushas	x
		else
		exitm
		endif
		endm
		endm

apop		macro	a,b,c,d,e,f,g,h,i,j
		irp	x,<a,b,c,d,e,f,g,h,i,j>
		ifnb	<x>
		pop	x
;		popas	x
		else
		exitm
		endif
		endm
		endm
		

