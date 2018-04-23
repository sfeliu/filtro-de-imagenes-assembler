; void monocromatizar_inf_asm (
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

extern monocromatizar_inf_c

global monocromatizar_inf_asm

section .rodata
	mascara_ultimo_byte_de_DW: DB 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff
	mover_una_posicion_DW: DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
	negativos times 16 DB 0xff

section .text

monocromatizar_inf_asm:

	push rbp									; Stack frame								'ALINEADO'
	mov rbp, rsp

	mov rax, rdx
	mul rcx
	mov rcx, rax
	shr rcx, 2									;rcx = height*width / 4 (cantidad de loops)

	movdqu xmm0, [mascara_ultimo_byte_de_DW]
	pxor xmm2, xmm2
	pxor xmm3, xmm3
	pxor xmm4, xmm4
	pxor xmm5, xmm5
	movdqu xmm6, [mover_una_posicion_DW]
	movdqu xmm7, [negativos]
	
	.ciclo:
		movdqu xmm1, [rdi]						; xmm1 = |R|G|B|A|R|G|B|A|R|G|B|A|R|G|B|A| = |PIXEL|PIXEL|PIXEL|PIXEL|
		pblendvb xmm2, xmm1						; xmm2 = |   A   |   A   |   A   |   A   |
		
		pslld xmm1, 8					        ; xmm1 = |-|R|G|B|-|R|G|B|-|R|G|B|-|R|G|B|
		pblendvb xmm3, xmm1						; xmm3 = |   B   |   B   |   B   |   B   |

		pslld xmm1, 8					        ; xmm1 = |-|-|R|G|-|-|R|G|-|-|R|G|-|-|R|G|
		pblendvb xmm4, xmm1						; xmm4 = |   G   |   G   |   G   |   G   |

		pslld xmm1, 8					        ; xmm1 = |   R   |   R   |   R   |   R   |
	
		movdqu xmm5, xmm3						; xmm5 = xmm3
		psrld xmm5, 8 
		psrld xmm4, 8
		pcmpgtd xmm5, xmm4						; xmm5 = |max(B,G)|max(B,G)|max(B,G)|max(B,G)| "Mascara"
		pand xmm3, xmm5							; xmm3 = |   B    |   0    |    0   |    B   |
		pxor xmm5, xmm7
		pand xmm4, xmm5							; xmm4 = |   0    |   G    |    G   |    0   |
		por xmm3, xmm4							; xmm3 = |   B    |   G    |    G   |    B   |

		movdqu xmm5, xmm3						; xmm5 = xmm3
		psrld xmm5, 8
		psrld xmm1, 8
		pcmpgtd xmm5, xmm1						; xmm5 = |max(B,G,R)|max(B,G,R)|max(B,G,R)|max(B,G,R)| "Mascara"
		pand xmm3, xmm5							; xmm3 = |     0    |     0    |     G    |     B    |
		pxor xmm5, xmm7
		pand xmm1, xmm5							; xmm1 = |     R    |     R    |     0    |     0    |
		por xmm3, xmm1							; xmm3 = |     R    |     R    |     G    |     B    |

												; xmm3 = |0|0|0|R|0|0|0|R|0|0|0|G|0|0|0|B| "Máximos de cada pixel"
	
		psrld xmm3, 8							; xmm3 = |0|0|R|0|0|0|R|0|0|0|G|0|0|0|B|0|
		movdqu xmm1, xmm3
		psrld xmm3, 8							; xmm3 = |0|R|0|0|0|R|0|0|0|G|0|0|0|B|0|0|
		por xmm1, xmm3							; xmm1 = |0|R|R|0|0|R|R|0|0|G|G|0|0|B|B|0|
		psrld xmm3, 8							; xmm3 = |R|0|0|0|R|0|0|0|G|0|0|0|B|0|0|0|
		por xmm1, xmm3							; xmm1 = |R|R|R|0|R|R|R|0|G|G|G|0|B|B|B|0|
		por xmm1, xmm2							; xmm1 = |R|R|R|A|R|R|R|A|G|G|G|A|B|B|B|A|

		movdqu [rsi], xmm1

		add rdi, 16
		add rsi, 16
		dec rcx
		cmp rcx, 0
		jg .ciclo

	pop rbp

	;sub rsp, 8

	;call monocromatizar_inf_c

	;add rsp, 8

	ret
