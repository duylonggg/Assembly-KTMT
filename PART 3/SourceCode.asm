.MODEL SMALL
.STACK 100H
.DATA
	;Dia chi cong du lieu ra A: 00H
	;Su dung de giao tiep cac thiet bi ngoai vi den LED
    PORTA EQU 00H
	
	;(Control Port): Dia chi cong dieu khien: 06H
	;DIeu khien cac chuc nang cua 8255A  
    PORT_CON EQU 06H
	 
	;Dieu chinh toc do hien thi
   	DELAY_COUNT DW 1FFFH

	;Cac so tu 0-9 theo he nhi phan 
    NUM DB 11000000B, 11111001B, 10100100B, 10110000B, 10011001B, 10010010B, 10000010B, 11011000B, 10000000B, 10010000B	
.CODE
MAIN PROC
		;Thiet lap DS de tro vao dau du lieu trong chuong trinh
		MOV AX, @DATA
		MOV DS, AX
   	START:
	 	;3 lenh dau: Khoi tao che do dau ra o mode 0 cho 8255A
	 	MOV DX, PORT_CON ;Dia chi cong dieu khien (Port_Control) -> DX (DX = 0006H)
		MOV AL, 80H        ;AL luu dia chi cua thanh ghi dieu khien che de (Control word format)  			
		OUT DX, AL         ;Output tu AL xuat den cong 
		MOV CX, 10         ;So lan lap
		MOV SI, OFFSET NUM ;Luu dia chi cua mang NUM vao SI
	LOOP_DISPLAY:
		MOV BX, DELAY_COUNT ;Luu so lan lap
	DELAY:
		MOV  AL, [SI]     ;Luu dia chi mang NUM vao AL
		MOV  DX, PORTA    ;Dia chi cong A duoc luu vao DX de dieu khien hien thi cac thanh LED				 
		OUT  DX, AL       ;Tu AL hien thi so qua dau ra cong A, gia tri tai AL la the hien cac so tu 0-9
		DEC  BX           ;Giam bien BX di 1 don vi
		JNZ  DELAY        ;BX khac 0 thi tiep tuc nhay vao nhan DELAY
		INC  SI           ;Tang bien SI de truy cap vao phan tu tiep theo trong mang NUM	
		LOOP LOOP_DISPLAY
		JMP  START        ;Lap lai chuong trinh
MAIN ENDP
END  MAIN
