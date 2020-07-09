clear all;clc
fechas=x2mdate(xlsread('boletin1.xlsx','futuros','B1:B120'),0);
futurostiie=xlsread('boletin1.xlsx','futuros','C1:C120')/100;
[cuponcero,fechastasas]=fwd2zero(futurostiie,fechas,'14-oct-2019');%convertir a tasas cupon cero
curvadetasas=intenvset('Rates',cuponcero,'StartDates','14-oct-2019','EndDates',fechastasas,'Compounding',12,'Basis',2);
%12 tasa a mensual...2 por la combinacion: meses exactos años 360
%esto ya se queda diferente, excepto la fecha del boletin 9 oct

%cuando sientes que las tasas vayan a subir, te compras un cap(equivalente
%a call, cuando temas que las tasas vayan a bajar, compras un floor (equivalente a put), que
%compensa lo que stá subiendo la tasa
primacap=capbyblk(curvadetasas,[.08,.085,.09],today,'14-oct-2024',[.2243, .2263, .2307],'Principal',[2402 320 583]*1000000)
%FORMAT BANK
%curvadetasas,strike(hasta donde se quiere cubrir),dia hoy,fehca futura:variosmeses de
%lo que te intentas cubrir (siempre más de un mes), tasa implicita que
%ponga el profesor,principal, exposure
primafloor=floorbyblk(curvadetasas,[.07,.075,.08],today,'14-oct-2024',[.2034, .2096, .2243],'Principal',[677 171 456]*1000000)

%En precio de bono
precios2y=bndprice([.0683 .0684 .0685],.0725,today,'09-dic-2021');
%ytm, cupon

%swap, el valor debe ser 0, ya que la tasa es a la que el valor presente de
%ambas partes es 0
%leg rate= tasa que recibes, tasa que pagas----al reves
%si se epsera ver si es positivo o negativo, en lugar de NaN poner la tasa
[valorswap tasaswap]=swapbyzero(curvadetasas,[NaN,0],today,'10-oct-2021')