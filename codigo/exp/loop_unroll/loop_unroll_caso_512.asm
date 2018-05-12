; void monocromatizar_inf_asm(
; 	unsigned char *src,
; 	unsigned char *dst,
; 	int width,
; 	int height,
; 	int src_row_size,
; 	int dst_row_size
; );

; Parámetros:
; 	rdi = src
; 	rsi = dst
; 	rdx = width
; 	rcx = height
; 	r8 = src_row_size
; 	r9 = dst_row_size

global monocromatizar_inf_asm

section .rodata

	mascara_ultimo_byte_de_DW: DB 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0
	mover_una_posicion_DW: DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
	negativos: times 16 DB 0xff

section .text

monocromatizar_inf_asm:

	push rbp									; Stack frame				'ALINEADO'
	mov rbp, rsp

	mov rax, rdx
	mul rcx
	mov rcx, rax
	shr rcx, 2									;rcx = height*width / 4 (cantidad de loops)

	movdqu xmm0, [mascara_ultimo_byte_de_DW]
	movdqu xmm7, [negativos]

	%macro ciclo 0
		pxor xmm2, xmm2
		pxor xmm3, xmm3
		pxor xmm4, xmm4
		pxor xmm5, xmm5
		movdqu xmm1, [rdi]						; xmm1 = |A|R|G|B|A|R|G|B|A|R|G|B|A|R|G|B| = |PIXEL|PIXEL|PIXEL|PIXEL|
		pblendvb xmm2, xmm1						; xmm2 = |   B   |   B   |   B   |   B   |

		psrld xmm1, 8					        ; xmm1 = |-|A|R|G|-|A|R|G|-|A|R|G|-|A|R|G|
		pblendvb xmm3, xmm1						; xmm3 = |   G   |   G   |   G   |   G   |

		psrld xmm1, 8					        ; xmm1 = |-|-|A|R|-|-|A|R|-|-|A|R|-|-|A|R|
		pblendvb xmm4, xmm1						; xmm4 = |   R   |   R   |   R   |   R   |

		psrld xmm1, 8					        ; xmm1 = |   A   |   A   |   A   |   A   |

		movdqu xmm5, xmm3						; xmm5 = xmm3
		pcmpgtd xmm5, xmm4						; xmm5 = |max(R,G)|max(R,G)|max(R,G)|max(R,G)| "Mascara"
		pand xmm3, xmm5							; xmm3 = |   R    |   0    |    0   |    R   |
		pxor xmm5, xmm7
		pand xmm4, xmm5							; xmm4 = |   0    |   G    |    G   |    0   |
		por xmm3, xmm4							; xmm3 = |   R    |   G    |    G   |    R   |

		movdqu xmm5, xmm3						; xmm5 = xmm3
		pcmpgtd xmm5, xmm2						; xmm5 = |max(B,G,R)|max(B,G,R)|max(B,G,R)|max(B,G,R)| "Mascara"
		pand xmm3, xmm5							; xmm3 = |     0    |     0    |     G    |     R    |
		pxor xmm5, xmm7
		pand xmm2, xmm5							; xmm2 = |     B    |     B    |     0    |     0    |
		por xmm3, xmm2							; xmm3 = |     B    |     B    |     G    |     R    | [0|0|0|B](PIXEL)

		movdqu xmm2, xmm3
		pslld xmm3, 8							; xmm3 = |0|0|R|0|0|0|R|0|0|0|G|0|0|0|B|0|
		por xmm2, xmm3							; xmm2 = |0|0|R|R|0|0|R|R|0|0|G|G|0|0|B|B|
		pslld xmm3, 8							; xmm3 = |0|R|0|0|0|R|0|0|0|G|0|0|0|B|0|0|
		por xmm2, xmm3							; xmm2 = |0|R|R|R|0|R|R|R|0|G|G|G|0|B|B|B|
		pslld xmm1, 24							; xmm1 = |A|0|0|0|A|0|0|0|A|0|0|0|A|0|0|0|
		por xmm2, xmm1							; xmm2 = |A|R|R|R|A|R|R|R|A|G|G|G|A|B|B|B|

		movdqu [rsi], xmm2

		add rdi, 16
		add rsi, 16
		%endmacro

	mov rax, rcx
	mov r8, 512
	div r8
	cmp rdx, 0
	je .caso_multiplo_512
	mov rax, rcx
	jmp .caso_multiplo_1

	.caso_multiplo_1:
		ciclo
		dec rax
		cmp rax, 0
		jne .caso_multiplo_1
		jmp .fin

	.caso_multiplo_512:
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		ciclo
		dec rax
		cmp rax, 0
		jne .caso_multiplo_512

	.fin:
		pop rbp

		ret
