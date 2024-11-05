;chuyen xau thanh toan in thuong va toan in hoa
.model small
.stack 100
.data
    tb1 db 'nhap xau: $'
    str db 256 dup('$') ;khoi tao mang co 256 dau $
    tb2 db 13, 10, 'chuyen xau sang chuoi in thuong: $'
    tb3 db 13, 10, 'chuyen xau sang chuoi in hoa: $'
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ah, 9
        lea dx, tb1 ;hien xau tb1
        int 21h
        
        mov ah, 10  ;nhap xau ngat 10
        lea dx, str
        int 21h
        
        mov ah, 9
        lea dx, tb2 ;hien xau tb2
        int 21h
        call inthuong ;goi ham inthuong
        
        mov ah, 9
        lea dx, tb3  ;hien xau tb3
        int 21h
        call inhoa   ;goi ham inhoa
        
        
        mov ah, 4ch
        int 21h
    main endp
    inthuong proc
        lea si, str + 2  ;tro den phan tu dau tien cua xau str
        
        ;lap kiem tra tung ki tu
        lap1:
            mov dl, [si]
            cmp dl, 'A' ;so sanh voi ki tu A
            jl in1      ;neu nho hon thi nhay den in1
            cmp dl, 'Z' ;so sanh voi ki tu Z
            jg in1      ;neu lon hon thi nhay den in 1
            add dl, 32  ; neu lon hon ki tu A va nho hon ki tu Z thi cong dl voi 32 de thanh chu in thuong
        in1:
            mov ah, 2  ;in 1 ki tu
            int 21h
            inc si     ;tang si len 1 don vi
            cmp [si], '$' ;so sanh voi $
            jne lap1      ;neu khong bang thi nhay den ham lap1
        ret               ;return
     inthuong endp
    
    
     inhoa proc
        lea si, str + 2
        lap2:
            mov dl, [si]
            cmp dl, 'a'
            jl in2
            cmp dl, 'z'
            jg in2
            sub dl, 32
        in2:
            mov ah, 2
            int 21h
            inc si
            cmp [si], '$'
            jne lap2
        ret
     inhoa endp
    end