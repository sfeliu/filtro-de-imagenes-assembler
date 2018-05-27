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
#MONOCROMATIZAR CASO 32768
MC32768 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_32768.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 65536
MC65536 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_65536.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 131072
MC131072 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_131072.txt', delim_whitespace = True)
#MONOCROMATIZAR CASO 262144
MC262144 = pd.read_csv('txt_result/TimeMonoLoopUnroll_caso_262144.txt', delim_whitespace = True)

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
CMono32768 = MC32768.ix[:,0]
CMono65536 = MC65536.ix[:,0]
CMono131072 = MC131072.ix[:,0]
CMono262144 = MC262144.ix[:,0]

CMono0 = [int(CMono1[0]/1000), int(CMono2[0]/1000), int(CMono4[0]/1000), int(CMono8[0]/1000), int(CMono16[0]/1000), int(CMono32[0]/1000),
 			int(CMono64[0]/1000), int(CMono128[0]/1000), int(CMono256[0]/1000), int(CMono512[0]/1000), int(CMono1024[0]/1000), int(CMono2048[0]/1000),
 			int(CMono4096[0]/1000), int(CMono8192[0]/1000), int(CMono16384[0]/1000), int(CMono32768[0]/1000), int(CMono65536[0]/1000),
 			 int(CMono131072[0]/1000), int(CMono262144[0]/1000)]

CMono1 = [int(CMono1[1]/1000), int(CMono2[1]/1000), int(CMono4[1]/1000), int(CMono8[1]/1000), int(CMono16[1]/1000), int(CMono32[1]/1000),
 			int(CMono64[1]/1000), int(CMono128[1]/1000), int(CMono256[1]/1000), int(CMono512[1]/1000), int(CMono1024[1]/1000), int(CMono2048[1]/1000),
 			int(CMono4096[1]/1000), int(CMono8192[1]/1000), int(CMono16384[1]/1000), int(CMono32768[1]/1000), int(CMono65536[1]/1000),
 			 int(CMono131072[1]/1000), int(CMono262144[1]/1000)]

CMono2 = [int(CMono1[2]/1000), int(CMono2[2]/1000), int(CMono4[2]/1000), int(CMono8[2]/1000), int(CMono16[2]/1000), int(CMono32[2]/1000),
 			int(CMono64[2]/1000), int(CMono128[2]/1000), int(CMono256[2]/1000), int(CMono512[2]/1000), int(CMono1024[2]/1000), int(CMono2048[2]/1000),
 			int(CMono4096[2]/1000), int(CMono8192[2]/1000), int(CMono16384[2]/1000), int(CMono32768[2]/1000), int(CMono65536[2]/1000),
 			 int(CMono131072[2]/1000), int(CMono262144[2]/1000)]

CMono3 = [int(CMono1[3]/1000), int(CMono2[3]/1000), int(CMono4[3]/1000), int(CMono8[3]/1000), int(CMono16[3]/1000), int(CMono32[3]/1000),
 			int(CMono64[3]/1000), int(CMono128[3]/1000), int(CMono256[3]/1000), int(CMono512[3]/1000), int(CMono1024[3]/1000), int(CMono2048[3]/1000),
 			int(CMono4096[3]/1000), int(CMono8192[3]/1000), int(CMono16384[3]/1000), int(CMono32768[3]/1000), int(CMono65536[3]/1000),
 			 int(CMono131072[3]/1000), int(CMono262144[3]/1000)]

CMono4 = [int(CMono1[4]/1000), int(CMono2[4]/1000), int(CMono4[4]/1000), int(CMono8[4]/1000), int(CMono16[4]/1000), int(CMono32[4]/1000),
 			int(CMono64[4]/1000), int(CMono128[4]/1000), int(CMono256[4]/1000), int(CMono512[4]/1000), int(CMono1024[4]/1000), int(CMono2048[4]/1000),
 			int(CMono4096[4]/1000), int(CMono8192[4]/1000), int(CMono16384[4]/1000), int(CMono32768[4]/1000), int(CMono65536[4]/1000),
 			 int(CMono131072[4]/1000), int(CMono262144[4]/1000)]

CMono5 = [int(CMono1[5]/1000), int(CMono2[5]/1000), int(CMono4[5]/1000), int(CMono8[5]/1000), int(CMono16[5]/1000), int(CMono32[5]/1000),
 			int(CMono64[5]/1000), int(CMono128[5]/1000), int(CMono256[5]/1000), int(CMono512[5]/1000), int(CMono1024[5]/1000), int(CMono2048[5]/1000),
 			int(CMono4096[5]/1000), int(CMono8192[5]/1000), int(CMono16384[5]/1000), int(CMono32768[5]/1000), int(CMono65536[5]/1000),
 			 int(CMono131072[5]/1000), int(CMono262144[5]/1000)]

fig = plt.figure()
x = range(0, len(CMono0))
plt.bar(x, CMono0)
plt.xlabel("n*4 pixel procesados por ciclo")
plt.ylabel("Cantidad de miles de ciclos de clock")
plt.xticks([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
		   ['1', '2', '4', '8', '16', '32', '64', '128', '256', '512', '1024', '2048', '4096', '8192', '16384', '32768',
		    '65536', '131072', '262144'], rotation=25)
plt.savefig("ExpLoopUnroll.png")

plt.figure()
logMono0 = np.log(CMono0)
logMono1 = np.log(CMono1)
logMono2 = np.log(CMono2)
logMono3 = np.log(CMono3)
logMono4 = np.log(CMono4)
logMono5 = np.log(CMono5)
plt.plot(logMono0, "c", label="512x512")
plt.plot(logMono1, "m", label="1024x1024")
plt.plot(logMono2, "k", label="2048x2048")
plt.plot(logMono3, "g", label="4096x4096")
plt.plot(logMono4, "y", label="8192x8192")
plt.plot(logMono5, "w", label="16384x16384")
plt.xlabel("n*4 pixel procesados por ciclo")
plt.ylabel("Cantidad de miles de ciclos de clock")
plt.xticks([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
		   ['1', '2', '4', '8', '16', '32', '64', '128', '256', '512', '1024', '2048', '4096', '8192', '16384', '32768',
		    '65536', '131072', '262144'], rotation=25)
plt.legend()
plt.savefig("ExpMuchasTA.png")
