.386


include \masm32\include\masm32rt.inc

; Nhập 1 ký tự và xuất ra màn hình

.data
	prompt db "Enter a character: ", 0
	result db "The character is: ", 0
	buffer db 2 dup(?)
	newline db 0Dh, 0Ah, 0
.code
start:
	invoke StdOut, addr prompt
	invoke StdIn, addr buffer, 2
	invoke StdOut, addr result
	invoke StdOut, addr buffer
	invoke StdOut, addr newline
	invoke ExitProcess, 0
end start