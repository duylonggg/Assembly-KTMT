section .data
    num1 dd 10               ; Số nguyên đầu tiên là 10
    num2 dd 20               ; Số nguyên thứ hai là 20
    buffer db 'Result: ', 0  ; Chuỗi kết quả để hiển thị
    buffer_len equ $ - buffer
    newline db 0xA           ; Ký tự xuống dòng

section .bss
    result resb 10           ; Khu vực lưu trữ kết quả chuỗi của số nguyên (tối đa 10 byte)
    result_len resb 1        ; Độ dài của chuỗi kết quả

section .text
    global _start

_start:
    ; Tính tổng của hai số
    mov eax, [num1]          ; Đặt giá trị của 'num1' vào thanh ghi 'eax'
    add eax, [num2]          ; Thực hiện phép cộng với 'num2'

    ; Chuyển đổi số trong eax thành chuỗi ASCII và lưu vào result
    mov edi, result          ; Đặt con trỏ chuỗi kết quả vào edi
    call int_to_ascii        ; Gọi hàm chuyển đổi số thành ASCII

    ; In chuỗi "Result: "
    mov eax, 4               ; syscall sys_write
    mov ebx, 1               ; xuất ra stdout
    mov ecx, buffer          ; chuỗi 'Result: '
    mov edx, buffer_len      ; độ dài của chuỗi
    int 0x80                 ; gọi hệ thống

    ; In kết quả là chuỗi số từ result
    mov eax, 4               ; syscall sys_write
    mov ebx, 1               ; xuất ra stdout
    mov ecx, edi             ; con trỏ bắt đầu của chuỗi kết quả
    mov edx, [result_len]    ; độ dài của chuỗi kết quả
    int 0x80                 ; gọi hệ thống

    ; Xuống dòng
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Kết thúc chương trình
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Hàm int_to_ascii: Chuyển đổi số nguyên trong eax thành chuỗi ASCII và lưu vào địa chỉ của edi
int_to_ascii:
    mov ebx, 10              ; Cơ số 10
    mov ecx, edi             ; Lưu con trỏ ban đầu vào ecx để tính độ dài chuỗi
.convert_loop:
    xor edx, edx             ; Xóa thanh ghi edx trước khi chia
    div ebx                  ; Chia eax cho 10, kết quả ở eax, dư ở edx
    add dl, '0'              ; Chuyển số dư thành ký tự ASCII
    dec edi                  ; Di chuyển con trỏ chuỗi ngược lại
    mov [edi], dl            ; Lưu ký tự vào result
    test eax, eax            ; Kiểm tra nếu eax = 0 (hoàn tất chuyển đổi)
    jnz .convert_loop        ; Nếu chưa xong, tiếp tục vòng lặp

    mov eax, ecx             ; Đoạn này tính độ dài chuỗi kết quả
    sub eax, edi             ; Lấy khoảng cách để ra độ dài chuỗi
    mov [result_len], al     ; Lưu độ dài chuỗi vào result_len
    ret
