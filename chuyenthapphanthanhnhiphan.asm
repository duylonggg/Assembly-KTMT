.Model Small
.Stack 100
.Data
		crlf DB	13, 10, 'so da nhap co dang nhi phan: $'
		str  db 5 dup('$'); nhap vao 1 chuoi toi da 5 ky tu
.Code
main proc
    
		mov ax, @Data
		mov ds, ax  
		
        mov ax, '#'
        push ax
        mov ah, 10
        lea dx, str
        int 21h
        
        mov cl, str+1
        lea si, str+2
        mov ax, 0
        mov bx, 10
        thapphan:
            mul bx
            mov dl, [si]
            sub dl, '0'
            add ax, dx
            inc si
            loop thapphan
        mov cl, 2
        nhiphan:
            mov ah, 0
            div cl
            push ax
            cmp al, 0
            jne nhiphan
            
        mov ah, 9
        lea dx, crlf
        int 21h
        
        mov ah, 2
        inra:
            pop dx
            cmp dx, '#'
            je done
            mov dl, dh
            add dl, '0'
            int 21h
            jmp inra
        done:
            mov ah, 4ch
            int 21h
	    
main endp
END