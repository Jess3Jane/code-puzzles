%include "functions.asm"

section .data

section .text
global _start

_start:
	mov r12, 1
	mov r13, 2
	mov r14, 0
	mov r15, 2

loop:
	mov rax, r12
	mov r12, r13
	add r13, rax

	mov rax, r12
	mov rdx, 0
	idiv r15
	cmp rdx, 0
	jnz foot
	add r14, r12

foot:
	cmp r12, 4000000 
	jl loop

	mov rax, r14
	call iprintlf
	call quit
