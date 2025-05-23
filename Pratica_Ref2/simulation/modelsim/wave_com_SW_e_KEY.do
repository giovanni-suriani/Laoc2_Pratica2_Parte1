view wave 
wave clipboard store
wave create -pattern clock -initialvalue 0 -period 2ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/computador/clock 
wave create -pattern constant -value 1 -starttime 0ps -endtime 1500ps sim:/computador/run 
wave create -pattern constant -value 0 -starttime 0ps -endtime 1500ps sim:/computador/resetn 
wave create -driver freeze -pattern constant -value 1zzzzzzzzzzzzzzz0z -range 17 0 -starttime 0ps -endtime 1500ps sim:/computador/SW 
WaveExpandAll -1
wave create -driver freeze -pattern counter -startvalue 000 -endvalue 001 -type Range -direction Up -period 2ps -step 1 -repeat forever -range 2 0 -starttime 0ps -endtime 1000ps sim:/computador/KEY 
WaveExpandAll -1
WaveCollapseAll -1
wave clipboard restore
