# Cria um script para compilar e simular o testbench de hierarquia de memória
# Cria a biblioteca de trabalho
vlib work
vlib altera
# Compila a biblioteca altera necessária 
# vlog -work altera /home/gi/altera/13.0sp1/modelsim_ase/altera/verilog/src/altera_mf.v
# vlog -work altera /home/gi/intelFPGA/20.1/modelsim_ase/altera/verilog/src/altera_mf.v

# Compila os arquivos Verilog necessários, *FALTA* memoram.v
vlog +acc tb_memoram.v memoram.v
vsim -L altera work.tb_memoram


# Executa a simulação

# Sinais do ambiente de simulação
add wave -label "clock" Clock



# Sinais do uut (unit under test)
add wave -label "wren" uut/wren
add wave -label "address" -radix unsigned uut/address
add wave -label "data" -radix binary uut/data
add wave -label "q" -radix binary uut/q


# Executa a simulacao
run 600ps

# Abre o waveform e ajusta exibição
radix -unsigned
view wave
WaveRestoreZoom 0ps 500ps
configure wave -timelineunits ps


# para rodar:   killmodelsim;vsim -do vlog_wave_tb_proc.do 
