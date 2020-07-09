%PSO (Particle Swarm Optimization) with Parametric Restrictions 
%Triangulo "Región Factible"
clear all;
close all;
clc;

np=1000; %número de partículas

%función a graficar
x1 = -5:0.01:5;%definir tamaño de paso / intervalo

x1p=rand(np,1).*randi([-5 5], np,1); %las posiciones iniciales

x1pL=x1p;


vx1=zeros(np,1); %velocidades iniciales
x1pg=0;  %Posicion del mejor global


fxpg=10000; %mejor desempeño inicial
fxpL=ones(np,1)*fxpg; %desempeño local inicial


c1=0.80; %Velocidad de convergencia


a = -1000; %se hace negativo al maximizar y solo la función en negativo

for i=1:100 %Número de generaciones

    fx= -((exp(x1p+1).*(2*x1p-x1p.^2+1)-2*x1p)./(exp(x1p+1)-1).^2+...
        a*max(x1p-5,0)+a*max(-5-x1p,0)) + a*max(-1-x1p,0);
    
    [val,ind] = min(fx);
    
    if val<fxpg %Actualización del mejor global
        fxpg=val; %Desempeño 
        x1pg=x1p(ind,1); %Posiciónp
    end
    
    for p=1:np
        if fx(p,1)<fxpL(p,1)
            fxpL(p,1)=fx(p,1); %se actualiza el desempeño del local
            x1pL(p,1)=x1p(p,1); %se actualizan las nuevas posiciones del local ********** (duda)  *******
        end
    end    

    plot(x1p, fx,'bo', x1pg, fx,'go')
    axis([-10 10 -10 10]);
    title(['x1pg= ' num2str(x1pg)]);
    pause(0.1);
    
    %Ecuaciones de movimiento
    
    vx1=vx1+c1*rand()*(x1pg-x1p); %ecuación de velocidad
    x1p=x1p+vx1; %ecuación de posición
     
end
x1pg
if x1pg<-1
    fxpg=2
else
    fxpg= (exp(x1pg+1).*(2*x1pg-x1pg.^2+1)-2*x1pg)./(exp(x1pg+1)-1).^2
end