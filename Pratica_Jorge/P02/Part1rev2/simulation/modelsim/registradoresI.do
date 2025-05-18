onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /registradoresI/IRIn
add wave -noupdate /registradoresI/Clock
add wave -noupdate /registradoresI/InstEntrada
add wave -noupdate /registradoresI/InstSaida
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 262
configure wave -valuecolwidth 87
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
WaveRestoreZoom {0 ps} {800 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern constant -value 0101010001 -range 9 0 -starttime 0ps -endtime 1000ps sim:/registradoresI/InstEntrada 
WaveExpandAll -1
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/registradoresI/IRIn 
wave create -driver freeze -pattern clock -initialvalue 0 -period 200ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/registradoresI/Clock 
wave modify -driver freeze -pattern repeater -initialvalue 0 -period 100ps -sequence { 1 0  } -repeat forever -starttime 0ps -endtime 1000ps Edit:/registradoresI/IRIn 
wave modify -driver freeze -pattern repeater -initialvalue 0 -period 100ps -sequence { 0 1  } -repeat forever -starttime 0ps -endtime 1000ps Edit:/registradoresI/IRIn 
wave modify -driver freeze -pattern repeater -initialvalue St0 -period 200ps -sequence { St0 St1  } -repeat forever -starttime 0ps -endtime 1000ps Edit:/registradoresI/IRIn 
WaveCollapseAll -1
wave clipboard restore
