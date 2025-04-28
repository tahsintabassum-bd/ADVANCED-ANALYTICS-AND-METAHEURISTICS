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


#objectives
maximize Return: XB + 1.4*XE + 1.75*XD + 1.06*Xb3;#Maximizing Return
minimize TotalRisk: 0.10*XA + 0.12*XB + 0.05*XC + 0.20*XD + 0.05*XE;#Minimizing Risk


#constraints
subject to A1 : XA + XC + XD + Xb1 = 1000000; #Initial Investment
subject to A2 : 0.3*XA + 1.1*XC + 1.06*Xb1 = XB + Xb2;#Year1 balance
subject to A3 : XA + 0.3*XB + 1.06*Xb2 = XE + Xb3;#Year2 balance
subject to A4 : XA <= 500000;#Limit on Project A
subject to A5 : XB <= 500000;#Limit on Project B
subject to A6 : XE <= 750000;#Limit on Project E


#SCALARIZATION----------------------------------------------------------------------------------------------------------------------------------

param lambda1;
param lambda2;


maximize objWeightedSum : ((lambda1*( XB + 1.4*XE + 1.75*XD + 1.06*Xb3))-(lambda2*(0.10*XA + 0.12*XB + 0.05*XC + 0.20*XD + 0.05*XE)));

problem maxScalarized: objWeightedSum,XA,XB,XC,XD,XE,Xb1,Xb2,Xb3,A1,A2,A3,A4,A5,A6;

for {k in 0..4} {
let lambda1 := k/4;
let lambda2 := 1 - lambda1;
solve maxScalarized;

printf "\n\nlambda1 = %6.2f; lambda2 = %6.2f \n", lambda1,lambda2;
printf "Profit generated: %6.2f\n", Return;
printf "Total Risk: %6.2f \n\n", TotalRisk ;

printf "%d, %3.2f, %3.2f, %7.4f, %7.4f, %7.4f, %7.4f,%7.4f, %7.4f, %7.4f\n",
k,lambda1,lambda2,XA,XB,XC,XD,XE,Return,TotalRisk > "C:\Users\shrey\Downloads\lambda_output.txt";
}


