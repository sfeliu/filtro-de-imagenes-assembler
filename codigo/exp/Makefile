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

run2 :
	python3 GenerarTamanos.py

	python3 mover_file.py True loop_unroll loop_unroll_caso_1.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 1
	python3 mover_file.py False loop_unroll loop_unroll_caso_1.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_2.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 2
	python3 mover_file.py False loop_unroll loop_unroll_caso_2.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_4.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 4
	python3 mover_file.py False loop_unroll loop_unroll_caso_4.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_8.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 8
	python3 mover_file.py False loop_unroll loop_unroll_caso_8.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_16.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 16
	python3 mover_file.py False loop_unroll loop_unroll_caso_16.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_32.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 32
	python3 mover_file.py False loop_unroll loop_unroll_caso_32.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_64.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 64
	python3 mover_file.py False loop_unroll loop_unroll_caso_64.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_128.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 128
	python3 mover_file.py False loop_unroll loop_unroll_caso_128.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_256.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 256
	python3 mover_file.py False loop_unroll loop_unroll_caso_256.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_512.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 512
	python3 mover_file.py False loop_unroll loop_unroll_caso_512.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_1024.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 1024
	python3 mover_file.py False loop_unroll loop_unroll_caso_1024.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_2048.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 2048
	python3 mover_file.py False loop_unroll loop_unroll_caso_2048.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_4096.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 4096
	python3 mover_file.py False loop_unroll loop_unroll_caso_4096.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_8192.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 8192
	python3 mover_file.py False loop_unroll loop_unroll_caso_8192.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_16384.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 16384
	python3 mover_file.py False loop_unroll loop_unroll_caso_16384.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_32768.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 32768
	python3 mover_file.py False loop_unroll loop_unroll_caso_32768.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_65536.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 65536
	python3 mover_file.py False loop_unroll loop_unroll_caso_65536.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_131072.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 131072
	python3 mover_file.py False loop_unroll loop_unroll_caso_131072.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_262144.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 262144
	python3 mover_file.py False loop_unroll loop_unroll_caso_262144.asm monocromatizar_inf_asm.asm

	python3 crear_grafico_loop_unroll.py
	mv *.png plot_result/

	rm -fr ../filtros_backup
	rm -fr *.bmp

run3 :

	python3 mover_file.py True cuello_de_botella monocromatizar_inf_asm.asm monocromatizar_inf_asm.asm
	python3 cuello_de_botella_tiempos.py
	python3 mover_file.py False cuello_de_botella monocromatizar_inf_asm.asm monocromatizar_inf_asm.asm

	python3 crear_grafico_cuello_botella.py
	mv *.png plot_result/

	rm -fr ../filtros_backup
	rm -fr *.bmp

run4 :
	python3 GenerarTamanos.py

	python3 mover_file.py True loop_unroll loop_unroll_caso_1.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 1
	python3 mover_file.py False loop_unroll loop_unroll_caso_1.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_2.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 2
	python3 mover_file.py False loop_unroll loop_unroll_caso_2.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_4.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 4
	python3 mover_file.py False loop_unroll loop_unroll_caso_4.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_8.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 8
	python3 mover_file.py False loop_unroll loop_unroll_caso_8.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_16.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 16
	python3 mover_file.py False loop_unroll loop_unroll_caso_16.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_32.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 32
	python3 mover_file.py False loop_unroll loop_unroll_caso_32.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_64.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 64
	python3 mover_file.py False loop_unroll loop_unroll_caso_64.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_128.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 128
	python3 mover_file.py False loop_unroll loop_unroll_caso_128.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_256.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 256
	python3 mover_file.py False loop_unroll loop_unroll_caso_256.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_512.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 512
	python3 mover_file.py False loop_unroll loop_unroll_caso_512.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_1024.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 1024
	python3 mover_file.py False loop_unroll loop_unroll_caso_1024.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_2048.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 2048
	python3 mover_file.py False loop_unroll loop_unroll_caso_2048.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_4096.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 4096
	python3 mover_file.py False loop_unroll loop_unroll_caso_4096.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_8192.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 8192
	python3 mover_file.py False loop_unroll loop_unroll_caso_8192.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_16384.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos_tamanos.py 16384
	python3 mover_file.py False loop_unroll loop_unroll_caso_16384.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_32768.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 32768
	python3 mover_file.py False loop_unroll loop_unroll_caso_32768.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_65536.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 65536
	python3 mover_file.py False loop_unroll loop_unroll_caso_65536.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_131072.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 131072
	python3 mover_file.py False loop_unroll loop_unroll_caso_131072.asm monocromatizar_inf_asm.asm

	python3 mover_file.py True loop_unroll loop_unroll_caso_262144.asm monocromatizar_inf_asm.asm
	python3 loop_unroll_tiempos.py 262144
	python3 mover_file.py False loop_unroll loop_unroll_caso_262144.asm monocromatizar_inf_asm.asm


	rm -fr ../filtros_backup
	rm -fr *.bmp

clean :
	rm -fr txt_result/*.txt
	rm -fr plot_result/*.png
	rm -fr img/VarXY/*.bmp
