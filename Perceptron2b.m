%CON PARTICIÓN DE DATOS 

clear all;
close all;
clc;

%Cargar datos
load datos2.mat;
data=datos2;
X=data(:,[1 2]);      %Se puede modificar para ver las varialbes
Y=data(:,3);  

%ESTA FUNCIÓN AUTOMATIZA EL SEPARAR (SOLO DATOS DE CLASIFICACIÓN NO REGRESIÓN)
cv=cvpartition(Y,'holdout',0.2) %da información de los datos separados
% holdout: divide aleatoriamente las observaciones en un conjunto de datos
% de entrenamiento y prueba, usando la información de la clase del grupo.
% Datos de entrenamiento.
Xtrain = X(training(cv),:);
Ytrain = Y(training(cv));
% Datos de prueba.
Xtest = X(test(cv),:);
Ytest = Y(test(cv));

n=size(Xtrain,1);

grado=2;     

Xa=func_polinomio(Xtrain,grado);
W=zeros(size(Xa,2),1);

[J,dJdW]=fun_costo(W,Xa,Ytrain);

options=optimset('GradObj', 'on', 'MaxIter', 1000);
[Wopt, Jopt]=fminunc(@(W)fun_costo(W,Xa,Ytrain), W, options); %guardar los pesos cuando 
                                                              %te da un modelo buenas métricas
                                                              %le das save en workspace "save as"

%Simulación 
V=Xa*Wopt;
Ygtrain=1./(1+exp(-V));
Ygtrain=round(Ygtrain);

TP=sum((Ytrain==1)&(Ygtrain==1)); 
TN=sum((Ytrain==1)&(Ygtrain==0)); 
FP=sum((Ytrain==0)&(Ygtrain==1));
FN=sum((Ytrain==1)&(Ygtrain==0)); 

Accu= (TP+TN)/(TP+TN+FP+FN); 
Prec=TP/(TP+FP); 
Recall=TP/(TP+FN);


%AHORA LOS TEST
Xatemp=func_polinomio(Xtest,grado);
%Simulación 
Vtemp=Xatemp*Wopt;
Ygtest=1./(1+exp(-Vtemp));
Ygtest=round(Ygtest);

TPtest=sum((Ytest==1)&(Ygtest==1)); 
TNtest=sum((Ytest==1)&(Ygtest==0)); 
FPtest=sum((Ytest==0)&(Ygtest==1));
FNtest=sum((Ytest==1)&(Ygtest==0)); 

Accutest= (TPtest+TNtest)/(TPtest+TNtest+FPtest+FNtest); 
Prectest=TPtest/(TPtest+FPtest); 
Recalltest=TPtest/(TPtest+FNtest);


[Accu Prec Recall ; Accutest Prectest Recalltest]

%confusionchart(Ytest, Ygtest) da la matriz de confusión pero alrevés

%% probar datos especificos ver cuales pasan en --> A

A = [3 2 12; 5 3 1; 4 1 4; 8 10 36]; 

Xatemp2 = func_polinomio(A,grado);
Vtemp2=Xatemp2*Wopt;
Yg2=1./(1+exp(-Vtemp2)); %Regresión logística
Yg2=round(Yg2)



