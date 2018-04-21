import subprocess as sub


################################################################################

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarXY EN ASM
f = open('txt_result/TimeMonoASM_XY.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarX EN ASM
f = open('txt_result/TimeMonoASM_X.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarX/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarY EN ASM
f = open('txt_result/TimeMonoASM_Y.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarXY_const EN ASM
f = open('txt_result/TimeMonoASM_XYconst.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY_const/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()


################################################################################

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarXY EN C
f = open('txt_result/TimeMonoC_XY.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarX EN C
f = open('txt_result/TimeMonoC_X.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarX/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarY EN C
f = open('txt_result/TimeMonoC_Y.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA MONOCROMATICO CON IMAGENES VarXY_const EN C
f = open('txt_result/TimeMonoC_XYconst.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY_const/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'monocromatizar_inf', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()