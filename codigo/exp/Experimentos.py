import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np


################################################################################
#IMPORTO TODOS LOS ARCHIVOS.####################################################

#BLIT ASM
BAXY = pd.read_csv('txt_result/TimeBlitASM_XY.txt', delim_whitespace = True)
#BLIT C
BCXY = pd.read_csv('txt_result/TimeBlitC_XY.txt', delim_whitespace = True)
#BLIT C con O3
BC3XY = pd.read_csv('txt_result/TimeBlitC3_XY.txt', delim_whitespace = True)

#EDGE ASM
EAXY = pd.read_csv('txt_result/TimeEdgeASM_XY.txt', delim_whitespace = True)
#EDGE C
ECXY = pd.read_csv('txt_result/TimeEdgeC_XY.txt', delim_whitespace = True)
#EDGE C con O3
EC3XY = pd.read_csv('txt_result/TimeEdgeC3_XY.txt', delim_whitespace = True)

#MONOCROMATIZAR ASM
MAXY = pd.read_csv('txt_result/TimeMonoASM_XY.txt', delim_whitespace = True)
#MONOCROMATIZAR C
MCXY = pd.read_csv('txt_result/TimeMonoC_XY.txt', delim_whitespace = True)
#MONOCROMATIZAR C con O3
MC3XY = pd.read_csv('txt_result/TimeMonoC3_XY.txt', delim_whitespace = True)

#ONDAS ASM
OAXY = pd.read_csv('txt_result/TimeOndasASM_XY.txt', delim_whitespace = True)
#ONDAS C
OCXY = pd.read_csv('txt_result/TimeOndasC_XY.txt', delim_whitespace = True)
#ONDAS C con O3
OC3XY = pd.read_csv('txt_result/TimeOndasC3_XY.txt', delim_whitespace = True)

#TEMPERATURE ASM
TAXY = pd.read_csv('txt_result/TimeTempASM_XY.txt', delim_whitespace = True)
#TEMPERATURE C
TCXY = pd.read_csv('txt_result/TimeTempC_XY.txt', delim_whitespace = True)
#TEMPERATURE C con O3
TC3XY = pd.read_csv('txt_result/TimeTempC3_XY.txt', delim_whitespace = True)

################################################################################
#EXPERIMENTOS###################################################################


#BLIT###########################################################################

ABlitXY = BAXY.ix[:,0]
CBlitXY = BCXY.ix[:,0]
C3BlitXY = BC3XY.ix[:,0]

plt.figure()
plt.plot(ABlitXY, "c", label="Blit implementado en ASM")
plt.plot(CBlitXY, "m", label="Blit implementado en C")
plt.plot(C3BlitXY, "k", label="Blit implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("Exp_BlitXY.png")

################################################################################

#Edge###########################################################################

AEdgeXY = EAXY.ix[:,0]
CEdgeXY = ECXY.ix[:,0]
C3EdgeXY = EC3XY.ix[:,0]

plt.figure()
plt.plot(AEdgeXY, "c", label="Edge implementado en ASM")
plt.plot(CEdgeXY, "m", label="Edge implementado en C")
plt.plot(C3EdgeXY, "k", label="Edge implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("Exp_EdgeXY.png")

################################################################################

#Monocromatizar#################################################################

AMonoXY = MAXY.ix[:,0]
CMonoXY = MCXY.ix[:,0]
C3MonoXY = MC3XY.ix[:,0]

plt.figure()
plt.plot(AMonoXY, "c", label="Monocromatizar implementado en ASM")
plt.plot(CMonoXY, "m", label="Monocromatizar implementado en C")
plt.plot(C3MonoXY, "k", label="Monocromatizar implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("Exp_MonoXY.png")

################################################################################

#Ondas##########################################################################

AOndasXY = OAXY.ix[:,0]
COndasXY = OCXY.ix[:,0]
C3OndasXY = OC3XY.ix[:,0]

plt.figure()
plt.plot(AOndasXY, "c", label="Ondas implementado en ASM")
plt.plot(COndasXY, "m", label="Ondas implementado en C")
plt.plot(C3OndasXY, "k", label="Ondas implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("Exp_OndasXY.png")

################################################################################

#Temperature####################################################################

ATempXY = TAXY.ix[:,0]
CTempXY = TCXY.ix[:,0]
C3TempXY = TC3XY.ix[:,0]

plt.figure()
plt.plot(ATempXY, "c", label="Temperature implementado en ASM")
plt.plot(CTempXY, "m", label="Temperature implementado en C")
plt.plot(C3TempXY, "k", label="Temperature implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("Exp_TempXY.png")
################################################################################
