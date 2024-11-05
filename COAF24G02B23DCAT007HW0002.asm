;Duong Hoang Anh - B23DCAT007

include \masm32\include\masm32rt.inc

.data
    txt1 db "Character: ", 0
    a db 0
    output db 0
    buffer db 1 dup(0)
.code

convert proc
    mov al, a
    cmp al, 'A'
    jl check_lower
    cmp al, 'Z'
    jg check_lower
    add al, 32
    jmp store_char

check_lower:
    cmp al, 'a'
    jl store_char
    cmp al, 'z'
    jg store_char
    sub al, 32

store_char:
    mov [buffer], al

ret
convert endp
    start:
    print OFFSET txt1
    invoke StdIn, addr buffer, 1
    mov al, [buffer]     
    mov a, al
    invoke convert
    invoke StdOut, addr buffer
    print chr$(13, 10)
    end start


