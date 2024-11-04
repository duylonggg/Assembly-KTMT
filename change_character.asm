section .data
    prompt db 'Ky tu sau khi chuyen doi: ', 0
    len equ $ - prompt
    newline db 0xA, 0
    input_char db 'A'     ; Cho sẵn một ký tự, ví dụ 'A'

section .bss
    char resb 1           ; Biến lưu trữ ký tự sau khi chuyển đổi

section .text
    global _start

_start:
    ; In thông báo
    mov eax, 4           ; syscall sys_write
    mov ebx, 1           ; xuất ra stdout
    mov ecx, prompt      ; địa chỉ chuỗi prompt
    mov edx, len         ; độ dài chuỗi prompt
    int 0x80

    ; Lấy ký tự cho sẵn từ data segment vào thanh ghi al
    mov al, [input_char]

    ; Kiểm tra xem ký tự là chữ hoa hay chữ thường
    cmp al, 'A'
    jl .not_alpha        ; Nếu nhỏ hơn 'A' thì không phải ký tự
    cmp al, 'Z'
    jle .to_lower        ; Nếu trong khoảng từ 'A' đến 'Z' thì chuyển thành chữ thường

    cmp al, 'a'
    jl .not_alpha        ; Nếu nhỏ hơn 'a' thì không phải ký tự
    cmp al, 'z'
    jle .to_upper        ; Nếu trong khoảng từ 'a' đến 'z' thì chuyển thành chữ hoa

    jmp .done

.to_lower:
    add al, 32           ; Chuyển chữ hoa thành chữ thường
    jmp .store

.to_upper:
    sub al, 32           ; Chuyển chữ thường thành chữ hoa

.store:
    mov [char], al       ; Lưu ký tự đã chuyển đổi vào biến char

.done:
    ; In ký tự sau khi chuyển đổi
    mov eax, 4           ; syscall sys_write
    mov ebx, 1           ; xuất ra stdout
    mov ecx, char        ; địa chỉ của ký tự đã đổi
    mov edx, 1           ; in ra 1 ký tự
    int 0x80

    ; Xuống dòng
    mov eax, 4           ; syscall sys_write
    mov ebx, 1           ; xuất ra stdout
    mov ecx, newline     ; địa chỉ chuỗi xuống dòng
    mov edx, 1           ; độ dài xuống dòng
    int 0x80

    ; Kết thúc chương trình
    mov eax, 1           ; syscall sys_exit
    xor ebx, ebx         ; mã thoát là 0
    int 0x80

.not_alpha:
    ; Nếu ký tự không phải là chữ cái thì kết thúc chương trình
    jmp .done
