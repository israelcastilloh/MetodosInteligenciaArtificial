clear all; %Borrar todas las variables 
close all; %Cierra todas las ventanas 
clc; %Limpia la pantalla


nbits=8; %Numeros de bits
np=32; %Numero de pobladores

clear all; %Borrar todas las variables 
close all; %Cierra todas las ventanas 
clc; %Limpia la pantalla

 
xmax=1024; %valor mayor el intervalo
xmin=1; %valor menor del intervalo
tp=1; %número de pasos

nbits=ceil(log2((xmax-xmin+1)/tp)); %Numero de bits (redondeado)
np=32; %Numero de pobladores

 %%
%Generar población

x1 = randi([0, 2^nbits-1], np, 1); %Generar la población de enteros inicial 
x1real=((xmax-xmin)/(2^nbits-1))*x1 + xmin; %Conversion de enteros a reales

for n=1:1000 %Número de Generaciones
    y= -(x1real-628).^2+20; %Al usar . potencia se hace con todos los elementos.
    
    yprom(n)=mean(y);
    
    %Cromosoma 
    cromosoma=sortrows([y x1 x1real],1); %Ordenar
    
    %Competencia
    for i = 1:np/2
        s=rand(); %criterio para seleccionar los mejores/peores padres** competencia
        if s>=.8; %osea solo gana 20%
            padre(i,1)=cromosoma(2*i-1,2); %peor (te queda los peores)
        else 
            padre(i,1)=cromosoma(2*i,2); %mejor 
        end    
    end
    

    %Selección (En el caso de Maximizar se toman los mayores) 
    padresbin=de2bi(padre,nbits);
 
    for k=1:16
        p1=randi([2, nbits-2]); %cruce 1
        p2=randi([p1+1, nbits-1]); %cruce 2
        
        dad1 = randi(16); %seleccionamos los padres
        dad2 = randi(16);
        dad3 = randi(16);
        
        hijobin(k, :)=[padresbin(dad1,1:p1) padresbin(dad2,p1+1:p2) padresbin(dad3,p2+1:nbits)]; 
        %tomamos las partes de los padres seleccionando cada uno y condicionando
        %los espacions de los puntos
        y=hijobin;
    end

    
    %Mutación
    m=rand(); %Número aleatorio
    if m >= 0.80
        nhijo=randi(np/2); %Numero de hijo
        bit=randi(nbits); %bit a mutar
        if hijobin(nhijo, bit)==1
           hijobin(nhijo, bit)=0;
        else
           hijobin(nhijo, bit)=1;     
        end  
    end

    %Reemplazo
    hijoentero=bi2de(hijobin); %Convierte a entero
    hijoreal=((xmax-xmin)/(2^nbits-1))*hijoentero + xmin; %Convertir hijos reales a reales
    x1=[cromosoma(np/2+1:end,2); hijoentero]; %Nueva generación 
    x1real=[cromosoma(np/2+1:end,3); hijoreal];

       
end 
plot(y)
y= -(x1real-628).^2+20;
cromosoma=[y x1 x1real];
[val, ind]=max(y); %TRAMPAAAA
disp(['Resultado: x1= ' num2str(cromosoma(ind,3)) ' y= '  num2str(val)]);
