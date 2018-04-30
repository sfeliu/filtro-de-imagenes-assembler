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
	pxor xmm0, xmm0;

	.ciclo:
		movdqu xmm0, [rdi]				;xmm0 = [{r1,g1,b1,a1} = P_{x,y} , {r2,g2,b2,a2} = P_{x+1,y} , ...]
 
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

		psubd xmm1, xmm3				;xmm1 = [(x)-x0 = d_x | (x+1)-x0 | (x+2)-x0 | (x+3)-x0]
		psubd xmm2, xmm4				;xmm2 = [(y)-y0 = d_y | (y+1)-y0 | (y+2)-y0 | (y+3)-y0]

		pmulld xmm1, xmm1				;xmm1 = [(d_x)^2 | (d_{x+1})^2 | (d_{x+2})^2 | (d_{x+3})^2]
		pmulld xmm2, xmm2				;xmm2 = [(d_y)^2 | (d_{y+1})^2 | (d_{y+2})^2 | (d_{y+3})^2] 

		paddd xmm1, xmm2				;xmm5 = [(d_x)^2 +(d_y)^2 | (d_{x+1})^2 + (d_{y+1})^2 | ...]
		cvtdq2ps xmm1, xmm1
		sqrtps xmm1, xmm1				;xmm5 = [d_{x,y} = sqrt((d_x)^2+(d_y)^2) | ...]

		movups xmm2, [radius]
		movups xmm3, [pi]
		movups xmm4, [wavelength]
		movups xmm5, [trainwidth]

		subps xmm1, xmm2				;xmm5 = [(d_{x,y} - radius) | (d_{x+1,y+1}-radius) | ...]
		divps xmm1, xmm4				;xmm5 = [(d_{x,y} - radius / wavelength) | (d_{x+1,y}-radius /wavelength) | ...]


		;cual es la diferencia entre mulps y pmuldq ?? creo que pmuldq es para double-precision floats 

		movups xmm6, xmm1				;xmm6 = xmm1 = [r1|r2|r3|r4]
		divps xmm6, xmm5				;xmm6 = [r1/trainwidth | r2/trainwidth |...]
		mulps xmm6, xmm6 				;xmm6 = [(r1/trainwidth)^2 | (r2/trainwidth)^2 | ...]
		movups xmm5, [cte1]
		addps xmm6, xmm5				;xmm6 = [(r1/trainwidth)^2 + 1 | (r2/trainwidth)^2 + 1 | ...]
		divps xmm5, xmm6				;xmm4 = [1 / ((r1/trainwidth)^2 +1) | 1 / ((r2/trainwidth)^2 +1) | ...]

		;cvttps2dq xmm7, xmm1			;xmm2 = [floor((d_xy - radius / wavelength)) | ... ]
		roundps xmm7, xmm1, 1
		;cvtdq2ps xmm7, xmm7
		subps xmm1, xmm7				;xmm5 = [(d_xy - radius / wavelength) - floor(d_xy - radius / wavelength) | ... ]
		movups xmm4, [cte2] 
		mulps xmm1, xmm4				;xmm5 = [(r1-floor(r1))*2 | (r2 - floor(r2))*2 | ...]
		mulps xmm1, xmm3				;xmm5 = [(r1-floor(r1))*2*pi | (r2 - floor(r2))*2*pi | ...]
		subps xmm1, xmm3				;xmm5 = [(r1-floor(r1))*2*pi - pi | (r2 - floor(r2))*2*pi - pi | ...]


		;Empezando aca calculo (t - (t^2)/6 + (t^5)/120 - (t^7)/5040)
		movups xmm3, [cte6] 			;xmm3 = [6|6|6|6]

		movups xmm2, xmm1				;xmm1 = [t1 | t2 | t3 | t4]
		movups xmm4, xmm1				;xmm2 = [t1 | t2 | t3 | t4]
		mulps xmm2, xmm2				;xmm2 = [(t1)^2 | (t2)^2 | (t3)^2 | (t4)^2]
		mulps xmm2, xmm1				;xmm2 = [(t1)^3 | (t2)^3 | (t3)^3 | (t4)^3]
		divps xmm2, xmm3				;xmm2 = [ ((t1)^3)/6 | ((t2)^3)/6 | ((t3)^3)/6 | ((t4)^3)/6]

		subps xmm4, xmm2				;xmm5 = [t1 - ((t1)^3)/6 | ... ]
		
		movups xmm3, [cte120]			;xmm3 = [120|120|120|120]

		movups xmm2, xmm1				;xmm1 = [t1 | t2 | t3 | t4]
		mulps xmm2, xmm2				;xmm2 = [(t1)^2 | (t2)^2 | (t3)^2 | (t4)^2]---------
		mulps xmm2, xmm2				;xmm2 = [(t1)^4 | (t2)^4 | (t3)^4 | (t4)^4]---------
		mulps xmm2, xmm1				;xmm2 = [(t1)^5 | (t2)^5 | (t3)^5 | (t4)^5]---------------
		divps xmm2, xmm3				;xmm2 = [((t1)^5)/120 | ((t2)^5)/120 | ((t3)^5)/120 | ((t4)^5)/120]

		addps xmm4, xmm2				;xmm5 = [t1 - ((t1)^3)/6 + ((t1)^5)/120 | ... ]

		movups xmm3, [cte5040]			;xmm3 = [5040|5040|5040|5040]

		movups xmm2, xmm1				;xmm1 = [t1 | t2 | t3 | t4]
		mulps xmm2, xmm2				;xmm2 = [(t1)^2 | (t2)^2 | (t3)^2 | (t4)^2]
		mulps xmm2, xmm2				;xmm2 = [(t1)^4 | (t2)^4 | (t3)^4 | (t4)^4]
		mulps xmm2, xmm1				;xmm2 = [(t1)^5 | (t2)^5 | (t3)^5 | (t4)^5]
		mulps xmm2, xmm1				;xmm2 = [(t1)^6 | (t2)^6 | (t3)^6 | (t4)^6]
		mulps xmm2, xmm1				;xmm2 = [(t1)^7 | (t2)^7 | (t3)^7 | (t4)^7]
		divps xmm2, xmm3				;xmm2 = [((t1)^7)/5040 | ((t2)^7)/5040 |((t3)^7)/5040 |((t4)^7)/5040]
		subps xmm4, xmm2				;xmm5 = [t1 - ((t1)^3)/6 + ((t1)^5)/120 - ((t1)^7)/5040  | ... ]

		mulps xmm4, xmm5				;xmm6 = [prof1|prof2|prof3|prof4]
		movups xmm2, [wavelength]		;xmm2 = [64|64|64|64]
		mulps xmm4, xmm2				;xmm6 = [(prof1)*64|(prof2)*64| ...]

		roundps xmm4, xmm4 ,1
		cvtps2dq xmm4, xmm4			;cual es la diferencia entre cvttps2qs y roundps ???????????????????????????

		packusdw xmm4, xmm4				;xmm6 = [prof1|prof2|prof3|prof4|prof1|prof2|prof3|prof4]
		packuswb xmm4, xmm4				;xmm6 = [prof1|prof2|prof3|prof4|prof1|prof2|prof3|prof4| ...]

		movdqu xmm3, [mask]
		pshufb xmm4, xmm3				;xmm6 = [prof1|prof1|prof1|0|prof2|prof2|prof2|0|porf3 ...]

		paddusb xmm4, xmm0				;xmm6 = [saturate((prof1)*64 + src[x][y]) | saturate((prof2)*64 + src[x+1][y]) | ...]

		movdqu [rsi], xmm4				;dest[0..15] = xmm4

		add rsi, 16
		add rdi, 16

		cmp rax, rdx
		jl .ciclo
		cmp r10, rcx
		je .fin
		xor rax, rax
		inc r10
		jmp .ciclo
		
	.fin:
		pop rbp
		ret
