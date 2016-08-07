
; Test program
; Conversion Routines
; Edmundo Anton Chow
; 6-25-96
; Randall Hyde

;*****************************************************************

                .xlist

                includelib      ucrlib.lib
                include         ucrlib.a
            
                .list

;*****************************************************************

dseg		segment	para public 'data'

Computer        byte    "-13",0

ErrorString     byte    " _2 ",0

Science         byte    " 1234 5678 ",0

Assembly        byte    " 246 8",0

Unsign          byte    "1996",0

Sign            byte    "-1996",0

Unsign2         byte    "1997",0

LongUnSigned    byte    "2000",0

LongSigned      byte      "-2000",0

floater         byte    "3.5",0

RealValue1      dword ?;real8   ?

RealValue2      real8   ?

Out1            word    ?

Out2            word    ?

DblOut          dword   ?

LongOut         sdword   ?

dseg		ends

;*****************************************************************


cseg		segment	para public 'code'
		assume	cs:cseg, ds:dseg

;*****************************************************************

Main		proc
		mov	ax, dseg
		mov	ds, ax
		mov	es, ax
		meminit

;                mov     al, '0'
 ;               IsAlNum                       ;Alphanumeric char  
  ;              je      AlphaVal              ;it is an alpha num char
                                                
;AlphaVal:       printf
 ;               byte    "\tIsAlNum Works: \'0\' ",cr,lf,0

;                mov     al, 4
 ;               IsAlNum
  ;              jne     NotAlpha

;NotAlpha:       printf
 ;               byte    "\t4 is not Alphanumeric character",cr,lf,0

;                mov     al, 'b'
 ;               IsXDigit                        ;Hexadecimal char
  ;              je      HexVal

;HexVal:         printf
 ;               byte    "\tWorks Fine: \'b\'",cr,lf,0
  ;
                mov     al, 3
                jne     NotHex

NotHex:         printf
                byte    "\t3 is not a hexadecimal number",cr,lf,0

                mov     al, '9'
                IsDigit
                je      Digit

Digit:          printf
                byte    "\tIsDigit Works: \'9\'",cr,lf,0

                mov     al, 9
                IsDigit
                jne     NotDigit

NotDigit:       printf
                byte    "\t9 is not a digit",cr,lf,0

                mov     al, 'z'
                IsAlpha
                je      Alph

Alph:           printf
                byte    "\tIsAlpha Works: \'z\'",cr,lf,0

                mov     al, '2'
                IsAlpha
                jne     NotAlph

NotAlph:        printf
                byte    "\t\'2\' is not an Alphabetic character",cr,lf,0

                mov     al, 'a'
                IsLower
                je      Lower

Lower:          printf
                byte    "\tIsLower Works: \'a\'",cr,lf,0

                mov     al, 'A'
                IsLower
                jne     NotLower

NotLower:       printf
                byte    "\t\'A\' is not lower case character",cr,lf,0

                mov     al, 'Z'
                IsUpper
                je      Upper

Upper:          printf
                byte    "\tIsUpper Works: \'Z\'",cr,lf,0

                mov     al, 'z'
                IsUpper
                jne     NotUpper

NotUpper:       printf
                byte    "\t\'z\' is not upper case character",cr,lf,0

                lesi     Computer
                atoi
                mov     Out1, ax
                printf
                byte    "\tAtoi Works: %i",cr,lf,0
                dword   Out1

                lesi    ErrorString
                atoi
                cmp     cx, 1
                je      Over

Over:           printf
                byte    "\tInvalid Input check: _2",cr,lf,0

                lesi    Science
                atoix
                mov     Out1, ax
                printf
                byte    "\tWorks Fine: %i",cr,lf,0
                dword   Out1

                atoix
                mov     Out2, ax
                printf
                byte    "\tAtoix Works: %i",cr,lf,0
                dword   Out2

                push    seg    Assembly
                push    offset Assembly
                atoiStk
                mov     Out1, ax
                printf
                byte    "\tatoiStk Works fine: %i",cr,lf,0
                dword   Out1

                lesi    Unsign                                            
                atou
                mov     Out1, ax
                printf
                byte    "\tWorks Fine: %i",cr,lf,0
                dword   Out1

                lesi    Unsign                                            
                atou
                cmp     cx, 1
                je      Signed

Signed:         printf
                byte    "\tInvalid Input Check: -1996",cr,lf,0

                lesi    Unsign2
                atoux
                mov     Out1, ax
                printf
                byte    "\tatoux Works: %i",cr,lf,0
                dword   Out1
     
                push    seg    Assembly
                push    offset Assembly
                atoiStk
                mov     Out1, ax
                printf
                byte    "\tatoiStk works fine: %i",cr,lf,0
                dword   Out1

                lesi    LongUnSigned
                atol
                mov     LongOut, eax
                printf
                byte    "\tatol Works: %li",cr,lf,0
                dword   LongOut
      
                lesi    LongSigned
                atol
                mov     LongOut, eax
                printf
                byte    "\tatol Works: %li",cr,lf,0
                dword   LongOut

                lesi    Unsign
                atoh
                mov     Out1, ax
                printf
                byte    "\tAtoh Works Fine: %x",cr,lf,0
                dword   Out1

                lesi    Sign
                atoh
                cmp     cx, 1
                je      ConvError

ConvError:      printf
                byte    "\tSigned value check works: -1996",cr,lf,0
                
                lesi    floater
                atof
                fst     RealValue1
                printf
                byte    "\tAtof Works Fine: %1.1F",cr,lf,0
                dword   RealValue1

                lesi    Unsign
                toInt
                mov     Out1, ax
                printf
                byte    "\ttoInt works Fine: %i",cr,lf,0
                dword   Out1

                push    seg     Unsign                   
                push    offset  Unsign
                toIntStk
                mov     Out1, ax
                printf
                byte    "\ttoIntStk works fine: %i",cr,lf,0
                dword   Out1

                lesi    Unsign
                toUns
                mov     Out1, ax
                printf
                byte    "\ttoUns works fine: %i",cr,lf,0
                dword   Out1

                push    seg     Unsign
                push    offset  Unsign
                toUnsStk
                mov     Out1, ax
                printf
                byte    "\ttoUnsStk works fine: %i",cr,lf,0
                dword   Out1

                lesi    Sign
                toLong
                mov     dblOut, eax
                printf
                byte    "\ttoLong works fine: %li",cr,lf,0
                dword   dblOut

                 lesi   Unsign
                 toULong
                 mov    dblOut, eax
                 printf
                 byte   "\ttoULong works: %lu",cr,lf,0
                 dword  dblOut

                          



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
