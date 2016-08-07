; Simple executable-file compressor.

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

Syntax      db 'Syntax:  SQUASH <infile> <outfile>',0

;****************** 'main' procedure

Proc        main

            lcall fsetbuf 16384     ;Set file buffers to 16K

            cmp cx,2                ;Wrong number of args?
            jne m_syntax

            lcall fopen [di],0      ;Open input file
            jc m_syntax             ;File not found?
            xchg bx,ax              ;BX = handle

            lcall fopen [di+2],3    ;Open output file
            jnc m_ok1               ;Check for errors
            lcall fclose bx         ;Close input file
            jmp m_syntax            ;Go print syntax

m_ok1:      xchg dx,ax              ;DX = handle

            push bx dx              ;Encode the file
            call Encode

            lcall fclose bx         ;Close files
            lcall fclose dx
            ret                     ;Return

m_syntax:   push offset(Syntax)     ;Display 'Syntax' message
            lcall puts
            ret                     ;Return

EndP        main

;The decoder prefix.  See the end of the file for the actual
;assembly language code used to generate this block of data.

Decoder     dw 48736,354,4287,35707,6670,-3327,48804,284,191
            dw 22510,185,-3327,50084

DLen        dw 0                    ;File length

            dw 191,45295,47392,4096,43763,4286,49019,256
            dw 11915,282,37292,32949,49203,53811,-3446,53386
            dw -9421,-374,-5167,-9678,-6272,33807,30157
            dw 44037,34696,-4352,34698,-4352,53418,29645
            dw 35331,17932,30029,25049,-6401

;****************** Encode() -- Encode file
;void Encode(FILE *input, FILE *output)

input       equ bp+6
output      equ bp+4

Proc        Encode

            push bp                 ;Set up stack frame
            mov bp,sp
            pusha                   ;Save all registers
            push es

            lcall faralloc 256      ;Allocate 4K memory
            jc p1_quit              ;Out of memory?
            mov es,ax               ;ES = memory

            xor di,di               ;Fill buffer with spaces:
            mov al,20h              ;the most common character
            mov cx,1000h
            rep stosb

            lcall fseek [input],0,0,2 ;Get length
            lcall ftell [input]
            mov si,ax
            mov [DLen],ax           ;Save length
            lcall fseek [input],0,0,0

            push [output]           ;Write out decoder
            push 98
            push offset(Decoder)
            lcall fwrite

            xor ax,ax               ;Zero AX, DX, DI
            xor dx,dx
            xor di,di
            mov cx,8000h            ;CH = bit mask, CL = buffer

p1_loop:    mov dh,dl               ;Shift prev-chars
            mov dl,al
            lcall fgetc [input]     ;Load char

            xor bx,bx               ;Convert to 4K index
            mov bh,dh
            shr bx,1
            xor bl,dl
            and bh,0Fh

            cmp al,[es:bx]          ;Predicted it?
            jne p1_char
            or cl,ch                ;Set predict bit
            jmp p1_cont

p1_char:    mov [es:bx],al          ;Set prediction
            mov [p1_buf+di],al      ;Add char to buffer
            inc di

p1_cont:    shr ch,1                ;Next bit
            jnz p1_lb

            push ax                 ;Save AX

            lcall fputc [output],cx ;Output bit byte

            xor bx,bx               ;Zero BX
            mov cx,di               ;No chars?
            jcxz p1_cont2

p1_bloop:   push [output]           ;Output char
            push [word p1_buf+bx]
            lcall fputc
            inc bx                  ;Next char
            loop p1_bloop           ;Loop back

p1_cont2:   mov cx,8000h            ;Re-init bit buffer
            xor di,di

            pop ax                  ;Restore AX

p1_lb:      dec si                  ;Loop back
            jnz p1_loop

            cmp cx,8000h            ;Nothing, quit
            je p1_done

            lcall fputc [output],cx ;Output final flags

            xor bx,bx               ;Zero BX
            mov cx,di               ;No chars?
            jcxz p1_done

p1_bloop2:  push [output]           ;Output char
            push [word p1_buf+bx]
            lcall fputc
            inc bx                  ;Next char
            loop p1_bloop2          ;Loop back

p1_done:    lcall farfree es        ;Free the memory

p1_quit:    pop es                  ;Restore registers
            popa
            pop bp                  ;Delete stack frame
            ret 4                   ;Return

p1_buf      db 8 dup(0)

EndP        Encode

End Start

; The executable decoder (98 bytes).  Decodes files up to
; 30K in length (after decoding).  Assumes SI = IP at start.

; Start:      pusha                   ;Save all registers
;
;             mov si,offset Buffer    ;Relocate data buffer
;             mov di,31504
;             mov cx,[dlen]
;             rep movsb
;
;             mov si,offset Decode    ;Relocate decoder
;             mov di,0EE00h
;             push di
;             mov cx,256
;             rep movsb
;
;             ret                     ;Jump to decode code
;
; dlen        dw 0                    ;Length of file
;
; Decode:     mov di,0EF00h           ;Fill buffer with spaces:
;             mov al,20h              ;the most common character
;             mov cx,1000h
;             rep stosb
;
;             mov si,31504            ;SI = buffer, DI = start point
;             mov di,0100h
;
;             mov bp,[dlen]           ;BP = length
;
;             lodsb                   ;Init bit buffer
;             xchg cx,ax
;             mov ch,80h
;
;             xor ax,ax               ;Zero AX, DX
;             xor dx,dx
;
; DecLoop:    mov dh,dl               ;Shift prev-chars
;             mov dl,al
;
;             xor bx,bx               ;Convert to 4K index
;             mov bh,dh
;             shr bx,1
;             xor bl,dl
;             and bh,0Fh
;
;             test cl,ch              ;Check predict bit
;             jnz DecSkip
;
;             lodsb                   ;Wrong, set prediction
;             mov [bx+0EF00h],al
;
; DecSkip:    mov al,[bx+0EF00h]      ;Get prediction
;             stosb                   ;Output char
;
;             ror ch,1                ;Rotate mask
;             jnc $+5                 ;Check for wrap
;             mov cl,[si]             ;Load flag byte in CL
;             inc si
;
;             dec bp                  ;Loop back
;             jnz DecLoop
;
;             popa                    ;Restore registers
;             jmp si                  ;Jump to start
;
; Buffer:
