reset; # Reset the console
option solver cplex; # set the default solver to CPLEX

set PROD; # set of products
set STAGE; # set of stages

param rate {PROD,STAGE} > 0; # tons per hour in each stage
param avail {STAGE} >= 0; # hours available/week in each stage
param profit {PROD}; # profit per ton
param commit {PROD} >= 0; # lower limit on tons sold in week
param market {PROD} >= 0; # upper limit on tons sold in week
param share {PROD} >= 0;

var Make {p in PROD} <= market[p]; # tons produced
maximize Total_Profit: sum {p in PROD} profit[p] * Make[p];
# Objective: total profits from all products
subject to Time {s in STAGE}:
sum {p in PROD} (1/rate[p,s]) * Make[p] <= avail[s];
# In each stage: total of hours used by all
# products may not exceed hours available
subject to Amount {p in PROD}:
Make[p] >= share[p] * sum {k in PROD} Make[k];
# each product represent a certain share of the total tons produced

data HW1_group11_p4d2_data.dat;
solve;

for {p in PROD} {
	printf "Value of %s: %g\n", p, Make[p];
}

