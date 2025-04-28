reset;
option solver cplex;
#2

#decision variables

var Xa >=0;# Amount to be invested in bond A
var Xb >=0 ;# Amount to be invested in bond B
var Xc >=0 ;# Amount to be invested in bond C
var Xd >=0 ; # Amount to be invested in bond D
var Xe >=0 ; # Amount to be invested in bond E
var Y  >=0 ;# Amount borrowed
#Objective

maximize aftertaxearnings: 0.043*Xa + 0.027*Xb + 0.025*Xc + 0.022*Xd + 0.045*Xe - 0.0275*Y;

#Constraints

subject to  total: Xa + Xb + Xc + Xd + Xe - Y <= 10;
subject to upperbound : Y <= 1;
subject to govtAgencybonds : Xb + Xc + Xd >=4;
subject to averagequality : 0.6*Xa + 0.6*Xb - 0.4*Xc - 0.4*Xd + 3.6*Xe <= 0;
subject to averagematurity : 4*Xa + 10*Xb - Xc - 2*Xd - 3*Xe <= 0;

solve;

display Xa , Xb , Xc , Xd , Xe , Y;


