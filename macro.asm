%macro write_string 2
    mov eax, 4  ; Đặt số hiệu hệ thống call là 4 (sys_write)
    mov ebx, 1  ; Đặt mô tả file là 1 (stdout - tiêu chuẩn xuất)
    mov ecx, %1 ; Địa chỉ chuỗi cần ghi vào thanh ghi ECX
    mov edx, %2 ; Độ dài chuỗi cần ghi vào thanh ghi EDX
    int 80h     ; Gọi ngắt 80h để thực thi hệ thống call
%endmacro

%macro end_program 0
    mov eax, 1 ; Đặt số hiệu hệ thống call là 1 (sys_exit)
    int 0x80   ; Gọi ngắt 80h để kết thúc chương trình
%endmacro

section .text
    global _start ; Khai báo điểm bắt đầu của chương trình

_start:
    write_string msg1, len1 ; Ghi chuỗi `msg1` ra màn hình
    write_string msg2, len2 ; Ghi chuỗi `msg2` ra màn hình
    write_string msg3, len3 ; Ghi chuỗi `msg3` ra màn hình
    
    end_program ; Kết thúc chương trình

section .data
    msg1 db  'Hello, programmers!', 0xA, 0xD ; Chuỗi 1 với ký tự xuống dòng
    len1 equ $ - msg1                        ; Tính độ dài chuỗi `msg1`
    
    msg2 db  'Welcome to the world of,', 0xA, 0xD ; Chuỗi 2 với ký tự xuống dòng
    len2 equ $- msg2                              ; Tính độ dài chuỗi `msg2`
    
    msg3 db  'Linux assembly programming! ', 0xA, 0xD ; Chuỗi 3 với ký tự xuống dòng
    len3 equ $- msg3                                  ; Tính độ dài chuỗi `msg3`
