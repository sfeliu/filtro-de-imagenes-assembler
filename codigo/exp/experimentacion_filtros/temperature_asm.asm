;void temperature_asm(
;	unsigned char *src,
;   unsigned char *dst,
;   int width,
;   int height,
;   int src_row_size,
;   int dst_row_size
; );

; Parámetros:
; 	rdi = src
; 	rsi = dst
; 	rdx = width
; 	rcx = height
; 	r8 = src_row_size
; 	r9 = dst_row_size

global temperature_asm

section .rodata
	align 16
	mascara_32:		DB 32, 0, 0, 0, 32, 0, 0, 0, 32, 0, 0, 0, 32, 0, 0, 0
	mascara_1:		times 4 DD 1
	mascara_3:		times 4 DD 3.0
	m_0_0_255:		DB 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0
	negativos:		times 16 DB 0xff
	mascara_ultimo_byte_de_DW: DB 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0

section .text

temperature_asm:

	push rbp									; Stack frame			  'ALINEADO'
	mov rbp, rsp

	mov rax, rdx
	mul rcx
	mov rcx, rax
	shr rcx, 2									;rcx = height*width / 4 (cantidad de loops)

	movdqu xmm14, [mascara_1]
	movdqu xmm13, [mascara_3]
	movdqu xmm12, [m_0_0_255]
	movdqu xmm11, [negativos]
	movdqu xmm0, [mascara_ultimo_byte_de_DW]

	.ciclo:
		movdqu xmm15, [mascara_32]
		pxor xmm1, xmm1							;ALFA
		pxor xmm2, xmm2
		pxor xmm3, xmm3
		pxor xmm4, xmm4
		pxor xmm5, xmm5
		pxor xmm6, xmm6
		pxor xmm7, xmm7
		pxor xmm8, xmm8
		pxor xmm9, xmm9
		pxor xmm10, xmm10

		movdqu xmm1, [rdi]						; xmm1 = |A|R|G|B|A|R|G|B|A|R|G|B|A|R|G|B| = |PIXEL|PIXEL|PIXEL|PIXEL|
		pblendvb xmm2, xmm1						; xmm2 = |   B   |   B   |   B   |   B   |

		psrld xmm1, 8					        ; xmm1 = |-|A|R|G|-|A|R|G|-|A|R|G|-|A|R|G|
		pblendvb xmm3, xmm1						; xmm3 = |   G   |   G   |   G   |   G   |

		psrld xmm1, 8					        ; xmm1 = |-|-|A|R|-|-|A|R|-|-|A|R|-|-|A|R|
		pblendvb xmm4, xmm1						; xmm4 = |   R   |   R   |   R   |   R   |

		psrld xmm1, 8							; xmm1 = |   A   |   A   |   A   |   A   |

		paddd xmm2, xmm3						; xmm2 = |  B+G  |  B+G  |  B+G  |  B+G  |
		paddd xmm2, xmm4						; xmm2 = | B+G+R | B+G+R | B+G+R | B+G+R |
		cvtdq2ps xmm2, xmm2
		divps xmm2, xmm13						; xmm2 = |   T   |   T   |   T   |   T   |
		cvtps2dq xmm2, xmm2						; xmm2 = | | | |T| | | |T| | | |T| | | |T|	; Esto pasa porque T < 255


		movdqu xmm4, xmm2						; xmm4 = xmm2
		movdqu xmm6, xmm2						; xmm6 = xmm2
		movdqu xmm7, xmm2						; xmm7 = xmm2
		movdqu xmm8, xmm2						; xmm8 = xmm2
		movdqu xmm9, xmm2						; xmm9 = xmm2
		movdqu xmm10, xmm2						; xmm10 = xmm2

		movdqu xmm2, xmm15						; xmm2 = 32
		psubd xmm2, xmm14						; xmm2 = 31
		pcmpgtd xmm6, xmm2						; xmm6 = |  T>31  |  T>31  |  T>31  |  T>31  | "Mascara"
		pxor xmm6, xmm11						; xmm6 = | 0<T<32 | 0<T<32 | 0<T<32 | 0<T<32 | "Mascara"

		movdqu xmm2, xmm10						; xmm2 = T
		pslld xmm2, 2							; xmm2 = |  T*4   |  T*4   |  T*4   |  T*4   |
		movdqu xmm3, xmm15						; xmm3 = 32
		pslld xmm3, 2							; xmm3 = 0|0|0|128
		paddd xmm2, xmm3						; xmm2 = |T*4+128 |T*4+128 |T*4+128 |T*4+128 | [0|0|0|T*4+128](PIXEL)

		movdqu xmm5, xmm6						; Mascara temporaria
		pand xmm6, xmm2							; Resultado caso 1


		movdqu xmm2, xmm15						; xmm2 = 32
		paddd xmm2, xmm15
		paddd xmm2, xmm15						; xmm2 = 0|0|0|96
		psubd xmm2, xmm14						; xmm2 = 0|0|0|95
		pcmpgtd xmm7, xmm2						; xmm7 = |  T>95  |  T>95  |  T>95  |  T>95  | "Mascara"
		pxor xmm7, xmm11						; xmm2 = | 0<T<96 | 0<T<96 | 0<T<96 | 0<T<96 | "Mascara"
		pxor xmm7, xmm5							; xmm2 = |69<=T<96|69<=T<96|69<=T<96|69<=T<96| "Mascara"

		movdqu xmm2, xmm10						; xmm2 = T
		psubd xmm2, xmm15						; xmm2 = |  T-32  |  T-32  |  T-32  |  T-32  |
		pslld xmm2, 2							; xmm2 = |(T-32)*4|(T-32)*4|(T-32)*4|(T-32)*4| [0|0|0|(T-32)*4](PIXEL)
		pslld xmm2, 8							; [0|0|(T-32)*4|0](PIXEL)
		por xmm2, xmm12							; [0|0|(T-32)*4|255](PIXEL)

		por xmm5, xmm7							; Mascara temporaria
		pand xmm7, xmm2							; Resultado caso 2


		movdqu xmm2, xmm15						; xmm2 = 32
		pslld xmm2, 2							; xmm2 = 128
		paddd xmm2, xmm15						; xmm2 = 160
		psubd xmm2, xmm14						; xmm2 = 159
		pcmpgtd xmm8, xmm2						; xmm3 = |  T>159 |  T>159 |  T>159 |  T>159 | "Mascara"
		pxor xmm8, xmm11						; xmm3 = | 0<T<160| 0<T<160| 0<T<160| 0<T<160| "Mascara"
		pxor xmm8, xmm5							; xmm3 = |96<=T<160|96<=T<160|96<=T<160|96<=T<160| "Mascara"

		movdqu xmm2, xmm15						; xmm2 = 32
		paddd xmm2, xmm15						; xmm2 = 64
		paddd xmm2, xmm15						; xmm2 = 96

		movdqu xmm3, xmm10						; xmm3 = T
		psubd xmm3, xmm2						; xmm3 = |  T-96  |  T-96  |  T-96  |  T-96  |
		pslld xmm3, 2							; xmm3 = |(T-96)*4|(T-96)*4|(T-96)*4|(T-96)*4| [0|0|0|(T-96)*4](PIXEL)

		movdqu xmm2, xmm3						; xmm2 = xmm3 = (T-960)*4
		pslld xmm2, 8							; [0|0|(T-96)*4|0](PIXEL)
		por xmm2, xmm12							; [0|0|(T-96)*4|255](PIXEL)
		pslld xmm2, 8							; [0|(T-96)*4|255|0](PIXEL)
		por xmm2, xmm12							; [0|(T-96)*4|255|255](PIXEL)
		psubd xmm2, xmm3						; [0|(T-96)*4|255|255-(T-96)*4](PIXEL)

		por xmm5, xmm8							; Mascara temporaria
		pand xmm8, xmm2							; Resultado caso 3


		movdqu xmm2, xmm15						; xmm2 = 32
		pslld xmm2, 3							; xmm2 = 32*8
		psubd xmm2, xmm15						; xmm2 = 224
		psubd xmm2, xmm14						; xmm2 = 223
		pcmpgtd xmm9, xmm2						; xmm9 = |  T>223 |  T>223 |  T>223 |  T>223 | "Mascara"
		movdqu xmm4, xmm9						; xmm4 = xmm9
		pxor xmm9, xmm11						; xmm4 = | 0<T<224| 0<T<224| 0<T<224| 0<T<224| "Mascara"
		pxor xmm9, xmm5							; xmm4 = |160<=T<224|160<=T<224|160<=T<224|160<=T<224| "Mascara"

		movdqu xmm2, xmm15						; xmm2 = 32
		pslld xmm2, 2							; xmm2 = 128
		paddd xmm2, xmm15						; xmm2 = 160

		movdqu xmm3, xmm10						; xmm3 = T
		psubd xmm3, xmm2						; xmm3 = |  T-160  |  T-160  |  T-160  |  T-160  |
		pslld xmm3, 2							; xmm3 = |(T-160)*4|(T-160)*4|(T-160)*4|(T-160)*4| [0|0|0|(T-160)*4](PIXEL)

		movdqu xmm2, xmm12						; xmm2 = 255
		pslld xmm2, 8							; [0|0|255|0](PIXEL)
		por xmm2, xmm12							; [0|0|255|255](PIXEL)
		psubd xmm2, xmm3						; [0|0|255|255-(T-160)*4](PIXEL)
		pslld xmm2, 8							; [0|255|255-(T-160)*4|0](PIXEL)

		pand xmm9, xmm2							; Resultado caso 4


		movdqu xmm2, xmm15						; xmm2 = 32
		pslld xmm2, 3							; xmm2 = 32*8
		psubd xmm2, xmm15						; xmm2 = 224

		movdqu xmm3, xmm10						; xmm3 = T
		psubd xmm3, xmm2						; xmm3 = |  T-224 |  T-224 |  T-224 |  T-224 |
		pslld xmm3, 2							; xmm3 = |(T-224)*4|(T-224)*4|(T-224)*4|(T-224)*4| [0|0|0|(T-224)*4](PIXEL)
		movdqu xmm2, xmm12						; xmm2 = 255
		psubd xmm2, xmm3						; [0|0|0|255-(T-224)*4](PIXEL)
		pslld xmm2, 16							; [0|255-(T-224)*4|0|0](PIXEL)

		pand xmm4, xmm2							; Resultado caso 5


		por xmm4, xmm6							; junto resultados
		por xmm4, xmm7							; junto resultados
		por xmm4, xmm8							; junto resultados
		por xmm4, xmm9							; junto resultados

		pslld xmm1, 24							; agrego alfa a la solucion
		por xmm1, xmm4							; agrego alfa a la solucion

		movdqu [rsi], xmm1

		add rdi, 16
		add rsi, 16
		dec rcx
		cmp rcx, 0
		jg .ciclo

	pop rbp
	
	ret
