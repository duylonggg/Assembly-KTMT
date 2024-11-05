include \masm32\include\masm32rt.inc
;Duong Hoang Anh - B23DCAT007
.data
    num1 dd 5       
    num2 dd 10      
    result dd 0     

.code

; macro PRINT_SUM
PRINT_SUM MACRO val1, val2
    mov eax, val1           
    add eax, val2           
    mov result, eax         
    print str$(result)      
    print chr$(13, 10)      
ENDM

start:
    
    PRINT_SUM num1, num2

    
    mov num1, 20
    mov num2, 30
    PRINT_SUM num1, num2

    exit
end start
