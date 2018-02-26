%include "functions.asm"

section .data

section .text
global _start

_start:
	mov r12, 1000
	mov r13, 3
	mov r14, 5
	mov r15, 0
	
loop:
	dec r12
	cmp r12, 0
	jz end 

	;test 3
	mov rax, r12
	mov rdx, 0
	idiv r13 
	cmp rdx, 0
	jz add_it 

	mov rax, r12
	mov rdx, 0
	idiv r14
	cmp rdx, 0
	jnz loop

add_it:
	add r15, r12
	jmp loop

end:
	mov rax, r15
	call iprintlf
	call quit
