onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clock /Pratica2_Parte1_top_level/Clock
add wave -noupdate -label Run /Pratica2_Parte1_top_level/proc/Run
add wave -noupdate -label Clear -radix unsigned /Pratica2_Parte1_top_level/proc/Clear
add wave -noupdate /Pratica2_Parte1_top_level/Reset
add wave -noupdate -label Done -radix binary /Pratica2_Parte1_top_level/Done
add wave -noupdate -label DIN_proc -radix binary /Pratica2_Parte1_top_level/proc/DIN
add wave -noupdate -label Instrucao_proc -radix binary /Pratica2_Parte1_top_level/proc/Instrucao
add wave -noupdate -label Tstep_proc /Pratica2_Parte1_top_level/proc/Tstep
add wave -noupdate -label IRin_proc /Pratica2_Parte1_top_level/proc/IRin
add wave -noupdate -label Rin_proc -radix binary /Pratica2_Parte1_top_level/proc/Rin
add wave -noupdate -label Rout_proc -radix binary /Pratica2_Parte1_top_level/proc/Rout
add wave -noupdate -label R0out_proc /Pratica2_Parte1_top_level/proc/R0out
add wave -noupdate -label R1out_proc /Pratica2_Parte1_top_level/proc/R1out
add wave -noupdate -label BusWires -radix binary /Pratica2_Parte1_top_level/BusWires
add wave -noupdate -label {Registrador IR} -radix binary /Pratica2_Parte1_top_level/proc/IR/Q
add wave -noupdate -label Rx_data -radix unsigned /Pratica2_Parte1_top_level/proc/Rx_data
add wave -noupdate -label Ry_data -radix unsigned /Pratica2_Parte1_top_level/proc/Ry_data
add wave -noupdate -label R0 -radix unsigned /Pratica2_Parte1_top_level/proc/R0/Q
add wave -noupdate -label R1 -radix unsigned /Pratica2_Parte1_top_level/proc/R1/Q
add wave -noupdate -label G -radix unsigned /Pratica2_Parte1_top_level/proc/G/Q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 197
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
WaveRestoreZoom {0 ps} {477 ps}
