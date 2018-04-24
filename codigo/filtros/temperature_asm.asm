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

	mascara_32:		DB 32, 0, 0, 0, 32, 0, 0, 0, 32, 0, 0, 0, 32, 0, 0, 0
	mascara_96:		DB 96, 0, 0, 0, 96, 0, 0, 0, 96, 0, 0, 0, 96, 0, 0, 0
	mascara_160:	DB 160, 0, 0, 0, 160, 0, 0, 0, 160, 0, 0, 0, 160, 0, 0, 0
	mascara_224:	DB 224, 0, 0, 0, 224, 0, 0, 0, 224, 0, 0, 0, 224, 0, 0, 0
	mascara_128:	DB 128, 0, 0, 0, 128, 0, 0, 0, 128, 0, 0, 0, 128, 0, 0, 0
	m_0_0_255:		DB 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0
	negativos:		times 16 DB 0xff
	mascara_3:		DB 3, 0, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0
	mascara_ultimo_byte_de_DW: DB 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0

section .text

temperature_asm:

	push rbp									; Stack frame			  'ALINEADO'
	mov rbp, rsp

	mov rax, rdx
	mul rcx
	mov rcx, rax
	shr rcx, 2									;rcx = height*width / 4 (cantidad de loops)

	movdqu xmm11, [mascara_32]
	movdqu xmm13, [mascara_224]
	movdqu xmm15, [mascara_3]

	movdqu xmm10, [mascara_128]
	movdqu xmm9, [m_0_0_255]
	movdqu xmm8, [negativos]

	movdqu xmm0, [mascara_ultimo_byte_de_DW]

	.ciclo:
		pxor xmm1, xmm1
		pxor xmm2, xmm2
		pxor xmm3, xmm3
		pxor xmm4, xmm4
		pxor xmm5, xmm5
		pxor xmm6, xmm6
		pxor xmm7, xmm7
		pxor xmm12, xmm12
		pxor xmm14, xmm14

		movdqu xmm1, [rdi]						; xmm1 = |A|R|G|B|A|R|G|B|A|R|G|B|A|R|G|B| = |PIXEL|PIXEL|PIXEL|PIXEL|
		pblendvb xmm2, xmm1						; xmm2 = |   B   |   B   |   B   |   B   |

		psrld xmm1, 8					        ; xmm1 = |-|A|R|G|-|A|R|G|-|A|R|G|-|A|R|G|
		pblendvb xmm3, xmm1						; xmm3 = |   G   |   G   |   G   |   G   |

		psrld xmm1, 8					        ; xmm1 = |-|-|A|R|-|-|A|R|-|-|A|R|-|-|A|R|
		pblendvb xmm4, xmm1						; xmm4 = |   R   |   R   |   R   |   R   |

		psrld xmm1, 8							; xmm1 = |   A   |   A   |   A   |   A   |
		movdqu xmm14, xmm1						; xmm14 = xmm1

		paddd xmm2, xmm3						; xmm2 = |  B+G  |  B+G  |  B+G  |  B+G  |
		paddd xmm2, xmm4						; xmm2 = | B+G+R | B+G+R | B+G+R | B+G+R |
		cvtdq2ps xmm2, xmm2
		divps xmm2, xmm15						; xmm2 = |   T   |   T   |   T   |   T   |
		cvtps2dq xmm2, xmm2						; xmm2 = | | | |T| | | |T| | | |T| | | |T|	; Esto pasa porque T < 255

		movdqu xmm1, xmm2						; xmm1 = xmm2
		movdqu xmm3, xmm2						; xmm3 = xmm2
		movdqu xmm4, xmm2						; xmm4 = xmm2
		movdqu xmm13, xmm2						; xmm13 = xmm2

		pcmpgtd xmm1, xmm11						; xmm1 = |  T>32  |  T>32  |  T>32  |  T>32  | "Mascara"
		pxor xmm1,xmm8							; xmm1 = | 0<T<32 | 0<T<32 | 0<T<32 | 0<T<32 | "Mascara"

		movdqu xmm5, xmm13						; xmm5 = xmm13
		paddd xmm5, xmm5
		paddd xmm5, xmm5
		paddd xmm5, xmm5						; xmm5 = |  T*4   |  T*4   |  T*4   |  T*4   |
		paddd xmm5, xmm10						; xmm5 = |T*4+128 |T*4+128 |T*4+128 |T*4+128 | [0|0|0|T*4+128](PIXEL)

		pand xmm1, xmm5							;


		movdqu xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11						; xmm12 = 0|0|0|96
		pcmpgtd xmm2, xmm12						; xmm2 = |  T<96  |  T>96  |  T>96  |  T>96  | "Mascara"
		pxor xmm2, xmm8							; xmm2 = | 0<T<96 | 0<T<96 | 0<T<96 | 0<T<96 | "Mascara"
		pxor xmm2, xmm1							; xmm2 = |69<=T<96|69<=T<96|69<=T<96|69<=T<96| "Mascara"

		movdqu xmm5, xmm13						; xmm5 = xmm13
		psubd xmm5, xmm11						; xmm5 = |  T-32  |  T-32  |  T-32  |  T-32  |
		paddd xmm5, xmm5
		paddd xmm5, xmm5
		paddd xmm5, xmm5						; xmm5 = |(T-32)*4|(T-32)*4|(T-32)*4|(T-32)*4| [0|0|0|(T-32)*4](PIXEL)
		pslld xmm5, 8							; [0|0|(T-32)*4|0](PIXEL)
		paddd xmm5, xmm9						; [0|0|(T-32)*4|255](PIXEL)

		pand xmm2, xmm5							;


		movdqu xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11
		pcmpgtd xmm3, xmm12						; xmm3 = |  T>160 |  T>160 |  T>160 |  T>160 | "Mascara"
		pxor xmm3, xmm8								; xmm3 = | 0<T<160| 0<T<160| 0<T<160| 0<T<160| "Mascara"
		pxor xmm3, xmm2							; xmm3 = |96<=T<160|96<=T<160|96<=T<160|96<=T<160| "Mascara"

		movdqu xmm5, xmm13						; xmm5 = xmm13
		movdqu xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11						; xmm12 = 0|0|0|96
		psubd xmm5, xmm12						; xmm5 = |  T-96  |  T-96  |  T-96  |  T-96  |
		paddd xmm5, xmm5
		paddd xmm5, xmm5
		paddd xmm5, xmm5						; xmm5 = |(T-96)*4|(T-96)*4|(T-96)*4|(T-96)*4| [0|0|0|(T-96)*4](PIXEL)
		movdqu xmm6, xmm5						; xmm5 = xmm5
		pslld xmm5, 8							; [0|0|(T-96)*4|0](PIXEL)
		paddd xmm5, xmm9						; [0|0|(T-96)*4|255](PIXEL)
		pslld xmm5, 8							; [0|(T-96)*4|255|0](PIXEL)
		paddd xmm5, xmm9						; [0|(T-96)*4|255|255](PIXEL)
		psubd xmm5, xmm6						; [0|(T-96)*4|255|255-(T-96)*4](PIXEL)

		pand xmm3, xmm5							;

		movdqu xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11
		pcmpgtd xmm4, xmm12						; xmm4 = |  T>224 |  T>224 |  T>224 |  T>224 | "Mascara"
		movdqu xmm7, xmm4
		pxor xmm4, xmm8								; xmm4 = | 0<T<224| 0<T<224| 0<T<224| 0<T<224| "Mascara"
		pxor xmm4, xmm3							; xmm4 = |160<=T<224|160<=T<224|160<=T<224|160<=T<224| "Mascara"

		movdqu xmm5, xmm13						; xmm5 = xmm13
		movdqu xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11
		paddd xmm12, xmm11						; xmm12 = 0|0|0|160
		psubd xmm5, xmm12						; xmm5 = |  T-160 |  T-160 |  T-160 |  T-160 |
		paddd xmm5, xmm5
		paddd xmm5, xmm5
		paddd xmm5, xmm5						; xmm5 = |(T-160)*4|(T-160)*4|(T-160)*4|(T-160)*4| [0|0|0|(T-96)*4](PIXEL)
		movdqu xmm6, xmm5						; xmm6 = xmm5
		movdqu xmm5, xmm9						; xmm5 = xmm9
		pslld xmm5, 8							; [0|0|255|0](PIXEL)
		paddd xmm5, xmm9						; [0|0|255|255](PIXEL)
		psubd xmm5, xmm6						; [0|0|255|255-(T-160)*4](PIXEL)
		pslld xmm5, 8							;[0|255|255-(T-160)*4|0](PIXEL)

		pand xmm4, xmm5							;


		movdqu xmm5, xmm13						; xmm5 = xmm13
		psubd xmm5, xmm13						; xmm5 = |  T-224 |  T-224 |  T-224 |  T-224 |
		paddd xmm5, xmm5
		paddd xmm5, xmm5
		paddd xmm5, xmm5						; xmm5 = |(T-224)*4|(T-224)*4|(T-224)*4|(T-224)*4| [0|0|0|(T-224)*4](PIXEL)
		movdqu xmm6, xmm5						; xmm6 = xmm5
		movdqu xmm5, xmm9						; xmm5 = xmm9
		psubd xmm5, xmm6						; [0|0|0|255-(T-224)*4](PIXEL)
		pslld xmm5, 16							; [0|255-(T-224)*4|0|0](PIXEL)

		pand xmm7, xmm5							;


		por xmm2, xmm1
		por xmm2, xmm3
		por xmm2, xmm4
		por xmm2, xmm7

		pslld xmm14, 24
		paddd xmm2, xmm14

		movdqu [rsi], xmm2

		add rdi, 16
		add rsi, 16
		dec rcx
		cmp rcx, 0
		jg .ciclo

	pop rbp
	ret
