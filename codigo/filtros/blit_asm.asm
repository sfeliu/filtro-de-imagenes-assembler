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
	movdqu xmm5, [mask2];				xmm5 = [{00,00,00,FF},{00,00,00,FF},...]
	movdqu xmm4, [mask1];				xmm4 = [{255,00,255,00},....]

	mov r12, rdx;						r12 = w
	xor rax, rax;						rax = 0
	xor r10, r10;						r10 = 0
	xor r11, r11;						r11 = 0
	xor rdx, rdx;						rdx = 0
	mov rax, r14;						'dividendo' = rax = bw = r14 = 89
	mov r10, 4;							r10 = 4
	div r10;							divido rax por r10 => 89/4 
	mov r11, r10;						r11 = r10 = 4
	sub r11, rdx;						r11 = 4- (89 mod 4) = 3, ya que rdx = 89 mod 4 = 1
	mov rax, r11;						rax = 4-(bw mod 4)
	mul r10;							rdx = 4*(4 - (bw mod 4)) = 4*3
	mov rdx, r11;						rdx = 4 - (bw mod 4) = 3
	mov r11, rax;						r11 = 4*3
	mov rax, rdx;
	mov rdx, r12;						rdx = w
	sub r10, rax;						r10 = 4 - (4 - (bw mod 4))
	
	ciclo1:
		mov r12, rdx;
		movdqu xmm1, [rdi];				xmm0 = [p1|p2|p3|p4]
		movdqu [rsi], xmm1;				copio los primeros 4 elementos de cada fila.
		sub r12, rax;					r12 = 520 - (4-(bw mod 4)) = 517
		add rdi, r11;					salteo los primeros 3 pixeles
		add rsi, r11;					salteo los primeros 3 pixeles
		ciclo2:
			movdqu xmm1, [rdi];			xmm0 = [p1|p2|p3|p4]
			cmp r12, r14;				r12 = (w - i) < bw ?? donde i es la cantidad de columnas recorridas
			jg continuar;
			cmp rcx, r15;				rcx = (h-j) > bh ?? donde j es la cantidad de filas recorridas 
			jg continuar;
		blit:
			movdqu xmm0, [r13];			xmm0 = [PixBlit1|PixBlit2|PixBlit3|PixBlit4]
			movdqu xmm3, xmm5;
			pand xmm3, xmm0; 			xmm3 = [{0,0,0,alpha},{0,0,0,alpha},...]
			por xmm3, xmm4;				xmm3 = [{255,0,255,alpha},{255,0,255,alpha},...] alpha es de PixBlit_j
			movdqu xmm2, xmm0;			xmm2 = xmm0
			pcmpeqd xmm0, xmm3;			pone en xmm0 0 o 1 en la pos de los pix que son iguales a los de xmm3
			blendvps xmm2, xmm1;
			movdqu [rsi], xmm2;
			add r13, 16;				avanzo el puntero de blit 4 pixeles
			add rdi, 16;
			add rsi, 16;
			sub r12, 4;
			cmp r12, r10;
			jg ciclo2;
			jl fin;
			sub r13, r11;				;retrocedo 3 pixeles para copiar el ultimo elemento de cada fila
			sub rdi, r11;				;retrocedo 3 pixeles para copiar el ultimo elemento de cada fila
			sub rsi, r11;				; "     "          "		"	"
			movdqu xmm1, [rdi]
			jmp blit;

		continuar:
			movdqu [rsi], xmm1;
			add rdi, 16;
			add rsi, 16;
			sub r12, 4;
			cmp r12, r10;					(w - i) > (bw mod 4) 
			jg ciclo2;
			sub rdi, r11;					;retrocedo 3 pixeles para copiar el ultimo elemento de cada fila
			sub rsi, r11;					; "     "          "		"	"
			movdqu xmm1, [rdi];
			movdqu [rsi], xmm1;
			add rdi, 16;
			add rsi, 16;
		fin:			
			dec rcx;
			cmp rcx, 0;
			jg ciclo1;						resta 1 a rcx, donde rcx = h. Luego el ciclo1 termina cuando h = 0.
	pop rbp
	ret
