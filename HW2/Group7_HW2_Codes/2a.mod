reset; 
option solver cplex;

set P;							# Set of all projects

param Y;						# Number of years to consider the projects for
param S >= 0;					# Maximum amount to be invested
param r {0 .. Y, P};			# Return rate in a given year from a project
param a {0 .. Y, P};			# Availability of a project in a given year
param l {P};					# Limit on the total investment in to a project
param b;						# Banking rate of return for money not re-invested in given year

var I {0 .. Y, P} >= 0;			# Amount invested in each project in a given year
var C {0 .. Y, P};				# Cumulative amount invested in a project up to a given year
var B {0 .. Y} >= 0;			# Amount of cash at the beginning of each year
var E {0 .. Y} >= 0;			# Amount of cash at the end of each year

maximize Total_Return: (E[Y]-S);								# Amount of Money Made Beyond the Initial Investment

subject to initial_investment: B[0] = S;						# The begining balance is the initial investment amount
subject to initial_spend: sum {p in P} I[0, p] = S;				# All of the intitial investment must be invested in year 0

subject to cash_flow {y in 0 .. Y}: 
	sum {p in P} I[y, p] <= B[y];								# Cannot spend more in a year than we had at the beginning of the year

subject to begin_balance {y in 1 .. Y}: 						# Beginning balance in each year after 0 is last years ending balance
	B[y] = (E[y-1]*(1+b)) + (sum {p in P} C[y-1, p]*r[y,p]);	# with the bank rate applied plus the returns on the existing investments
	
subject to end_balance {y in 0 .. Y}: 							# End balance each year is the beginning balance minus the 
	E[y] = B[y] - (sum {p in P} I[y, p]);						# amount invested that year

subject to cumulative_investment {y in 0 .. Y, p in P}: 		# The amount invested in a project up to that point is the sum of all the
	C[y, p] = sum {x in 0 .. y} I[x, p];						# years past. However, each project can only be invested in in 1 year
	
subject to availability {y in 0 .. Y, p in P}:					# If a project is not available that year, no money can be invested in it
    if a[y, p] = 0 then
        I[y, p] = 0;

subject to project_limits {y in 0 .. Y, p in P}: 				# Limits on the amount invested in each project
	C[y,p] <= l[p];

data 2a.dat
solve;

for {y in 0 .. Y, p in P} {										# Clean way to print results
	if I[y, p] >0 then printf "Year %d Project %s: = $%d \n", y, p, I[y, p];
	}
printf "Total Return: $%d\n", Total_Return;

display cumulative_investment.dual;

