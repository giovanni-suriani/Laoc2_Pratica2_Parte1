onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Yellow /registradoresR/RIn
add wave -noupdate -color Red /registradoresR/Clock
add wave -noupdate -color Green /registradoresR/RegEntrada
add wave -noupdate /registradoresR/RegSaida
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 279
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
wave create -driver freeze -pattern constant -value 0000000101001010 -range 15 0 -starttime 0ps -endtime 1000ps sim:/registradoresR/RegEntrada 
WaveExpandAll -1
wave create -driver freeze -pattern clock -initialvalue 0 -period 200ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/registradoresR/RIn 
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/registradoresR/Clock 
WaveCollapseAll -1
wave clipboard restore
