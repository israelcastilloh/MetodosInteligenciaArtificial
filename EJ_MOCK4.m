clear all; %Borrar todas las variables 
close all; %Cierra todas las ventanas 
clc; %Limpia la pantalla


nbits=16; %Numeros de bits
np=100; %Numero de pobladores

%% Primera variable
xmax1=10000; %valor mayor el intervalo
xmin1=0; %valor menor del intervalo

tp1=.1; %número de pasos
nbits1=ceil(log2((xmax1-xmin1+1)/tp1));

x1 = randi([0, 2^nbits1-1], np, 1); %Generar la población de enteros inicial 
x1real=((xmax1-xmin1)/(2^nbits1-1))*x1 + xmin1; %Conversion de enteros a reales


%% Segunda variable
xmax2=10000; %valor mayor el intervalo
xmin2=0; %valor menor del intervalo

tp2=.1; %número de pasos
nbits2=ceil(log2((xmax2-xmin2+1)/tp2));

x2 = randi([0, 2^nbits2-1], np, 1); %Generar la población de enteros inicial 
x2real=((xmax2-xmin2)/(2^nbits2-1))*x2 + xmin2; %Conversion de enteros a reales


%% TERCERA variable
xmax3=10000; %valor mayor el intervalo
xmin3=0; %valor menor del intervalo

tp3=.1; %número de pasos
nbits3=ceil(log2((xmax3-xmin3+1)/tp3));

x3 = randi([0, 2^nbits3-1], np, 1); %Generar la población de enteros inicial 
x3real=((xmax3-xmin3)/(2^nbits3-1))*x3 + xmin3; %Conversion de enteros a reales

%%
a = 1000; % maximizar a --> negativo // minimizar --> positivo
for n=1:1000 %Número de Generaciones
    %c=2*x1real+x2real+.5*x3real-400;
    %c2=c+2*x1real+x2real+.5*x3real-100;
    
    fun= (x1real+x2real+x3real) + a*max(-2*x1real - x2real - .5*x3real+400,0) +...
        a*max(-.5*x1real - 0.5*x2real - x3real+100,0)+...
        a*max(0*x1real - 1.5*x2real - 2*x3real+300,0)+...
        a*max(-x1real,0)+a*max(-x2real,0)+a*max(-x3real,0); %%DEJA LA FUNCIÓN COMO LA DEFINE EL PROB
    
    y= -fun; %(-) porque se minimiza **EN AG**
    yprom(n)=mean(y);
    
    %Cromosoma 
    cromosoma=sortrows([y x1 x1real x2 x2real x3 x3real], 1); %Cromosoma tiene que agregar x2, x2real, 1 en sortrows por y

    %Selección de ambas variables
    padresbin1=de2bi(cromosoma(np/2+1:end, 2), nbits1); %dependen de x1 y nbits1
    padresbin2=de2bi(cromosoma(np/2+1:end, 4), nbits2); %dependen de x2 y nbits2
    padresbin3=de2bi(cromosoma(np/2+1:end, 6), nbits3); %dependen de x2 y nbits2
    
    %Cruzamiento en ambas variables
    hijobin1=metodocruzamiento(padresbin1, np, nbits1, randi(2)); 
    hijobin2=metodocruzamiento(padresbin2, np, nbits2, randi(2)); 
    hijobin3=metodocruzamiento(padresbin3, np, nbits3, randi(2)); 
    
    
 %%
    %Mutación de x1
    m=rand(); %Número aleatorio
    if m >= 0.90
        nhijo1=randi(np/2); %Numero de hijo
        bit1=randi(nbits1); %bit a mutar
        if hijobin1(nhijo1, bit1)==1
           hijobin1(nhijo1, bit1)=0;
        else
           hijobin1(nhijo1, bit1)=1;     
        end  
    end
    
     
    %Mutación de x2
    m=rand(); %Número aleatorio
    if m >= 0.90
        nhijo2=randi(np/2); %Numero de hijo
        bit2=randi(nbits2); %bit a mutar
        if hijobin2(nhijo2, bit2)==1
           hijobin2(nhijo2, bit2)=0;
        else
           hijobin2(nhijo2, bit2)=1;     
        end  
    end
    
    
        %Mutación de x3
    m=rand(); %Número aleatorio
    if m >= 0.90
        nhijo3=randi(np/2); %Numero de hijo
        bit3=randi(nbits3); %bit a mutar
        if hijobin3(nhijo3, bit3)==1
           hijobin3(nhijo3, bit3)=0;
        else
           hijobin3(nhijo3, bit3)=1;     
        end  
    end
    
    

 %%
 
    %Reemplazo 1
    hijoentero1=bi2de(hijobin1); %Convierte a entero
    hijoreal1=((xmax1-xmin1)/(2^nbits1-1))*hijoentero1 + xmin1; %Convertir hijos reales a reales
    x1=[cromosoma(np/2+1:end,2); hijoentero1]; %Nueva generación 
    x1real=[cromosoma(np/2+1:end,3); hijoreal1];
    
     
    %Reemplazo
    hijoentero2=bi2de(hijobin2); %Convierte a entero
    hijoreal2=((xmax2-xmin2)/(2^nbits2-1))*hijoentero2 + xmin2; %Convertir hijos reales a reales
    x2=[cromosoma(np/2+1:end,4); hijoentero2]; %Nueva generación 
    x2real=[cromosoma(np/2+1:end,5); hijoreal2];
    
         
    %Reemplazo
    hijoentero3=bi2de(hijobin3); %Convierte a entero
    hijoreal3=((xmax3-xmin3)/(2^nbits3-1))*hijoentero3 + xmin3; %Convertir hijos reales a reales
    x3=[cromosoma(np/2+1:end,6); hijoentero3]; %Nueva generación 
    x3real=[cromosoma(np/2+1:end,7); hijoreal3];


       
end 
%%
plot(yprom)
cromosoma=[y x1 x1real x2 x2real x3 x3real];
y= fun;
[val, ind]=max(y);
disp([' x1= ' num2str(cromosoma(ind,3)) ' x2= ' num2str(cromosoma(ind,5)) ' x3= ' num2str(cromosoma(ind,7))  ' y= '  num2str(val)])