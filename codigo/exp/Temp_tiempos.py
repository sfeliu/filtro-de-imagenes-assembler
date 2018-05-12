import subprocess as sub


################################################################################

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarXY EN ASM
f = open('txt_result/TimeTempASM_XY.txt', 'w')
f.write('Tiempos' + '\n')
for i in range(1, 21):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'temperature', '-i', 'asm', '-t', '5', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + float(errors)
	f.write(str(time/5) + '\n')
f.close()

################################################################################

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarXY EN C
f = open('txt_result/TimeTempC_XY.txt', 'w')
f.write('Tiempos' + '\n')
for i in range(1, 21):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'temperature', '-i', 'c', '-t', '5', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + float(errors)
	f.write(str(time/5) + '\n')
f.close()

################################################################################

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarXY EN C en O3
f = open('txt_result/TimeTempC3_XY.txt', 'w')
f.write('Tiempos' + '\n')
for i in range(1, 21):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2O3', 'temperature', '-i', 'c', '-t', '5', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + float(errors)
	f.write(str(time/5) + '\n')
f.close()

#BORRO TODAS LAS IMAGES QUE SE GENERARARON
p = sub.Popen(['make'])
