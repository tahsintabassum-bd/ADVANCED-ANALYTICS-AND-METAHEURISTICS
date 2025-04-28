
reset;
option solver cplex;
# Sets
set Index;

# Parameters
param Revenue{Index} >= 0;
param RH{Index} >= 0;
param ConstraintCoeff{Index, Index};

# Binary decision variables
# var x{Index} binary;
var x{Index} >= 0 <= 1;
# Objective function
maximize TotalProfit:
    sum {i in Index} (Revenue[i] * x[i]);

# Constraints
subject to Constraint1 {i in Index}:
     sum {j in Index}(ConstraintCoeff[i,j] * x[j]) <= RH[i];
    
#subject to branch_1:
    # x[1]=0;
#subject to branch_1:
     #x[1]=1;
#subject to branch_2:
     #x[2]=0;
subject to branch_3:
     x[2]=1;
#subject to branch_4:
     #x[3]=0;
#subject to branch_5:
     #x[3]=1;
#subject to branch_6:
     #x[4]=0;
subject to branch_7:
     x[4]=1;

data Group10_HW5_Q5.dat;

# Solve the optimization problem
solve;

# Display the optimal solution
display x;
