clear all;clc
fechas=x2mdate(xlsread('boletin1.xlsx','futuros','B1:B05'),0);
futurostiie=xlsread('boletin1.xlsx','futuros','C1:C105')/100;
[cuponcero,fechastasas]=fwd2zero(futurostiie-1/10000,fechas,'21-oct-2019');%convertir a tasas cupon cero
curvadetasas=intenvset('Rates',cuponcero,'StartDates','21-oct-2019','EndDates',fechastasas,'Compounding',12,'Basis',2);
%12 tasa a mensual...2 por la combinacion: meses exactos años 360
%esto ya se queda diferente, excepto la fecha del boletin 9 oct

%cuando sientes que las tasas vayan a subir, te compras un cap(equivalente
%a call, cuando temas que las tasas vayan a bajar, compras un floor (equivalente a put), que
%compensa lo que stá subiendo la tasa
primacap3=capbyblk(curvadetasas,[.0825	.085],today,'21-oct-2022',[  0.1839 	 0.1926 ],'Principal',[2500	1600]*1000000)
primacap5=capbyblk(curvadetasas,[.0825	.085],today,'21-oct-2024',[ 0.1897 	 0.1948  ],'Principal',[1200	900]*1000000)

%FORMAT BANK
%curvadetasas,strike(hasta donde se quiere cubrir),dia hoy,fehca futura:variosmeses de
%lo que te intentas cubrir (siempre más de un mes), tasa implicita que
%ponga el profesor,principal, exposure
primafloor3=floorbyblk(curvadetasas,[.0725	.075],today,'21-oct-2022',[ 0.20 	 0.20 ],'Principal',[800	1100]*1000000)
primafloor5=floorbyblk(curvadetasas,[.0725	.075],today,'21-oct-2024',[ 0.20 	 0.20 ],'Principal',[500	600]*1000000)

%En precio de bono
precios3y=bndprice([.0676 .0677 .0678],.0650,today,'09-jun-2022')
precios5y=bndprice([.0678 .0679 .068],.10,today,'05-dec-2024')
%ytm, cupon

%swap, el valor debe ser 0, ya que la tasa es a la que el valor presente de
%ambas partes es 0
%leg rate= tasa que recibes, tasa que pagas----al reves
%si se epsera ver si es positivo o negativo, en lugar de NaN poner la tasa
%[valorswap tasaswap]=swapbyzero(curvadetasas,[NaN,0],today,'10-oct-2021')