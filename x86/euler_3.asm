%include "functions.asm"

section .text
global _start

_start:
	mov r12, 600851475143 

loop:
	mov rax, r12
	call nextpf
	mov r12, rax
	mov rax, rdx
	cmp r12, 1
	jne loop

	call iprintlf
	call quit	
