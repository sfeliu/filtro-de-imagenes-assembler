import subprocess as sub


################################################################################

#CORRE LOS EXPERIMENTOS PARA ONDAS CON IMAGENES VarXY EN ASM
f = open('txt_result/TimeOndasASM_XY.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'ondas', '-i', 'asm', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + int(errors)
	f.write(str(time/5) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA ONDAS CON IMAGENES VarX EN ASM
f = open('txt_result/TimeOndasASM_X.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarX/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'ondas', '-i', 'asm', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + int(errors)
	f.write(str(time/5) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA ONDAS CON IMAGENES VarY EN ASM
f = open('txt_result/TimeOndasASM_Y.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarY/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'ondas', '-i', 'asm', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + int(errors)
	f.write(str(time/5) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA ONDAS CON IMAGENES VarXY_const EN ASM
f = open('txt_result/TimeOndasASM_XYconst.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY_const/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'ondas', '-i', 'asm', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + int(errors)
	f.write(str(time/5) + '\n')
f.close()


################################################################################

#CORRE LOS EXPERIMENTOS PARA ONDAS CON IMAGENES VarXY EN C
f = open('txt_result/TimeOndasC_XY.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'ondas', '-i', 'c', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + int(errors)
	f.write(str(time/5) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA ONDAS CON IMAGENES VarX EN C
f = open('txt_result/TimeOndasC_X.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarX/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'ondas', '-i', 'c', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + int(errors)
	f.write(str(time/5) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA ONDAS CON IMAGENES VarY EN C
f = open('txt_result/TimeOndasC_Y.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarY/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'ondas', '-i', 'c', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + int(errors)
	f.write(str(time/5) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA ONDAS CON IMAGENES VarXY_const EN C
f = open('txt_result/TimeOndasC_XYconst.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY_const/' + str(i) + '.bmp'
	time = 0;
	for j in range(0, 5):
		p = sub.Popen(['./../build/tp2', 'ondas', '-i', 'c', imagen], stderr=sub.PIPE)
		output, errors = p.communicate()
		time = time + int(errors)
	f.write(str(time/5) + '\n')
f.close()

#BORRO TODAS LAS IMAGES QUE SE GENERARARON
p = sub.Popen(['make'])
