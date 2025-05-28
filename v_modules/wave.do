onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clock /tb_processador/Clock
add wave -noupdate -label Opcode /tb_processador/Opcode
add wave -noupdate -label Run /tb_processador/uut/Run
add wave -noupdate -label DIN_uut -radix binary /tb_processador/uut/DIN
add wave -noupdate -label Instrucao_uut /tb_processador/uut/Instrucao
add wave -noupdate -label Tstep_uut /tb_processador/uut/Tstep
add wave -noupdate -label IRin_uut /tb_processador/uut/IRin
add wave -noupdate -label Rout_uut /tb_processador/uut/Rout
add wave -noupdate -label Rin_uut /tb_processador/uut/Rin
add wave -noupdate -label R0out_uut /tb_processador/uut/R0out
add wave -noupdate -label R1out_uut /tb_processador/uut/R1out
add wave -noupdate -label BusWires_data_uut /tb_processador/uut/BusWires_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {116 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {400 ps}
