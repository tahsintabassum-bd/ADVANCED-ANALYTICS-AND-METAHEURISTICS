reset; # Reset the console
option solver cplex; # set the default solver to CPLEX

var x1 >= 0; # Budget to spend for advertisement in TV
var x2 >= 0; # Budget to spend for advertisement in magazines

maximize audience: 1.8*x1 + x2; # The objective is to maximize audience

# Must sign up for at least 10 minutes of TV time
subject to cons_TV_time: x1 >= 10;
# One minute of TV time costs $20,000 & a magazine page costs $10,000
subject to cost: 0.02*x1 + 0.01*x2 <= 1;

solve; # Solve the problem

# Print the variables
printf "Budget to spend for advertisement in TV: %d million dollars\n", x1;
printf "Budget to spend for advertisement in magazines: %d million dollars\n", x2;


