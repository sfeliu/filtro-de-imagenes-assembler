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

x = [i for i in range(0, 20)]

#BLIT###########################################################################

ABlitXY = BAXY.ix[:,0]
CBlitXY = BCXY.ix[:,0]
C3BlitXY = BC3XY.ix[:,0]

MinABlitXY = BAXY.ix[:,1]
MinCBlitXY = BCXY.ix[:,1]
MinC3BlitXY = BC3XY.ix[:,1]

MaxABlitXY = BAXY.ix[:,2]
MaxCBlitXY = BCXY.ix[:,2]
MaxC3BlitXY = BC3XY.ix[:,2]

ABlitXY = np.log(ABlitXY)
CBlitXY = np.log(CBlitXY)
C3BlitXY = np.log(C3BlitXY)

MinABlitXY = np.log(MinABlitXY)
MinCBlitXY = np.log(MinCBlitXY)
MinC3BlitXY = np.log(MinC3BlitXY)

MaxABlitXY = np.log(MaxABlitXY)
MaxCBlitXY = np.log(MaxCBlitXY)
MaxC3BlitXY = np.log(MaxC3BlitXY)

MinABlitXY = ABlitXY - MinABlitXY
MinCBlitXY = CBlitXY - MinCBlitXY
MinC3BlitXY = C3BlitXY - MinC3BlitXY

MaxABlitXY = MaxABlitXY - ABlitXY
MaxCBlitXY = MaxCBlitXY - CBlitXY
MaxC3BlitXY = MaxC3BlitXY - C3BlitXY

plt.figure()
plt.errorbar(x, ABlitXY, yerr=[MinABlitXY, MaxABlitXY], fmt='-o', label="Blit implementado en ASM")
plt.errorbar(x, CBlitXY, yerr=[MinCBlitXY, MaxCBlitXY], fmt='-o', label="Blit implementado en C")
plt.errorbar(x, C3BlitXY, yerr=[MinC3BlitXY, MaxC3BlitXY], fmt='-o', label="Blit implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Cantidad de ciclos de clock en escala logaritmica")
plt.xticks([-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
		   [	'128x128', '140x140', '160x160', '180x180', '200x200',
		   		'208x208', '220x220', '256x256', '300x300', '360X360',
		   		'400x400', '420x420', '480x480', '512x512', '640x640',
		   		'720x720', '800x800', '1024x1024', '2048x2048',
		   		'4096X4096'], rotation=35)
plt.legend()
plt.savefig("ExpBlitXY.pdf", bbox_inches='tight')

################################################################################

#Edge###########################################################################

AEdgeXY = EAXY.ix[:,0]
CEdgeXY = ECXY.ix[:,0]
C3EdgeXY = EC3XY.ix[:,0]

MinAEdgeXY = EAXY.ix[:,1]
MinCEdgeXY = ECXY.ix[:,1]
MinC3EdgeXY = EC3XY.ix[:,1]

MaxAEdgeXY = EAXY.ix[:,2]
MaxCEdgeXY = ECXY.ix[:,2]
MaxC3EdgeXY = EC3XY.ix[:,2]

AEdgeXY = np.log(AEdgeXY)
CEdgeXY = np.log(CEdgeXY)
C3EdgeXY = np.log(C3EdgeXY)

MinAEdgeXY = np.log(MinAEdgeXY)
MinCEdgeXY = np.log(MinCEdgeXY)
MinC3EdgeXY = np.log(MinC3EdgeXY)

MaxAEdgeXY = np.log(MaxAEdgeXY)
MaxCEdgeXY = np.log(MaxCEdgeXY)
MaxC3EdgeXY = np.log(MaxC3EdgeXY)

MinAEdgeXY = AEdgeXY - MinAEdgeXY
MinCEdgeXY = CEdgeXY - MinCEdgeXY
MinC3EdgeXY = C3EdgeXY - MinC3EdgeXY

MaxAEdgeXY = MaxAEdgeXY - AEdgeXY
MaxCEdgeXY = MaxCEdgeXY - CEdgeXY
MaxC3EdgeXY = MaxC3EdgeXY - C3EdgeXY

plt.figure()
plt.errorbar(x, AEdgeXY, yerr=[MinAEdgeXY, MaxAEdgeXY], fmt='-o', label="Edge implementado en ASM")
plt.errorbar(x, CEdgeXY, yerr=[MinCEdgeXY, MaxCEdgeXY], fmt='-o', label="Edge implementado en C")
plt.errorbar(x, C3EdgeXY, yerr=[MinC3EdgeXY, MaxC3EdgeXY], fmt='-o', label="Edge implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Cantidad de ciclos de clock en escala logaritmica")
plt.xticks([-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
		   [	'128x128', '140x140', '160x160', '180x180', '200x200',
		   		'208x208', '220x220', '256x256', '300x300', '360X360',
		   		'400x400', '420x420', '480x480', '512x512', '640x640',
		   		'720x720', '800x800', '1024x1024', '2048x2048',
		   		'4096X4096'], rotation=35)
plt.legend()
plt.savefig("ExpEdgeXY.pdf", bbox_inches='tight')

################################################################################

#Monocromatizar#################################################################

AMonoXY = MAXY.ix[:,0]
CMonoXY = MCXY.ix[:,0]
C3MonoXY = MC3XY.ix[:,0]

MinAMonoXY = MAXY.ix[:,1]
MinCMonoXY = MCXY.ix[:,1]
MinC3MonoXY = MC3XY.ix[:,1]

MaxAMonoXY = MAXY.ix[:,2]
MaxCMonoXY = MCXY.ix[:,2]
MaxC3MonoXY = MC3XY.ix[:,2]

AMonoXY = np.log(AMonoXY)
CMonoXY = np.log(CMonoXY)
C3MonoXY = np.log(C3MonoXY)

MinAMonoXY = np.log(MinAMonoXY)
MinCMonoXY = np.log(MinCMonoXY)
MinC3MonoXY = np.log(MinC3MonoXY)

MaxAMonoXY = np.log(MaxAMonoXY)
MaxCMonoXY = np.log(MaxCMonoXY)
MaxC3MonoXY = np.log(MaxC3MonoXY)

MinAMonoXY = AMonoXY - MinAMonoXY
MinCMonoXY = CMonoXY - MinCMonoXY
MinC3MonoXY = C3MonoXY - MinC3MonoXY

MaxAMonoXY = MaxAMonoXY - AMonoXY
MaxCMonoXY = MaxCMonoXY - CMonoXY
MaxC3MonoXY = MaxC3MonoXY - C3MonoXY

plt.figure()
plt.errorbar(x, AMonoXY, yerr=[MinAMonoXY, MaxAMonoXY], fmt='-o', label="Monocromatizar implementado en ASM")
plt.errorbar(x, CMonoXY, yerr=[MinCMonoXY, MaxCMonoXY], fmt='-o', label="Monocromatizar implementado en C")
plt.errorbar(x, C3MonoXY, yerr=[MinC3MonoXY, MaxC3MonoXY], fmt='-o', label="Monocromatizar implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Cantidad de ciclos de clock en escala logaritmica")
plt.xticks([-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
		   [	'128x128', '140x140', '160x160', '180x180', '200x200',
		   		'208x208', '220x220', '256x256', '300x300', '360X360',
		   		'400x400', '420x420', '480x480', '512x512', '640x640',
		   		'720x720', '800x800', '1024x1024', '2048x2048',
		   		'4096X4096'], rotation=35)
plt.legend()
plt.savefig("ExpMonoXY.pdf", bbox_inches='tight')

################################################################################

#Ondas##########################################################################

AOndasXY = OAXY.ix[:,0]
COndasXY = OCXY.ix[:,0]
C3OndasXY = OC3XY.ix[:,0]

MinAOndasXY = OAXY.ix[:,1]
MinCOndasXY = OCXY.ix[:,1]
MinC3OndasXY = OC3XY.ix[:,1]

MaxAOndasXY = OAXY.ix[:,2]
MaxCOndasXY = OCXY.ix[:,2]
MaxC3OndasXY = OC3XY.ix[:,2]

AOndasXY = np.log(AOndasXY)
COndasXY = np.log(COndasXY)
C3OndasXY = np.log(C3OndasXY)

MinAOndasXY = np.log(MinAOndasXY)
MinCOndasXY = np.log(MinCOndasXY)
MinC3OndasXY = np.log(MinC3OndasXY)

MaxAOndasXY = np.log(MaxAOndasXY)
MaxCOndasXY = np.log(MaxCOndasXY)
MaxC3OndasXY = np.log(MaxC3OndasXY)

MinAOndasXY = AOndasXY - MinAOndasXY
MinCOndasXY = COndasXY - MinCOndasXY
MinC3OndasXY = C3OndasXY - MinC3OndasXY

MaxAOndasXY = MaxAOndasXY - AOndasXY
MaxCOndasXY = MaxCOndasXY - COndasXY
MaxC3OndasXY = MaxC3OndasXY - C3OndasXY

plt.figure()
plt.errorbar(x, AOndasXY, yerr=[MinAOndasXY, MaxAOndasXY], fmt='-o', label="Ondas implementado en ASM")
plt.errorbar(x, COndasXY, yerr=[MinCOndasXY, MaxCOndasXY], fmt='-o', label="Ondas implementado en C")
plt.errorbar(x, C3OndasXY, yerr=[MinC3OndasXY, MaxC3OndasXY], fmt='-o', label="Ondas implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Cantidad de ciclos de clock en escala logaritmica")
plt.xticks([-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
		   [	'128x128', '140x140', '160x160', '180x180', '200x200',
		   		'208x208', '220x220', '256x256', '300x300', '360X360',
		   		'400x400', '420x420', '480x480', '512x512', '640x640',
		   		'720x720', '800x800', '1024x1024', '2048x2048',
		   		'4096X4096'], rotation=35)
plt.legend()
plt.savefig("ExpOndasXY.pdf", bbox_inches='tight')

################################################################################

#Temperature####################################################################

ATempXY = TAXY.ix[:,0]
CTempXY = TCXY.ix[:,0]
C3TempXY = TC3XY.ix[:,0]

MinATempXY = TAXY.ix[:,1]
MinCTempXY = TCXY.ix[:,1]
MinC3TempXY = TC3XY.ix[:,1]

MaxATempXY = TAXY.ix[:,2]
MaxCTempXY = TCXY.ix[:,2]
MaxC3TempXY = TC3XY.ix[:,2]

ATempXY = np.log(ATempXY)
CTempXY = np.log(CTempXY)
C3TempXY = np.log(C3TempXY)

MinATempXY = np.log(MinATempXY)
MinCTempXY = np.log(MinCTempXY)
MinC3TempXY = np.log(MinC3TempXY)

MaxATempXY = np.log(MaxATempXY)
MaxCTempXY = np.log(MaxCTempXY)
MaxC3TempXY = np.log(MaxC3TempXY)

MinATempXY = ATempXY - MinATempXY
MinCTempXY = CTempXY - MinCTempXY
MinC3TempXY = C3TempXY - MinC3TempXY

MaxATempXY = MaxATempXY - ATempXY
MaxCTempXY = MaxCTempXY - CTempXY
MaxC3TempXY = MaxC3TempXY - C3TempXY

plt.figure()
plt.errorbar(x, ATempXY, yerr=[MinATempXY, MaxATempXY], fmt='-o', label="Temperature implementado en ASM")
plt.errorbar(x, CTempXY, yerr=[MinCTempXY, MaxCTempXY], fmt='-o', label="Temperature implementado en C")
plt.errorbar(x, C3TempXY, yerr=[MinC3TempXY, MaxC3TempXY], fmt='-o', label="Temperature implementado en C O3")
plt.xlabel("Tamaño de la imagen")
plt.ylabel("Cantidad de ciclos de clock en escala logaritmica")
plt.xticks([-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
		   ['128x128', '140x140', '160x160', '180x180', '200x200',
		   		'208x208', '220x220', '256x256', '300x300', '360X360',
		   		'400x400', '420x420', '480x480', '512x512', '640x640',
		   		'720x720', '800x800', '1024x1024', '2048x2048',
		   		'4096X4096'], rotation=35)
plt.legend()
plt.savefig("ExpTempXY.pdf", bbox_inches='tight')
################################################################################
