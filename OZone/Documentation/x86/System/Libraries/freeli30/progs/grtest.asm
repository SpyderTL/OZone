; Graphics demo using FREELIB

Ideal

Public      main
Extrn       startup:near

Macro       lcall p,a,b,c,d,e,f,g,h ;; library call

            ifnb <a>
              push a                ;; if args, push first arg
              lcall p,b,c,d,e,f,g,h ;; and recurse . . .
            else
              extrn p:near          ;; declare procedure
              call p                ;; call procedure
            endif

EndM

Macro       lnk offs                ;; Loop if No Key

            mov ah,1
            int 16h
            jz offs
            xor ah,ah
            int 16h
EndM

Model Tiny
Codeseg
P186
Org 100h

Start:      jmp startup

;****************** Data Section

Str1        db 'This is a string . . .',0

WidthX      dw 320                  ;Variables
Height      dw 200
Colors      dw 256
Circ        dw 30

;****************** 'main' procedure

Proc        main

            lcall initgraph 0       ;Init lo-res mode
            lcall srand             ;Seed random numbers
            call loop1              ;Do the loops
            mov [Height],400        ;Set med-res values
            mov [Circ],60
            lcall initgraph 2       ;Init med-res mode
            call loop1              ;Do the loops
            mov [WidthX],640        ;Set hi-res values
            mov [Height],480
            mov [Colors],16
            mov [Circ],72
            lcall initgraph 1       ;Init hi-res mode
            call loop1              ;Do the loops
            lcall closegraph        ;Close graphics
            ret                     ;Return

;****************** Main Loops

loop1:      call do_rand            ;Pixels
            lcall putpix ax,bx
            lnk loop1
            lcall cls

loop2:      call do_rand            ;Lines
            lcall line ax,bx,cx,dx
            lnk loop2
            lcall cls

loop3:      call do_rand            ;Rectangles
            lcall rect ax,bx,cx,dx
            lnk loop3
            lcall cls

loop4:      call do_rand            ;Filled Rectangles
            lcall frect ax,bx,cx,dx
            lnk loop4
            lcall cls

loop5:      call do_rand            ;Circles
            lcall circle ax,bx,si
            lnk loop5
            lcall cls

loop6:      call do_rand            ;Ellipses
            lcall ellipse ax,bx,si,di
            lnk loop6
            lcall cls

loop7:      call do_rand            ;Filled Circles
            lcall fcircle ax,bx,si
            lnk loop7
            lcall cls

loop8:      call do_rand            ;Filled Ellipses
            lcall fellipse ax,bx,si,di
            lnk loop8
            lcall cls

loop9:      call do_rand            ;Triangles
            push ax bx cx dx
            call do_rand
            lcall triangle ax,bx
            lnk loop9
            lcall cls

loop10:     call do_rand            ;Strings
            sub ax,88
            lcall outstr ax,bx,offset(Str1)
            lnk loop10
            lcall cls
            ret

;****************** Get Random Numbers

do_rand:    lcall rand [Colors]     ;Set random color and get
            lcall setgcolor ax      ;random numbers in AX, BX,
            lcall rand [Circ]       ;CX, DX, SI, and DI.
            mov di,ax
            lcall rand [Circ]
            mov si,ax
            lcall rand [Height]
            mov dx,ax
            lcall rand [Height]
            mov bx,ax
            lcall rand [WidthX]
            mov cx,ax
            lcall rand [WidthX]
            ret

EndP        main

End Start
