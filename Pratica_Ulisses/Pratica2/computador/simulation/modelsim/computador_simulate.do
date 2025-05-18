view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 2ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/computador/CLOCK_50 
wave modify -driver freeze -pattern clock -initialvalue HiZ -period 6ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/computador/CLOCK_50 
wave create -driver freeze -pattern constant -value 1zzzzzzzzzzzzzzzzz -range 17 0 -starttime 0ps -endtime 1000ps sim:/computador/SW 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value z0 -range 1 0 -starttime 0ps -endtime 1000ps sim:/computador/KEY 
WaveExpandAll -1
wave modify -driver freeze -pattern clock -initialvalue 0 -period 6ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/computador/CLOCK_50 
WaveCollapseAll -1
wave clipboard restore
