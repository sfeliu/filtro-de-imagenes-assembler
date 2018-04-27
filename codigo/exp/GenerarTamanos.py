import subprocess
import sys

IMAGENES=["lena.bmp", "colores32.bmp"]

################################################################################
#GENERAR IMAGENES XY

sizesXY=[	'20X20', '40x40', '60x60', '80x80', '100x100',
			'120x120', '140x140', '160x160', '180x180', '200x200',
			'208x208', '220x220', '256x256', '300x300', '360X360',
			'400x400', '420x420', '480x480', '512x512', '640x640',
			'720x720', '800x800', '1024x1024', '2048x2048', '4096X4096']

i = 1
for filename in IMAGENES:
	print(filename)

	for size in sizes:
		sys.stdout.write("  " + size)
		name = filename.split('.')
		file_in  = "./img" + "/" + filename
		file_out = "./img/VarXY/" + str(i) + "." + name[1]
		resize = "convert -resize " + sizeXY + "! " + file_in + " " + file_out
		subprocess.call(resize, shell=True)
		i = i+1

print("")

################################################################################
#GENERAR IMAGENES X

sizesX=[	'20X256', '40x256', '60x256', '80x256', '100x256',
			'120x256', '140x256', '160x256', '180x256', '200x256',
			'208x256', '220x256', '256x256', '300x256', '360X256',
			'400x256', '420x256', '480x256', '512x256', '640x256',
			'720x256', '800x256', '1024x256', '2048x256', '4096X256']

i = 1
for filename in IMAGENES:
	print(filename)

	for size in sizes:
		sys.stdout.write("  " + size)
		name = filename.split('.')
		file_in  = "./img" + "/" + filename
		file_out = "./img/VarX/" + str(i) + "." + name[1]
		resize = "convert -resize " + sizeXY + "! " + file_in + " " + file_out
		subprocess.call(resize, shell=True)
		i = i+1

print("")

################################################################################
#GENERAR IMAGENES Y

sizesY=[	'256X20', '256x40', '256x60', '256x80', '256x100',
			'256x120', '256x140', '256x160', '256x180', '256x200',
			'256x208', '256x220', '256x256', '256x300', '256X360',
			'256x400', '256x420', '256x480', '256x512', '256x640',
			'256x720', '256x800', '256x1024', '256x2048', '256X4096']

i = 1
for filename in IMAGENES:
	print(filename)

	for size in sizes:
		sys.stdout.write("  " + size)
		name = filename.split('.')
		file_in  = "./img" + "/" + filename
		file_out = "./img/VarY/" + str(i) + "." + name[1]
		resize = "convert -resize " + sizeXY + "! " + file_in + " " + file_out
		subprocess.call(resize, shell=True)
		i = i+1

print("")

################################################################################
#GENERAR IMAGENES XY_const

sizesXYconst=[	'20X20', '40x40', '60x60', '80x80', '100x100',
				'120x120', '140x140', '160x160', '180x180', '200x200',
				'208x208', '220x220', '256x256', '300x300', '360X360',
				'400x400', '420x420', '480x480', '512x512', '640x640',
				'720x720', '800x800', '1024x1024', '2048x2048', '4096X4096']

i = 1
for filename in IMAGENES:
	print(filename)

	for size in sizes:
		sys.stdout.write("  " + size)
		name = filename.split('.')
		file_in  = "./img" + "/" + filename
		file_out = "./img/VarXY_const/" + str(i) + "." + name[1]
		resize = "convert -resize " + sizeXY + "! " + file_in + " " + file_out
		subprocess.call(resize, shell=True)
		i = i+1

print("")
