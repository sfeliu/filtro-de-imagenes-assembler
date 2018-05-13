import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
################################################################################
#IMPORTO TODOS LOS ARCHIVOS.####################################################

#MONOCROMATIZAR CUELLO DE BOTELLA
MCB = pd.read_csv('txt_result/TimeMonoCuello.txt', delim_whitespace = True)

################################################################################
#Monocromatizar#################################################################

TExtra = MCB.ix[:,0]
TMemoria = MCB.ix[:,1]
TProc = MCB.ix[:,2]

Times = [int(TExtra), int(TMemoria), int(TProc)]
Datos = ["Extras", "Memoria", "Procesamiento"]
Colores = ['Blue', 'Orange', 'Green']

fig = plt.figure()
plt.pie(Times, colors=Colores, labels=Datos, autopct='%1.1f%%')
plt.axis('equal')
plt.xlabel("Cantidad de ciclos de clock")
plt.savefig("ExpCuelloBotella.png")

Times = [int(TMemoria), int(TProc)]
Datos = ["Memoria", "Procesamiento"]
Colores = ['Orange', 'Green']

fig = plt.figure()
plt.pie(Times, colors=Colores, labels=Datos, autopct='%1.1f%%')
plt.axis('equal')
plt.xlabel("Cantidad de ciclos de clock")
plt.savefig("ExpCuelloBotella2.png")
