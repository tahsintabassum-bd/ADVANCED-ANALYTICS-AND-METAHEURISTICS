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

##create an "instance" 
value = []
for i in range(0,n):
    value.append(round(myPRNG.triangular(5,1000,200),1))
    
weights = []
for i in range(0,n):
    weights.append(round(myPRNG.triangular(10,200,60),1))

#defining the max weight
maxWeight = 2500

#function to evaluate a solution 
def evaluate(x):
    a = np.array(x)
    b = np.array(value)
    c = np.array(weights)

    totalValue = np.dot(a, b)
    totalWeight = np.dot(a, c)

    return [totalValue, totalWeight]

#creating a neighborhood
#1-flip neighborhood
def neighborhood(x):
    nbrhood = []
    for i in range(n):
        nbr = x[:]
        nbr[i] = 1 - nbr[i]  
        nbrhood.append(nbr)
    return nbrhood

#creating an initial solution
def initial_solution():
    x = [0] * n
    item_indices = list(range(n))
    myPRNG.shuffle(item_indices)

    currentWeight = 0
    for i in item_indices:
        if currentWeight + weights[i] <= maxWeight:
            x[i] = 1
            currentWeight += weights[i]
    return x




solutionsChecked = 0
x_curr = initial_solution() #current solution
f_curr = evaluate(x_curr)   #evaluation of current solution

done = 0

while done == 0:
    Neighborhood = neighborhood(x_curr)
    move = 0

    for s in Neighborhood:
        solutionsChecked += 1
        f_s = evaluate(s)

        
        if f_s[1] <= maxWeight and f_s[0] > f_curr[0]:
            x_curr = s[:]
            f_curr = f_s[:]
            move = 1
            break    #Stopping after the first improvement is found

    if move == 0:
        done = 1    #terminate if no improvement is found


print("\nFinal number of solutions checked: ", solutionsChecked)
print("Best value found: ", f_curr[0])
print("Weight is: ", f_curr[1])
print("Total number of items selected: ", np.sum(x_curr))
print("Best solution: ", x_curr) 