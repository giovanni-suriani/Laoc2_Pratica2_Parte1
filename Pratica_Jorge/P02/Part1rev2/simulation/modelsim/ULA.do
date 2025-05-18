onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Red -radix decimal /ULA/A
add wave -noupdate -color Green -radix decimal /ULA/B
add wave -noupdate -color Yellow /ULA/Opcode
add wave -noupdate -color Blue -radix decimal /ULA/ResultadoULA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 20
configure wave -datasetprefix 0
configure wave -rowmargin 10
configure wave -childrowmargin 10
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {600 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern constant -value zzzzzzzzzzzzzzzz -range 15 0 -starttime 0ps -endtime 1000ps sim:/ULA/A 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value zzzzzzzzzzzzzzzz -range 15 0 -starttime 0ps -endtime 1000ps sim:/ULA/B 
WaveExpandAll -1
wave modify -driver freeze -pattern constant -value 0000000000000101 -range 15 0 -starttime 0ps -endtime 1000ps Edit:/ULA/A 
wave modify -driver freeze -pattern constant -value 0000000000000010 -range 15 0 -starttime 0ps -endtime 1000ps Edit:/ULA/B 
wave create -driver freeze -pattern repeater -initialvalue 0 -period 100ps -sequence { 0101 0110 0111 1000 1001 1010  } -repeat forever -range 3 0 -starttime 0ps -endtime 1000ps sim:/ULA/Opcode 
WaveExpandAll -1
wave modify -driver freeze -pattern repeater -initialvalue 0000 -period 100ps -sequence { 0101 0110 0111 1000 1001 1010  } -repeat never -range 3 0 -starttime 0ps -endtime 1000ps Edit:/ULA/Opcode 
WaveCollapseAll -1
wave clipboard restore
