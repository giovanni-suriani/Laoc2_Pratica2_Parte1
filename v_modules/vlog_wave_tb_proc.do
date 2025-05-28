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

# Sinais do ambiente de simulação
add wave -label "clock" tb_processador/Clock
add wave -label "Opcode" -radix binary tb_processador/Opcode


# Sinais do uut (unit under test)
#add wave -label "clock_processador" tb_processador/uut/Clock
add wave -label "Run" tb_processador/uut/Run
add wave -label "DIN_uut" -radix binary /tb_processador/uut/DIN
add wave -label "Instrucao_uut" -radix binary tb_processador/uut/Instrucao
add wave -label "Tstep_uut" tb_processador/uut/Tstep
add wave -label "IRin_uut" tb_processador/uut/IRin
add wave -label "Rout_uut" tb_processador/uut/Rout
add wave -label "Rin_uut" tb_processador/uut/Rin
add wave -label "R0out_uut" tb_processador/uut/R0out
add wave -label "R1out_uut" tb_processador/uut/R1out
add wave -label "BusWires_data_uut" tb_processador/uut/BusWires_data
add wave -label "Registrador IR" -radix binary tb_processador/uut/IR/R

# Executa a simulacao
run 1000ps

# Abre o waveform e ajusta exibição
radix -unsigned

view wave
WaveRestoreZoom 0ps 400ps
configure wave -timelineunits ps


# para rodar:   killmodelsim;vsim -do vlog_wave_tb_proc.do 
