reset;

option solver cplex;

# Defining sets
set gastype;  
set tanks;    

# Defining parameters
param gasCapacity{gastype};   #each gasoline type requirement
param tankCapacity{tanks};    #capacity of each tank
param cost{gastype, tanks};   #pumping cost per 1000 liters

# Decision Variables
var x{gastype, tanks} >= 0;   #Quantity of gasoline stored in a tank
var b{gastype, tanks} binary; #Binary Variable - 1 if gasoline is stored in tank, otherwise 0

# Objective Function
minimize TotalCost:
    sum {g in gastype, t in tanks} (cost[g, t] * x[g, t] / 1000);


#Constraints
#each gasoline type is fully stored
subject to GasStorage {g in gastype}:
    sum {t in tanks} x[g, t] = gasCapacity[g];

#tank capacity constraint - total gas stored in tank should not exceed max capacity
subject to TankCap {t in tanks}:
    sum {g in gastype} x[g, t] <= tankCapacity[t];

#each tank can only store one type of gas
subject to OnegasinTank {t in tanks}:
    sum {g in gastype} b[g, t] <= 1;

#linking - used tanks are marked
subject to Link {g in gastype, t in tanks}:
    x[g, t] <= tankCapacity[t] * b[g, t];

data Group10_HW5_P3.dat;


solve;
display x;
display TotalCost;