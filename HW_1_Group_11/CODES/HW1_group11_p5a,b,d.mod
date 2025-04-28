reset;
option solver cplex;

#5

# desicion variables
var Xa >=0; # Amount to be invested in bond A
var Xd >=0; # Amount to be invested in bond D
var y >=0; #Amount to be borrowed
#Objective

maximize aftertaxearnings: 0.043*Xa + 0.022*Xd - 0.0275*y;

#Constraints
subject to muncipallimit: Xa <=3;
subject to borrowing : y <= 1;
subject to  total: Xa + Xd <= 10 + y;
subject to govtAgencybonds : Xd >=4;
subject to averagequality : 0.6*Xa - 0.4*Xd <= 0;
subject to averagematurity : 4*Xa - 2*Xd <= 0;
#a)
 solve;
 
 display Xa, Xd, y;

#b)
printf"Shadow price of muncipallimit constraint :\n ";
display muncipallimit;


#d)
display y.rc; # deduct this reduced cost from y coefficient to get the favorable  interest rate