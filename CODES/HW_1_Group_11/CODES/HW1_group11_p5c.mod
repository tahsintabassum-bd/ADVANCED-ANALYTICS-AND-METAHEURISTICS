reset;
option solver cplex;

#5c

# desicion variables
var Xa >=0; # Amount to be invested in bond A
var Xd >=0; # Amount to be invested in bond D
var y >=0; #Amount to be borrowed
#Objective

maximize aftertaxearnings: 0.043*Xa + 0.022*Xd - 0.0275*y;

#Constraints

subject to  total: Xa + Xd <= 10+y;
subject to borrowing : y <= 1;
subject to govtAgencybonds : Xd >=4;
subject to averagequality : 0.6*Xa - 0.4*Xd <= 0;
subject to averagematurity : 4*Xa - 2*Xd <= 0;

 solve;
 
 display Xa, Xd , y ;

