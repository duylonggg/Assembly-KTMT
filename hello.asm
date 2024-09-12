section .text
    global _start ; Khai báo điểm bắt đầu cho linker (ld)

_start: ; Nhãn điểm vào của chương trình
    mov edx, len ; Đưa độ dài thông điệp vào thanh ghi EDX
    mov ecx, msg ; Đưa địa chỉ thông điệp vào thanh ghi ECX
    mov ebx, 1   ; Đặt mô tả file là 1 (stdout - tiêu chuẩn xuất)
    mov eax, 4   ; Đặt số hiệu hệ thống call là 4 (sys_write)
    int 0x80     ; Gọi ngắt 0x80 để thực thi hệ thống call

    mov eax, 1 ; Đặt số hiệu hệ thống call là 1 (sys_exit)
    int 0x80   ; Gọi ngắt 0x80 để kết thúc chương trình

section .data
msg db  'Hello, world!', 0xa ; Định nghĩa chuỗi thông điệp với ký tự xuống dòng
len equ $ - msg              ; Tính độ dài của chuỗi thông điệp
