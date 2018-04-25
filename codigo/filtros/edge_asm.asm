; void edge_asm(
; 	unsigned char *src,
; 	unsigned char *dst,
; 	int cols,
;	int filas,
; 	int src_row_size,
; 	int dst_row_size
; 	);

; Parámetros:
; 	rdi = src
; 	rsi = dst
; 	rdx = cols
; 	rcx = filas
; 	r8 = src_row_size
; 	r9 = dst_row_size

global edge_asm

section .rodata

	mascara_2:	DB 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2

section .text

edge_asm:

	push rbp									; Stack frame			  'ALINEADO'
	mov rbp, rsp

	mov rax, rdx
	mul rcx
	mov rcx, rax
	shr rcx, 2									;rcx = height*width / 4 (cantidad de loops)

	movdqu xmm15, [mascara_2]

	.ciclo:
		pxor xmm1, xmm1

		movdqu xmm1, [rdi]						; xmm1 = |P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|




		movdqu [rsi], xmm1

		add rdi, 16
		add rsi, 16
		dec rcx
		cmp rcx, 0
		jg .ciclo

	pop rbp

	ret
