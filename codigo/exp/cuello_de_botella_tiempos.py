import subprocess as sub
import sys
import re

total = 20

################################################################################

#CORRE LOS EXPERIMENTOS PARA LOOP UNROLL CON IMAGENES VarXY EN ASM
f = open('txt_result/TimeMonoCuello.txt', 'w')
f.write('Tiempo extra, Tiempo memoria, Tiempo procesamiento ' + '\n')
# 14.bmp es la imagen con 512x512 bytes
imagen = '../img/lena32.bmp'
time = 0;
memory_clocks = 0
process_clocks = 0
total_clocks = 0
for j in range(0, total):
    p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'asm', imagen], stdout=sub.PIPE, stderr=sub.PIPE)
    output, errors = p.communicate()
    memory_clocks += int(re.search(r'El programa tardo (\d*) ciclos de clock buscando en memoria', str(output)).group(1))
    process_clocks += int(re.search(r'El programa tardo (\d*) ciclos de clock procesando datos', str(output)).group(1))
    total_clocks += int(float(errors))
#f.write(str(time/10) + '\n')
memory_clocks = memory_clocks/total
process_clocks = process_clocks/total
total_clocks = total_clocks/total

f.write(str(int(total_clocks)) + ' ' + str(int(memory_clocks)) + ' ' + str(int(process_clocks)) + '\n')
f.close()
