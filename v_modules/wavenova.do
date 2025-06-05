onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clock /tb_processador/Clock
add wave -noupdate -label Resetn -radix unsigned /tb_processador/uut/Resetn
add wave -noupdate -label ADDRout -radix unsigned /tb_processador/uut/ADDRout
add wave -noupdate -label IncrPc -radix binary /tb_processador/uut/u_unidade_controle/IncrPc
add wave -noupdate -label Tstep_uut /tb_processador/uut/Tstep
add wave -noupdate -label Run /tb_processador/uut/Run
add wave -noupdate -label Opcode -radix binary /tb_processador/uut/Opcode
add wave -noupdate -label ADDR -radix unsigned /tb_processador/uut/ADDR/Q
add wave -noupdate -label Clear -radix unsigned /tb_processador/uut/Clear
add wave -noupdate -label Done -radix binary /tb_processador/Done
add wave -noupdate -label DIN_uut -radix binary /tb_processador/uut/DIN
add wave -noupdate -label Instrucao_uut -radix binary /tb_processador/uut/Instrucao
add wave -noupdate -label IRin_uut /tb_processador/uut/IRin
add wave -noupdate -label Rin_uut -radix binary /tb_processador/uut/Rin
add wave -noupdate -label Rout_uut -radix binary /tb_processador/uut/Rout
add wave -noupdate -label R0out_uut /tb_processador/uut/R0out
add wave -noupdate -label R1out_uut /tb_processador/uut/R1out
add wave -noupdate -label BusWires -radix binary /tb_processador/BusWires
add wave -noupdate -label {Registrador IR} -radix binary /tb_processador/uut/IR/Q
add wave -noupdate -label R0 -radix unsigned /tb_processador/uut/R0/Q
add wave -noupdate -label R1 -radix unsigned /tb_processador/uut/R1/Q
add wave -noupdate -label R2 -radix unsigned /tb_processador/uut/R2/Q
add wave -noupdate -label R3 -radix unsigned /tb_processador/uut/R3/Q
add wave -noupdate -label R4 -radix unsigned /tb_processador/uut/R4/Q
add wave -noupdate -label R5 -radix unsigned /tb_processador/uut/R5/Q
add wave -noupdate -label R6 -radix unsigned /tb_processador/uut/R6/Q
add wave -noupdate -label R7 -radix unsigned /tb_processador/uut/R7/Q
add wave -noupdate -label A -radix unsigned /tb_processador/uut/A/Q
add wave -noupdate -label G -radix unsigned /tb_processador/uut/G/Q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1711 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1451 ps} {2451 ps}
