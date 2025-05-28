onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clock /tb_processador/uut/clk
add wave -noupdate /tb_processador/uut/DIN
add wave -noupdate /tb_processador/uut/Resetn
add wave -noupdate /tb_processador/uut/Clock
add wave -noupdate /tb_processador/uut/Run
add wave -noupdate /tb_processador/uut/Done
add wave -noupdate /tb_processador/uut/BusWires
add wave -noupdate /tb_processador/uut/Instrucao
add wave -noupdate /tb_processador/uut/Tstep
add wave -noupdate /tb_processador/uut/Rout
add wave -noupdate /tb_processador/uut/Rin
add wave -noupdate /tb_processador/uut/R0out
add wave -noupdate /tb_processador/uut/R1out
add wave -noupdate /tb_processador/uut/IRin
add wave -noupdate /tb_processador/uut/BusWires_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 300
configure wave -valuecolwidth 319
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
WaveRestoreZoom {0 ps} {64 ps}
