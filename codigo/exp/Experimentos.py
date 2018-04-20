import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np


################################################################################
CIFB = pd.read_csv('CIFB.txt', delim_whitespace = True)
CIBT = pd.read_csv('CIBT.txt', delim_whitespace = True)
CIDN = pd.read_csv('CIDN.txt', delim_whitespace = True)

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
EFFB = pd.read_csv('EFFB.txt', delim_whitespace = True)
EFBT = pd.read_csv('EFBT.txt', delim_whitespace = True)
EFDN = pd.read_csv('EFDN.txt', delim_whitespace = True)

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
MFFB = pd.read_csv('MFFB.txt', delim_whitespace = True)
MFBT = pd.read_csv('MFBT.txt', delim_whitespace = True)
MFDN = pd.read_csv('MFDN.txt', delim_whitespace = True)

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
