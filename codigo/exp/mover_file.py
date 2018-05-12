import os
import subprocess as sub
import sys

ida = sys.argv[1]
directorio_codigo_a_probar = sys.argv[2]
codigo_a_probar = sys.argv[3]
codigo_original = sys.argv[4]
parent_dir = os.pardir
if ida == 'True':
	os.makedirs(parent_dir + '/filtros_backup', exist_ok=True)
	os.rename(parent_dir + '/filtros/' + codigo_original, parent_dir + '/filtros_backup/' + codigo_original)
	os.rename(parent_dir + '/exp/' + directorio_codigo_a_probar + '/' + codigo_a_probar, parent_dir + '/filtros/' + codigo_original)
	p = sub.Popen('make', cwd=parent_dir + '/', shell=True)
	p.communicate()
else:
	os.rename(parent_dir + '/filtros/' + codigo_original, parent_dir + '/exp/'  + directorio_codigo_a_probar + '/' + codigo_a_probar)
	os.rename(parent_dir + '/filtros_backup/' + codigo_original, parent_dir + '/filtros/' + codigo_original)
	p = sub.Popen('make clean', cwd=parent_dir + '/', shell=True)
	p.communicate()
