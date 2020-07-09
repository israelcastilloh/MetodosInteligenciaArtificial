clear all;close all;clc
precios=xlsread('sp500.xlsx','d','B2:B756');
rends=price2ret(precios);
 
Modelogarch=garch(1,1);
 
for n=500:length(rends)
    Mgarchajustado{n}=estimate(Modelogarch,rends(n-499:n));
    varianza{n}=forecast(Mgarchajustado{n},1,'Y0',rends(n-249:n));  
end
