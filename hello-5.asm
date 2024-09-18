.386
option casemap:none

include \masm32\include\masm32rt.inc

.data
    msg db "Hello, World!", 0     ; Chuỗi để in ra
    count dd 5                    ; Số lần lặp

.code
start:
    mov eax, [count]              ; Đặt số lần lặp vào eax

print_loop:
    invoke StdOut, addr msg       ; In chuỗi ra console

    dec eax                        ; Giảm eax đi 1
    cmp eax, 0                     ; So sánh eax với 0
    jg print_loop                 ; Nếu eax > 0, lặp lại

    invoke ExitProcess, 0         ; Thoát chương trình
end start
