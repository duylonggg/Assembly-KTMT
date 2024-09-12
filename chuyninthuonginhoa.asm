.model small
.stack 100
.data
    tb1 db 'nhap xau: $'
    str db 256 dup('$')
    tb2 db 13, 10, 'chuyen xau sang chuoi in thuong: $'
    tb3 db 13, 10, 'chuyen xau sang chuoi in hoa: $'
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ah, 9
        lea dx, tb1
        int 21h
        
        mov ah, 10
        lea dx, str
        int 21h
        
        mov ah, 9
        lea dx, tb2
        int 21h
        call inthuong
        
        mov ah, 9
        lea dx, tb3
        int 21h
        call inthoa
    main endp
    inthuong proc
        lea si, str + 2
        lap1:
            mov dl, [si]
            cmp dl, 'A'
            jl in1
            cmp dl, 'Z'
            jg in1
            add dl, 32
        in1
            mov ah, 2
            int 21h
            inc [si]
            cmp [si], '$'
            jne lap1
        ret
     inhoa proc
        lea si, str + 2
        lap1:
            mov dl, [si]
            cmp dl, 'a'
            jl in1
            cmp dl, 'z'
            jg in1
            sub dl, 32
        in1
            mov ah, 2
            int 21h
            inc [si]
            cmp [si], '$'
    end