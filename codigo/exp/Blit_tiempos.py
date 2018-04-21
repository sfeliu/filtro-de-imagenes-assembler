import subprocess as sub


################################################################################

#CORRE LOS EXPERIMENTOS PARA BLIT CON IMAGENES VarXY EN ASM
f = open('txt_result/TimeBlitASM_XY.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'blit', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA BLIT CON IMAGENES VarX EN ASM
f = open('txt_result/TimeBlitASM_X.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarX/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'blit', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA BLIT CON IMAGENES VarY EN ASM
f = open('txt_result/TimeBlitASM_Y.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'blit', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA BLIT CON IMAGENES VarXY_const EN ASM
f = open('txt_result/TimeBlitASM_XYconst.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY_const/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'blit', '-i', 'asm', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()


################################################################################

#CORRE LOS EXPERIMENTOS PARA BLIT CON IMAGENES VarXY EN C
f = open('txt_result/TimeBlitC_XY.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'blit', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA BLIT CON IMAGENES VarX EN C
f = open('txt_result/TimeBlitC_X.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarX/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'blit', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA BLIT CON IMAGENES VarY EN C
f = open('txt_result/TimeBlitC_Y.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarY/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'blit', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()

#CORRE LOS EXPERIMENTOS PARA BLIT CON IMAGENES VarXY_const EN C
f = open('txt_result/TimeBlitC_XYconst.txt', 'w')
for i in range(1, 51):
	imagen = '../exp/img/VarXY_const/' + str(i) + '.bmp'
	p = sub.Popen(['./../build/tp2', 'blit', '-i', 'c', imagen], stderr=sub.PIPE)
	output, errors = p.communicate()
	f.write(str(int(errors)) + '\n')
f.close()