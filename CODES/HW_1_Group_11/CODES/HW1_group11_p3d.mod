reset; # Reset the console
option solver cplex; # set the default solver to CPLEX

var x1 >= 0; # Budget to spend for advertisement in TV
var x2 >= 0; # Budget to spend for advertisement in magazines
var x3 >= 0; # Budget to spend for advertisement in radio

maximize audience: 1.8*x1 + x2 + 0.25*x3; # The objective is to maximize audience

# Must sign up for at least 10 minutes of TV time
subject to cons_TV_time: x1 >= 10;
# One minute of TV time costs $20,000 & a magazine page costs $10,000
subject to cons_cost: 0.02*x1 + 0.01*x2 + 0.002*x3 <= 1;
# Three person-weeks to create a magazine page, and one person-week to create a TV minute
subject to cons_time: 1*x1 + 3*x2 + (1/7)*x3 <= 100;
# Have to sign up for at least two magazine pages
subject to C4: x2 >= 2;
# Have to sign up for a maximum of 120 minutes of radio
subject to C5: x3 <= 120;


solve; # Solve the problem

# Print the variables
printf "Budget to spend for advertisement in TV: %d million dollars\n", x1;
printf "Budget to spend for advertisement in magazines: %d million dollars\n", x2;
printf "Budget to spend for advertisement in radio: %d million dollars\n", x3;

