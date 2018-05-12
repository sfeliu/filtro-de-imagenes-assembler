import subprocess as sub
import sys

caso_loop_unroll = sys.argv[1]

################################################################################

#CORRE LOS EXPERIMENTOS PARA LOOP UNROLL CON IMAGENES VarXY EN ASM
f = open('txt_result/TimeMonoLoopUnroll_caso_' + caso_loop_unroll  + '.txt', 'w')
f.write('Tiempos' + '\n')
# 14.bmp es la imagen con 512x512 bytes
	imagen = '../exp/img/VarXY/14.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'asm', '-t', '5', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + float(errors)
	f.write(str(time/5) + '\n')
f.close()