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

;get the next prime factor of the number in rax
;to be used to implement a prime factorization algo
;returns the number in rax
;and the factor in rdx
nextpf:
	mov r8, rax
	cmp rax, 1
	jg .checktwo
	pop rax
	mov rdx, 1
	ret
.checktwo:
	mov rdx, 0
	mov rcx, 2
	idiv rcx
	cmp rdx, 0
	jnz .setup
	mov rdx, rcx
	ret
.setup:
	mov rcx, 3
.loop:
	mov rdx, 0
	mov rax, r8
	idiv rcx
	cmp rdx, 0
	jnz .footer
	mov rdx, rcx
	ret
.footer:
	add rcx, 2
	cmp rcx, r8
	jl .loop
	mov rax, 1
	mov rdx, r8
	ret

quit:
	mov eax, 1
	mov ebx, 0
	int 80h 
