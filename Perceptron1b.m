% Perceptrón

clear all; %borra todas las variables
close all; %cierra todas las ventanas
clc; % limpia pantalla
%%
% Cargar datos
load Skin_NonSkin.txt;
data = Skin_NonSkin;

%hold on
%contour(x1,x2, Ytemp, [0 0], 'LineWidth', 2);
%hold off

%Regresión logística
X=data(:,1:2);
Y=data(:,3);
n=size(X,1); %tamaño de la muestra

%Xa=[ones(n,1) X]; %se le añade una matriz de unos a X
Xa=func_polinomio(X,2);
W=zeros(size(Xa,2),1); %los pesos 


[J,dJdW]=fun_costo(W,Xa,Y);

options=optimset('GradObj', 'on', 'MaxIter', 1000);
[Wopt, Jopt]=fminunc(@(W)fun_costo(W,Xa,Y), W, options);

%Simulación 
V=Xa*Wopt;
Yg=1./(1+exp(-V));
Yg=round(Yg);
%Yg=Yg>=0.5;

TP=sum((Y==1)&(Yg==1)); %True Positive
TN=sum((Y==1)&(Yg==0)); %True Negative
FP=sum((Y==0)&(Yg==1)); %False Positive
FN=sum((Y==1)&(Yg==0)); %False Negative

Accu= (TP+TN)/(TP+TN+FP+FN); %EL % TOTAL DE ELEMENTOS CLASIFICADOS CORRECTAMENTE
Prec=TP/(TP+FP); %EL % DE LOS 1s ESTIMADOS CUANTOS SON 1s
Recall=TP/(TP+FN); %EL % DE LOS 1s REALES A LOS QUE LE ATINÓ EL MODELO


[Accu Prec Recall]

%%

%dibujar la frontera de separación
x1=-1:0.1:1;
x2=-1:0.1:1;
x3=-1:0.1:1;
x4=-1:0.1:1;

[x1,x2, x3, x4]=meshgrid(x1,x2, x3,x4);
[m,n]=size(x1);
x1temp=reshape(x1,m*n,1);
x2temp=reshape(x2,m*n,1);
x3temp=reshape(x3,m*n,1);
x4temp=reshape(x4,m*n,1);
xtemp=[x1temp x2temp x3temp x4temp];
%Ytemp=[ones(m*n,1) x1temp x2temp]*Wopt;
Ytemp=func_polinomio(xtemp,2)*Wopt;
Ytemp=reshape(Ytemp, m, n);

plot(G0(:,1), G0(:,2), 'bo', G1(:,1), G1(:,2), 'rx');

hold on
contour(x1,x2, Ytemp, [0 0], 'LineWidth', 2);
hold off

%% Modelo 1 -- CON FUNC_POLINOMIO

A = [-1,1; 0,2; 0,1; 0.5,0.5 ; 0.75,0.75; 1,1; 2,3; 2,-1];

Xatemp = func_polinomio(A,2);
Vtemp=Xatemp*Wopt;
Salida=1./(1+exp(-Vtemp)); %Regresión logística
Salida=round(Salida)

plot(G0(:,1), G0(:,2), 'bo', G1(:,1), G1(:,2), 'rx');

hold on
contour(x1,x2, Ytemp, [0 0], 'LineWidth', 2);
hold off

%% Modelo 2 -- CON SIMPLE CLUSTER

clear all;
close all;
clc;

%Cargar datos 
load simplecluster_dataset.mat; %Predefinida en matlab 
                                %utilizando esta función, instalar nnstart
X=simpleclusterInputs';         %Probar con diferentes datos
Y=simpleclusterTarget(1,:)';
data=[X Y]


G0=data(data(:,3)==0,1:2); 
G1=data(data(:,3)==1,1:2); 

plot(G0(:,1), G0(:,2), 'bo', G1(:,1), G1(:,2), 'rx');


%Regresión logística
n=size(X,1);

grado=2                         %MOFICAR GRADOS PARA VER EXACTITUD
Xa=func_polinomio(X,grado);
W=zeros(size(Xa,2),1);

[J,dJdW]=fun_costo(W,Xa,Y);

options=optimset('GradObj', 'on', 'MaxIter', 1000);
[Wopt, Jopt]=fminunc(@(W)fun_costo(W,Xa,Y), W, options);

%Simulación 
V=Xa*Wopt;
Yg=1./(1+exp(-V));
Yg=round(Yg);

TP=sum((Y==1)&(Yg==1)); 
TN=sum((Y==1)&(Yg==0)); 
FP=sum((Y==0)&(Yg==1));
FN=sum((Y==1)&(Yg==0)); 

Accu= (TP+TN)/(TP+TN+FP+FN); 
Prec=TP/(TP+FP); 
Recall=TP/(TP+FN);


[Accu Prec Recall]

x1=-1:0.1:1;
x2=-1:0.1:1;

[x1,x2]=meshgrid(x1,x2);
[m,n]=size(x1);
x1temp=reshape(x1,m*n,grado);
x2temp=reshape(x2,m*n,grado);
xtemp=[x1temp x2temp];
Ytemp=func_polinomio(xtemp,grado)*Wopt; 
Ytemp=reshape(Ytemp, m, n);

plot(G0(:,1), G0(:,2), 'bo', G1(:,1), G1(:,2), 'rx');

hold on
contour(x1,x2, Ytemp, [0 0], 'LineWidth', 2);
hold off


%% Modelo 2 -- CON FUNC_POLINOMIO Y SIMPLE CLUSTERS

A = simpleclusterInputs';

Xatemp = func_polinomio(A,2);
Vtemp=Xatemp*Wopt;
Salida=1./(1+exp(-Vtemp)); %Regresión logística
Salida=round(Salida)

plot(G0(:,1), G0(:,2), 'bo', G1(:,1), G1(:,2), 'rx');

hold on
contour(x1,x2, Ytemp, [0 0], 'LineWidth', 2);
hold off



