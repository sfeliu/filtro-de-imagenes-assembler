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

mascara_32:		DB 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0
mascara_96:		DB 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0
mascara_160:	DB 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0
mascara_224:	DB 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0
mascara_128:	DB 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0
m_0_0_255:		DB 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0, 0xff, 0, 0, 0

section .text

temperature_asm:
push rbp									; Stack frame			  'ALINEADO'
mov rbp, rsp

mov rax, rdx
mul rcx
mov rcx, rax
shr rcx, 2									;rcx = height*width / 4 (cantidad de loops)

movdqu xmm11, [mascara_32]
movdqu xmm12, [mascara_96]
movdqu xmm13, [mascara_160]
movdqu xmm14, [mascara_224]

movdqu xmm10, [mascara_128]
movdqu xmm9, [m_0_0_255]

.ciclo:
	pxor xmm0, xmm0
	pxor xmm1, xmm1
	pxor xmm2, xmm2
	pxor xmm3, xmm3
	pxor xmm4, xmm4
	pxor xmm5, xmm5
	pxor xmm6, xmm6
	pxor xmm7, xmm7

	movdqu xmm1, [rdi]						; xmm1 = |A|R|G|B|A|R|G|B|A|R|G|B|A|R|G|B| = |PIXEL|PIXEL|PIXEL|PIXEL|
	pblendvb xmm0, xmm1						; xmm0 = |   B   |   B   |   B   |   B   |

	psrld xmm1, 8					        ; xmm1 = |-|A|R|G|-|A|R|G|-|A|R|G|-|A|R|G|
	pblendvb xmm2, xmm1						; xmm2 = |   G   |   G   |   G   |   G   |

	psrld xmm1, 8					        ; xmm1 = |-|-|A|R|-|-|A|R|-|-|A|R|-|-|A|R|
	pblendvb xmm3, xmm1						; xmm3 = |   R   |   R   |   R   |   R   |

	paddd xmm0, xmm2						; xmm0 = |  B+G  |  B+G  |  B+G  |  B+G  |
	paddd xmm0, xmm3						; xmm0 = | B+G+R | B+G+R | B+G+R | B+G+R |
	;xmm0/3 (?)								; xmm0 = |   T   |   T   |   T   |   T   |

	movdqu xmm1, xmm0						; xmm1 = xmm0
	movdqu xmm2, xmm0						; xmm2 = xmm0
	movdqu xmm3, xmm0						; xmm3 = xmm0
	movdqu xmm4, xmm0						; xmm4 = xmm0


	pcmpgtd xmm1, xmm11						; xmm1 = |  T>69  |  T>69  |  T>69  |  T>69  | "Mascara"
	;not xmm1								; xmm1 = | 0<T<69 | 0<T<69 | 0<T<69 | 0<T<69 | "Mascara"

	movdqu xmm5, xmm0						; xmm5 = xmm0
	paddd xmm5, xmm5
	paddd xmm5, xmm5
	paddd xmm5, xmm5						; xmm5 = |  T*4   |  T*4   |  T*4   |  T*4   |
	paddd xmm5, xmm10						; xmm5 = |T*4+128 |T*4+128 |T*4+128 |T*4+128 | [0|0|0|T*4+128](PIXEL)

	pand xmm1, xmm5							;


	pcmpgtd xmm2, xmm12						; xmm2 = |  T<96  |  T>96  |  T>96  |  T>96  | "Mascara"
	;not xmm2								; xmm2 = | 0<T<96 | 0<T<96 | 0<T<96 | 0<T<96 | "Mascara"
	pxor xmm2, xmm1							; xmm2 = |69<=T<96|69<=T<96|69<=T<96|69<=T<96| "Mascara"

	movdqu xmm5, xmm0						; xmm5 = xmm0
	psubd xmm5, xmm11						; xmm5 = |  T-32  |  T-32  |  T-32  |  T-32  |
	paddd xmm5, xmm5
	paddd xmm5, xmm5
	paddd xmm5, xmm5						; xmm5 = |(T-32)*4|(T-32)*4|(T-32)*4|(T-32)*4| [0|0|0|(T-32)*4](PIXEL)
	pslld xmm5, 8							; [0|0|(T-32)*4|0](PIXEL)
	paddd xmm5, xmm9						; [0|0|(T-32)*4|255](PIXEL)

	pand xmm2, xmm5							;


	pcmpgtd xmm3, xmm13						; xmm3 = |  T>160 |  T>160 |  T>160 |  T>160 | "Mascara"
	;not xmm3								; xmm3 = | 0<T<160| 0<T<160| 0<T<160| 0<T<160| "Mascara"
	pxor xmm3, xmm2							; xmm3 = |96<=T<160|96<=T<160|96<=T<160|96<=T<160| "Mascara"

	movdqu xmm5, xmm0						; xmm5 = xmm0
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


	pcmpgtd xmm4, xmm14						; xmm4 = |  T>224 |  T>224 |  T>224 |  T>224 | "Mascara"
	movdqu xmm7, xmm4
	;not xmm4								; xmm4 = | 0<T<224| 0<T<224| 0<T<224| 0<T<224| "Mascara"
	pxor xmm4, xmm3							; xmm4 = |160<=T<224|160<=T<224|160<=T<224|160<=T<224| "Mascara"

	movdqu xmm5, xmm0						; xmm5 = xmm0
	psubd xmm5, xmm13						; xmm5 = |  T-160 |  T-160 |  T-160 |  T-160 |
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


	movdqu xmm5, xmm0						; xmm5 = xmm0
	psubd xmm5, xmm14						; xmm5 = |  T-224 |  T-224 |  T-224 |  T-224 |
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

	movdqu [rsi], xmm2

	add rdi, 16
	add rsi, 16
	dec rcx
	cmp rcx, 0
	jg .ciclo

pop rbp

ret
