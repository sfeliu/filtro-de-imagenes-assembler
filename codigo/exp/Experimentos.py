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

################################################################################
#EXPERIMENTOS###################################################################


#BLIT###########################################################################

ABlitXY = BAXY.ix[:,0]
ABlitX = BAX.ix[:,0]
ABlitY = BAY.ix[:,0]
ABlitXYc = BAXYc.ix[:,0]

CBlitXY = BCXY.ix[:,0]
CBlitX = BCX.ix[:,0]
CBlitY = BCY.ix[:,0]
CBlitXYc = BCXYc.ix[:,0]

plt.figure()
plt.plot(ABlitXY, "c", label="Blit implementado en ASM")
plt.plot(CBlitXY, "m", label="Blit implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_BlitXY.png")

plt.figure()
plt.plot(ABlitX, "c", label="Blit implementado en ASM")
plt.plot(CBlitX, "m", label="Blit implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_BlitX.png")

plt.figure()
plt.plot(ABlitY, "c", label="Blit implementado en ASM")
plt.plot(CBlitY, "m", label="Blit implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_BlitY.png")

plt.figure()
plt.plot(ABlitXYc, "c", label="Blit implementado en ASM")
plt.plot(CBlitXYc, "m", label="Blit implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_BlitXYc.png")

################################################################################

#Edge###########################################################################

AEdgeXY = EAXY.ix[:,0]
AEdgeX = EAX.ix[:,0]
AEdgeY = EAY.ix[:,0]
AEdgeXYc = EAXYc.ix[:,0]

CEdgeXY = ECXY.ix[:,0]
CEdgeX = ECX.ix[:,0]
CEdgeY = ECY.ix[:,0]
CEdgeXYc = ECXYc.ix[:,0]

plt.figure()
plt.plot(AEdgeXY, "c", label="Edge implementado en ASM")
plt.plot(CEdgeXY, "m", label="Edge implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_EdgeXY.png")

plt.figure()
plt.plot(AEdgeX, "c", label="Edge implementado en ASM")
plt.plot(CEdgeX, "m", label="Edge implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_EdgeX.png")

plt.figure()
plt.plot(AEdgeY, "c", label="Edge implementado en ASM")
plt.plot(CEdgeY, "m", label="Edge implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_EdgeY.png")

plt.figure()
plt.plot(AEdgeXYc, "c", label="Edge implementado en ASM")
plt.plot(CEdgeXYc, "m", label="Edge implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_EdgeXYc.png")

################################################################################

#Monocromatizar#################################################################

AMonoXY = MAXY.ix[:,0]
AMonoX = MAX.ix[:,0]
AMonoY = MAY.ix[:,0]
AMonoXYc = MAXYc.ix[:,0]

CMonoXY = MCXY.ix[:,0]
CMonoX = MCX.ix[:,0]
CMonoY = MCY.ix[:,0]
CMonoXYc = MCXYc.ix[:,0]

plt.figure()
plt.plot(AMonoXY, "c", label="Monocromatizar implementado en ASM")
plt.plot(CMonoXY, "m", label="Monocromatizar implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_MonoXY.png")

plt.figure()
plt.plot(AMonoX, "c", label="Monocromatizar implementado en ASM")
plt.plot(CMonoX, "m", label="Monocromatizar implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_MonoX.png")

plt.figure()
plt.plot(AMonoY, "c", label="Monocromatizar implementado en ASM")
plt.plot(CMonoY, "m", label="Monocromatizar implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_MonoY.png")

plt.figure()
plt.plot(AMonoXYc, "c", label="Monocromatizar implementado en ASM")
plt.plot(CMonoXYc, "m", label="Monocromatizar implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_MonoXYc.png")

################################################################################

#Ondas##########################################################################

AOndasXY = OAXY.ix[:,0]
AOndasX = OAX.ix[:,0]
AOndasY = OAY.ix[:,0]
AOndasXYc = OAXYc.ix[:,0]

COndasXY = OCXY.ix[:,0]
COndasX = OCX.ix[:,0]
COndasY = OCY.ix[:,0]
COndasXYc = OCXYc.ix[:,0]

plt.figure()
plt.plot(AOndasXY, "c", label="Ondas implementado en ASM")
plt.plot(COndasXY, "m", label="Ondas implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_OndasXY.png")

plt.figure()
plt.plot(AOndasX, "c", label="Ondas implementado en ASM")
plt.plot(COndasX, "m", label="Ondas implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_OndasX.png")

plt.figure()
plt.plot(AOndasY, "c", label="Ondas implementado en ASM")
plt.plot(COndasY, "m", label="Ondas implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_OndasY.png")

plt.figure()
plt.plot(AOndasXYc, "c", label="Ondas implementado en ASM")
plt.plot(COndasXYc, "m", label="Ondas implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_OndasXYc.png")

################################################################################

#Temperature####################################################################

ATempXY = TAXY.ix[:,0]
ATempX = TAX.ix[:,0]
ATempY = TAY.ix[:,0]
ATempXYc = TAXYc.ix[:,0]

CTempXY = TCXY.ix[:,0]
CTempX = TCX.ix[:,0]
CTempY = TCY.ix[:,0]
CTempXYc = TCXYc.ix[:,0]

plt.figure()
plt.plot(ATempXY, "c", label="Temperature implementado en ASM")
plt.plot(CTempXY, "m", label="Temperature implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_TempXY.png")

plt.figure()
plt.plot(ATempX, "c", label="Temperature implementado en ASM")
plt.plot(CTempX, "m", label="Temperature implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_TempX.png")

plt.figure()
plt.plot(ATempY, "c", label="Temperature implementado en ASM")
plt.plot(CTempY, "m", label="Temperature implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_TempY.png")

plt.figure()
plt.plot(ATempXYc, "c", label="Temperature implementado en ASM")
plt.plot(CTempXYc, "m", label="Temperature implementado en C")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Ciclos de clock")
plt.legend()
plt.savefig("plot/Exp_TempXYc.png")

################################################################################
