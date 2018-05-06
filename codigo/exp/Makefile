all :
	rm -fr *.bmp

run :
	python3	GenerarTamanos.py
	python3 Blit_tiempos.py
	python3 Edge_tiempos.py
	python3 Mono_tiempos.py
	python3 Ondas_tiempos.py
	python3 Temp_tiempos.py
	python3 Experimentos.py
	mv *.png plot_result/

clean :
	rm -fr txt_result/*.txt
	rm -fr plot_result/*.png
	rm -fr img/VarX/*.bmp
	rm -fr img/VarXY/*.bmp
	rm -fr img/VarY/*.bmp
	rm -fr img/VarXY_const/*.bmp
