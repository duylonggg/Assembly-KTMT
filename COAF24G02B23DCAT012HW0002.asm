;in, nhap chuoi

.model small ; chuong trinh nay chon bo nho la small
.stack 100h; kich thuoc ngan xep la 100byte
.data ; cac dong duoi data la khai bao
        CRLF    DB 13, 10, '$' ;ki tu xuong dong
        str     db 'hello world'
        xau     db 50 dup('$') ;khoi tao mang co 50 phan tu
.code
main Proc ;thu tuc chinh
    mov ax, @data
    mov ds, ax
    
    lea si, xau
    lap:
        mov ah, 1       ;ngat 1 co tac dung nhap mot xau
        int 21h
        
        cmp al, 13      ;so sanh voi phim enter
        je nhapXong     ;neu bang thi nhay den ham nhapXong
        
        mov [si], al    ;neu chua bang thi gan gia tri vua nhap vao mang
        inc si
        
        jmp lap
    nhapXong:
    
    mov ah, 9
    lea dx, CRLF   ;xuong dong
    int 21h
    lea dx, xau    ;hien thi xau vua nhap
    int 21h      
    
    mov ah, 4ch    ;ket thuc chuong trinh
    int 21h
main endp
end main