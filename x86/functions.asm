;print whatever is in rax
iprint:
	mov r8, 0
	mov rsi, 10
.divideloop:
	inc r8
	mov rdx, 0
	idiv rsi
	add rdx, 48
	push rdx
	cmp rax, 0
	jnz .divideloop
	mov rax, 1
	mov rdi, 1
	mov rdx, 1
.printloop:
	dec r8
	mov rsi, rsp
	syscall
	pop rsi
	cmp r8, 0
	jnz .printloop
	ret

;print whatever is in rax with a newline
iprintlf:
	call iprint
	mov rax, 0Ah
	push rax
	mov rax, 1
	mov rdi, 1
	mov rdx, 1
	mov rsi, rsp
	syscall
	pop rsi
	ret

quit:
	mov eax, 1
	mov ebx, 0
	int 80h 
