.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
    message db "Hello, World!", 0

.code
start:
    invoke MessageBoxA, 0, addr message, addr message, 0  ; Hiển thị hộp thoại thông báo "Hello, World!"
    invoke ExitProcess, 0  ; Thoát chương trình

end start
