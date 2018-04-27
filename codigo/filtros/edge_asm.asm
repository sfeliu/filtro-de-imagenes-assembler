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

	negativos:		times 16 DB 0xff
	mascara_2:	DB 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2

section .text

edge_asm:

	push rbp									; Stack frame			  'ALINEADO'
	mov rbp, rsp

	mov rax, rdx
	mul rcx
	mov rcx, rax
	shr rcx, 2									;rcx = height*width / 4 (cantidad de loops)

	movdqu xmm15, [negativos]

	.ciclo:
		pxor xmm0, xmm0
		pxor xmm1, xmm1
		pxor xmm2, xmm2
		pxor xmm3, xmm3
		pxor xmm4, xmm4
		pxor xmm5, xmm5
		pxor xmm6, xmm6
		pxor xmm7, xmm7
		pxor xmm8, xmm8
		pxor xmm9, xmm9

												; IMG = |P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|
												;       |P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|
												;       |P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|
												;       |P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|

		movdqu xmm1, [rdi + offset_arriba]		; xmm1 = | Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar|
		movdqu xmm2, [rdi]						; xmm2 = | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P | P |
		movdqu xmm3, [rdi + offset_abajo]		; xmm3 = | Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab|
		
		movdqu xmm5, xmm1 						; xmm5 = xmm1
		movdqu xmm6, xmm2 						; xmm6 = xmm2
		movdqu xmm7, xmm3 						; xmm7 = xmm3
		
		punpcklbw xmm1, xmm0					; Partes bajas del pixel de arriba
		punpcklbw xmm2, xmm0					; Partes bajas del pixel
		punpcklbw xmm3, xmm0					; Partes bajas del pixel de abajo
		movdqu xmm4, xmm2						; xmm4 = xmm2

		punpckhbw xmm5, xmm0					; Partes altas del pixel de arriba	
		punpckhbw xmm6, xmm0					; Partes altas del pixel
		punpckhbw xmm7, xmm0					; Partes altas del pixel de abajo
		movdqu xmm8, xmm2 						; xmm8 = xmm6

		jmp .sumatoria

	.ordenar:

		



		movdqu [rsi], xmm1

		add rdi, 16
		add rsi, 16
		dec rcx
		cmp rcx, 0
		jg .ciclo

	pop rbp

	ret

	.sumatoria:
		pxor xmm2, xmm15						; xmm2 = -Pxy
		pslaw xmm2, 2							; xmm2 = (-2)*Pxy
		pslldq xmm4, 16							; xmm4 = Px(y+1)
		paddsw xmm2, xmm4						; xmm2 = (-2)*Pxy + Px(y+1)
		psrldq xmm4, 32							; xmm4 = Px(y-1)
		paddsw xmm2, xmm4						; xmm2 = (-2)*Pxy + Px(y+1) + Px(y-1)
		pslldq xmm4, 16							; xmm4 = Pxy
		pxor xmm4, xmm15						; xmm4 = -Pxy
		pslldq xmm4, 2							; xmm4 = (-2)*Pxy
		paddsw xmm2, xmm4						; xmm2 = (-2)*Pxy + (-2)*Pxy + Px(y+1) + Px(y-1)
		paddsw xmm2, xmm4						; xmm2 = (-2)*Pxy + (-2)*Pxy + (-2)*Pxy + Px(y+1) + Px(y-1)
												; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1)
		paddsw xmm2, xmm1 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y
		psraw xmm1 								; xmm1 = (0.5)*P(x+1)y
		pslldq xmm1, 16							; xmm1 = (0.5)*P(x+1)(y+1)
		paddsw xmm2, xmm1 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1)
		psrldq xmm1, 32							; xmm1 = (0.5)*P(x+1)(y-1)
		paddsw xmm2, xmm1 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1) + (0.5)*P(x+1)(y-1)
		paddsw xmm2, xmm3						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1) + (0.5)*P(x+1)(y-1)													+ P(x-1)y
		psraw xmm3 								; xmm3 = (0.5)*P(x-1)y
		pslldq xmm3, 16							; xmm3 = (0.5)*P(x-1)(y+1)
		paddsw xmm2, xmm3 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1) + (0.5)*P(x+1)(y-1)													+ P(x-1)y + (0.5)*P(x-1)(y+1)
		psrldq xmm3, 32							; xmm3 = (0.5)*P(x-1)(y-1)
		paddsw xmm2, xmm3 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1) + (0.5)*P(x+1)(y-1)
														 + P(x-1)y + (0.5)*P(x-1)(y+1) + (0.5)*P(x-1)(y-1) "sumatoria"
		jmp .ordenar