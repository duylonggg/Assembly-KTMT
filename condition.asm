section .text
    global _start

_start:
    ; So sánh num1 và num2
    mov ecx, [num1]
    cmp ecx, [num2]
    jg  check_third_num 
    mov ecx, [num2]
    
check_third_num:
    ; So sánh với num3
    cmp ecx, [num3]
    jg  _exit
    mov ecx, [num3]
    
_exit:    
    ; Lưu giá trị lớn nhất vào biến largest
    mov [largest], ecx
    
    ; In thông báo
    mov ecx, msg
    mov edx, len
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; In giá trị lớn nhất
    mov ecx, largest
    mov edx, 2
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; In ký tự xuống dòng
    mov ecx, newline
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; Kết thúc chương trình
    mov eax, 1
    int 0x80

section .data
    msg     db  "The largest digit is: ", 0xA, 0xD
    len     equ $ - msg
    num1    dd  '47'
    num2    dd  '22'
    num3    dd  '31'
    newline db  0xA

segment .bss
    largest resb 2
