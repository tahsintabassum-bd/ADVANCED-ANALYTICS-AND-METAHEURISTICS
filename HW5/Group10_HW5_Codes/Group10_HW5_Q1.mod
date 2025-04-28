reset;
option solver cplex;

set A;  # Set of airports

param f{A};  # Fuel burn from airport i to the next airport
param C{A};  # Fuel cost at airport i
param r{A};  # Ramp fee at airport i
param w{A};  # Minimum gallon of fuel required to buy for waiving ramp fee at airport i
param p{A};  # Number of passengers flying from airport i to the next airport
param pw;    # Passenger weight (per person)
param tc;    # Tank capacity of the aircraft
param rw;    # Maximum ramp weight of the aircraft
param lw;    # Maximum landing weight of the aircraft
param ow;    # Basic operating weight (BOW) of the aircraft
param lf;    # Minimum fuel required of the aircraft during landing
param uf;    # Fuel up level of the aircraft
param sf;    # Starting fuel of the aircraft from the 1st airport
param bf;    # (for 1b) Minimum amount of fuel that must be bought in case fuel is needed

var x{i in A} >= 0;  # Amount of fuel to purchase (in gallons) at airport i
var y{i in A} binary;# Binary variable, indicating whether ramp fee is to be paid at airport i
var z{i in A} >= 0;  # Remaining fuel amount (in gallons) after a trip completed at airport i
var v{i in A} binary;# (for 1b) Binary variable, indicating whether fuel should be brought from airport i

minimize TotalCost: sum{i in A} (6.7 * C[i] * x[i]) + sum{i in A} (r[i] * y[i]);

subject to RemainingFuel{i in A}: z[i] = x[i] + z[i] - f[i];
subject to MaxRampWeight{i in A}: ow + pw * p[i] + z[i] + x[i] <= rw;
subject to MaxLandingWeight{i in A}: ow + pw * p[i] + z[i] <= lw;
subject to InitialFuel: z['KCID'] = sf;
subject to FuelAtLastAirport: z['KTUL'] + x['KTUL'] >= sf;
subject to TankCapacity{i in A}: x[i] + z[i] <= tc;
subject to MinFuelForLanding{i in A}: z[i] >= lf;
subject to FuelPurchase{i in A}: x[i] >= 6.7 * w[i] * (1 - y[i]);
# for 1(b)
subject to extraConstr1{i in A}: x[i] <= tc * v[i];
subject to extraConstr2{i in A}: x[i] >= 6.7 * bf * v[i];

data Group10_HW5_Q1.dat;

solve;
display x;
display y;
display z;
display v;



