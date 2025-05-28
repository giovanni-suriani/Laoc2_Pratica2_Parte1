# Cria um script para compilar e simular o testbench de hierarquia de memória
# Cria a biblioteca de trabalho
vlib work
vlib altera
# Compila a biblioteca altera necessária 
# vlog -work altera /home/gi/altera/13.0sp1/modelsim_ase/altera/verilog/src/altera_mf.v

# Compila os arquivos Verilog necessários, *FALTA* memoram.v
vlog processador_multiciclo.v registrador.v registrador_IR.v mux.v unidade_controle.v contador_2bits.v memoram.v
vsim -L altera work.processador_multiciclo


# Executa a simulação
add wave -label "clock" /processador_multiciclo/clk
add wave -label "DIN" /processador_multiciclo/DIN
add wave -label "Instrucao" /processador_multiciclo/Instrucao
add wave -label "Tstep" /processador_multiciclo/Tstep
add wave -label "IRin" /processador_multiciclo/IRin
add wave -label "Rout" /processador_multiciclo/Rout
add wave -label "Rin" /processador_multiciclo/Rin
add wave -label "R0out" /processador_multiciclo/R0out
add wave -label "R1out" /processador_multiciclo/R1out
add wave -label "BusWires_data" /processador_multiciclo/BusWires_data

# Executa a simulacao
run 1000ps

# Abre o waveform e ajusta exibição
radix -unsigned
view wave
WaveRestoreZoom 0ps 100ps
configure wave -timelineunits ps


# para rodar:   killmodelsim;vsim -do vlog_wave_proc.do 
