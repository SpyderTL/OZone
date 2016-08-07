

; Edmundo Anton Chow
; Miscellaneous Routines
; CS 193
; Randall Hyde

;**********************************************************************

                .xlist

		include 	ucrlib.a
		includelib	ucrlib.lib

                .list

dseg		segment	para public 'data'


maxargs =       50
wp      textequ <word ptr>

var
        string *args[maxargs]
        integer argcnt

endvar

path            byte    "path",0
incl            byte    "include",0
lib             byte    "lib",0
garbage         byte    "garbage",0

Out1            word    ?

Value1          byte    ?

Value2          word    ?

Value3          word    ?

dseg            ends

cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg

;**********************************************************************

Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax
		meminit
                initexcept
                enableexcept

;**************************Argc and Argv*******************************

                mov     ax, 0
                mov     bx, ax
                argc
                jcxz    noparms

cxlp:           inc     ax
                argv
                mov     wp args[bx], di
                mov     wp args[bx+2], es
                add     bx, 4
                loop    cxlp

noparms:        mov     argcnt, ax
 
                mov     bx, 0
                mov     ax, 1
                mov     cx, argcnt
     
                jcxz    done
 
lp2:            print   "parameter "
                puti
                print   " = "
                les     di, args[bx]
                puts
                putcr
                add     bx, 4
                inc     ax
        
done:           mov     Out1, cx
                printf
                byte    "\tThere were %i argument(s)",cr,lf,0
                dword   Out1
    
                CleanUpEx

; *************************GetEnv***********************************

                lesi    incl
                getenv
                print   "include "
                puts
                free
                putcr
      
                lesi    path
                getenv
                print   "path "
                puts
                free
                putcr
      
                lesi    lib
                getenv
                print   "lib "
                puts
                free
                putcr
                lesi    garbage
                getenv
                print   "could not find garbage"
                jmp     gdone
          
foundit:        print   "garbage "
                puts
                free
                putcr
    
gdone:          
 
;**************************DOS**************************************

                mov     ah, 2ah
                Dos     
                mov     Value1, ah
                mov     Value2, cx
                mov     Value3, dx
                printf
                byte    "\n\tThe date is: %i - %i- %i",cr,lf,0
                dword   Value1, Value2, Value3

;**************************Random***********************************

                randomize
a:              random
                mov     Out1, ax

                printf
                byte    "\n\tRandom number: %i",cr,lf,0
                dword   Out1

;**********************CPUident***********************************

                CPUIdent
                mov     Out1, ax
                cmp     Out1, 586
                je      GoodCpu
               jmp     Quit

GoodCpu:        printf
                byte    "\tCPU: %i",cr,lf,0
                dword   Out1

;*******************************************************************

Quit:		ExitPgm			;DOS macro to quit program.
Main		endp

cseg            ends

sseg		segment	para stack 'stack'
stk		db	1024 dup ("stack   ")
sseg		ends


zzzzzzseg	segment	para public 'zzzzzz'
LastBytes	db	16 dup (?)
zzzzzzseg	ends
		end	Main
