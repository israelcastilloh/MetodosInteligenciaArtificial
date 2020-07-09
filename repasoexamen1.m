

clear all; %Borrar todas las variables 
close all; %Cierra todas las ventanas 
clc; %Limpia la pantalla


nbits=8; %Numeros de bits
np=32; %Numero de pobladores

%% Primera variable
xmax1=1024; %valor mayor el intervalo
xmin1=1; %valor menor del intervalo

tp1=.1; %número de pasos
nbits1=ceil(log2((xmax1-xmin1+1)/tp1))

x1 = randi([0, 2^nbits1-1], np, 1); %Generar la población de enteros inicial 
x1real=((xmax1-xmin1)/(2^nbits1-1))*x1 + xmin1; %Conversion de enteros a reales


%%
for n=1:1000 %Número de Generaciones
    
    fun= -(x1real-628).^2 +20;
    y= fun; %(-) porque se minimiza **EN AG**
    yprom(n)=mean(y);
    
    %Cromosoma 
    cromosoma=sortrows([y x1 x1real], 1); %Cromosoma tiene que 1 en sortrows por y

    %Selección de ambas variables
    padresbin=de2bi(cromosoma(np/2+1:end, 2), nbits1) %dependen de x1 y nbits1
    
    %Cruzamiento 
        for k=1:np/4
            p1=randi([2, nbits1-4])
            p2=randi([p1+1, nbits1-2])
            p3=randi([p2+1, nbits1])
            hijobin1(2*k-1, :)=[padresbin(2*k-1,1:p1) padresbin(2*k,p1+1:p2) padresbin(2*k+1,p2+1:nbits1)]
            %hijobin1(2*k, :)=[padresbin(2*k,1:p1) padresbin(2*k+1,p1+1:p2) padresbin(2*k+2,p2+1:nbits1)];
            y=hijobin1;
        end
        
    
    
 %%
    %Mutación de x1
    m=rand(); %Número aleatorio
    if m >= 0.80
        nhijo1=randi(np/2); %Numero de hijo
        bit1=randi(nbits1); %bit a mutar
        if hijobin1(nhijo1, bit1)==1
           hijobin1(nhijo1, bit1)=0;
        else
           hijobin1(nhijo1, bit1)=1;     
        end  
    end
    
    
    

 %%
 
    %Reemplazo 1
    hijoentero1=bi2de(hijobin1); %Convierte a entero
    hijoreal1=((xmax1-xmin1)/(2^nbits1-1))*hijoentero1 + xmin1; %Convertir hijos reales a reales
    x1=[cromosoma(np/2+1:end,2); hijoentero1]; %Nueva generación 
    x1real=[cromosoma(np/2+1:end,3); hijoreal1];
    

       
end 
%%
plot(yprom)
cromosoma=[y x1 x1real];
%y= -fun;
[val, ind]=max(y);
disp([' x1= ' num2str(cromosoma(ind,3)) ' y= '  num2str(val)])