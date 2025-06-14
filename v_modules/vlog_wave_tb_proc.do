# Cria um script para compilar e simular o testbench de hierarquia de memória
# Cria a biblioteca de trabalho
vlib work
vlib altera
# Compila a biblioteca altera necessária 
# vlog -work altera /home/gi/altera/13.0sp1/modelsim_ase/altera/verilog/src/altera_mf.v

# Compila os arquivos Verilog necessários, *FALTA* memoram.v
vlog +acc processador_multiciclo.v registrador.v registrador_IR.v mux.v unidade_controle.v contador_2bits.v memoram.v decode3_8bits.v ula.v tb_processador.v
vsim -L altera work.tb_processador


# Executa a simulação

# Sinais do ambiente de simulação
add wave -label "clock" tb_processador/Clock
#add wave -label "Opcode" -radix binary tb_processador/Opcode


# Sinais do uut (unit under test)
#add wave -label "clock_processador" tb_processador/uut/Clock
add wave -label "Run" tb_processador/uut/Run
add wave -label "Clear" -radix unsigned tb_processador/uut/Clear
add wave -label "Done" -radix binary tb_processador/Done
add wave -label "DIN_uut" -radix binary /tb_processador/uut/DIN
add wave -label "Instrucao_uut" -radix binary tb_processador/uut/Instrucao
add wave -label "Tstep_uut" tb_processador/uut/Tstep
add wave -label "IRin_uut" tb_processador/uut/IRin
add wave -label "Rin_uut" -radix binary tb_processador/uut/Rin
add wave -label "Rout_uut" -radix binary tb_processador/uut/Rout
add wave -label "R0out_uut" tb_processador/uut/R0out
add wave -label "R1out_uut" tb_processador/uut/R1out
#add wave -label "BusWires_data_uut" tb_processador/uut/BusWires_data
add wave -label "BusWires" -radix binary tb_processador/BusWires
add wave -label "Registrador IR" -radix binary tb_processador/uut/IR/Q
#add wave -label "u_unidade_controle Rin" -radix binary tb_processador/uut/u_unidade_controle/Rin
#add wave -label "u_unidade_controle Rout" -radix binary tb_processador/uut/u_unidade_controle/Rout
#add wave -label "Wire_Rin" -radix binary tb_processador/uut/u_unidade_controle/Wire_Rin
#add wave -label "Wire_Rout" -radix binary tb_processador/uut/u_unidade_controle/Wire_Rout
#add wave -label "Rx_data" -radix unsigned tb_processador/uut/Rx_data
#add wave -label "Ry_data" -radix unsigned tb_processador/uut/Ry_data
add wave -label "R0" -radix unsigned tb_processador/uut/R0/Q
add wave -label "R1" -radix unsigned tb_processador/uut/R1/Q
add wave -label "R2" -radix unsigned tb_processador/uut/R2/Q
add wave -label "R3" -radix unsigned tb_processador/uut/R3/Q
add wave -label "R4" -radix unsigned tb_processador/uut/R4/Q
add wave -label "R5" -radix unsigned tb_processador/uut/R5/Q
add wave -label "R6" -radix unsigned tb_processador/uut/R6/Q
add wave -label "R7" -radix unsigned tb_processador/uut/R7/Q
add wave -label "A" -radix unsigned tb_processador/uut/A/Q
add wave -label "G" -radix unsigned tb_processador/uut/G/Q

# Executa a simulacao
run 600ps

# Abre o waveform e ajusta exibição
radix -unsigned
view wave
WaveRestoreZoom 0ps 500ps
configure wave -timelineunits ps


# para rodar:   killmodelsim;vsim -do vlog_wave_tb_proc.do 
