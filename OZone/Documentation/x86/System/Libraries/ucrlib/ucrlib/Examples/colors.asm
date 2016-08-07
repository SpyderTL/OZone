		.xlist
                include         ucrlib.a
                includelib      ucrlib.lib
		.listall


var
	enum colors,<red,green,blue>

	colors c1, c2

endvar




cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg

$$PV_colors     macro   color
                mov     al, byte ptr color
                call    PrintColors
                endm
                
$$PP_colors     macro   color
                les     di, dword ptr color
                mov     al, es:[di]
                call    PrintColors
                endm
                
PrintColors     proc
                cmp     al, red
                jne     NotRed
                print   "red"
                ret
                
NotRed:         cmp     al, green
                jne     NotGreen
                print   "green"
                ret
                
NotGreen:       cmp     al, blue
                jne     NotBlue
                print   "blue"
                ret
                
NotBlue:        print   "Illegal Color!"
                ret
PrintColors     endp






$$GV_Colors     macro   Color2Read
                call    GetColor
                mov     byte ptr Color2Read, al
                endm
                
$$GP_Colors     macro   ColorPtr
                call    GetColor
                les     di, ColorPtr
                mov     es:[di], al
                endm
                


TstChar		macro	Chars
		forc	chr, <Chars>
		getc
		tolower
		cmp	al, '&chr&'
		jne	BadColor
		endm
		endm
		
		
GetColor        proc    near
                getc
                jc      BadColor        ;If GETC error.
                tolower                 ;Allow upper and lower case.
                cmp     al, "r"
                je      MustBeRed
                cmp     al, "g"
                je      MustBeGreen
                cmp     al, "b"
                je      MustBeBlue
                
; Illegal character.  Cannot be red, green, or blue at this
; point.  So if exceptions are enabled, raise an exception.

BadColor:       GetXEnabled
                cmp     ax, 0
                je      NoExceptions
                mov     ax, $Conversion
                Raise

; If exceptions are not enabled, just return with a bogus value.

NoExceptions:   mov     ax, -1
                stc
                ret

MustBeRed:      tstchar	ed
                mov     al, red
                ret
                
MustBeGreen:    tstchar	reen
                mov     al, green
                ret
                
                
MustBeBlue:     tstchar	lue
                mov     al, blue
                ret
GetColor        endp

		

Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax

		MemInit
		InitExcept
		EnableExcept

		finit

		try

		cout	"Enter two colors:"
		cin	c1, c2
		cout	"You entered ",c1," and ",c2,nl

		except	$Conversion
		cout	"Conversion error occured",nl
		except	$Overflow
		cout	"Overflow error occured",nl
		endtry

		CleanUpEx

		ExitPgm			;DOS macro to quit program.
Main		endp

cseg            ends

sseg		segment	para stack 'stack'
stk             db      16384 dup (?)
sseg		ends


zzzzzzseg	segment	para public 'zzzzzz'
LastBytes	db	16 dup (?)
zzzzzzseg	ends
		end	Main
