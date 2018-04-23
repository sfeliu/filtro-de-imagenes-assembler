all :
	rm -fr *.bmp

img:
	g++ -std=c++11 -D_GLIBCXX_DEBUG -g -Wall GenerarImg.cpp -o GenerarImg.out
	./GenerarImg.out
	python GenerarTamano.py

run :
	python Blit_tiempos.py
	python Edge_tiempos.py
	python Mono_tiempos.py
	python Ondas_tiempos.py
	python Temp_tiempos.py

clean :
	rm -fr txt_result/*.txt
