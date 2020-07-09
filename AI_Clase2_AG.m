clear all; %Borrar todas las variables 
close all; %Cierra todas las ventanas 
clc; %Limpia la pantalla


nbits=8; %Numeros de bits
np=8; %Numero de pobladores

%Generar la población inicial 
xpadres = randi([0 255], np, 1);

%Evaluacion
for n=1:100 %Número de Generaciones
    y=xpadres.^2;
    
    yprom(n)=mean(y);
    
    %Cromosoma 
    cromosoma=sortrows([xpadres y],2); %Ordenar

    %Selección (En el cas®o de Maximizar se toman los mayores) 
    padres=cromosoma(np/2+1:end, 1);

    %Convertir a binario (Selección)
    %de2bi()
    padresbin=de2bi(padres,nbits);

    %Cruzamiento
    for k=1:np/4
        p=randi([2 nbits-1]);
        hijobin(2*k-1, :)=[padresbin(2*k-1,1:p) padresbin(2*k,p+1:end)];
        hijobin(2*k, :)=[padresbin(2*k,1:p) padresbin(2*k-1,p+1:end)];
    end

    %Mutación
    m=rand();
    if m >= 0.85
        nhijo=randi([1,p/2]); %Hijo al azar
        bit=randi([1 nbits]); %bit al azar
        if hijobin(nhijo, bit)==1
           hijobin(nhijo, bit)=0;
        else
           hijobin(nhijo, bit)=1;
           
        end
        
    end
    
    
    
    
    %Reemplazo
    hijodec=bi2de(hijobin); %Convierte a entero
    xpadres=[padres; hijodec] %Nueva generación 
    
    

end 
plot(yprom)
max(y)
