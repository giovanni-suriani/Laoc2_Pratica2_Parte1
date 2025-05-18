onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color yellow /contadoresR/Clear
add wave -noupdate -color yellow /contadoresR/IncrPc
add wave -noupdate -color yellow /contadoresR/RIn
add wave -noupdate -color red /contadoresR/Clock
add wave -noupdate -color magenta /contadoresR/RegEntrada
add wave -noupdate -color blue /contadoresR/RegSaida
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {245 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 231
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
view wave 
wave clipboard store
wave create -driver freeze -pattern constant -value 0000000101010001 -range 15 0 -starttime 0ps -endtime 1000ps sim:/contadoresR/RegEntrada 
WaveExpandAll -1
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/contadoresR/Clock 
wave create -driver freeze -pattern repeater -initialvalue 0 -period 100ps -sequence { 0 1  } -repeat 1 -starttime 0ps -endtime 1000ps sim:/contadoresR/RIn 
wave create -driver freeze -pattern repeater -initialvalue 1 -period 1ps -sequence { 1 0  } -repeat 1 -starttime 0ps -endtime 1000ps sim:/contadoresR/Clear 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/contadoresR/IncrPc 
wave modify -driver freeze -pattern repeater -initialvalue St1 -period 100ps -sequence { St1 St0  } -repeat 1 -starttime 0ps -endtime 1000ps Edit:/contadoresR/Clear 
wave modify -driver freeze -pattern constant -value 1 -starttime 100ps -endtime 1000ps Edit:/contadoresR/RIn 
wave modify -driver freeze -pattern constant -value 0 -starttime 100ps -endtime 1000ps Edit:/contadoresR/Clear 
WaveCollapseAll -1
wave clipboard restore
