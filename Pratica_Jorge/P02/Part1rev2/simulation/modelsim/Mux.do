onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Magenta -radix decimal /mux/DIN
add wave -noupdate -color Magenta -radix decimal /mux/R0Saida
add wave -noupdate -color Magenta -radix decimal /mux/R1Saida
add wave -noupdate -color Magenta -radix decimal /mux/R2Saida
add wave -noupdate -color Magenta -radix decimal /mux/R3Saida
add wave -noupdate -color Magenta -radix decimal /mux/R4Saida
add wave -noupdate -color Magenta -radix decimal /mux/R5Saida
add wave -noupdate -color Magenta -radix decimal /mux/R6Saida
add wave -noupdate -color Magenta -radix decimal /mux/R7Saida
add wave -noupdate -color Magenta -radix decimal /mux/GSaida
add wave -noupdate -color Green -radix binary /mux/ROut
add wave -noupdate -color Red /mux/GOut
add wave -noupdate -color Yellow /mux/DINOut
add wave -noupdate -color Blue -radix decimal /mux/MuxSaida
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 212
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
WaveRestoreZoom {0 ps} {1300 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern constant -value 0000000101010001 -range 15 0 -starttime 0ps -endtime 1000ps sim:/mux/DIN 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000000001 -range 15 0 -starttime 0ps -endtime 1000ps sim:/mux/R0Saida 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000000010 -range 15 0 -starttime 0ps -endtime 1000ps sim:/mux/R1Saida 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000000011 -range 15 0 -starttime 0ps -endtime 1000ps sim:/mux/R2Saida 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000000100 -range 15 0 -starttime 0ps -endtime 1000ps sim:/mux/R3Saida 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000000101 -range 15 0 -starttime 0ps -endtime 1000ps sim:/mux/R4Saida 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000000110 -range 15 0 -starttime 0ps -endtime 1000ps sim:/mux/R5Saida 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000000111 -range 15 0 -starttime 0ps -endtime 1000ps sim:/mux/R6Saida 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000001000 -range 15 0 -starttime 0ps -endtime 1000ps sim:/mux/R7Saida 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000001001 -range 15 0 -starttime 0ps -endtime 1000ps sim:/mux/GSaida 
WaveExpandAll -1
wave create -driver freeze -pattern repeater -initialvalue 0 -period 100ps -sequence { 00000001 00000010 00000100 00001000 00010000 00100000 01000000 10000000  } -repeat forever -range 7 0 -starttime 0ps -endtime 1000ps sim:/mux/ROut 
WaveExpandAll -1
wave modify -driver freeze -pattern repeater -initialvalue 00000000 -period 100ps -sequence { 00000001 00000010 00000100 00001000 00010000 00100000 01000000 10000000  } -repeat never -range 7 0 -starttime 0ps -endtime 1000ps Edit:/mux/ROut 
wave create -driver freeze -pattern repeater -initialvalue 0 -period 100ps -sequence { 0 1  } -repeat never -starttime 800ps -endtime 1000ps sim:/mux/GOut 
wave modify -driver freeze -pattern constant -value 0000000101010001 -range 15 0 -starttime 0ps -endtime 2000ps Edit:/mux/DIN 
wave modify -driver freeze -pattern constant -value 0000000000000001 -range 15 0 -starttime 0ps -endtime 2000ps Edit:/mux/R0Saida 
wave modify -driver freeze -pattern constant -value 0000000000000010 -range 15 0 -starttime 0ps -endtime 2000ps Edit:/mux/R1Saida 
wave modify -driver freeze -pattern constant -value 0000000000000011 -range 15 0 -starttime 0ps -endtime 2000ps Edit:/mux/R2Saida 
wave modify -driver freeze -pattern constant -value 0000000000000100 -range 15 0 -starttime 0ps -endtime 2000ps Edit:/mux/R3Saida 
wave modify -driver freeze -pattern constant -value 0000000000000101 -range 15 0 -starttime 0ps -endtime 2000ps Edit:/mux/R4Saida 
wave modify -driver freeze -pattern constant -value 0000000000000110 -range 15 0 -starttime 0ps -endtime 2000ps Edit:/mux/R5Saida 
wave modify -driver freeze -pattern constant -value 0000000000000111 -range 15 0 -starttime 0ps -endtime 2000ps Edit:/mux/R6Saida 
wave modify -driver freeze -pattern constant -value 0000000000001000 -range 15 0 -starttime 0ps -endtime 2000ps Edit:/mux/R7Saida 
wave modify -driver freeze -pattern constant -value 0000000000001001 -range 15 0 -starttime 0ps -endtime 2000ps Edit:/mux/GSaida 
wave modify -driver freeze -pattern repeater -initialvalue 00000000 -period 100ps -sequence { 00000001 00000010 00000100 00001000 00010000 00100000 01000000 10000000 00000000  } -repeat never -range 7 0 -starttime 0ps -endtime 2000ps Edit:/mux/ROut 
wave modify -driver freeze -pattern repeater -initialvalue St0 -period 100ps -sequence { St0 St1 0  } -repeat never -starttime 800ps -endtime 1000ps Edit:/mux/GOut 
wave modify -driver freeze -pattern repeater -initialvalue St0 -period 100ps -sequence { St0 St1 St0  } -repeat never -starttime 800ps -endtime 1000ps Edit:/mux/GOut 
wave modify -driver freeze -pattern repeater -initialvalue St0 -period 100ps -sequence { St0 St1 St0  } -repeat never -starttime 800ps -endtime 2000ps Edit:/mux/GOut 
wave create -driver freeze -pattern repeater -initialvalue 0 -period 50ps -sequence { 0 1 0  } -repeat forever -starttime 1100ps -endtime 2000ps sim:/mux/DINOut 
wave modify -driver freeze -pattern repeater -initialvalue St0 -period 100ps -sequence { St0 St1 St0  } -repeat never -starttime 1100ps -endtime 2000ps Edit:/mux/DINOut 
wave modify -driver freeze -pattern repeater -initialvalue 1 -period 100ps -sequence { 1 0  } -repeat never -starttime 1100ps -endtime 2000ps Edit:/mux/DINOut 
WaveCollapseAll -1
wave clipboard restore
