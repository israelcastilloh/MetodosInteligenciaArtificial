%% Problema 2 Tarea 1: Adaline
clear all;
close all;
clc;

%%
datos = xlsread('CCPP.xlsx');
X1 = datos(:,1);
X2 = datos(:,2);
X3 = datos(:,3);
X4 = datos(:,4);
Y = datos(:,5);

%% MÍNIMOS CUADRADOS
n=size(Y,1); %Cantidad de Datos
Xa= [ones(n,1)]; %Primer columna de Xa

%Construir Xa
for i=1:10
    grado=9;
    Xa = func_polinomio([X1,X2,X3,X4],i); %bias (tiene la estructura del polinomio)
    Wmc=inv(Xa'*Xa)*Xa'*Y; %Mínimos cuadrados
    Yg_mc=Xa*Wmc; %Y testada estimada a través de mínimos cuadrados
    E=Y-Yg_mc; %Error
    J(i,1) = (E'*E)./(2*n); %Función de costo 
    Salida=1./(1+exp(-Yg_mc));
    plot(J,'b-');
end

subplot(2,1,1);
plot(Xa,Y,'b.',Xa,Yg_mc,'r.');
subplot(2,1,2)
plot(J,'b-');
xlabel('Grado del polinomio');
ylabel('J(W,X)');
J(grado)