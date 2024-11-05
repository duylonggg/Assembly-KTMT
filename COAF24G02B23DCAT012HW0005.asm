.Model Small
.Stack 50h
.Data
		crlf DB	13, 10, 'so da nhap co dang nhi phan: $'
		str  db 5 dup('$'); nhap vao 1 chuoi toi da 5 ky tu
.Code
main proc
    
		mov ax, @Data
		mov ds, ax  
		
        mov ax, '#'     ;gan gia tri # cho ax
        push ax         ;day # vao ngan xep
        mov ah, 10      
        lea dx, str     ;nhap xau
        int 21h
        
        mov cl, [str+1]   ;gan do dai cua mang vao cl
        lea si, str+2   ;tro den gia tri dau tien trong mang
        mov ax, 0       ;ax = 0
        mov bx, 10      ;bx = 10
        
        ;ham chuyen xau ve so thap phan
        thapphan:
            mul bx      ;ax * 10
            mov dl, [si];dl = gia tri tai si 
            sub dl, '0' ;chuyen gia tri ki tu thanh gia tri so
            add ax, dx  ;ax = ax + dx
            inc si      ;chuyen si tro den vi tri ke tiep
            loop thapphan;khi cl > 0 tiep tuc lap
        mov cl, 2 ;cl = 2 de chuan bi chia
        
        nhiphan:
            mov ah, 0   ;dat phan du cua ah ve 0
            div cl      ;ax /= cl
            push ax     ;day gia tri cua ax vao ngan xep
            cmp al, 0   ;so sanh thuong voi 0
            jne nhiphan ;neu al khac 0 thi lap nhiphan
            
            
        mov ah, 9
        lea dx, crlf
        int 21h
        
        mov ah, 2    ;ngat 2 de in 1 ki tu
        inra:
            pop dx      ;lay phan tu ngoai cung ngan xep luu vao dx
            cmp dx, '#' ;so sanh dx voi #
            je done     ;neu bang thi qua trinh hoan tat
            mov dl, dh  ;gan phan du vao phan thuong
            add dl, '0' ;chuyen so thanh ki tu
            int 21h     ;in 1 ki tu ra
            jmp inra    ;lap lai ham in ra
        done:
            mov ah, 4ch
            int 21h
	    
main endp
END