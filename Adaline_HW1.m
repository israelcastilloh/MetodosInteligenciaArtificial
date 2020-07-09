%% Problema 1 Tarea 1: Adaline
clear all;
close all;
clc;

%%
datos = xlsread('regresion','Problema 1','A2:B201');
X = datos(:,1);
Y = datos(:,2);
%% MÍNIMOS CUADRADOS
n=size(X,1); %Cantidad de Datos
Xa= [ones(n,1)]; %Primer columna de Xa
%Construir Xa
for i=1:3
    grado=i;
    Xa = [Xa X.^i]; %bias (tiene la estructura del polinomio)
    Wmc=inv(Xa'*Xa)*Xa'*Y; %Mínimos cuadrados
    Yg_mc=Xa*Wmc; %Y testada estimada a través de mínimos cuadrados
    E=Y-Yg_mc; %Error
    J(i,1) = (E'*E)./(2*n); %Función de costo 
end


subplot(2,1,2);
plot(X,Y,'b.',X,Yg_mc,'r.');
subplot(2,1,1);
plot(J,'b-');
xlabel('Grado del polinomio');
ylabel('J(W,X)');
J(grado)






