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

Syntax      db 'Syntax:  HEX2BIN <infile> <outfile>',0

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
            mov dx,0100h            ;DX = bit-buffer

m_loop:     lcall fgetc bp          ;Get char
            jc m_done               ;EOF, done
            cmp al,'0'              ;Digit?
            jl m_loop
            cmp al,'9'
            jle m_digit
            cmp al,'A'              ;Uppercase letter?
            jl m_loop
            cmp al,'F'
            jle m_letter
            cmp al,'a'              ;Lowercase letter?
            jl m_loop
            cmp al,'f'
            jg m_loop

m_letter:   sub al,7                ;Convert to binary
m_digit:    and al,15
            shl dl,4                ;Shift in digit
            or dl,al
            neg dh                  ;Flip flag
            jl m_loop               ;Nonzero, loop

            lcall fputc di,dx       ;Output char
            jmp m_loop              ;Loop back

m_done:     lcall fclose bp         ;Close files
            lcall fclose di
            ret                     ;Return

m_syntax:   push offset(Syntax)     ;Display 'Syntax' message
            lcall puts
            ret                     ;Return

EndP        main

End Start
