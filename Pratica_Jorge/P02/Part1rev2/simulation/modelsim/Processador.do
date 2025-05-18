onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Processador/Clock
add wave -noupdate /Processador/Run
add wave -noupdate /Processador/Resetn
add wave -noupdate -radix decimal /Processador/DIN
add wave -noupdate -radix unsigned /Processador/BusWires
add wave -noupdate /Processador/Write
add wave -noupdate -radix unsigned /Processador/AddressOut
add wave -noupdate -radix unsigned /Processador/DOUT
add wave -noupdate -radix unsigned /Processador/Tstep_Q
add wave -noupdate /Processador/Done
add wave -noupdate /Processador/Clear
add wave -noupdate /Processador/Rx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 279
configure wave -valuecolwidth 128
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
WaveRestoreZoom {0 ps} {10105 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern constant -value 0000000101010001 -range 15 0 -starttime 0ps -endtime 1000ps sim:/Processador/DIN 
WaveExpandAll -1
wave create -driver freeze -pattern repeater -initialvalue 0 -period 100ps -sequence { 0 1  } -repeat 1 -starttime 0ps -endtime 1000ps sim:/Processador/Resetn 
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/Processador/Clock 
wave create -driver freeze -pattern repeater -initialvalue 0 -period 100ps -sequence { 0 1  } -repeat 1 -starttime 0ps -endtime 1000ps sim:/Processador/Run 
wave modify -driver freeze -pattern constant -value 0 -starttime 100ps -endtime 1000ps Edit:/Processador/Resetn 
wave modify -driver freeze -pattern constant -value St0 -starttime 100ps -endtime 1000ps Edit:/Processador/Resetn 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 100ps Edit:/Processador/Resetn 
wave modify -driver freeze -pattern constant -value 1 -starttime 100ps -endtime 1000ps Edit:/Processador/Run 
wave modify -driver freeze -pattern clock -initialvalue St0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 10000ps Edit:/Processador/Clock 
wave modify -driver freeze -pattern constant -value St1 -starttime 100ps -endtime 10000ps Edit:/Processador/Run 
wave modify -driver freeze -pattern constant -value 0000000101010001 -range 15 0 -starttime 0ps -endtime 10000ps Edit:/Processador/DIN 
wave modify -driver freeze -pattern constant -value 0000000100001000 -range 15 0 -starttime 0ps -endtime 10000ps Edit:/Processador/DIN 
wave modify -driver freeze -pattern constant -value 000000000000000 -range 15 0 -starttime 0ps -endtime 10000ps Edit:/Processador/DIN 
WaveCollapseAll -1
wave clipboard restore
