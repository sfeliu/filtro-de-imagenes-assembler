; void ondas_asm (
; 	unsigned char *src,
; 	unsigned char *dst,
; 	int width,
; 	int height,
; 	int src_row_size,
;   int dst_row_size,
;	int x0,
;	int y0
; );

; Parámetros:
; 	rdi = src
; 	rsi = dst
; 	rdx = width
; 	rcx = height
; 	r8 = src_row_size
; 	r9 = dst_row_size
;   rbp + 16 = x0
; 	rbp + 24 = y0

section .data

radius: times 4 DD 35.0
pi: times 4 DD 3.1415
wavelength: times 4 DD 64.0
trainwidth: times 4 DD 3.4
cte1: times 4 DD 1.0
cte2: times 4 DD 2.0
cte6: times 4 DD 6.0
cte120: times 4 DD 120.0				;se puede multiplicar una mascara por un inmediato?? me sive porque 6*20=120
cte5040: times 4 DD 5040.0				;5040 = 6*840
mask: DB 0x00, 0x00, 0x00, 0x80, 0x01, 0x01, 0x01, 0x80, 0x02, 0x02, 0x02, 0x80, 0x03, 0x03, 0x03, 0x80
radius2: times 2 DQ 35.0
pi2: times 2 DQ 3.1415
wavelength2: times 2 DQ 64.0
trainwidth2: times 2 DQ 3.4
cte12: times 2 DQ 1.0
cte22: times 2 DQ 2.0
cte62: times 2 DQ 6.0
cte1202: times 2 DQ 120.0				;se puede multiplicar una mascara por un inmediato?? me sive porque 6*20=120
cte50402: times 2 DQ 5040.0				;5040 = 6*840

global ondas_asm

section .text

ondas_asm:
	push rbp
	mov rbp, rsp
	xor rax, rax;
	xor r10, r10;
	dec rcx;
	dec rdx;
	mov r12, [rbp +16]
	mov r13, [rbp +24]

	.ciclo:
		movups xmm0, [rdi]				;xmm0 = [{r1,g1,b1,a1} = P_{x,y} , {r2,g2,b2,a2} = P_{x+1,y} , ...]
 
		pinsrd xmm1, eax, 0				;xmm1 = [x | * | * | *], donde x es el indice de ancho del primer pixel de xmm0
		pinsrd xmm2, r10d, 0			;xmm2 = [y | * | * | *], donde y es el indice de ancho del primer pixel de xmm0
		pinsrd xmm3, r12d, 0			;xmm3 = [x0 | * | * | *]
		pinsrd xmm4, r13d, 0 			;xmm4 = [y0 | * | * | *]
		inc eax;
		pinsrd xmm1, eax, 1				;xmm1 = [x | x-1 | * | *]
		pinsrd xmm2, r10d, 1			;xmm2 = [y | y | * | *]
		pinsrd xmm3, r12d, 1			;xmm3 = [x0 | x0 | * | *]
		pinsrd xmm4, r13d, 1 			;xmm4 = [y0 | y0 | * | *]
		inc eax;	
		pinsrd xmm1, eax, 2				;xmm1 = [x | x-1 | x-2 | *]
		pinsrd xmm2, r10d, 2			;xmm2 = [y | y | y | *]
		pinsrd xmm3, r12d, 2			;xmm3 = [x0 | x0 | x0 | *]
		pinsrd xmm4, r13d, 2 			;xmm4 = [y0 | y0 | y0 | *]
		inc eax;	
		pinsrd xmm1, eax, 3				;xmm1 = [x | x-1 | x-2 | x-3]
		pinsrd xmm2, r10d, 3			;xmm2 = [y | y | y | y]
		pinsrd xmm3, r12d, 3			;xmm3 = [x0 | x0 | x0 | x0]
		pinsrd xmm4, r13d, 3 			;xmm4 = [y0 | y0 | y0 | y0]
		inc eax;						

		psubd xmm1, xmm3;				;xmm1 = [(x)-x0 = d_x | (x+1)-x0 | (x+2)-x0 | (x+3)-x0]
		psubd xmm2, xmm4				;xmm2 = [(y)-y0 = d_y | (y+1)-y0 | (y+2)-y0 | (y+3)-y0]

		pmulld xmm1, xmm1				;xmm1 = [(d_x)^2 | (d_{x+1})^2 | (d_{x+2})^2 | (d_{x+3})^2]
		pmulld xmm2, xmm2				;xmm2 = [(d_y)^2 | (d_{y+1})^2 | (d_{y+2})^2 | (d_{y+3})^2] 

		paddd xmm1, xmm2				;xmm5 = [(d_x)^2 +(d_y)^2 | (d_{x+1})^2 + (d_{y+1})^2 | ...]

		cvtdq2ps xmm1, xmm1				;convierto de int a single-precision float

		cvtps2pd xmm3, xmm1				;convierto de single-precision float a double-precision float
		psrldq xmm1, 8
		cvtps2pd xmm4, xmm1				;convierto de single-precision float a double-precision float

		sqrtpd xmm3, xmm3				;xmm5 = [d_{x,y} = sqrt((d_x)^2+(d_y)^2) | ...]
		sqrtpd xmm4, xmm4				;xmm5 = [d_{x,y} = sqrt((d_x)^2+(d_y)^2) | ...]

		movdqu xmm1, [radius2]
		movdqu xmm2, [pi2]
		movdqu xmm5, [wavelength2]
		movdqu xmm6, [trainwidth2]

		subpd xmm3, xmm1;
		subpd xmm4, xmm1;
		divpd xmm3, xmm5
		divpd xmm4, xmm5


		;cual es la diferencia entre mulps y pmuldq ?? creo que pmuldq es para double-precision floats 

		movdqu xmm7, xmm3
		movdqu xmm8, xmm4
		divpd xmm7, xmm6				;xmm6 = [r1/trainwidth | r2/trainwidth |...]
		divpd xmm8, xmm6				;xmm6 = [r1/trainwidth | r2/trainwidth |...]
		mulpd xmm7, xmm7 				;xmm6 = [(r1/trainwidth)^2 | (r2/trainwidth)^2 | ...]
		mulpd xmm8, xmm8 				;xmm6 = [(r1/trainwidth)^2 | (r2/trainwidth)^2 | ...]
		movdqu xmm6, [cte12]
		movdqu xmm1, [cte12]
		addpd xmm7, xmm6				;xmm6 = [(r1/trainwidth)^2 + 1 | (r2/trainwidth)^2 + 1 | ...]
		addpd xmm8, xmm1				;xmm6 = [(r1/trainwidth)^2 + 1 | (r2/trainwidth)^2 + 1 | ...]
		divpd xmm6, xmm7				;xmm4 = [1 / ((r1/trainwidth)^2 +1) | 1 / ((r2/trainwidth)^2 +1) | ...]
		divpd xmm1, xmm8				;xmm4 = [1 / ((r1/trainwidth)^2 +1) | 1 / ((r2/trainwidth)^2 +1) | ...]

		cvttpd2dq xmm7, xmm3				;xmm2 = [floor((d_xy - radius / wavelength)) | ... ]
		cvtdq2pd xmm7, xmm7				;convert xmm7 de int a float
		cvttpd2dq xmm8, xmm4				;xmm2 = [floor((d_xy - radius / wavelength)) | ... ]
		cvtdq2pd xmm8, xmm8				;convert xmm7 de int a float
		subpd xmm3, xmm7				;xmm5 = [(d_xy - radius / wavelength) - floor(d_xy - radius / wavelength) | ... ]
		subpd xmm4, xmm8				;xmm5 = [(d_xy - radius / wavelength) - floor(d_xy - radius / wavelength) | ... ]
		movups xmm7, [cte22] 
		movups xmm8, [cte22]
		mulpd xmm3, xmm7;
		mulpd xmm4, xmm8;
		mulpd xmm3, xmm2;
		mulpd xmm4, xmm2;
		subpd xmm3, xmm2;
		subpd xmm4, xmm2;


		;Empezando aca calculo (t - (t^2)/6 + (t^5)/120 - (t^7)/5040)
		movdqu xmm7 , [cte62]

		movdqu xmm2, xmm3
		movdqu xmm5, xmm4
		movdqu xmm8, xmm3
		movdqu xmm9, xmm4
		mulpd xmm2, xmm2
		mulpd xmm2, xmm3
		mulpd xmm5, xmm5
		mulpd xmm5, xmm4
		divpd xmm2, xmm7;
		divpd xmm5, xmm7;

		subpd xmm8, xmm2
		subpd xmm9, xmm5

		movdqu xmm7, [cte1202]

		movdqu xmm2, xmm3
		movdqu xmm5, xmm4
		mulpd xmm2, xmm2
		mulpd xmm2, xmm2
		mulpd xmm2, xmm3
		mulpd xmm5, xmm5
		mulpd xmm5, xmm5
		mulpd xmm5, xmm4
		divpd xmm2, xmm7;
		divpd xmm5, xmm7;

		addpd xmm8, xmm2
		addpd xmm9, xmm5

		movdqu xmm7, [cte50402]

		movdqu xmm2, xmm3
		movdqu xmm5, xmm4
		mulpd xmm2, xmm2
		mulpd xmm2, xmm2
		mulpd xmm2, xmm3
		mulpd xmm2, xmm3
		mulpd xmm2, xmm3
		mulpd xmm5, xmm5
		mulpd xmm5, xmm5
		mulpd xmm5, xmm4
		mulpd xmm5, xmm4
		mulpd xmm5, xmm4
		divpd xmm2, xmm7;
		divpd xmm5, xmm7;

		subpd xmm8, xmm2;
		subpd xmm9, xmm5;

		mulpd xmm8, xmm6;
		mulpd xmm9, xmm1;
		movdqu xmm2, [wavelength2]
		mulpd xmm8, xmm2
		mulpd xmm9, xmm2

		cvtpd2ps xmm8, xmm8
		cvttps2dq xmm8,xmm8;
		cvtpd2ps xmm9, xmm9
		cvttps2dq xmm9,xmm9;

		pslldq xmm9, 8
		paddd xmm8, xmm9
		movdqu xmm4, xmm8
		packusdw xmm4, xmm4				;xmm6 = [prof1|prof2|prof3|prof4|prof1|prof2|prof3|prof4]
		packuswb xmm4, xmm4				;xmm6 = [prof1|prof2|prof3|prof4|prof1|prof2|prof3|prof4| ...]

		movups xmm3, [mask]
		pshufb xmm4, xmm3				;xmm6 = [prof1|prof1|prof1|0|prof2|prof2|prof2|0|porf3 ...]

		paddusb xmm4, xmm0				;xmm6 = [saturate((prof1)*64 + src[x][y]) | saturate((prof2)*64 + src[x+1][y]) | ...]

		movups [rsi], xmm4				;dest[0..15] = xmm4

		add rsi, 16
		add rdi, 16

		cmp rax, rdx
		jl .ciclo
		cmp r10, rcx
		je .fin
		xor rax, rax
		mov rax,1;
		inc r10
		jmp .ciclo
		
	.fin:
		pop rbp
		ret
