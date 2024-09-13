section .data
    a dd '10'        ; Khai báo số a
    b dd '20'        ; Khai báo số b
    msg db 'Min value: ', 0  ; Chuỗi thông báo kết quả
    msg_len equ $ - msg
    newline db  0xA

section .bss
    result resb 2    ; Khu vực lưu trữ số nhỏ nhất

section .text
    global _start

_start:
    mov ecx, [a]
    cmp ecx, [b] 
    jle .b_is_min

.b_is_min:
    mov ecx, [b]

__exit:
    mov [result], ecx 

    mov ecx, msg
    mov edx, msg_len
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, newline
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, result
    mov edx, 2
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 1
    int 0x80