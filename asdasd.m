

clear all; %Limpia todas las variables
close all; %Cierra todas las ventanas
clc;       %Limoia el espacio de trabajo

%Ejercicio 1
%Objetivo: Max(y) | donde y = x^2
%Rango: xE[0,255]

nbits = 8; %Cantidad de Bits
np = 32;    %Numero de Pobladores

%1.- Poblacion Inicial
xpadres = randi([0,255], np, 1); %Padres aleatorios en intervalo

%% Iterar
for n = 1: 100
     
    %2.- Evaluarlos
    y = xpadres.^2; %Funcion para evaluar la poblacion
    
    yprom(n) = mean(y);
    
    %Cromosoma (convertir a binario)
    crom = [xpadres y];
    cromosoma = sortrows([xpadres y], 2); %Ordenar de mas pequeño a mayor

    %% 3.- Seleccionar
    padresBin = de2bi(cromosoma(np/2+1:np, 1), nbits);
    %Tomar ultimos (4) columna 1 (padres), y convertirlo a binario con (8) bits

   
        %Aritmetico
       for i =1:np/2
           j = i+1;
           if j == np/2+1
               j = 1;
           end
           hijo(i,1) = crom(i,1)+crom(j,1);
           hijobin(i,:) = de2bi(hijo(i,1),nbits+1);
       end
       hijoBin = hijobin(:,1:end-1);
%%
    %Mutacion
    na = rand(); %Aleatorio [0,1]
    if na >= 0.8 %Probabilidad de 20% de mutacion
        %Si muta, que sea aleatoriamente
        nhijo = randi(np/2);
        nbit = randi(nbits);
        if hijoBin(nhijo, nbit) == 1
            hijoBin(nhijo, nbit) = 0;
        else
            hijoBin(nhijo, nbit) = 1;
        end
    end
    
    %Los hijos de binario a decimal
    hijoDec = bi2de(hijoBin);

    xpadres = [cromosoma(np/2+1: np, 1); hijoDec];
end

plot(yprom)