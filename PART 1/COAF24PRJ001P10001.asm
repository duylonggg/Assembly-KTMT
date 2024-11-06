; Duong Hoang Anh - B23DCAT007
; Nguyen Hoang Anh - B23DCAT012
; Tran Khanh Duy - B23DCAT077
; Ha Duy Long - B23DCAT172

.model small
.stack 100h
.data
    str1 db 'xinchao$'
    str2 db 'chao$'
    strout db 'xau xuat hien tai vi tri thu: $'
    strout2 db 'xau 2 khong xuat hien trong xau 1$'
    vitri dw 0          
.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea si, str1
    lea di, str2
    xor bx, bx

sosanh:
    mov al, [si]
    cmp al, '$'
    je khongthay            ;neu het chuoi 1 ma khong thay thi nhay den khongthay
    cmp al, [di]
    jne tiep                ; Neu ki tu khong bang nhau thi nhay den tiep

    push si                 ;luu vi tri hien tai cua si

kiemtra:
    mov al, [di]
    cmp al, '$'             ; neu den cuoi cung cua chuoi hai thi nhay den timthay
    je timthay
    mov al, [si]
    cmp al, [di]
    jne khongphai           ; Neu ki tu khong bang nhau thi nhay den khong phai

    inc si                  ; Neu ki tu bang nhau thi tang vi tri kiem tra xau 1 va xau 2
    inc di
    jmp kiemtra             ; Lap lai ham

khongphai:
    pop si                  ; lay lai vi tri da luu cho si
    inc si                  ; Di chuyen den vi tri tiep theo trong str1
    inc bx                  ; Tang bien dem 1 don vi
    lea di, str2            ; tro lai vi tri dau tien cua xau str2
    jmp sosanh              ; Quay lai so sanh

timthay:
    mov vitri, bx           ; Luu vi tri tim thay vào vitri
    lea dx, strout
    mov ah, 9
    int 21h
    call inso               ; Goi ham inso
    jmp exit                ; ket thuc chuong trinh

tiep:
    inc si                  ; Chuyen den ki tu tiep theo trong str1
    inc bx                  ; Tang bien dem vi tri
    jmp sosanh              ; Quay lai so sanh

khongthay:
    lea dx, strout2         ; hien thong bao khong tim thay
    mov ah, 9
    int 21h

exit:
    mov ah, 4Ch
    int 21h

main endp

inso proc
    mov ax, vitri
    xor cx, cx
    mov bx, 10

chuyenso:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz chuyenso

inlap:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop inlap

    ret
inso endp
end main
