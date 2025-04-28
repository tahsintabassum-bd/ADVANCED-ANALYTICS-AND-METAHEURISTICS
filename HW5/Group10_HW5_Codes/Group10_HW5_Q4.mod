reset;
option solver cplex;

# -----------------------------
# PARAMETERS
# -----------------------------

# Space Ray piecewise segments
param max_ray1 := 125;
param max_ray2 := 100;
param max_ray3 := 150;
param max_ray4 := 800;

# Zapper piecewise segments
param max_zap1 := 50;
param max_zap2 := 75;
param max_zap3 := 600;

# Resource limits
param plastic_limit := 1000;
param labor_limit := 2400;  # 40 hours × 60 minutes
param prod_limit := 700;
param ray_zap_diff := 350;

# -----------------------------
# DECISION VARIABLES
# -----------------------------

# Space Rays (prod in 4 cost blocks)
var ray1 >= 0, <= max_ray1, integer;
var ray2 >= 0, <= max_ray2, integer;
var ray3 >= 0, <= max_ray3, integer;
var ray4 >= 0, <= max_ray4, integer;

# Binary flags for block usage
var b1 binary;
var b2 binary;
var b3 binary;

# Binary flags for zapper blocks
var z1 binary;
var z2 binary;

# Zappers (prod in 3 cost blocks)
var zap1 >= 0, <= max_zap1, integer;
var zap2 >= 0, <= max_zap2, integer;
var zap3 >= 0, <= max_zap3, integer;

# -----------------------------
# OBJECTIVE: Maximize Profit
# -----------------------------

maximize Profit:
    (8 - 1.5)*ray1 + (8 - 1.05)*ray2 + (8 - 0.95)*ray3 + (8 - 0.75)*ray4 +
    (5 - 1.05)*zap1 + (5 - 0.75)*zap2 + (5 - 1.5)*zap3;

# -----------------------------
# CONSTRAINTS
# -----------------------------

# Resource usage
subject to PlasticUse:
    2*(ray1 + ray2 + ray3 + ray4) + 1*(zap1 + zap2 + zap3) <= plastic_limit;

subject to LaborUse:
    3*(ray1 + ray2 + ray3 + ray4) + 4*(zap1 + zap2 + zap3) <= labor_limit;

# Total production cap
subject to TotalProd:
    (ray1 + ray2 + ray3 + ray4) + (zap1 + zap2 + zap3) <= prod_limit;

# Ray-Zap difference
subject to ProdDifference:
    (ray1 + ray2 + ray3 + ray4) - (zap1 + zap2 + zap3) <= ray_zap_diff;

# -----------------------------
# Piecewise Control – Space Rays
# -----------------------------

subject to Ray_Block2: ray2 <= max_ray2 * b2;
subject to Ray_Block3: ray3 <= max_ray3 * b3;
subject to Ray_Block4: ray4 <= max_ray4;

# Sequential block logic
subject to Ray_Order_b2: b2 <= b1;
subject to Ray_Order_b3: b3 <= b2;

# -----------------------------
# Piecewise Control – Zappers
# -----------------------------

subject to Zap_Block2: zap2 <= max_zap2 * z2;
subject to Zap_Block3: zap3 <= max_zap3;

# Sequential block logic
subject to Zap_Order_z2: z2 <= z1;

# -----------------------------
# SOLVE + OUTPUT
# -----------------------------

solve;

display Profit;
display ray1, ray2, ray3, ray4, b1, b2, b3;
display zap1, zap2, zap3, z1, z2;
