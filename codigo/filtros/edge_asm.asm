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
global 

section .rodata

	negativos:		times 16 DB 0xff
	mascara_2:	DB 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2

section .text

edge_asm:

	push rbp									; Stack frame			  'ALINEADO'
	mov rbp, rsp

	mov r8, rdx									; r8 = Ancho
	mov r9, rcx									; r9 = Alto

	movdqu xmm15, [negativos]

	.ciclo_fila:
		.ciclo_columna:
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

			movdqu xmm2, [rdi]						; xmm2 = |P15|P14|P13|P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| P0|
			cmp rcx, r9
			je .fondo
			movdqu xmm3, [rdi + offset_abajo]		; xmm3 = | Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab|
		.fondo:										; xmm3 = | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
			
			cmp rcx, 0
			je .tope
			movdqu xmm1, [rdi + offset_arriba]		; xmm1 = | Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar|
		.tope:										; xmm1 = | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
			
			cmp rdx, r8
			jne .no_caso_principio

			mov r10, 10								; Como estoy en el primer caso, avanzo de a 10

			pslldq xmm1, 16
			pslldq xmm2, 16							; xmm2 = |P13|P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| P0| 0 | 0 |
			pslldq xmm3, 16

			jmp desempaquetar 

		.no_caso_principio:	
			mov r10, 12								; Cómo no estoy en el primer caso, voy a querer avanzar de a 12
		
		.desempaquetar:

			movdqu xmm5, xmm1 						; xmm5 = xmm1
			movdqu xmm6, xmm2 						; xmm6 = xmm2
			movdqu xmm7, xmm3 						; xmm7 = xmm3

			psrldq xmm1, 8
			psrldq xmm2, 8							; xmm2 = | 0 |P15|P14|P13|P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| 
			psrldq xmm3, 8							; caso especial = 
													;		 | 0 |P13|P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| P0| 0 |

			punpcklbw xmm1, xmm0					; Partes bajas del pixel de arriba
			punpcklbw xmm2, xmm0					; xmm2 = | P8 | P7 | P6 | P5 | P4 | P3 | P2 | P1 |	"ó"
													; xmm2 = | P6 | P5 | P4 | P3 | P2 | P1 | P0 |  0 | 
			punpcklbw xmm3, xmm0					; Partes bajas del pixel de abajo

			call sumatoria							; Utiliza xmm1, xmm2, xmm3, xmm4 y devuelve resultado en xmm2 

			mov xmm8, xmm2

			cmp rdx, 4
			je .ordenar_4

			mov xmm1, xmm5
			mov xmm2, xmm6
			mov xmm3, xmm7

			pslldq xmm1, 8
			pslldq xmm2, 8							; xmm2 = |P14|P13|P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| P0| 0 | "ó"
													; xmm2 = |P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| P0| 0 | 0 | 0 |
			pslldq xmm3, 8

			punpckhbw xmm1, xmm0					; Partes altas del pixel de arriba	
			punpckhbw xmm2, xmm0					; xmm2 = | P14 | P13 | P12 | P11 | P10 | P9 | P8 | P7 | "ó"
													; xmm2 = | P12 | P11 | P10 | P9  | P8  | P7 | P6 | P5 |
			punpckhbw xmm3, xmm0					; Partes altas del pixel de abajo
			

			call sumatoria
			jmp ordenar


		.ordenar:									; xmm2 y xmm8 tengo words para convertir a bytes.

			psrldq xmm2, 8							; xmm2 = |  0  | P14 | P13 | P12 | P11 | P10 | P9 | P8 | "ó"
													; xmm2 = |  0  | P12 | P11 | P10 | P9  | P8  | P7 | P6 |
			pslldq xmm8, 8							; xmm8 = |  P7 | P6  | P5  | P4  | P3  | P2  | P1 |  0 | "ó"
													; xmm8 = |  P5 | P4  | P3  | P2  | P1  | P0  |  0 |  0 |

			packuswb xmm8, xmm2						; xmm8 = | 0 |P14|P13|P12|P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 | 0 | "ó"
													; xmm8 = | 0 |P12|P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 |P0 | 0 | 0 |

			pslldq xmm8, 16							; xmm8 = |P13|P12|P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 | 0 | 0 | 0 | "ó"
													; xmm8 = |P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 |P0 | 0 | 0 | 0 | 0 |

			psrldq xmm8, 32							; xmm8 = | 0 | 0 | 0 | 0 |P13|P12|P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 | "ó"
													; xmm8 = | 0 | 0 | 0 | 0 |P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 |P0 |

			pslldq xmm8, 16							; xmm8 = | 0 | 0 |P13|P12|P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 | 0 | 0 | "ó"
													; xmm8 = | 0 | 0 |P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 |P0 | 0 | 0 |

			movdqu xmm14, xmm15						; xmm14 = negativos

			cmp rdx, r8
			jne .final_no_primero

			psrldq xmm8, 16							; xmm8 = | 0 | 0 | 0 | 0 |P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 |P0 |
			psrldq xmm14, 32						; xmm14= | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
			pxor xmm14, xmm15						; xmm14= | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
			pand xmm14, xmm6						; xmm14= | originales x4 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
			por xmm8, xmm14						    ; xmm8 = | originales x4 |				 modificados x12	     	     |
			jmp .poner_en_memoria

		.final_no_primero:
			cmp rdx, 8
			je .caso_8					
													; Caso normal del medio
			psrldq xmm14, 16						; xmm14= | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
			pslldq xmm14, 32						; xmm14= | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 |
			pslldq xmm14, 32						; xmm14= | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 |
			pxor xmm14, xmm15						; xmm14= | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 |
			pand xmm14, xmm6						; xmm14= |orig x2| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |orig x2|
			por xmm8, xmm14							; xmm8 = |orig x2| 				  modificados x12			     |orig x2|
			jmp .poner_en_memoria

		.caso_8:

			psrldq xmm14, 16						; xmm14= | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |		
			pslldq xmm14, 64						; xmm14= | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
			psrldq xmm14, 48						; xmm14= | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 |
			pand xmm8, xmm14						; xmm8 = | 0 | 0 | 0 | 0 | 0 | 0 |P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 | 0 | 0 |
			pxor xmm14, xmm15						; xmm14= | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 |
			pand xmm14, xmm6						; xmm14= |      originales x6    | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |orig x2|
			por xmm8, xmm14							; xmm8 = |      originales x6    |        modificados x8         |orig x2|
			jmp .poner_en_memoria

		.caso_4:

			psrldq xmm14, 16						; xmm14= | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
			pslldq xmm14, 96						; xmm14= | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
			pslldq xmm14, 80						; xmm14= | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 0 | 0 |
			pand xmm8, xmm14						; xmm8 = | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |P5 |P4 |P3 |P2 | 0 | 0 |
			pxor xmm14, xmm15						; xmm14= | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 1 | 1 |
			pand xmm14, xmm6						; xmm14= |             originales x10            | 0 | 0 | 0 | 0 |orig x2|
			por xmm8, xmm14							; xmm8 = |             originales x10            | modificados x4|orig x2|


		.poner_en_memoria:
			movdqu [rsi], xmm1

			add rdi, r10
			add rsi, r10
			sub rdx, 12
			jg .ciclo_columna
		mov rdx, r8
		dec rcx
		cmp rcx, 0
		jg .ciclo_fila

	pop rbp

	ret

sumatoria:
	movdqu xmm4, xmm2						; xmm4 = xmm2
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
	paddsw xmm2, xmm1 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1)
	 												 + (0.5)*P(x+1)(y-1)	
	paddsw xmm2, xmm3						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1)
													 + (0.5)*P(x+1)(y-1) + P(x-1)y
	psraw xmm3 								; xmm3 = (0.5)*P(x-1)y
	pslldq xmm3, 16							; xmm3 = (0.5)*P(x-1)(y+1)
	paddsw xmm2, xmm3 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1)
													 + (0.5)*P(x+1)(y-1) + P(x-1)y + (0.5)*P(x-1)(y+1)
	psrldq xmm3, 32							; xmm3 = (0.5)*P(x-1)(y-1)
	paddsw xmm2, xmm3 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1)
													 + (0.5)*P(x+1)(y-1) + P(x-1)y + (0.5)*P(x-1)(y+1) + (0.5)*P(x-1)(y-1) "sumatoria"
	ret