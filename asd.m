%% AG_Ejercicio1
clear all %limpiar Workplace
close all %limpia ventanas
clc %limpia command window
%% Supuestos
%Poblacion multiplo de 4
%% Codigo
xmax = 2;
xmin = 0;
tpaso = 0.01;
num_ele = (xmax-xmin+1)/tpaso;
nbits = ceil(log2(num_ele));
np = 16; %numero de pobladores
%% Generar poblacion
xpadres = randi([0, 2^nbits-1], np, 1); %Pobladores iniciales enteros
xpadresreal = ((xmax-xmin)/(2^nbits-1))*xpadres + xmin; %Pobladores iniciales en numeros reales
for n=1:100
    y= -(xpadresreal+40.2).^2+100;
    yprom(n) = mean(y);
    %% Cromosoma
    cromosoma = [xpadres xpadresreal y];
    cromosoma = sortrows(cromosoma,size(cromosoma,2));
    %% Selecccion 
    padresbin = de2bi(cromosoma((np/2)+1:np,1),nbits); % Seleccion de los mejores y conversion a binario
    %% Cruzamiento
    hijobin = metodocruzamiento(padresbin,np,nbits,3);
    %% Mutacion
        n = rand();
        if n>=0.85
            nhijo = randi(np/2);
            nbit = randi(nbits);
            if hijobin(nhijo,nbit)== 1
                hijobin(nhijo,nbit)= 0;
            else
                hijobin(nhijo,nbit)= 1;
            end
        end
        hijoent = bi2de(hijobin); %Convierte de binario a decimal
        hijoreal = (((xmax - xmin)*hijoent)/((2^nbits)-1)) + xmin; %Convierte de binario a decimal
        
        xpadres = [cromosoma(np/2+1:np,1); hijoent]; %Sustitucion generada
        xpadresreal = [cromosoma(np/2+1:np,1); hijoreal];
end
%% Grafica y Resultados
y= -(xpadresreal+40.2).^2+100;
cromosoma = [xpadres xpadresreal y];
[val,ind] = max(y); 
disp(["Resultado xpadresreal: ", num2str(cromosoma(ind,2))])
disp(["Resultado y: ", num2str(val)])
plot(yprom); %Se grafican los promedios de la y
xlabel('x')
ylabel('y')
title('Gráfica de la Simulación')
max(y); %guarda el maximo valor de y