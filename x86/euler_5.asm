%include "functions.asm"

section .data
hexalphabet	db	"0123456789ABCDEF"

section .text
global _start

_start:
	mov r8, 2 
.loop:
	mov r9, 1
.subloop:
	mov rdx, 0
	mov rax, r8
	idiv r9
	cmp rdx, 0
	jne .fail
	inc r9
	cmp r9, 20
	jle .subloop
	
	mov rax, r8
	call iprintlf
	call quit

.fail:
	inc r8
	jmp .loop
