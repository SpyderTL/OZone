; ZD: Decodes files produced with ZE

Ideal
Jumps

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
Codeseg
P186
Org 100h

Start:      jmp startup

;****************** Data Section

FSize       dw 0,0                  ;File size

;****************** Strings Section

Syntax      db 'Syntax:  ZD <infile> <outfile>',0

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

            mov si,8                ;8 digits

m_sloop:    mov dx,4                ;4 bits

m_01:       add bx,bx               ;Shift in bit
            adc cx,cx
            dec dx                  ;Loop back
            jnz m_01

m_02:       lcall fgetc bp          ;Get hex digit
            cmp al,'0'
            jb m_02
            cmp al,'F'
            ja m_02

            cmp al,3Ah              ;Convert to binary
            jb $+4
            sub al,7
            and al,0Fh
            or bl,al                ;OR in digit
            dec si
            jnz m_sloop             ;Loop back

            mov [FSize],bx          ;Save file size
            mov [FSize+2],cx

            mov dl,91               ;DL = multiplier

m_loop:     lcall fgetc bp          ;Load char
            cmp al,7Eh              ;Check bounds
            je m_done               ;Tilde '~' = end
            ja m_loop
            cmp al,21h
            jb m_loop

            sub al,21h              ;Remove offset
            mul dl                  ;BX = AL * 91
            xchg bx,ax

            lcall fgetc bp          ;Get char
            sub al,21h              ;Remove offset
            xor ah,ah               ;Add in remainder
            add bx,ax

            push di bx              ;Output 13 bits
            call Put13Bits
            jmp m_loop              ;Loop back

m_done:     lcall fclose bp         ;Close files
            lcall fclose di
            ret                     ;Return

m_syntax:   push offset(Syntax)     ;Display 'Syntax' message
            lcall puts
            ret                     ;Return

EndP        main

;****************** Put13Bits -- Put 13 bits to output file
;void Put13Bits(FILE *input, int code);

Proc        Put13Bits

            push bp                 ;Set up stack frame
            mov bp,sp
            pusha                   ;Save registers

            mov dx,[bp+6]           ;DX = file
            mov bx,[bp+4]           ;BX = shifted code
            shl bx,3
            mov cx,13               ;13 bits

pb_loop:    add bx,bx               ;Shift out bit
            jnc pb_skip1            ;Check bit
            mov al,[BitMask]        ;Add bit to buffer
            or [BitBuf],al

pb_skip1:   ror [BitMask],1         ;Rotate mask
            jnc pb_skip2            ;Check for wrap
            mov al,[BitBuf]         ;AL = byte
            mov [BitBuf],0          ;Clear bit buffer
            sub [FSize],1           ;Decrement size
            sbb [FSize+2],0         ;Enough data?
            jl pb_skip2
            lcall fputc dx,ax       ;Output byte

pb_skip2:   loop pb_loop            ;Loop back

            popa                    ;Restore registers
            pop bp                  ;Delete stack frame
            ret 4                   ;Return

BitMask     db 80h                  ;Mask and buffer
BitBuf      db 0

EndP        Put13Bits

End Start
