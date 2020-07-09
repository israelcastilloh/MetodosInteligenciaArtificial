clear all;
close all;
clc;

%Cargar datos
load datos4.mat

Y=[IPCfinal(:,4) IPCfinal(:,5)]'; %Variable dependiente
X=[BMV_1final(:,5) BMV_7final(:,5) BMV_13final(:,5)]'; %Variable independiente


ndat=round(0.9*size(Y,2)); %Se redondea para no tener decimales

Xtrain=X(:,1:ndat); 
Ytrain=Y(:,1:ndat);

%Crear la red neuronal
red=feedforwardnet([10 10 5]);

red.trainFcn='trainlm'; %Tipo de entrenamiento
%traingd entrenamiento por gradiente Descendente
%trainlm Entrenamiento por Levenberg-Marquart
red=train(red,Xtrain,Ytrain);
% Cu?l red, con qu? datos de entrada y qu? datos de salida

%Simulaci?n
Yg=red(X);
figure(1)
plot(1:size(Y,2),Y(1,:),'-b',1:size(Y,2),Yg(1,:),'r--')
figure(2)
plot(1:size(Y,2),Y(2,:),'-b',1:size(Y,2),Yg(2,:),'r--')
perform(red,Y,Yg)



