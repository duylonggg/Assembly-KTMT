.model small
.stack 100h
.data
    result dw ?       ; bien luu ket qua
    a dw 0
    b dw 16

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, a
    push ax           ; push a
    mov ax, b
    push ax           ; push b
    
    call myFunc       ; goi hàm myFunc
    
    ; luu ket qua vi tri cua myFunc vào result
    mov result, ax
    
    ; goi ham in so
    call indau
    
    ;ket thuc chuong trinh
    mov ah, 4Ch
    int 21h
main endp
;   x = [SP+4], y = [SP+2]
myFunc proc
    ; thiet lap bp de làm co so truy cap cac tham so tren stack
    push bp           ; Luu BP hien tai
    mov bp, sp        ; BP tro den vi tri hien tai cua SP

    mov ax, [bp+4]    ; ax = x
    mov bx, [bp+6]    ; bx = y
    
    xor dx, dx

    ; Tinh tong x + y
    add ax, bx        ; ax = x + y
    test ax, 8000h 
    jnz chuyendoi

    ; So sanh x và y
    sosanh:
        mov cx, [bp+4]    ; cx = x
        cmp cx, bx        ; So sanh x voi y
        je bang          ; Neu x == y, nhay den nhan bang
    
        ; Truong hop x != y: z &= 16
        cmp dx, 1
        je khongbang
        and ax, 16        ; ax &= 16
        jmp ketthuc       ; Nhay den ket thuc hàm
    
    ;chuyen so am thanh so duong    
    chuyendoi:
        neg ax
        mov dx, 1
        jmp sosanh
    
    ;chuyen so duong thanh so am    
    chuyendoi2:
        neg ax
        mov dx, 0
        jmp ketthuc    
    
    khongbang:
        neg ax
        mov dx, 0
        and ax, 16        ; ax &= 16
        jmp ketthuc       ; Nhay den ket thuc hàm
bang:
    shl ax, 2         ; ax <<= 2
    cmp dx, 1
    je chuyendoi2

ketthuc:
    pop bp            ; Khôi ph?c BP ban d?u
    ret               ; Tr? v? (stack dã du?c gi? nguyên)
myFunc endp

; Hàm in s? nguyên
indau proc
    mov ax, result    ; ax = result
    
    mov cx, ax        ; cx = 0
    mov bx, 10        ; bx = 10 d? chu?n b? chia
    
    ; Ki?m tra xem s? có âm không
    test ax, 8000h    ; Ki?m tra bit cao nh?t (bit 15)
    jz soduong ; N?u s? không âm, nh?y d?n ph?n x? lý s? duong

    ; In d?u "-"
    mov dl, '-'        ; Ð?t ký t? '-' vào DL
    mov ah, 2          ; Hàm in ký t?
    int 21h
    mov ax, cx  
    

    ; Chuyen so am thành tri tuyet doi
    neg ax             ; Chuy?n s? âm thành s? duong

soduong:
    ; Chuy?n s? duong thành chu?i và in ra
    call inso

    ret
indau endp

; Hàm chuyen so thành chuoi và in ra
inso proc
    ; Chuyen doi so thanh cac chu so tren stack
    xor cx, cx            ; lam sach cx
    mov bx, 10            ; Co so 10 de chia

chuyen:
    xor dx, dx            ; Xoa DX truoc khi chia
    div bx                ; ax /= bx, phan du luu vào dx
    push dx               ; day dx vào stack
    inc cx                ; Tang CX de dem so chu so
    cmp ax, 0             ; Kiem tra xem ax co het so khong
    jnz chuyen           ; Neu ax chua bang 0, tiep tuc chuyen doi

inlap:
    pop dx                ; Lay gia tri ngoai cung trong stack gan vào dx
    add dl, '0'           ; Chuyen so thành ki tu
    mov ah, 2             ; Ham in 1 ki tu
    int 21h
    loop inlap        ; Lap den khi CX = 0
    
    ret
inso endp
end main
