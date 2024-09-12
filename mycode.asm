;in, nhap chuoi

.model small ; chuong trinh nay chon bo nho la small
.stack 100h; kich thuoc ngan xep la 100byte
.data ; cac dong duoi data la khai bao
        CRLF    DB 13, 10, '$' ;ki tu xuong dong
        str     db 'hello world'
        xau     db 50 dup('$')
.code
main Proc ;thu tuc chinh
    mov ax, @data
    mov ds, ax
    
    lea si, xau
    lap:
        mov ah, 1
        int 21h
        
        cmp al, 13
        je nhapXong
        
        mov [si], al
        inc si
        
        jmp lap
    nhapXong:
    
    mov ah, 9
    lea dx, CRLF
    int 21h
    lea dx, xau
    int 21h      
    
    mov ah, 4ch
    int 21h
main endp
end main