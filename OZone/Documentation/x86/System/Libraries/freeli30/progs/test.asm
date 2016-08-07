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

;****************** 'main' procedure

Proc        main

            ret                     ;Return

EndP        main

End Start
