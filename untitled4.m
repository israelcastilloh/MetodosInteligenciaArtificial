%% Para calcular los precios
[pcall pput] = blsprice(19.7775 , 19.80 , .0761, 90/360, .01021)
%%

% Solo lo toma de puts
[dcall dput] = blsdelta(19.4775 , 20 , .0761, 90/360, .0931)