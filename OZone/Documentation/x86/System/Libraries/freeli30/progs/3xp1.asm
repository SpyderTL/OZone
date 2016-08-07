; 3X+1 solver using FREELIB

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

Model Tiny
CodeSeg
P186
Org 100h

Start:      jmp startup

;****************** Data Section

rtn         db 13,0
buf         db 15 dup(0)
BadFmt      db 13,10,13,10,'Number %d went out of range',13,10,0
BadArg      dw ?,?
OkStr       db 'No anomaly found',0

;****************** 'main' procedure

Proc        main

            mov ax,3                ;Start with 3
            xor dx,dx

MLoop:      pusha                   ;Save all registers
            mov bp,dx               ;CX:BX:AX = number
            mov bx,dx               ;BP = threshold
            xor cx,cx

CLoop:      test cx,cx              ;Out of range, quit
            jl Quit
            jnz CCont
            cmp bx,bp               ;CX = 0, check if less
            jb CDone                ;Quit if less than the
            test bx,bx              ;original number
            jz CDone

CCont:      test ax,1               ;Check for odd
            jz CSkip

            mov dx,ax               ;N = 3 * N + 1
            add ax,ax
            mov si,bx
            adc bx,bx
            mov di,cx
            adc cx,cx
            add ax,dx
            adc bx,si
            adc cx,di
            add ax,1
            adc bx,0
            adc cx,0

CSkip:      shr cx,1                ;N = N / 2
            rcr bx,1
            rcr ax,1
            jmp CLoop               ;Loop back

CDone:      popa                    ;Restore all registers

            cmp ax,3                ;Low word = 3, display
            jne MSkip

            lcall ltoa dx,ax,offset(buf)  ;Display the number
            lcall puts offset(buf)
            lcall puts offset(rtn)

MSkip:      add ax,4                ;Add 4 (increment)
            adc dx,0
            cmp dx,230              ;Loop while < 15 million
            jb MLoop

            lcall puts offset(OkStr)      ;Print OK message
            ret                     ;Return

Quit:       popa                    ;Overflowed...
            mov [BadArg],ax         ;Print out-of-range message
            mov [BadArg+2],dx
            lcall printf offset(BadFmt),offset(BadArg)
            ret                     ;Return

EndP        main

End Start
