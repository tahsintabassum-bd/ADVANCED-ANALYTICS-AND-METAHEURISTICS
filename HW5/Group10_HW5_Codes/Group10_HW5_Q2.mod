reset;
option solver cplex;

# -----------------------------
# SETS
# -----------------------------

set I ordered;          # Set of animals
set K;                  # Set of possible enclosures (colors)
set S := {I, I};        # All possible animal pairs (used for constraints)

# -----------------------------
# PARAMETERS
# -----------------------------

param h{I, I} >= 0;     # Compatibility matrix: h[i,j] = 1 means i and j CANNOT be together
param M >= 0;           # A large constant for big-M constraints (optional use if needed)

# -----------------------------
# VARIABLES
# -----------------------------

var E{K} binary;        # E[k] = 1 if enclosure k is used
var X{I, K} binary;     # X[i,k] = 1 if animal i is assigned to enclosure k

# -----------------------------
# OBJECTIVE: Minimize number of enclosures used
# -----------------------------

minimize enc: sum {k in K} E[k];

# -----------------------------
# CONSTRAINTS
# -----------------------------

# Each animal must be assigned to exactly one enclosure
subject to assign_one_enclosure {i in I}:
    sum {k in K} X[i,k] = 1;

# If any animal is assigned to enclosure k, then E[k] must be 1
subject to activate_enclosure {k in K}:
    sum {i in I} X[i,k] <= card(I) * E[k];

# Animals that cannot be housed together (h[i,j] = 1) must not share the same enclosure
subject to incompatible_animals {(i,j) in S, k in K}: X[i,k] + X[j,k] <=  1 + M * (1-h[i,j]); 

#DATA ------------------------------------------
data Group10_HW5_Q2.dat;


#COMMANDS --------------------------------------
solve; 
display X;