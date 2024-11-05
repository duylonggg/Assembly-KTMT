.386
include \masm32\include\masm32rt.inc
;Duong Hoang Anh - B23DCAT007
.data
    n dd 0

.code
print_1_to_n proc num:dword
    local index:dword
    mov index, 1
laplai:    
    
    mov eax, num
    cmp eax, index
    jge hienThi
    jl ketThuc
hienThi:
    print str$(index)
    print chr$(13, 10)
    inc index
    jmp laplai
ketThuc:
    

ret
print_1_to_n endp

start:
    mov n, sval(input("n = "))
    invoke print_1_to_n, n
end start