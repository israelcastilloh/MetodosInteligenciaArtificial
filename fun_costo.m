%fun_costo(W,Xa,Y)
function [J, dJdW]=fun_costo(W,Xa,Y)
V=Xa*W;
Yg=1./(1+exp(-V));
n=size(Xa,1);

J=sum(-Y.*log(Yg)-(1-Y).*log(1-Yg))/n; %función de costo
E=(Yg-Y); %error
dJdW=(E'*Xa)'/n; %gradiente
end