; print_al.asm 

; recursive function to print UNsigned value of AL register... 

name "printal"

org 100h

mov al, 254
call print_al

ret




print_al proc
cmp al, 0
jne print_al_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int 10h
    pop ax
    ret
print_al_r:
    pusha
    mov ah, 0
    cmp ax, 0
    je pn_done
    mov dl, 10
    div dl
    call print_al_r
    mov al, ah
    add al, 30h
    mov ah, 0eh
    int 10h
    jmp pn_done
pn_done:
    popa
    ret
endp




