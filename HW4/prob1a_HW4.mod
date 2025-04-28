reset;
option solver cplex;


#decision variables
var XA>=0;   #Project A Investment
var XB>=0;   #Project B Investment
var XC>=0;   #Project C Investment
var XD>=0;   #Project D Investment
var XE>=0;   #Project E Investment
var Xb1>=0;  #annual investment allocations to the bank for year 1
var Xb2>=0;  #annual investment allocations to the bank for year 2
var Xb3>=0;  #annual investment allocations to the bank for year 3

#objective

maximize Return: XB + 1.4*XE + 1.75*XD + 1.06*Xb3;#Maximizing the Return

#constraints
subject to A1 : XA + XC + XD + Xb1 = 1000000; #Initial Investment
subject to A2 : 0.3*XA + 1.1*XC + 1.06*Xb1 = XB + Xb2;#Year1 balance
subject to A3 : XA + 0.3*XB + 1.06*Xb2 = XE + Xb3;#Year2 balance
subject to A4 : XA <= 500000;#Limit on Project A
subject to A5 : XB <= 500000;#Limit on Project B
subject to A6 : XE <= 750000;#Limit on Project E

#Display the Results
solve;
display XA,XB,XC,XD,XE;
display Xb1,Xb2,Xb3;
display Return;


