; ZE: Like UUencode, but 27% instead of 40% expansion.

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

Syntax      db 'Syntax:  ZE <infile> <outfile>',0

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

            lcall fseek bp,0,0,2    ;Get file size
            lcall ftell bp
            mov [FSize],ax          ;Save size
            mov [FSize+2],dx
            lcall fseek bp,0,0,0    ;Seek to beginning

            mov cx,[FSize+2]        ;CX:BX = size
            mov bx,[FSize]
            mov si,8                ;8 digits

m_sloop:    mov dx,4                ;4 bits

m_01:       add bx,bx               ;Shift in bit
            adc cx,cx
            adc al,al
            dec dx                  ;Loop back
            jnz m_01

            and al,0Fh              ;Convert to hex
            cmp al,0Ah
            sbb al,69h
            das
            lcall fputc di,ax       ;Output char
            dec si
            jnz m_sloop             ;Loop back

            lcall fgetc bp          ;Preload bit buffer
            mov [BitBuf],al

            mov cx,4                ;4 digrams output
            mov dl,91               ;DL = divisor

m_loop:     push bp                 ;Get 13-bit code
            call Get13Bits
            div dl                  ;Convert to Mod91
            add ax,2121h

            mov bl,ah               ;Output digram
            lcall fputc di,ax
            xchg bx,ax
            lcall fputc di,ax

            inc cx                  ;Increment counter
            cmp cx,35               ;End of line?
            jb m_skip

            xor cx,cx               ;Reset counter
            lcall fputc di,13       ;Output CR, LF
            lcall fputc di,10

m_skip:     cmp [FSize+2],0         ;Check size
            jnl m_loop              ;Loop back

            lcall fputc di,7Eh      ;Output tilde
            lcall fputc di,13       ;Output CR, LF
            lcall fputc di,10

m_done:     lcall fclose bp         ;Close files
            lcall fclose di
            ret                     ;Return

m_syntax:   push offset(Syntax)     ;Display 'Syntax' message
            lcall puts
            ret                     ;Return

EndP        main

;****************** Get13Bits -- Get 13 bits from input file
;int Get13Bits(FILE *input);

Proc        Get13Bits

            push bp                 ;Set up stack frame
            mov bp,sp
            push bx cx dx           ;Save registers

            mov dx,[bp+4]           ;DX = file
            mov cx,13               ;13 bits
            xor bx,bx               ;Zero buffer

gb_loop:    add bx,bx               ;Shift in bit
            mov al,[BitMask]        ;Test bit
            test al,[BitBuf]
            jz $+3
            inc bx                  ;Set bit

            ror [BitMask],1         ;Rotate mask
            jnc gb_skip             ;Check for wrap
            lcall fgetc dx          ;Get byte
            mov [BitBuf],al
            sub [FSize],1           ;Decrement size
            sbb [FSize+2],0

gb_skip:    loop gb_loop            ;Loop back

            xchg bx,ax              ;Result in AX

gb_done:    pop dx cx bx            ;Restore registers
            pop bp                  ;Delete stack frame
            ret 2                   ;Return

BitMask     db 80h                  ;Mask and buffer
BitBuf      db 0

EndP        Get13Bits

End Start
