; Duong Hoang Anh - B23DCAT007
; Nguyen Hoang Anh - B23DCAT012
; Tran Khanh Duy - B23DCAT077
; Ha Duy Long - B23DCAT172

.model small
.stack 100h
.data
    arr db 1, -2, 3, -4, 5, -6, -7 ,8, 9
    arrsize dw 9
    cnt dw 0
    str db 'so luong phan tu nguyen duong la: $'
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        lea si, arr      ;tro si den dau mang
        mov cx, arrsize  ;cx = 9
        mov bx, 0        ;bx lam bien dem
        
        dem:
            mov al, [si] ;gan al voi gia tri tai si
            cmp al, 0    ;so sanh voi 0
            jg tangdem   ;lon hon thi nhay den tang dem
            
            jmp skip     ;neu khong thi nhay den skip
        
        tangdem:
            inc bx       ;tang bien dem len 1 don vi
            jmp skip
        
        ;tiep tuc duyet cac phan tu trong mang cho den het va goi ham in so
        skip:
            inc si
            loop dem    
            mov ah, 9
            lea dx, str
            int 21h
        
            mov cnt, bx
            call inso
            
            mov ah, 4ch
            int 21h
        
    main endp
    ;ham in so nguyen
    inso proc
        mov ax, cnt
        xor cx, cx
        mov bx, 10
        
    chuyenso:
        xor dx, dx
        div bx
        push dx
        inc cx
        cmp ax, 0
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