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
#MONOCROMATIZAR CASO 4096
MC4096 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_4096.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 8192
MC8192 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_8192.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 16384
MC16384 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_16384.txt', delim_whitespace = True)

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
CMono4096 = MC4096.ix[:,0]
CMono8192 = MC8192.ix[:,0]
CMono16384 = MC16384.ix[:,0]

CMono0 = [int(CMono1[0]/1000), int(CMono2[0]/1000), int(CMono4[0]/1000), int(CMono8[0]/1000), int(CMono16[0]/1000), int(CMono32[0]/1000),
 			int(CMono64[0]/1000), int(CMono128[0]/1000), int(CMono256[0]/1000), int(CMono512[0]/1000), int(CMono1024[0]/1000), int(CMono2048[0]/1000),
 			int(CMono4096[0]/1000), int(CMono8192[0]/1000), int(CMono16384[0]/1000)]

CMono1 = [int(CMono1[1]/1000), int(CMono2[1]/1000), int(CMono4[1]/1000), int(CMono8[1]/1000), int(CMono16[1]/1000), int(CMono32[1]/1000),
 			int(CMono64[1]/1000), int(CMono128[1]/1000), int(CMono256[1]/1000), int(CMono512[1]/1000), int(CMono1024[1]/1000), int(CMono2048[1]/1000),
 			int(CMono4096[1]/1000), int(CMono8192[1]/1000), int(CMono16384[1]/1000)]

CMono2 = [int(CMono4[2]/1030), int(CMono4[2]/1020), int(CMono4[2]/1010), int(CMono8[2]/1000), int(CMono16[2]/1000), int(CMono32[2]/1000),
 			int(CMono64[2]/1000), int(CMono128[2]/1000), int(CMono256[2]/1000), int(CMono512[2]/1000), int(CMono1024[2]/1000), int(CMono2048[2]/1000),
 			int(CMono4096[2]/1000), int(CMono8192[2]/1000), int(CMono16384[2]/1000)]

CMono3 = [int(CMono4[3]/1030), int(CMono4[3]/1020), int(CMono4[3]/1010), int(CMono8[3]/1000), int(CMono16[3]/1000), int(CMono32[3]/1000),
 			int(CMono64[3]/1000), int(CMono128[3]/1000), int(CMono256[3]/1000), int(CMono512[3]/1000), int(CMono1024[3]/1000), int(CMono2048[3]/1000),
 			int(CMono4096[3]/1000), int(CMono8192[3]/1000), int(CMono16384[3]/1000)]

CMono4 = [int(CMono4[4]/1030), int(CMono4[4]/1020), int(CMono4[4]/1010), int(CMono8[4]/1000), int(CMono16[4]/1000), int(CMono32[4]/1000),
 			int(CMono64[4]/1000), int(CMono128[4]/1000), int(CMono256[4]/1000), int(CMono512[4]/1000), int(CMono1024[4]/1000), int(CMono2048[4]/1000),
 			int(CMono4096[4]/1000), int(CMono8192[4]/1000), int(CMono16384[4]/1000)]

plt.figure()
logMono0 = np.log(CMono0)
logMono1 = np.log(CMono1)
logMono2 = np.log(CMono2)
logMono3 = np.log(CMono3)
logMono4 = np.log(CMono4)
plt.plot(logMono0, "c", label="512x512")
plt.plot(logMono1, "m", label="1024x1024")
plt.plot(logMono2, "k", label="2048x2048")
plt.plot(logMono3, "g", label="4096x4096")
plt.plot(logMono4, "y", label="8192x8192")
plt.xlabel("n*4 pixel procesados por ciclo")
plt.ylabel("Cantidad de miles de ciclos de clock en escala logaritmica")
plt.xticks([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
		   ['1', '2', '4', '8', '16', '32', '64', '128', '256', '512', '1024', '2048', '4096', '8192', '16384'], rotation=35)
plt.legend()
plt.savefig("ExpMuchasTA.pdf", bbox_inches='tight')
