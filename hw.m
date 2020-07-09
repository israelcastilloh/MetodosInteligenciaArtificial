%PSO (Particle Swarm Optimization) with Parametric Restrictions 
%Triangulo "Región Factible"
clear all;
close all;
clc;

np=1000; %número de partículas

%función a graficar
x1 = -10000:0.01:10000;%definir tamaño de paso / intervalo
x2 = -10000:0.01:10000;



x1p=rand(np,1).*randi([-10 10], np,1); %las posiciones iniciales
x2p=rand(np,1)+10;

x1pL=x1p;
x2pL=x2p;

vx1=zeros(np,1); %velocidades iniciales
x1pg=0;  %Posicion del mejor global

vx2=zeros(np,1); %velocidades iniciales
x2pg=0;  %Posicion del mejor global

fxpg=10000; %mejor desempeño inicial
fxpL=ones(np,1)*fxpg; %desempeño local inicial


c1=0.80; %Velocidad de convergencia
c2=0.80; %velocidad de convergencia


a = -1000; %se hace negativo al maximizar y solo la función en negativo

for i=1:100 %Número de generaciones
   fx= -(5*x1p+2*x2p+a*max(3*x1p+2*x2p-2400,0)+ a*max(x2p-800,0)+ ...
        a*max(2*x1p-1200,0)+ ... + 
        a*max(-x1p,0)+a*max(-x2p,0));

        %función de desempeño con restricciones
    
    [val,ind] = min(fx);
    
    if val<fxpg %Actualización del mejor global
        fxpg=val; %Desempeño 
        x1pg=x1p(ind,1); %Posición
        x2pg=x2p(ind,1);
    end
    
    for p=1:np
        if fx(p,1)<fxpL(p,1)
            fxpL(p,1)=fx(p,1); %se actualiza el desempeño del local
            x1pL(p,1)=x1p(p,1); %se actualizan las nuevas posiciones del local ********** (duda)  *******
            x2pL(p,1)=x2p(p,1);
        end
    end    

    plot(x1p, x2p, 'bo', x1pg, x2pg, 'go')
    axis([-10 10 -10 10]);
    title(['x1pg= ' num2str(x1pg) ' x2pg= ' num2str(x2pg)]);
    pause(0.1);
    
    %Ecuaciones de movimiento
    
    vx1=vx1+c1*rand()*(x1pg-x1p)+c2*rand()*(x1pL-x1p); %ecuación de velocidad
    x1p=x1p+vx1; %ecuación de posición
    
    vx2=vx2+c1*rand()*(x2pg-x2p)+c2*rand()*(x2pL-x2p); %ecuación de velocidad
    x2p=x2p+vx2; %ecuación de posición
            
end         

fxpg= 5*x1pg+2*x2pg

