#Student name: Anvitha Reddy Thummalapally
#Date:13 April 2025


#python libraries
import copy
from random import Random
import numpy as np

#select a seed value & generate random number
seed = 51132023
myPRNG = Random(seed)

#number of elements in a solution
n = 150

#create an "instance" 
value = []
for i in range(0, n):
    value.append(round(myPRNG.triangular(5, 1000, 200), 1))

weights = []
for i in range(0, n):
    weights.append(round(myPRNG.triangular(10, 200, 60), 1))

#defining the max weight
maxWeight = 2500

#monitor the number of solutions evaluated
solutionsChecked = 0

#function to evaluate a solution 
def evaluate(x):
    
    a = np.array(x)
    b = np.array(value)
    c = np.array(weights)
    
    totalValue = np.dot(a, b)
    totalWeight = np.dot(a, c)

    
    penalty = max(0, totalWeight - maxWeight) * 500
    fitness = totalValue - penalty

    return [fitness, totalValue, totalWeight]

#creating a neighborhood
#1-flip neighborhood
def neighborhood(x):
    nbrhood = []
    for i in range(0, n):
        nbrhood.append(x[:])
        if nbrhood[i][i] == 1:
            nbrhood[i][i] = 0
        else:
            nbrhood[i][i] = 1
    return nbrhood

#function to generate an initial solution
def initial_solution():
    x = []
    for i in range(n):
        x.append(myPRNG.randint(0, 1))
    return x

#variable to record number of solutions evaluated
solutionsChecked = 0
x_curr = initial_solution()  #current solution
x_best = x_curr[:]           #best solution
f_curr = evaluate(x_curr)    #evaluation of current solution
f_best = f_curr[:]           #best evaluation

done = 0
while done == 0:
    Neighborhood = neighborhood(x_curr)
    bestnghbr = x_curr
    bestnghbr_fit = f_curr

    
    for s in Neighborhood:
        solutionsChecked = solutionsChecked + 1
        fit = evaluate(s)
        if fit[0] > bestnghbr_fit[0]:
            bestnghbr = s[:]
            bestnghbr_fit = fit[:]

    
    if bestnghbr_fit == f_curr:
        done = 1
    
    else:
        x_curr = bestnghbr[:]    #move to best neighbor
        f_curr = bestnghbr_fit[:]  #updating the current evaluation  

    if f_curr[0] > f_best[0]:
        x_best = x_curr[:]
        f_best = f_curr[:]

print("\nTotal number of solutions checked: ", solutionsChecked)
print("Best value found so far: ", f_best[1])
print("Weight is: ", f_best[2])
print("Total number of items selected: ", np.sum(x_best))
print("Best solution: ", x_best)
