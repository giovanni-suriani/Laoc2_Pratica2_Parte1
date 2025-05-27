# Cria um script para compilar e simular o testbench de hierarquia de memória
# Cria a biblioteca de trabalho
vlib work
vlib altera
# Compila a biblioteca altera necessária vlog -work altera /home/gi/altera/13.0sp1/modelsim_ase/altera/verilog/src/altera_mf.v

# Compila os arquivos Verilog necessários
vlog contador_2bits.v decode3-8bits.v mux.v processador_multiciclo.v registrador.v unidade_controle.v tb_processador.v # memoram.v
vsim -L altera work.tb_processador -c -do "run 10000ps; quit"

# para rodar:  clear;vsim -c -do vlog_terminal_tb_proc.do