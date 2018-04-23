section .data
DEFAULT REL
mask1: times 4 DD 0x00FF00FF
mask2: times 4 DD 0xFF000000

;rdi = unsigned char *src
;rsi = unsigned char *dst
;rdx = int w
;rcx = int h
;r8 = int src_row_size
;r9 = int dst_row_size
;[rbp + 16] = unsigned char *blit
;[rbp + 24] = int bw
;[rbp + 32] = int bh
;[rbp + 40] = int b_row_size

section .text

global blit_asm
blit_asm:
	push rbp;
	mov rbp, rsp;
	mov r13, [rbp+16];

	mov r14, [rbp+24];
	mov r15, [rbp+32];
	mov r10, rcx;
	;mov r14, 400;
	;mov r15, 300;
	;mov r14, 90;
	;mov r15, 130;

	movdqu xmm3, [mask2];		xmm3 = [{00,00,00,FF},{00,00,00,FF},...]
	movdqu xmm4, [mask1];		xmm4 = [{255,00,255,00},....]

	ciclo1:
		mov r12, rdx;
		ciclo2:
			movdqu xmm1, [rdi];			xmm0 = [p1|p2|p3|p4]
			cmp r12, r14;				r12 = (w - i) < bw ?? donde i es la cantidad de columnas recorridas
			jg continuar;
		blit:
			cmp rcx, r15;				rcx = (h-j) > bh ?? donde j es la cantidad de filas recorridas 
			jg continuar;
			movdqu xmm0, [r13];			xmm0 = [PixBlit1|PixBlit2|PixBlit3|PixBlit4]
			pand xmm3, xmm0; 			xmm3 = [{0,0,0,alpha},{0,0,0,alpha},...]
			por xmm3, xmm4;				xmm3 = [{255,0,255,alpha},{255,0,255,alpha},...] alpha es de PixBlit_j
			movdqu xmm2, xmm0;			xmm2 = xmm0
			pcmpeqd xmm0, xmm3;			pone en xmm0 0 o 1 en la pos de los pix que son iguales a los de xmm3
			blendvps xmm2, xmm1;
			movdqu [rsi], xmm2;
			add r13, 16;
			jmp continuar2;
		continuar:
			movdqu [rsi], xmm1;
		continuar2:
			add rdi, 16;
			add rsi, 16;
			sub r12, 4;
			cmp r12, 0;
			jg ciclo2;
		loop ciclo1;					resta 1 a rcx, donde rcx = h. Luego el ciclo1 termina cuando h = 0.
	fin:
		pop rbp
		ret
