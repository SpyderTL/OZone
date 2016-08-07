; SHOWGY:  Display *.GY files, resolution enhanced

; *.GY are grayscale files that are 160x100 in raw
; 8-bit format.  Two examples are provided.

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
CodeSeg
P186
Org 100h

Start:      jmp startup

;****************** Data Section

Syntax      db 'Syntax:  SHOWGY <gy-file>',13,10,0

;****************** 'main' procedure

Proc        main

            test cx,cx              ;No arguments?
            jz m_syntax

            lcall fopen [di],0      ;Open the file
            jc m_syntax             ;File not found?

            xchg bp,ax              ;BP = handle

            lcall initgraph 0       ;Init 320x200 mode
            lcall setgwin 0,0,318,198 ;Set graphics window

;-----------------------------------------------------------
; Set grayscale palette:  64 grays mapped to 256 colors
;-----------------------------------------------------------

            mov dx,03C8h            ;Set up for palette
            xor al,al               ;write operation
            out dx,al
            inc dx

m_pal:      mov cx,12               ;4 regs at a time
m_pal2:     out dx,al               ;Send gray value
            loop m_pal2             ;Loop back

            inc ax                  ;Next shade
            test al,40h             ;Loop while < 64
            jz m_pal

;-----------------------------------------------------------
; Put the defined pixels on the screen, separated by 1
;-----------------------------------------------------------

            xor cx,cx               ;Zero row counter
m_oloop1:   xor dx,dx               ;Zero column counter
m_iloop1:   lcall fgetc bp          ;Get byte
            lcall setgcolor ax      ;Set color
            lcall putpix dx,cx      ;Put pixel

            inc dx                  ;Next column
            inc dx
            cmp dx,320              ;Loop back
            jb m_iloop1 

            inc cx                  ;Next row
            inc cx
            cmp cx,200              ;Loop back
            jb m_oloop1

;-----------------------------------------------------------
; Now, interpolate to the other 3/4 of the pixels
;-----------------------------------------------------------

            xor cx,cx               ;Zero row counter
m_oloop2:   xor dx,dx               ;Zero column counter

m_iloop2:   lcall getpix dx,cx      ;Get average of 2 horizontal pixels
            xchg bx,ax
            push bx
            inc dx
            inc dx
            lcall getpix dx,cx
            add bx,ax
            shr bx,1
            dec dx                  ;Put this pixel in the middle
            lcall setgcolor bx
            lcall putpix dx,cx
            dec dx

            pop bx                  ;Get average of 2 vertical pixels
            inc cx
            inc cx
            lcall getpix dx,cx
            add bx,ax
            push bx
            shr bx,1
            dec cx                  ;Put this pixel in the middle
            lcall setgcolor bx
            lcall putpix dx,cx
            dec cx

            pop bx                  ;Restore vertical count
            inc dx                  ;Get average of all 4 pixels
            inc dx
            lcall getpix dx,cx
            add bx,ax
            inc cx
            inc cx
            lcall getpix dx,cx
            add bx,ax
            shr bx,2
            dec cx                  ;Put this pixel in the middle
            dec dx
            lcall setgcolor bx
            lcall putpix dx,cx
            dec cx

            inc dx                  ;Next column
            cmp dx,320              ;Loop back
            jb m_iloop2 

            inc cx                  ;Next row
            inc cx
            cmp cx,200              ;Loop back
            jb m_oloop2

            xor ah,ah               ;Wait for a key
            int 16h

            lcall closegraph        ;Return to text mode
            lcall fclose bp         ;Close file
            ret                     ;Return

m_syntax:   push offset(Syntax)     ;Print syntax message
            lcall puts
            ret                     ;Return

EndP        main

End Start
