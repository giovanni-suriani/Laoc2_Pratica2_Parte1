onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color red /counter/Clock
add wave -noupdate -color magenta /counter/Clear
add wave -noupdate -color blue -radix unsigned /counter/CounterSaida
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
configure wave -valuecolwidth 41
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
WaveRestoreZoom {0 ps} {2100 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 50ps -dutycycle 50 -starttime 0ps -endtime 2000ps sim:/counter/Clock 
wave create -driver freeze -pattern clock -initialvalue 0 -period 1000ps -dutycycle 50 -starttime 0ps -endtime 2000ps sim:/counter/Clear 
wave modify -driver freeze -pattern clock -initialvalue St0 -period 700ps -dutycycle 50 -starttime 0ps -endtime 2000ps Edit:/counter/Clear 
wave modify -driver freeze -pattern random -initialvalue 1 -period 50ps -random_type Uniform -seed 5 -starttime 0ps -endtime 2000ps Edit:/counter/Clear 
wave modify -driver freeze -pattern random -initialvalue St1 -period 50ps -random_type Normal -seed 5 -starttime 0ps -endtime 2000ps Edit:/counter/Clear 
wave modify -driver freeze -pattern random -initialvalue St1 -period 50ps -random_type Normal -seed 10 -starttime 0ps -endtime 2000ps Edit:/counter/Clear 
wave modify -driver freeze -pattern random -initialvalue St1 -period 100ps -random_type Normal -seed 3 -starttime 0ps -endtime 2000ps Edit:/counter/Clear 
WaveCollapseAll -1
wave clipboard restore
