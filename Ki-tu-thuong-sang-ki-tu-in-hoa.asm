

include \masm32\include\masm32rt.inc

.data
	message BYTE "Enter a lowercase character: ", 0
	inputBuffer BYTE 2 DUP(?)
	result BYTE "Uppercase character is: ", 0
	newline db 0Dh, 0Ah, 0
.code
start:
	; Hiển thị thông báo nhập kí tự thường
	invoke StdOut, addr message
	; Nhập kí tự thường
	invoke StdIn, addr inputBuffer, 2
	; Nạp giá trị của buffer vào thanh ghi AL
	mov al, [inputBuffer]
	; So sánh giá trị trong thanh ghi AL với 'a'
	cmp al, 'a'
	; Nhảy tới lệnh nhãn not_lowercase nếu al nhỏ hơn 'a'
	jb not_lowercase
	; So sánh giá trị trong thanh ghi AL với 'z'
	cmp al, 'z'
	;Nhảy tới lệnh nhãn not_lowercase nếu AL lớn hơn 'z'
	ja not_lowercase
	; Trừ giá trị trong AL cho 32 để về kí tự in hoa
	sub al, 32
not_lowercase:
	; Lưu kết quả vào uppercase
	mov [inputBuffer], al
	; Hiển thị kết quả
	invoke StdOut, addr result
	invoke StdOut, addr inputBuffer
	invoke StdOut, addr newline
	; Kết thúc chương trình
	invoke ExitProcess, 0

end start

