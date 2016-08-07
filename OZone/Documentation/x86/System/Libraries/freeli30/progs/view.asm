; VIEW v1.0: File viewer.

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

HelpStr     db ' FreeLib VIEW v1.1    Line: 1      '
            db 'Keys: Up Dn PgUp PgDn Home End Esc'
JunkBuf     db 12 dup(' '),0
OutOfMem    db 'Out of memory',13,10,0
Syntax      db 'Syntax:  VIEW <file>',0
FNotFound   db 'File not found',0
Indexing    db 'Indexing file . . .',0

;****************** 'main' procedure

Proc        main

            test cx,cx
            jz BadSyntax

            lcall fsetbuf 8192      ;Set file buffers to 8K

            mov bx,[di]             ;Open the file
            lcall fopen bx,0
            jc NoFile               ;File not found?

            mov bp,ax               ;BP = handle

            lcall allocmem 81*24    ;Allocate the string buffer
            jnc Continue

NoMem:      lcall fclose bp         ;Close the file
            push offset OutOfMem    ;Display 'Out of memory' message
PutRet:     lcall puts
            ret                     ;Return
BadSyntax:  push offset Syntax      ;Display 'Syntax' message
            jmp PutRet
NoFile:     push offset FNotFound   ;Display 'File not found' message
            jmp PutRet

Continue:   mov si,ax               ;SI = string buffer

            lcall getmfree          ;Get free memory
            mov cx,ax
            shr cx,2                ;Max lines
            jz NoMem                ;Zero, return
            lcall allocmem ax       ;Allocate the memory
            mov di,ax               ;DI = index buffer

            lcall puts offset(Indexing)   ;Display 'Indexing' message

            xor bx,bx               ;Line count
            push di                 ;Save DI

IndexLoop:  lcall ftell bp          ;Get file pointer
            stosw                   ;Store position
            xchg ax,dx
            stosw

            lcall fgets bp,si,81    ;Get string
            jc IndexCont            ;Loop while no EOF
            loop IndexLoop

IndexCont:  mov dx,di               ;Restore DI, and put
            pop di                  ;the line count in DX
            sub dx,di
            shr dx,2

            lcall inittext          ;Initialize text system
            lcall setctype 2000h    ;Turn off cursor

            lcall setcolor 70h      ;Display help string
            lcall tputs 0,24,offset(HelpStr)

            xor cx,cx               ;Current line = 0

MainLoop:   push dx                 ;Save DX
            mov bx,cx               ;Index position
            shl bx,2
            push bp [di+bx+2]       ;Seek to line
            push [di+bx] 0
            lcall fseek
            xor dx,dx               ;Zero DX

ReadLoop:   imul ax,dx,81           ;AX = pointer
            add ax,si
            lcall fgets bp,ax,81    ;Read line
            inc dx                  ;Loop back
            cmp dx,24
            jl ReadLoop

            lcall setcolor 70h      ;Display current line...
            inc cx                  ;Make it one-based
            lcall itoa cx,offset(JunkBuf) ;Convert to string
            dec cx
            lcall hline 28,32,24,20h      ;Display the string
            lcall tputs 28,24,offset(JunkBuf)

            lcall setcolor 07h      ;Set text color
            xor dx,dx               ;Zero DX
DispLoop:   lcall hline 0,79,dx,20h ;Clear the line
            imul ax,dx,81           ;AX = pointer
            add ax,si
            lcall tputs 0,dx,ax     ;Display string
            inc dx                  ;Loop back
            cmp dx,24
            jl DispLoop

            pop dx                  ;Restore DX
KeyLoop:    xor ah,ah               ;Get a key
            int 16h

            cmp ax,011Bh            ;Escape?
            je Quit
            cmp dx,24               ;File < 1 page,  no need
            jle KeyLoop             ;to process other keys

            cmp ax,4800h            ;Up?
            je KUp
            cmp ax,5000h            ;Down?
            je KDown
            cmp ax,4900h            ;PgUp?
            je KPgUp
            cmp ax,5100h            ;PgDn?
            je KPgDn
            cmp ax,4700h            ;Home?
            je KHome
            cmp ax,4F00h            ;End?
            je KEnd
            jmp KeyLoop             ;Invalid, loop

KUp:        test cx,cx              ;Already at top?
            jz KeyLoop
            dec cx                  ;Go up one line
            jmp MainLoop

KDown:      mov ax,cx               ;Already at bottom?
            add ax,24
            cmp ax,dx
            jge KeyLoop
            inc cx                  ;Go down one line
            jmp MainLoop

KPgUp:      test cx,cx              ;Already at top?
            jz KeyLoop
            sub cx,24               ;Go up one page
            jge MainLoop
            xor cx,cx               ;Too far, go to top
            jmp MainLoop

KPgDn:      mov ax,cx               ;Already at bottom?
            add ax,24
            cmp ax,dx
            jge KeyLoop
            mov cx,ax               ;Move down one page
            add ax,24
            cmp ax,dx
            jle MainLoop
            mov cx,dx               ;Too far, go to bottom
            sub cx,24
            jmp MainLoop

KHome:      xor cx,cx               ;Move to top
            jmp MainLoop

KEnd:       mov cx,dx               ;Move to bottom
            sub cx,24
            jmp MainLoop

Quit:       lcall closetext         ;Clean up...
            lcall freemem si
            lcall freemem di
            lcall fclose bp
            ret                     ;Return

EndP        main

End Start
