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
global sumatoria

section .rodata

	negativos:		times 16 DB 0xff
	mascara_1:	DW 1, 1, 1, 1, 1, 1, 1, 1

section .text

		sumatoria:
			movdqu xmm4, xmm2						; xmm4 = xmm2
			pxor xmm2, xmm15						
			paddsw xmm2, xmm13						; xmm2 = -Pxy
			psllw xmm2, 1							; xmm2 = (-2)*Pxy
			pslldq xmm2, 2							; xmm4 = Px(y+1)
			paddsw xmm2, xmm4						; xmm2 = (-2)*Pxy + Px(y+1)
			psrldq xmm2, 4							; xmm4 = Px(y-1)
			paddsw xmm2, xmm4						; xmm2 = (-2)*Pxy + Px(y+1) + Px(y-1)
			pslldq xmm2, 2							; xmm4 = Pxy
			pxor xmm4, xmm15
			paddsw xmm4, xmm13						; xmm4 = -Pxy
			psllw xmm4, 1							; xmm4 = (-2)*Pxy
			paddsw xmm2, xmm4						; xmm2 = (-2)*Pxy + (-2)*Pxy + Px(y+1) + Px(y-1)
			paddsw xmm2, xmm4						; xmm2 = (-2)*Pxy + (-2)*Pxy + (-2)*Pxy + Px(y+1) + Px(y-1)
													; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1)
			paddsw xmm2, xmm1 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y
			psraw xmm1, 1							; xmm1 = (0.5)*P(x+1)y
			pslldq xmm2, 2							; xmm1 = (0.5)*P(x+1)(y+1)
			paddsw xmm2, xmm1 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1)
			psrldq xmm2, 4							; xmm1 = (0.5)*P(x+1)(y-1)
			paddsw xmm2, xmm1 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1)
			 										;		 + (0.5)*P(x+1)(y-1)	
			pslldq xmm2, 2							; Posicion original
			
			paddsw xmm2, xmm3						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1)
													;		 + (0.5)*P(x+1)(y-1) + P(x-1)y
			psraw xmm3, 1							; xmm3 = (0.5)*P(x-1)y
			pslldq xmm2, 2							; xmm3 = (0.5)*P(x-1)(y+1)
			paddsw xmm2, xmm3 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1)
													;		 + (0.5)*P(x+1)(y-1) + P(x-1)y + (0.5)*P(x-1)(y+1)
			psrldq xmm2, 4							; xmm3 = (0.5)*P(x-1)(y-1)
			paddsw xmm2, xmm3 						; xmm2 = (-6)*Pxy + Px(y+1) + Px(y-1) + P(x+1)y + (0.5)*P(x+1)(y+1)
													;		 + (0.5)*P(x+1)(y-1) + P(x-1)y + (0.5)*P(x-1)(y+1) + (0.5)*P(x-1)(y-1) 
													;		"sumatoria"
			pslldq xmm2, 2							; Posición
			ret

edge_asm:

	push rbp									; Stack frame			  'ALINEADO'
	mov rbp, rsp
	push rcx
	push rdx
	push r8

	mov r13, rdx									; r13 = Ancho
	mov r11, rdx
	not r11
	inc r11

	movdqu xmm15, [negativos]
	movdqu xmm13, [mascara_1]

	mov r14, 12
	mov rax, rdx
	xor rdx, rdx
	div r14												; divido ancho por 12
	mov r14, rdx										; Dejo el resto en r14
	mov rdx, r13										; Restauro rdx
	dec rcx
	dec rcx												; rcx = Alto -2	resto 2 porque no quiero hacer ni la primer ni la última fila
	add rdi, r13										; Me salteo la primer fila
	add rsi, r13

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
			xor r15, r15
			mov r8, 12

													; IMG = |P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|
													;       |P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|
													;       |P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|
													;       |P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|P|
		
			movdqu xmm1, [rdi + r13]				; xmm1 = | Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar| Ar|
			movdqu xmm2, [rdi]						; xmm2 = |P15|P14|P13|P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| P0|
			movdqu xmm3, [rdi + r11]				; xmm3 = | Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab| Ab|
			movdqu xmm10, [rsi]


			cmp rdx, r13
			jne .caso_no_primero

			pslldq xmm1, 2							; Cómo estoy al principio de la columna debo shiftear para acomodar los pixeles
			pslldq xmm2, 2							; xmm2 = |P13|P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| P0| 0 | 0 |
			pslldq xmm3, 2
		
		.caso_no_primero:

			movdqu xmm5, xmm1 						; xmm5 = xmm1
			movdqu xmm6, xmm2 						; xmm6 = xmm2
			movdqu xmm7, xmm3 						; xmm7 = xmm3

			psrldq xmm1, 1
			psrldq xmm2, 1							; xmm2 = | 0 |P15|P14|P13|P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| 
			psrldq xmm3, 1							; caso especial = 
													;		 | 0 |P13|P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| P0| 0 |

			punpcklbw xmm1, xmm0					; Partes bajas del pixel de arriba
			punpcklbw xmm2, xmm0					; xmm2 = | P8 | P7 | P6 | P5 | P4 | P3 | P2 | P1 |	"ó"
													; xmm2 = | P6 | P5 | P4 | P3 | P2 | P1 | P0 |  0 | 
			punpcklbw xmm3, xmm0					; Partes bajas del pixel de abajo

			call sumatoria							; Utiliza xmm1, xmm2, xmm3, xmm4 y devuelve resultado en xmm2 

			movdqu xmm8, xmm2

			cmp rdx, r13
			jne .continuar2
			cmp r14, 4
			je .caso_4

		.continuar2:
			movdqu xmm1, xmm5
			movdqu xmm2, xmm6
			movdqu xmm3, xmm7

			psrldq xmm1, 1
			psrldq xmm2, 1							; xmm2 = |P14|P13|P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| P0| 0 | "ó"
													; xmm2 = |P12|P11|P10| P9| P8| P7| P6| P5| P4| P3| P2| P1| P0| 0 | 0 | 0 |
			psrldq xmm3, 1

			punpckhbw xmm1, xmm0					; Partes altas del pixel de arriba	
			punpckhbw xmm2, xmm0					; xmm2 = | P14 | P13 | P12 | P11 | P10 | P9 | P8 | P7 | "ó"
													; xmm2 = | P12 | P11 | P10 | P9  | P8  | P7 | P6 | P5 |
			punpckhbw xmm3, xmm0					; Partes altas del pixel de abajo

			call sumatoria

													; xmm2 y xmm8 tengo words para convertir a bytes.

			psrldq xmm2, 2							; xmm2 = |  0  | P14 | P13 | P12 | P11 | P10 | P9 | P8 | "ó"
													; xmm2 = |  0  | P12 | P11 | P10 | P9  | P8  | P7 | P6 |
			pslldq xmm8, 2							; xmm8 = |  P7 | P6  | P5  | P4  | P3  | P2  | P1 |  0 | "ó"
													; xmm8 = |  P5 | P4  | P3  | P2  | P1  | P0  |  0 |  0 |

			packuswb xmm8, xmm2						; xmm8 = | 0 |P14|P13|P12|P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 | 0 | "ó"
													; xmm8 = | 0 |P12|P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 |P0 | 0 | 0 |

			pslldq xmm8, 2							; xmm8 = |P13|P12|P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 | 0 | 0 | 0 | "ó"
													; xmm8 = |P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 |P0 | 0 | 0 | 0 | 0 |

			psrldq xmm8, 4							; xmm8 = | 0 | 0 | 0 | 0 |P13|P12|P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 | "ó"
													; xmm8 = | 0 | 0 | 0 | 0 |P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 |P0 |

			pslldq xmm8, 2							; xmm8 = | 0 | 0 |P13|P12|P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 | 0 | 0 | "ó"
													; xmm8 = | 0 | 0 |P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 |P0 | 0 | 0 |

			movdqu xmm14, xmm15						; xmm14 = negativos

			cmp rdx, r13
			jne .final_no_primero
			cmp r14, 8
			je .caso_8 

			mov r10, 10								; Como estoy en el primer caso y las columnas son múltiplo de 12, avanzo de a 10
			mov r8, 12

			psrldq xmm8, 3							; xmm8 = | 0 | 0 | 0 | 0 | 0 |P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 |
			pslldq xmm8, 1							; xmm8 = | 0 | 0 | 0 | 0 |P11|P10|P9 |P8 |P7 |P6 |P5 |P4 |P3 |P2 |P1 | 0 |
			psrldq xmm14, 5 						; xmm14= | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
			pslldq xmm14, 1 						; xmm14= | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 |
			pxor xmm14, xmm15						; xmm14= | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
			pand xmm14, xmm10						; xmm14= | originales x4 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |ox1|
			por xmm8, xmm14						    ; xmm8 = | originales x4 |				modificados x11	     	     |ox1|
													; los cuatro q no modifique, los 11 modificados, y el borde que no se modifica
			jmp .poner_en_memoria

		.caso_8:

			mov r10, 6								; Voy a querer avanzar sólo 6
			mov r8, 8
	
			pslldq xmm14, 9 						; xmm14= | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
			psrldq xmm14, 8 						; xmm14= | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 |
			pand xmm8, xmm14						; xmm8 = | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |P7 |P6 |P5 |P4 |P3 |P2 |P1 | 0 |
			pxor xmm14, xmm15						; xmm14= | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
			pand xmm14, xmm10						; xmm14= |         originales x8         | 0 | 0 | 0 | 0 | 0 | 0 | 0 |ox1|
			por xmm8, xmm14							; xmm8 = |         originales x8         |       modificados x7      |ox1|
													; El borde lo dejo sin modificar
			jmp .poner_en_memoria

		.final_no_primero:
			cmp rdx, 12
			je .caso_final_columna

													; Caso normal del medio
			mov r10, 12								; Cómo estoy en el caso del medio, voy a querer avanzar de a 12					

			pslldq xmm14, 4 						; xmm14= | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 |
			psrldq xmm14, 2 						; xmm14= | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 |
			pxor xmm14, xmm15						; xmm14= | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 |
			pand xmm14, xmm10						; xmm14= |orig x2| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |orig x2|
			por xmm8, xmm14							; xmm8 = |orig x2| 				  modificados x12			     |orig x2|
				
			jmp .poner_en_memoria

		.caso_final_columna:
			mov r10, 14								; Cómo estoy en el último caso, voy a querer empezar desde el principio de la 											  próxima fila
			mov r8, 12

			psrldq xmm14, 5 						; xmm14= | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
			pslldq xmm14, 2 						; xmm14= | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 |
			pxor xmm14, xmm15						; xmm14= | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 |
			pand xmm14, xmm10						; xmm14= |  orig x3  | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |orig x2|
			por xmm8, xmm14							; xmm8 = |  orig x3  | 	 	 	   modificados x11			     |orig x2|
													; Voy a querer mantener lo de la otra fila pero tambien el borde, por eso x3
			jmp .poner_en_memoria


		.caso_4:

			mov r10, 2								; solo avanzo 4, ya q son los bytes q me faltan para la próxima colúmna
			mov r8, 4

			pslldq xmm14, 13 						; xmm14= | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
			psrldq xmm14, 12 						; xmm14= | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 0 |
			pand xmm8, xmm14						; xmm8 = | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |P3 |P2 |P1 | 0 |
			pxor xmm14, xmm15						; xmm14= | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 1 |
			pand xmm14, xmm10						; xmm14= |                  originales x12               | 0 | 0 | 0 |ox1|
			por xmm8, xmm14							; xmm8 = |                  originales x12               |   modx3   |ox1|
													; El borde lo dejo sin modificar


		.poner_en_memoria:
			movdqu [rsi], xmm8

			add rdi, r10
			add rsi, r10
			sub rdx, r8
			jg .ciclo_columna
		mov rdx, r13
		dec rcx
		cmp rcx, 0
		jg .ciclo_fila

	pop r8
	pop rdx
	pop rcx
	pop rbp

	ret



