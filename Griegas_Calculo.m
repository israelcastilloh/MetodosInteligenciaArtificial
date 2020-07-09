% Solo lo toma de puts
[dcall dput] = blsdelta(43.15 ,42 ,90/360, .080950, .19, .025)

%% Para que te de calls y puts
[dcall dput] = blsdelta(95,[130,95,70], .08, .5, 0 .28, )
%Siempre te da las respuestas en el orden que pusiste los datos del K
%(strike). Si es positivo el delta es de largo en call. Y en el put te
% asume que lo estas larga. Mejor guiarse por la tablita. 
%% Para calcular los precios
[pcall pput] = blsprice(43.15 , 42 , 90/360 , .080950, .19, .025)

%% Para gamma
gamma = blsgamma(95,[130,95,70], .08, .5, 0.28)

%% Para Vega
vega = blsvega(43.15,[130,95,70], .08, .5, 0.28)


