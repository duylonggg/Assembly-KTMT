.Model Small ; chung trinh nay chon bo nho small
.Stack 100 ; kich thuoc ngan xep la 100 bytes
.Data ;cac dong duoi data la khai bao
		CRLF    DB	13, 10, '$'	;ki tu xuong dong
		ChaoTay	DB 	'hello!$'
		ChaoTa	DB 	'chao ban!$'
.Code
MAIN Proc;thu tuc chinh
		;khoi tao DS **
		MOV AX, @Data	; khoi dau thanh ghi DS
		MOV DS, AX;tro thanh ghi ds ve dau doan data
                             
		; hien thi loi ch�o d�ng h�m 9 cua INT 21H 
		MOV AH, 9; lenh goi ham 09h cua ngat 21 in mot xau ki tu
                                    
		LEA DX, ChaoTay ; dong in chuoichao tay
		INT 21H  ;hello!
        
		LEA DX, CRLF;in dau enter va lui vao dau dong
		INT 21H                              
		
		; hien thi loi ch�o ta dung h�m 9 cua INT 21H 
		LEA DX, ChaoTa
		INT 21H      ;chao ban!
		
		; tro ve DOS d�ng h�m 4 CH cua INT 21H
		MOV AH, 4CH
		INT 21H
MAIN Endp
END 	