import subprocess as sub


################################################################################

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarXY EN ASM
f = open('txt_result/TimeTempASM_XY.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'temperature', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarX EN ASM
f = open('txt_result/TimeTempASM_X.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarX/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'temperature', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarY EN ASM
f = open('txt_result/TimeTempASM_Y.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'temperature', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarXY_const EN ASM
f = open('txt_result/TimeTempASM_XYconst.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY_const/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'temperature', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()


################################################################################

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarXY EN C
f = open('txt_result/TimeTempC_XY.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'temperature', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarX EN C
f = open('txt_result/TimeTempC_X.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarX/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'temperature', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarY EN C
f = open('txt_result/TimeTempC_Y.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'temperature', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA TEMPERATURE CON IMAGENES VarXY_const EN C
f = open('txt_result/TimeTempC_XYconst.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY_const/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'temperature', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()