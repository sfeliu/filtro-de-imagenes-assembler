import subprocess as sub
import sys

caso_loop_unroll = sys.argv[1]

################################################################################

#CORRE LOS EXPERIMENTOS PARA LOOP UNROLL CON IMAGENES VarXY EN ASM
f = open('txt_result/TimeMonoLoopUnroll_nop_caso_' + caso_loop_unroll  + '.txt', 'w')
f.write('Tiempos' + '\n')
# 14.bmp es la imagen con 2048x2048 bytes
imagen = '../exp/img/VarXY/19.bmp'
time = 0;
for j in range(0, 10):
    p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'asm', '-t', '100', imagen], stderr=sub.PIPE)
    output, errors = p.communicate()
    time = time + float(errors)
f.write(str(time/10) + '\n')
f.close()
