include \masm32\include\masm32rt.inc

.data
    input1 dd 0
    input2 dd 0
    
    remainder dd 0
.code


    sum proc a:dword, b:dword
        local result:dword
        mov eax, a
        add eax, b
        mov result, eax
        print str$(result)
        print chr$(13, 10)
    ret
    sum endp

    diff proc a:dword, b:dword
        local result:dword
        mov eax, a
        sub eax, b
        mov result, eax
        print str$(result)
        print chr$(13, 10)
    ret
    diff endp


    multi proc a:dword, b:dword
       local result:dword
        mov eax, a
        mul b
        mov result, eax
        print str$(result)
        print chr$(13, 10)
    ret
    multi endp


    divide proc a:dword, b:dword
                local result:dword
        mov edx, 0
        mov eax, a
        div b
        mov result, eax
        mov remainder, edx
        print str$(result)
        print chr$(13, 10)
        print str$(remainder)
    ret
    divide endp



    start:
        mov input1, sval(input("a = "))
        mov input2, sval(input("b = "))
        invoke sum, input1, input2
        invoke diff, input1, input2
        invoke multi, input1, input2
        invoke divide, input1, input2
        exit
    end start


