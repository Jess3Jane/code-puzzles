;solution to https://www.reddit.com/r/dailyprogrammer/comments/7yyt8e/20180220_challenge_352_easy_making_imgurstyle/
;basically just converts a number to base 62
;in x64 because one of the numbers was bigger than 32 bits

section .data
alphabet	db	"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
lf		db	0Ah
filename	db	"inputs.txt", 0Ah

section .text
global _start

_start:
	mov rax, 187621
	call printnum 

	mov rax, 237860461
	call printnum

	mov rax, 2187521
	call printnum

	mov rax, 18752
	call printnum

	;quit
	mov eax, 1
	mov ebx, 0
	int 80h 

;convert and print the number in rax
printnum:
	mov rcx, 0 	;counter
	mov rsi, 62 	;divisor 

.divideLoop:
	inc rcx

	mov rdx, 0	;gotta clear rdx before divs
	idiv rsi

	;rdx contains the remainder
	;so we add it to alphabet, then push that value on the stack to convert it
	;to a character
	add rdx, alphabet
	mov rdx, [rdx]
	push rdx

	cmp rax, 0	;check if we're done
	jnz .divideLoop

	;setup printing
	mov rbx, 1
	mov rdx, 1

.printloop:
	dec rcx

	;print out the top of the stack
	mov rsi, rsp
	mov rax, 1
	push rcx	;sys_write modifies rcx, so we need to save it
	syscall
	pop rcx	

	pop rax 	;remove the character we just printed
	cmp rcx, 0	;and see if we're done
	jnz .printloop

	;print a line feed
	mov rax, 1
	mov rsi, lf
	syscall

	ret
