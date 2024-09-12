.386

include \masm32\include\masm32rt.inc

.data
	msg db "Enter the number: ", 0
	pos db "The number is positive", 0
	nega db "The number is negative", 0
	input db 10 dup(?)
	number dd ?
.code
start:
	invoke StdOut, addr msg
	invoke StdIn, addr input, 10
	invoke atoi, addr input
	mov input, eax
	cmp input, 0
	jg positive
	jmp negative
positive:
	invoke StdOut, addr pos
	jmp done
negative:
	invoke StdOut, addr nega  
	jmp done
done:
	invoke ExitProcess, 0

end start
