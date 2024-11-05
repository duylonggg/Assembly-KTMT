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
        
        mov ah, 1   ;nhap 1 ky tu so
        int 21h
        sub al, '0' ;chuyen kieu ki tu ve kieu so
        
        
        mov cx, 0   ;dat lai cx = 0
        mov cl, al  ;cl = al
        
        mov ah, 9
        lea dx, tb2
        int 21h
        
        mov ax, 1  ;ax = 1 lam so nhan
        mov bx, 1  ;bx = 1 de lam so bi nhan
        
        giaithua:
            mul bx          ;ax = ax * bx
            inc bx          ;bx++
            cmp bx, cx      ;so sanh bx, cx
            jle giaithua    ;nho hon thi tiep tuc nhan
            
        mov cx, 0           ;cx = 0 de dung cho ham hienthi
        lappush:
            mov dx, 0
            div muoi         ; Chia ax cho 10, phan du trong DX, thuong trong ax
            add dx, '0'      ; Chuyen phan du thành ki tu và luu vào dx
            push dx          ; day ki tu vào ngan xep
            inc cx           ; Tang so chu so da day vào ngan xep
            cmp ax, 0        ; Kiem tra neu thuong bang 0
            jne lappush      ; Neu chua ket thuc, tiep tuc lap
            
            
        hienthi:
            pop dx
            mov ah, 2
            int 21h
            loop hienthi
        mov ah, 4ch
        int 21h
    main endp
    end