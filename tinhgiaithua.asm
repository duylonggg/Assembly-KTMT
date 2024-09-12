;tinh giai thua cua mot so nho hon 10
.model small
.stack 100
.data
    tb1 db 'nhap so nho hon 10: $'
    muoi dw 10
    tb2 db 13, 10, 'giai thua cua so vua nhap la: $'
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ah, 9
        lea dx, tb1
        int 21h
        
        mov ah, 1
        int 21h
        sub al, '0'
        
        
        mov cx, 0
        mov cl, al
        
        mov ah, 9
        lea dx, tb2
        int 21h
        
        mov ax, 1
        mov bx, 1
        
        giaithua:
            mul bx
            inc bx
            cmp bx, cx
            jle giaithua
        mov cx, 0
        lappush:
            mov dx, 0
            div muoi
            add dx, '0'
            push dx
            inc cx
            cmp ax, 0
            jne lappush
            
            
        hienthi:
            pop dx
            mov ah, 2
            int 21h
            loop hienthi
        mov ah, 4ch
        int 21h
    main endp
    end