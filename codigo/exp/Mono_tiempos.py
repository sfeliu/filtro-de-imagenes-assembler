import subprocess as sub


################################################################################

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarXY EN ASM
f = open('txt_result/TimeMonoASM_XY.txt', 'w')
f.write('Tiempos Min Max' + '\n')
for i in range(1, 21):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	time = 0;
	min = None
	max = None
	for j in range(0, 25):
		p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'asm', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		errors = float(errors)
		time = time + errors
		if min == None:
			min = errors
		elif min > errors:
			min = errors
		if max == None:
			max = errors
		elif max < errors:
			max = errors
	f.write(str(time/25) + " " + str(min) + " " + str(max) + '\n')
f.close()

################################################################################

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarXY EN C
f = open('txt_result/TimeMonoC_XY.txt', 'w')
f.write('Tiempos Min Max' + '\n')
for i in range(1, 21):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	time = 0;
	min = None
	max = None
	for j in range(0, 25):
		p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'c', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		errors = float(errors)
		time = time + errors
		if min == None:
			min = errors
		elif min > errors:
			min = errors
		if max == None:
			max = errors
		elif max < errors:
			max = errors
	f.write(str(time/25) + " " + str(min) + " " + str(max) + '\n')
f.close()

################################################################################

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarXY EN C en O3
f = open('txt_result/TimeMonoC3_XY.txt', 'w')
f.write('Tiempos Min Max' + '\n')
for i in range(1, 21):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	time = 0;
	min = None
	max = None
	for j in range(0, 25):
		p = sub.Popen(['./../build/tp2O3', 'monocromatizar_inf', '-i', 'c', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		errors = float(errors)
		time = time + errors
		if min == None:
			min = errors
		elif min > errors:
			min = errors
		if max == None:
			max = errors
		elif max < errors:
			max = errors
	f.write(str(time/25) + " " + str(min) + " " + str(max) + '\n')
f.close()

#BORRO TODAS LAS IMAGES QUE SE GENERARARON
p = sub.Popen(['make'])
