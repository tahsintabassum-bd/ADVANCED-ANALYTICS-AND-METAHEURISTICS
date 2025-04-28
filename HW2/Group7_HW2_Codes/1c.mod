#AMPL model for "Question 2" for HomeWork 1

#Note: Deep seek was used by ali to debug and help with defining issues.

reset;
#OPTIONS -------------------------------------
option solver cplex;

#SETS ----------------------------------------


set PRODS;   # Products: Raisins, Juice, Jelly
set INGRIDS; # Ingredients: A, B (types of grapes)

#PARAMETERS ----------------------------------

param usage {PRODS};           # Usage of grapes in each product from tabel
param demand {PRODS};          # Demand limit for each product
param supply {INGRIDS};        # Available supply for A and B grapes
param profit {PRODS};          # Profit per unit of each product
param quality {INGRIDS};       # Quality points for A and B grapes
param min_quality {PRODS};     # Minimum required quality per product

#DECISION VARIABLES ---------------------------
var X {i in PRODS} >= 0;  # Amount of each product to produce 
var Y {i in PRODS, j in INGRIDS} >= 0; # Amount of each ingredient used in each product

#OBJECTIVE --------------------------------------

maximize Total_Profit:
    sum {i in PRODS} profit[i] * X[i];
    
#CONSTRAINTS ------------------------------------

# 1. Demand Constraint
subject to Demand_Limit {i in PRODS}:
    X[i] <= demand[i];
    
# 2. Quality Constraint
subject to Quality_Requirement {i in PRODS}:
    sum {j in INGRIDS} Y[i,j] * quality[j] >= min_quality[i] * sum {j in INGRIDS} Y[i,j];
 
# 3. Ingredient Allocation Constraint 
subject to Ingredient_Balance {i in PRODS}:
    sum {j in INGRIDS} Y[i,j] = usage[i] * X[i];
 
# 4. Supply Limits for A and B grapes
subject to Supply_Limit {j in INGRIDS}:
    sum {i in PRODS} Y[i,j] <= supply[j];
    
#DATA ------------------------------------------
data 1c.dat;


#COMMANDS --------------------------------------
solve; 
display X, Y, Total_Profit;