clear all; clc
spot=19.67
vols=xlsread('ob.xlsx', 'ejercicio 1', 'f15:h18');
tasasmxn=xlsread('ob.xlsx', 'ejercicio 1', 'b7:b10');
tasasusd=xlsread('ob.xlsx', 'ejercicio 1', 'c7:c10');
[dc1m, dp1m]=blsdelta(spot, [19 19.5 20], tasasmxn(1), 30/360, vols(1,:),tasasusd(1))
[dc2m, dp2m]=blsdelta(spot, [19 19.5 20], tasasmxn(2), 60/360, vols(2,:),tasasusd(2))
[dc3m, dp3m]=blsdelta(spot, [19 19.5 20], tasasmxn(3), 90/360, vols(3,:),tasasusd(3))
[dc4m, dp4m]=blsdelta(spot, [19 19.5 20], tasasmxn(4), 180/360, vols(4,:),tasasusd(4))
