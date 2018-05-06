import subprocess
import sys

DATADIR = "./img"
TESTINDIR = DATADIR + "/VarXY"

IMAGENES=["lena.bmp"]

sizes=[	'128x128', '140x140', '160x160', '180x180', '200x200',
		'208x208', '220x220', '256x256', '300x300', '360X360',
		'400x400', '420x420', '480x480', '512x512', '640x640',
		'720x720', '800x800', '1024x1024', '2048x2048', '4096X4096']

for filename in IMAGENES:
	i = 1
	for size in sizes:
		name = filename.split('.')
		file_in  = DATADIR + "/" + filename
		file_out = TESTINDIR + "/" + str(i) + "." + name[1]
		resize = "convert -resize " + size + "! " + file_in + " " + file_out
		subprocess.call(resize, shell=True)
		i = i + 1

print("Imagenes generadas")
