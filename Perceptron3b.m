clear all;
close all;
clc;

%Cargar datos
load datos2.mat;
data=datos2;

plot(data(1,:), data(2,:), '.');

%% Crear la red neuronal
nn=10; %Número de neuronas / grupos

prom = mean(data')';
%W=[prom prom prom prom prom prom prom prom prom prom];
W=rand(2,nn);

eta=0.01;
W0=W;

for nepocas=1:50
    for k=1:size(data, 2): %Revisar todos los datos
        for j=1:nn         %Revisar cada neurona
            dist(1,j) = sum((data(:,k)-W(:,j)).^2);
        end
        [val ind]=min(dist);

        W(:,ind) = W(:,ind) + eta*(data(:,k)-W(:,ind));
    end %época
end

Wf=W
plot(data(1,:), data(2,:), '.', W0(1,:), W0(2,:), 'r.', Wf(1,:), Wf(2,:), 'rp');


%%

clear all;
close all;
clc;

%Cargar datos
load datos1.mat;
data=datos1;

plot(data(1,:), data(2,:), '.');


red=competlayer(nn); %Crear el tipo de red
red.trainParam.epochs=100; %Definir las épocas
red=train(red,data); %Los paquetes tienen que ser en renglones (si están en columnas, lo transponemos)

%% Simulación de datos
Y=red(data); %pasamos los datos por la red / click derecho para guardarlo cuando sea bueno / puedes añadir con datos pero tienen que ser en renglones red([;]) y transpuesta
Y=vec2ind(Y); %convierte vectores a índices /puedes añadir con datos pero tienen que ser en renglones vec2ind([;]) y transpuesta.
grupos=unique(Y); %da los grupos unicos 

for k=1:size(grupos,2)
    temp=data(:,Y==grupos(1,k))
    
    eval(sprintf('grupo%d=temp', k));
end


Wf=red.IW{1,1}';
Wf=W
plot(data(1,:), data(2,:), '.', Wf(1,:), Wf(2,:), 'rp');
