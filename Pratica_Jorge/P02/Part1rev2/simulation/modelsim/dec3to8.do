onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color red /dec3to8/En
add wave -noupdate -color magenta /dec3to8/W
add wave -noupdate -color blue -radix binary /dec3to8/Y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {69 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 172
configure wave -valuecolwidth 74
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
WaveRestoreZoom {0 ps} {970 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern counter -startvalue 000 -endvalue 111 -type Range -direction Up -period 100ps -step 1 -repeat never -range 2 0 -starttime 0ps -endtime 1000ps sim:/dec3to8/W 
WaveExpandAll -1
wave create -driver freeze -pattern repeater -initialvalue 0 -period 100ps -sequence { 0 1  } -repeat forever -starttime 0ps -endtime 1000ps sim:/dec3to8/En 
wave modify -driver freeze -pattern counter -startvalue 000 -endvalue 111 -type Range -direction Up -period 200ps -step 1 -repeat never -range 2 0 -starttime 0ps -endtime 1000ps Edit:/dec3to8/W 
wave modify -driver freeze -pattern repeater -initialvalue St0 -period 100ps -sequence { St0 St1  } -repeat forever -starttime 0ps -endtime 2000ps Edit:/dec3to8/En 
wave modify -driver freeze -pattern counter -startvalue 000 -endvalue 111 -type Range -direction Up -period 200ps -step 1 -repeat never -range 2 0 -starttime 0ps -endtime 2000ps Edit:/dec3to8/W 
WaveCollapseAll -1
wave clipboard restore
