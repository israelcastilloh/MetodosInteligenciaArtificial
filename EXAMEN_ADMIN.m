%%PUT Y CALLS
clear all; clc
spot=19.12 %PUSISTE MAL TU SPOT :D
[dc1m, dp1m]=blsdelta(spot, [18.80	19.20	19.50], .0771, 30/360, [0.087	0.0923	0.0999],.0174)
%[dc2m, dp2m]=blsdelta(spot, [19 19.30 19.60], .0771, 60/360, [0.10110 	 0.10560 	 0.11370 ],.0167)
[dc3m, dp3m]=blsdelta(spot, [18.80	19.20	19.50], .0756, 90/360, [0.0904	0.0938	0.09835],.0163)
%[dc6m, dp6m]=blsdelta(spot, [19 19.30 19.60], .0771, 180/360,[0.10430  0.10630 	 0.11070 ],.0189)

