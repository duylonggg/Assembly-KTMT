.386
include \masm32\include\masm32rt.inc

.data
    msg db "Number: %d", 13, 10, 0
    buffer db 20 dup(0)
    counter dd 1

.code
start:
    
print_loop:
    push ecx  ; Lưu giá trị ecx
    invoke wsprintf, addr buffer, addr msg, [counter]
    invoke StdOut, addr buffer
    pop ecx   ; Khôi phục giá trị ecx
    
    inc [counter]
    mov ecx, [counter]
    cmp ecx, 11
    jle print_loop

    invoke ExitProcess, 0
end start