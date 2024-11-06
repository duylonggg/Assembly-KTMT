; Duong Hoang Anh - B23DCAT007
; Nguyen Hoang Anh - B23DCAT012
; Tran Khanh Duy - B23DCAT077
; Ha Duy Long - B23DCAT172

;viet ham con theo yeu cau de va in ra ket qua
.model small
.stack 100h
.data
    a db 5
    b db 5            
    result dw ?       

.code
main proc
    mov ax, @data
    mov ds, ax
    
    call myfunc       ;goi ham con
    mov ah, 0         ;dat ah = 0 de phep tinh duoc thu hien dung
    mov result, ax    ;result = ax
    call inso         ;goi ham in so
        
    mov ah, 4ch
    int 21h

main endp

myfunc proc
    ;thuc hien day vao ngan xep
    mov al, a         
    push ax           
    mov al, b         
    push ax
    pop ax            
    pop bx
       
    cmp ax, bx        ;so sanh ax voi bx
    je bang           ;neu bang thi nhay den ham bang

    add bl, al        ;neu khong thi tinh tong va and voi 16
    and bl, 16        
    mov al, bl        ;gan lai gia tri cho al
    jmp ketthuc       ;nhay den ham ketthuc

    bang:
        add al, bl    ;neu bang thi thuc hien dich bit    
        shl al, 2         
        jmp ketthuc   ;nhay den ham ketthuc

    ketthuc:
        ret           ;return     
myfunc endp

;ham in 1 so nguyen
inso proc
        mov ax, result  ;ax = result
        xor cx, cx      ;cx = 0
        mov bx, 10      ;bx = 10 de chuan bi cho phep chia
        
    chuyenso:
        xor dx, dx      ;dx = 0
        div bx          ;ax /= bx phan du luu vao dx
        push dx         ;day dx vao ngan xep
        inc cx          ;tang cx dung cho ham inlap
        cmp ax, 0       ;kiem tra xem chia het chua
        jnz chuyenso    ;chua het thi nhay den ham chuyen so
    inlap:
        pop dx          ;lay gia ngoai cung stack gan vao dx
        add dl, '0'     ;chuyen so thanh ki tu
        mov ah, 2       ;in 1 ki tu
        int 21h
        loop inlap      ;lap cho den khi cx = 0
        
        ret
    inso endp
end main