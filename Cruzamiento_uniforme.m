clear all; %Borrar todas las variables 
close all; %Cierra todas las ventanas 
clc; %Limpia la pantalla


nbits=8; %Numeros de bits
np=8; %Numero de pobladores

clear all; %Borrar todas las variables 
close all; %Cierra todas las ventanas 
clc; %Limpia la pantalla

 
xmax=50; %valor mayor el intervalo
xmin=-50; %valor menor del intervalo
tp=.01; %número de pasos

nbits=ceil(log2((xmax-xmin+1)/tp)); %Numero de bits (redondeado)
np=32; %Numero de pobladores

 %%
%Generar población

x1 = randi([0, 2^nbits-1], np, 1); %Generar la población de enteros inicial 
x1real=((xmax-xmin)/(2^nbits-1))*x1 + xmin; %Conversion de enteros a reales

for n=1:1000 %Número de Generaciones
    y= -(x1real+40.2).^2+100; %Al usar . potencia se hace con todos los elementos.
    
    yprom(n)=mean(y);
    
    %Cromosoma 
    cromosoma=sortrows([y x1 x1real],1); %Ordenar

    %Selección (En el caso de Maximizar se toman los mayores) 
    padresbin=de2bi(cromosoma(np/2+1:end, 2),nbits);
    
    
    %CRUZAMIENTO UNFIORME
    mascara = randi([0 1], 1, nbits); %MÁSCARA PARA CAMBIAR DE 0-1
    for k=1:(np/2)
             p1 = k+1;
                if p1>(np/2)
                p1 = 1;
                end
                for p2=1:length(mascara)
                 if mascara(p2)==1
                    hijobin(k,p2)= padresbin(k,1);
                    else
                    hijobin(k,p2)= padresbin(p1,1);
                    end
                end          
     end    

         
    %Mutación
    m=rand(); %Número aleatorio
    if m >= 0.90
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
plot(yprom)
y= -(x1real+40.2).^2+100;
cromosoma=[y x1 x1real];
[val, ind]=max(y);
disp(['Resultado: x1= ' num2str(cromosoma(ind,3)) ' y= '  num2str(val)])
