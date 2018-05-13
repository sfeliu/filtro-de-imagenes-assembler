import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
################################################################################
#IMPORTO TODOS LOS ARCHIVOS.####################################################

#MONOCROMATIZAR CASO ORIGINAL (1)
MC1 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_1.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 2
MC2 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_2.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 4
MC4 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_4.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 8
MC8 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_8.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 16
MC16 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_16.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 32
MC32 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_32.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 64
MC64 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_64.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 128
MC128 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_128.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 256
MC256 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_256.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 512
MC512 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_512.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 1024
MC1024 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_1024.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 2048
MC2048 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_2048.txt', delim_whitespace = True)

################################################################################
#Monocromatizar#################################################################

CMono1 = MC1.ix[:,0]
CMono2 = MC2.ix[:,0]
CMono4 = MC4.ix[:,0]
CMono8 = MC8.ix[:,0]
CMono16 = MC16.ix[:,0]
CMono32 = MC32.ix[:,0]
CMono64 = MC64.ix[:,0]
CMono128 = MC128.ix[:,0]
CMono256 = MC256.ix[:,0]
CMono512 = MC512.ix[:,0]
CMono1024 = MC1024.ix[:,0]
CMono2048 = MC2048.ix[:,0]

CMono = [int(CMono1/1000), int(CMono2/1000), int(CMono4/1000), int(CMono8/1000), int(CMono16/1000), int(CMono32/1000),
 			int(CMono64/1000), int(CMono128/1000), int(CMono256/1000), int(CMono512/1000), int(CMono1024/1000), int(CMono2048/1000)]

fig = plt.figure()
x = range(0, len(CMono))
plt.bar(x, CMono)
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Cantidad de miles de ciclos de clock")
plt.xticks([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
		   ['1', '2', '4', '8', '16', '32', '64', '128', '256', '512', '1024', '2048'])
plt.savefig("Exp_MonoXY.png")
