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

plt.figure()
CMono1 = np.log(CMono1)
CMono2 = np.log(CMono2)
CMono4 = np.log(CMono4)
CMono8 = np.log(CMono8)
CMono16 = np.log(CMono16)
CMono32 = np.log(CMono32)
CMono64 = np.log(CMono64)
CMono128 = np.log(CMono128)
CMono256 = np.log(CMono256)
CMono512 = np.log(CMono512)
CMono1024 = np.log(CMono1024)
plt.plot(AMonoXY, "c", label="Monocromatizar implementado en ASM")
plt.plot(CMonoXY, "m", label="Monocromatizar implementado en C")
plt.plot(C3MonoXY, "k", label="Monocromatizar implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Cantidad de ciclos de clock en escala logaritmica")
plt.legend()
plt.savefig("Exp_MonoXY.png")
