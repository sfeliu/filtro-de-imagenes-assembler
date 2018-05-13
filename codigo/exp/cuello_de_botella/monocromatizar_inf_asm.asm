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
extern printf

section .rodata
	
	msg_memoria: DB 'El programa tardo %llu ciclos de clock buscando en memoria', 0x0a, 0x00
	msg_procesamiento: DB 'El programa tardo %llu ciclos de clock procesando datos', 0x0a, 0x00
	mascara_ultimo_byte_de_DW: DB 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0
	mover_una_posicion_DW: DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
	negativos: times 16 DB 0xff

section .text

monocromatizar_inf_asm:

	push rbp									; Stack frame				'ALINEADO'
	mov rbp, rsp
	push rbx									;							'DESALINEADO'
	push r12									;							'ALINEADO'

	mov rax, rdx
	mul rcx
	mov rcx, rax
	shr rcx, 2									;rcx = height*width / 4 (cantidad de loops)
	xor r10, r10								;r10 = tiempo memoria 
	xor r11, r11								;r11 = tiempo procesamiento
	mov r12, rcx

	movdqu xmm0, [mascara_ultimo_byte_de_DW]
	movdqu xmm6, [mover_una_posicion_DW]
	movdqu xmm7, [negativos]

	.ciclo:
		pxor xmm2, xmm2
		pxor xmm3, xmm3
		pxor xmm4, xmm4
		pxor xmm5, xmm5
		
		
		rdtscp
		shl rdx, 32
		or rdx, rax
		mov r8, rdx
		
		movdqu xmm1, [rdi]						; xmm1 = |A|R|G|B|A|R|G|B|A|R|G|B|A|R|G|B| = |PIXEL|PIXEL|PIXEL|PIXEL|
				
		
		rdtscp
		shl rdx, 32
		or rdx, rax
		mov r9, rdx
		sub r9, r8
		add r10, r9
		mov rdx, r9
		
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

		
		rdtscp
		shl rdx, 32
		or rdx, rax
		mov r8, rdx
		sub r8, r9
		add r11, r9
		mov r8, rdx

		movdqu [rsi], xmm2
		

		rdtscp
		shl rdx, 32
		or rdx, rax
		mov r9, rdx
		sub r9, r8
		add r10, r9

		add rdi, 16
		add rsi, 16
		dec r12
		cmp r12, 0
		jg .ciclo

	push r11									;						'DESALINEADO'
	sub rsp, 8									;						'ALINEADO'
	mov rdi, msg_memoria
	mov rsi, r10
	call printf

	add rsp, 8									; 						'DESALINEADO'
	pop r11										;						'ALINEADO'
	mov rdi, msg_procesamiento
	mov rsi, r11
	call printf

	pop r12
	pop rbx
	pop rbp

	ret
