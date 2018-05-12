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

clean :
	rm -fr txt_result/*.txt
	rm -fr plot_result/*.png
	rm -fr img/VarX/*.bmp
	rm -fr img/VarXY/*.bmp
	rm -fr img/VarY/*.bmp
	rm -fr img/VarXY_const/*.bmp
