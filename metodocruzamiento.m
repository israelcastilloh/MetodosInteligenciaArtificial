% np = n of population/ n = crossover class/ 
%function y = crossovermethod(parents, np, nbits, n)

function y=metodocruzamiento(padresbin,np,nbits,n) 

switch n
    case 1 %SIMPLE CROSSOVER
         %Cruzamiento Simple
        for k=1:np/4
            p=randi([2 nbits-1]); %Punto de cruce;
            hijobin(2*k-1, :)=[padresbin(2*k-1,1:p) padresbin(2*k,p+1:nbits)];
            hijobin(2*k, :)=[padresbin(2*k,1:p) padresbin(2*k-1,p+1:nbits)];
            y=hijobin;
        end
    case 2 %2 POINT CROSSOVER
        for k=1:np/4
            p1=randi([2, nbits-2]);
            p2=randi([p1+1, nbits-1]);
            hijobin(2*k-1, :)=[padresbin(2*k-1,1:p1) padresbin(2*k,p1+1:p2) padresbin(2*k-1,p2+1:nbits)];
            hijobin(2*k, :)=[padresbin(2*k,1:p1) padresbin(2*k-1,p1+1:p2) padresbin(2*k,p2+1:nbits)];
            y=hijobin;
        end
        
    otherwise
        disp("Invalid Input")
    %case 3 %ARITHMETIC CROSSOVER
end
end