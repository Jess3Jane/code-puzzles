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

;print whatever is in rax in base rbx using the alphabet at rcx
iprint_base:
	mov r8, 0
.divideloop:
	inc r8
	mov rdx, 0
	idiv rbx
	add rdx, rcx 
	push rdx
	cmp rax, 0
	jnz .divideloop
	mov rax, 1
	mov rdi, 1
	mov rdx, 1
.printloop:
	dec r8
	pop rsi
	syscall
	cmp r8, 0
	jnz .printloop
	ret

;store the ascii repr of rax into the buffer at rbx
;lol this will totally overflow so maybe don't use it if even basic
;security is a goal
;returns length of output in rax
istr:	
	push rbx
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
	mov rax, r8
.printloop:
	dec r8
	mov rsi, [rsp]
	mov [rbx], rsi
	pop rsi
	add rbx, 1
	cmp r8, 0
	jnz .printloop
	pop rbx
	ret

;print whatever is in rax with a newline
iprintlf:
	call iprint
	mov rax, 0Ah
	call putchar_direct
	ret

;print the value at rax
;doesn't trash rax
putchar:
	push rax
	mov rsi, rax
	mov rax, 1
	mov rdi, 1
	mov rdx, 1
	syscall
	pop rax
	ret

;print the value of rax
putchar_direct:
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
