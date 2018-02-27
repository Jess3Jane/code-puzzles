%include "functions.asm"

section .data
buffer: times 64 db 0

section .text
global _start

_start:
	mov r10, 0
	mov r14, 100
	mov r15, 100

.check:
	mov rax, r14
	mul r15
	call checkpalindrome
	cmp rax, 1
	jne .checkfooter
	mov rax, r14
	mul r15
	cmp r10, rax
	jg .checkfooter
	mov r10, rax

.checkfooter
	inc r14
	cmp r14, 1000
	jl .check

	inc r15
	mov r14, 100
	cmp r15, 1000
	jl .check

	mov rax, r10
	call iprintlf

	call quit

checkpalindrome:
	;convert it to a string
	mov rbx, buffer
	call istr
	
	mov r12, buffer
	mov r13, rax
	add r13, buffer
	dec r13

.loop:
	cmp r12, r13
	jge .pass

	mov bl, [r12]
	mov al, [r13]
	cmp bl, al
	jne .fail

	inc r12
	dec r13
	jmp .loop

.fail:
	mov rax, 0
	ret

.pass:
	mov rax, 1
	ret
