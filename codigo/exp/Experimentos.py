import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

################################################################################
#IMPORTO TODOS LOS ARCHIVOS.####################################################

#BLIT ASM
BAXY = pd.read_csv('txt_result/TimeBlitASM_XY.txt', delim_whitespace = False)
BAX = pd.read_csv('txt_result/TimeBlitASM_X.txt', delim_whitespace = False)
BAY = pd.read_csv('txt_result/TimeBlitASM_Y.txt', delim_whitespace = False)
BAXYc = pd.read_csv('txt_result/TimeBlitASM_XYconst.txt', delim_whitespace = False)

#BLIT C
BCXY = pd.read_csv('txt_result/TimeBlitC_XY.txt', delim_whitespace = False)
BCX = pd.read_csv('txt_result/TimeBlitC_X.txt', delim_whitespace = False)
BCY = pd.read_csv('txt_result/TimeBlitC_Y.txt', delim_whitespace = False)
BCXYc = pd.read_csv('txt_result/TimeBlitC_XYconst.txt', delim_whitespace = False)

#EDGE ASM
EAXY = pd.read_csv('txt_result/TimeEdgeASM_XY.txt', delim_whitespace = False)
EAX = pd.read_csv('txt_result/TimeEdgeASM_X.txt', delim_whitespace = False)
EAY = pd.read_csv('txt_result/TimeEdgeASM_Y.txt', delim_whitespace = False)
EAXYc = pd.read_csv('txt_result/TimeEdgeASM_XYconst.txt', delim_whitespace = False)

#EDGE C
ECXY = pd.read_csv('txt_result/TimeEdgeC_XY.txt', delim_whitespace = False)
ECX = pd.read_csv('txt_result/TimeEdgeC_X.txt', delim_whitespace = False)
ECY = pd.read_csv('txt_result/TimeEdgeC_Y.txt', delim_whitespace = False)
ECXYc = pd.read_csv('txt_result/TimeEdgeC_XYconst.txt', delim_whitespace = False)

#MONOCROMATIZAR ASM
MAXY = pd.read_csv('txt_result/TimeMonoASM_XY.txt', delim_whitespace = False)
MAX = pd.read_csv('txt_result/TimeMonoASM_X.txt', delim_whitespace = False)
MAY = pd.read_csv('txt_result/TimeMonoASM_Y.txt', delim_whitespace = False)
MAXYc = pd.read_csv('txt_result/TimeMonoASM_XYconst.txt', delim_whitespace = False)

#MONOCROMATIZAR C
MCXY = pd.read_csv('txt_result/TimeMonoC_XY.txt', delim_whitespace = False)
MCX = pd.read_csv('txt_result/TimeMonoC_X.txt', delim_whitespace = False)
MCY = pd.read_csv('txt_result/TimeMonoC_Y.txt', delim_whitespace = False)
MCXYc = pd.read_csv('txt_result/TimeMonoC_XYconst.txt', delim_whitespace = False)

#ONDAS ASM
OAXY = pd.read_csv('txt_result/TimeoOndasASM_XY.txt', delim_whitespace = False)
OAX = pd.read_csv('txt_result/TimeOndasASM_X.txt', delim_whitespace = False)
OAY = pd.read_csv('txt_result/TimeOndasASM_Y.txt', delim_whitespace = False)
OAXYc = pd.read_csv('txt_result/TimeOndasASM_XYconst.txt', delim_whitespace = False)

#ONDAS C
OCXY = pd.read_csv('txt_result/TimeOndasC_XY.txt', delim_whitespace = False)
OCX = pd.read_csv('txt_result/TimeOndasC_X.txt', delim_whitespace = False)
OCY = pd.read_csv('txt_result/TimeOndasC_Y.txt', delim_whitespace = False)
OCXYc = pd.read_csv('txt_result/TimeOndasC_XYconst.txt', delim_whitespace = False)

#TEMPERATURE ASM
TAXY = pd.read_csv('txt_result/TimeTempASM_XY.txt', delim_whitespace = False)
TAX = pd.read_csv('txt_result/TimeTempASM_X.txt', delim_whitespace = False)
TAY = pd.read_csv('txt_result/TimeTempASM_Y.txt', delim_whitespace = False)
TAXYc = pd.read_csv('txt_result/TimeTempASM_XYconst.txt', delim_whitespace = False)

#TEMPERATURE C
TCXY = pd.read_csv('txt_result/TimeTempC_XY.txt', delim_whitespace = False)
TCX = pd.read_csv('txt_result/TimeTempC_X.txt', delim_whitespace = False)
TCY = pd.read_csv('txt_result/TimeTempC_Y.txt', delim_whitespace = False)
TCXYc = pd.read_csv('txt_result/TimeTempC_XYconst.txt', delim_whitespace = False)

imegen = [x for x in range(1, 51)]

################################################################################
#EXPERIMENTOS###################################################################

CIpesos = CIFB.ix[:,0]
CIvalores = CIFB.ix[:,1]

CIFuerzaBruta = CIFB.ix[:,2]
CIBacktracking = CIBT.ix[:,2]
CIDinamica = CIDN.ix[:,2]

plt.figure()
datosFB = np.log(CIFuerzaBruta)
datosBT = np.log(CIBacktracking)
datosDN = np.log(CIDinamica)
plt.plot(datosFB, "c", label="Algoritmo Fuerza Bruta")
plt.plot(datosBT, "m", label="Algoritmo Backtracking")
plt.plot(datosDN, "k", label="Algoritmo Dinamico")
plt.xlabel("Elementos o tamaño de la mochila")
plt.ylabel("Tiempo en nansegundos (en escala logaritmica)")
plt.legend()
plt.savefig("plot/Exp1.png")


################################################################################

EFpesos = EFFB.ix[:,0]
EFvalores = EFFB.ix[:,1]

EFFuerzaBruta = EFFB.ix[:,2]
EFBacktracking = EFBT.ix[:,2]
EFDinamica = EFDN.ix[:,2]

plt.figure()
datosFB = np.log(EFFuerzaBruta)
datosBT = np.log(EFBacktracking)
datosDN = np.log(EFDinamica)
plt.plot(datosFB, "c", label="Algoritmo Fuerza Bruta")
plt.plot(datosBT, "m", label="Algoritmo Backtracking")
plt.plot(datosDN, "k", label="Algoritmo Dinamico")
plt.xlabel("Tamaño de la mochila")
plt.ylabel("Tiempo en nansegundos (en escala logaritmica)")
plt.legend()
plt.savefig("plot/Exp2.png")


################################################################################

MFpesos = MFFB.ix[:,0]
MFvalores = MFFB.ix[:,1]

MFFuerzaBruta = MFFB.ix[:,2]
MFBacktracking = MFBT.ix[:,2]
MFDinamica = MFDN.ix[:,2]

plt.figure()
datosFB = np.log(MFFuerzaBruta)
datosBT = np.log(MFBacktracking)
datosDN = np.log(MFDinamica)
plt.plot(datosFB, "c", label="Algoritmo Fuerza Bruta")
plt.plot(datosBT, "m", label="Algoritmo Backtracking")
plt.plot(datosDN, "k", label="Algoritmo Dinamico")
plt.xlabel("Elementos")
plt.ylabel("Tiempo en nansegundos (en escala logaritmica)")
plt.legend()
plt.savefig("plot/Exp3.png")

################################################################################
