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

;****************** Strings Section

Syntax      db 'Syntax:  BIN2HEX <infile> <outfile>',0

;****************** 'main' procedure

Proc        main

            lcall fsetbuf 16384     ;Set file buffers to 16K

            cmp cx,2                ;Wrong number of args?
            jne m_syntax

            lcall fopen [di],0      ;Open input file
            jc m_syntax             ;File not found?
            xchg bp,ax              ;BP = handle

            lcall fopen [di+2],3    ;Open output file
            jnc m_ok1               ;Check for errors
            lcall fclose bp         ;Close input file
            jmp m_syntax            ;Go print syntax

m_ok1:      xchg di,ax              ;DI = handle
            xor dx,dx               ;DX = char counter

m_loop:     lcall fgetc bp          ;Get char
            jc m_finish             ;EOF, done

            push ax                 ;Save AX
            shr al,4                ;Get first hex digit
            cmp al,0Ah
            sbb al,69h
            das
            lcall fputc di,ax       ;Output char

            pop ax
            and al,0Fh              ;Get second hex digit
            cmp al,0Ah
            sbb al,69h
            das
            lcall fputc di,ax       ;Output char

            inc dx                  ;Increment char counter
            cmp dx,35               ;End of line?
            jb m_loop

            lcall fputc di,13       ;Output CR, LF
            lcall fputc di,10
            xor dx,dx               ;Reset counter
            jmp m_loop              ;Loop back

m_finish:   test dx,dx              ;Nothing on line?
            jz m_done
            lcall fputc di,13       ;Output CR, LF
            lcall fputc di,10

m_done:     lcall fclose bp         ;Close files
            lcall fclose di
            ret                     ;Return

m_syntax:   push offset(Syntax)     ;Display 'Syntax' message
            lcall puts
            ret                     ;Return

EndP        main

End Start
