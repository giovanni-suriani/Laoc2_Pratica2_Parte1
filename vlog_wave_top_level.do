# Cria um script para compilar e simular o testbench de hierarquia de memória
# Cria a biblioteca de trabalho
vlib work
vlib altera
# Compila a biblioteca altera necessária 
# vlog -work altera /home/gi/altera/13.0sp1/modelsim_ase/altera/verilog/src/altera_mf.v

# Compila os arquivos Verilog necessários, *FALTA* memoram.v
vlog +acc Pratica2_Parte1_top_level.v display.v v_modules/processador_multiciclo.v v_modules/registrador.v v_modules/registrador_IR.v v_modules/mux.v v_modules/unidade_controle.v v_modules/contador_2bits.v v_modules/memoram.v v_modules/decode3_8bits.v v_modules/ula.v 
vsim -L altera work.Pratica2_Parte1_top_level


# Executa a simulação

# Sinais do ambiente de simulação
add wave -label "clock" Pratica2_Parte1_top_level/Clock
#add wave -label "Opcode" -radix binary Pratica2_Parte1_top_level/Opcode


# Sinais do uut (unit under test)
#add wave -label "clock_processador" Pratica2_Parte1_top_level/proc/Clock
add wave -label "Run" Pratica2_Parte1_top_level/proc/Run
add wave -label "Clear" -radix unsigned Pratica2_Parte1_top_level/proc/Clear
add wave -label "Done" -radix binary Pratica2_Parte1_top_level/Done
add wave -label "DIN_proc" -radix binary /Pratica2_Parte1_top_level/proc/DIN
add wave -label "Instrucao_proc" -radix binary Pratica2_Parte1_top_level/proc/Instrucao
add wave -label "Tstep_proc" Pratica2_Parte1_top_level/proc/Tstep
add wave -label "IRin_proc" Pratica2_Parte1_top_level/proc/IRin
add wave -label "Rin_proc" -radix binary Pratica2_Parte1_top_level/proc/Rin
add wave -label "Rout_proc" -radix binary Pratica2_Parte1_top_level/proc/Rout
add wave -label "R0out_proc" Pratica2_Parte1_top_level/proc/R0out
add wave -label "R1out_proc" Pratica2_Parte1_top_level/proc/R1out
#add wave -label "BusWires_data_proc" Pratica2_Parte1_top_level/proc/BusWires_data
add wave -label "BusWires" -radix binary Pratica2_Parte1_top_level/BusWires
add wave -label "Registrador IR" -radix binary Pratica2_Parte1_top_level/proc/IR/Q
#add wave -label "u_unidade_controle Rin" -radix binary Pratica2_Parte1_top_level/proc/u_unidade_controle/Rin
#add wave -label "u_unidade_controle Rout" -radix binary Pratica2_Parte1_top_level/proc/u_unidade_controle/Rout
#add wave -label "Wire_Rin" -radix binary Pratica2_Parte1_top_level/proc/u_unidade_controle/Wire_Rin
#add wave -label "Wire_Rout" -radix binary Pratica2_Parte1_top_level/proc/u_unidade_controle/Wire_Rout
add wave -label "Rx_data" -radix unsigned Pratica2_Parte1_top_level/proc/Rx_data
add wave -label "Ry_data" -radix unsigned Pratica2_Parte1_top_level/proc/Ry_data
add wave -label "R0" -radix unsigned Pratica2_Parte1_top_level/proc/R0/Q
add wave -label "R1" -radix unsigned Pratica2_Parte1_top_level/proc/R1/Q
add wave -label "G" -radix unsigned Pratica2_Parte1_top_level/proc/G/Q

# Executa a simulacao
run 600ps

# Abre o waveform e ajusta exibição
radix -unsigned
force -repeat 100ps Pratica2_Parte1_top_level/Clock 1 0ps, 0 50ps
view wave
WaveRestoreZoom 0ps 500ps
configure wave -timelineunits ps


# para rodar:   killmodelsim;vsim -do vlog_wave_tb_proc.do 
