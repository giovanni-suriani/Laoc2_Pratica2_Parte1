# Cria um script para compilar e simular o testbench de hierarquia de memória
# Cria a biblioteca de trabalho
vlib work
vlib altera
# Compila a biblioteca altera necessária 
# vlog -work altera /home/gi/altera/13.0sp1/modelsim_ase/altera/verilog/src/altera_mf.v

# Compila os arquivos Verilog necessários, *FALTA* memoram.v
vlog processador_multiciclo.v registrador.v registrador_IR.v mux.v unidade_controle.v contador_2bits.v memoram.v tb_processador.v
vsim -L altera work.tb_processador


# Executa a simulação
add wave -label "clock" tb_processador/Clock
add wave -label "clock_processador" tb_processador/uut/clk
add wave -label "DIN" /tb_processador/uut/DIN
add wave -label "Instrucao" tb_processador/uut/Instrucao
add wave -label "Tstep" tb_processador/uut/Tstep
add wave -label "IRin" tb_processador/uut/IRin
add wave -label "Rout" tb_processador/uut/Rout
add wave -label "Rin" tb_processador/uut/Rin
#add wave -label "R0out" tb_processador/uut/R0out
#add wave -label "R1out" tb_processador/uut/R1out
#add wave -label "BusWires_data" tb_processador/uut/BusWires_data

# Executa a simulacao
run 1000ps

# Abre o waveform e ajusta exibição
radix -unsigned
view wave
WaveRestoreZoom 0ps 400ps
configure wave -timelineunits ps


# para rodar:   killmodelsim;vsim -do vlog_wave_tb_proc.do 
