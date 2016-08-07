;****************** Macro include file

Macro       SET_CH                  ;; Set character
                                    ;; Assumes ES = CurSeg
            push di                 ;; Regs on Entry:
            mov di,cx               ;;   BX = X
            shl di,8                ;;   CX = Y
            add di,bx               ;;   AL = char
            add di,bx
            mov [es:di],al
            pop di

EndM

Macro       SET_AT                  ;; Set attribute
                                    ;; Assumes ES = CurSeg
            push di                 ;; Regs on Entry:
            mov di,cx               ;;   BX = X
            shl di,8                ;;   CX = Y
            add di,bx               ;;   AL = attr
            add di,bx
            mov [es:di+1],al
            pop di

EndM

Macro       SET_CHA                 ;; Set char & attr
                                    ;; Assumes ES = CurSeg
            push di                 ;; Regs on Entry:
            mov di,cx               ;;   BX = X
            shl di,8                ;;   CX = Y
            add di,bx               ;;   AL = char
            add di,bx               ;;   AH = attr
            mov [es:di],ax
            pop di

EndM

Macro       GET_CHA                 ;; Get char & attr
                                    ;; Assumes ES = CurSeg
            push di                 ;; Regs on Entry:
            mov di,cx               ;;   BX = X
            shl di,8                ;;   CX = Y
            add di,bx               ;; Returns:
            add di,bx               ;;   AL = char
            mov ax,[es:di]          ;;   AH = attr
            pop di

EndM

Macro       SET_ROW_CHA             ;; Set row of chars with attr
                                    ;; Assumes ES = CurSeg
            push cx di              ;; Regs on Entry:
            mov di,cx               ;;   BX = X
            shl di,8                ;;   CX = Y
            add di,bx               ;;   DX = count
            add di,bx               ;;   AL = char
            mov cx,dx               ;;   AH = attr
            rep stosw
            pop di cx

EndM

Macro       SET_ROW_CH              ;; Set row of chars w/o attr
                                    ;; Assumes ES = CurSeg
            push cx di              ;; Regs on Entry:
            mov di,cx               ;;   BX = X
            shl di,8                ;;   CX = Y
            add di,bx               ;;   DX = count
            add di,bx               ;;   AL = char
            mov cx,dx
            mov [es:di],al
            add di,2
            dec cx
            jnz $-7
            pop di cx

EndM

Macro       SET_VROW_CHA            ;; Set vertical row of chars with attr
                                    ;; Assumes ES = CurSeg
            push cx di              ;; Regs on Entry:
            mov di,cx               ;;   BX = X
            shl di,8                ;;   CX = Y
            add di,bx               ;;   DX = count
            add di,bx               ;;   AL = char
            mov cx,dx               ;;   AH = attr
            mov [es:di],ax
            add di,256
            dec cx
            jnz $-8
            pop di cx

EndM

Macro       SET_VROW_CH             ;; Set vertical row of chars w/o attr
                                    ;; Assumes ES = CurSeg
            push cx di              ;; Regs on Entry:
            mov di,cx               ;;   BX = X
            shl di,8                ;;   CX = Y
            add di,bx               ;;   DX = count
            add di,bx               ;;   AL = char
            mov cx,dx
            mov [es:di],al
            add di,256
            dec cx
            jnz $-8
            pop di cx

EndM
