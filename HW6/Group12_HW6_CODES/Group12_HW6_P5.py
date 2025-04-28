# select a seed value & generate random number
seed = 51132023
myPRNG = Random(seed)

# number of elements in a solution
n = 150

# create an "instance" for the knapsack problem
value = []
for i in range(0,n):
    value.append(round(myPRNG.triangular(5,1000,200),1))
    
weights = []
for i in range(0,n):
    weights.append(round(myPRNG.triangular(10,200,60),1))
    
# define max weight for the knapsack
maxWeight = 2500

all_items={}
for i in range(n):
    all_items[i+1]=(value[i],weights[i])
    
#create the initial solution : based on Random selection
def initial_solution():
    x = []   # i recommend creating the solution as a list
    selected = []
    while sum(all_items[item][1] for item in selected) < maxWeight:
        item = random.choice(list(all_items.keys()))
        if sum(all_items[item][1] for item in selected) + all_items[item][1] <= maxWeight:
            selected.append(item)
        else:
            x = [1 if i in selected else 0 for i in range(1, n+1)]
            break
    return x

#1-flip neighborhood of solution x         
def neighborhood(x):
    nbrhood = []     
    for i in range(0,n):
        nbrhood.append(x[:])
        if nbrhood[i][i] == 1:
            nbrhood[i][i] = 0
        else:
            nbrhood[i][i] = 1
    return nbrhood

# Evaluate the function
def evaluate(x):
    a=np.array(x)
    b=np.array(value)
    c=np.array(weights)
    
    totalValue = np.dot(a,b)     #compute the value of the knapsack selection
    totalWeight = np.dot(a,c)    #compute the weight value of the knapsack selection
    
    if totalWeight > maxWeight:
        penalty = totalValue-500*(totalWeight - maxWeight) # set a large penalty for exceeding the max weight
        return [penalty, totalWeight]
    
    return [totalValue, totalWeight]

#varaible to record the number of solutions evaluated
solutionsChecked = 0

# Set the probability of random walk
p = 0.9

x_curr=initial_solution()
x_best=x_curr[:]
f_curr=evaluate(x_curr)
f_best=f_curr[:]

#begin local search overall logic ----------------    
max_iters = 1000000 # maximum number of iterations allowed
num_iters = 0   # initialize the number of iterations performed to zero
num_non_improving_iters = 0 # initialize the number of consecutive non-improving iterations to zero
num_non_improving_iter_limit=10000
best_value = 0  # initialize the best value found to zero

while num_iters < max_iters and num_non_improving_iters < num_non_improving_iter_limit:
    # Generate a random number between 0 and 1
    rand_num = myPRNG.random()
    
    if rand_num <= p:  # Perform a random walk
        Neighborhood = neighborhood(x_curr)
        x_curr = random.choice(Neighborhood)[:]
        f_curr = evaluate(x_curr)[:]
    
    else:  # Evaluate the current solution
        Neighborhood = neighborhood(x_curr)
        found_improvement = False
        for s in Neighborhood:
            solutionsChecked = solutionsChecked + 1
            if evaluate(s)[0] > f_best[0]:
                x_best = s[:]
                f_best = evaluate(s)[:]
                found_improvement = True
        
        if found_improvement:
            x_curr = x_best[:]
            f_curr = f_best[:]
            num_non_improving_iters = 0
            print ("\nTotal number of solutions checked: ", solutionsChecked)
            print ("Best value found so far: ", f_best)
            
            if f_best[0] > best_value:
                best_value = f_best[0]
        
        else:
            num_non_improving_iters += 1
            
    num_iters += 1
        
print ("\nTotal number of solutions checked: ", solutionsChecked)
print ("Best value found: ", f_best[0])
print ("Weight is: ", f_best[1])
print ("Total number of items selected: ", np.sum(x_best))
print ("Best solution: ", x_best)
# select a seed value & generate random number
seed = 51132023
myPRNG = Random(seed)

# number of elements in a solution
n = 150

# create an "instance" for the knapsack problem
value = []
for i in range(0,n):
    value.append(round(myPRNG.triangular(5,1000,200),1))
    
weights = []
for i in range(0,n):
    weights.append(round(myPRNG.triangular(10,200,60),1))
    
# define max weight for the knapsack
maxWeight = 2500

all_items={}
for i in range(n):
    all_items[i+1]=(value[i],weights[i])
    
#create the initial solution : based on Random selection
def initial_solution():
    x = []   # i recommend creating the solution as a list
    selected = []
    while sum(all_items[item][1] for item in selected) < maxWeight:
        item = random.choice(list(all_items.keys()))
        if sum(all_items[item][1] for item in selected) + all_items[item][1] <= maxWeight:
            selected.append(item)
        else:
            x = [1 if i in selected else 0 for i in range(1, n+1)]
            break
    return x

#1-flip neighborhood of solution x         
def neighborhood(x):
    nbrhood = []     
    for i in range(0,n):
        nbrhood.append(x[:])
        if nbrhood[i][i] == 1:
            nbrhood[i][i] = 0
        else:
            nbrhood[i][i] = 1
    return nbrhood

# Evaluate the function
def evaluate(x):
    a=np.array(x)
    b=np.array(value)
    c=np.array(weights)
    
    totalValue = np.dot(a,b)     #compute the value of the knapsack selection
    totalWeight = np.dot(a,c)    #compute the weight value of the knapsack selection
    
    if totalWeight > maxWeight:
        penalty = totalValue-500*(totalWeight - maxWeight) # set a large penalty for exceeding the max weight
        return [penalty, totalWeight]
    
    return [totalValue, totalWeight]

#varaible to record the number of solutions evaluated
solutionsChecked = 0

# Set the probability of random walk
p = 0.5

x_curr=initial_solution()
x_best=x_curr[:]
f_curr=evaluate(x_curr)
f_best=f_curr[:]

#begin local search overall logic ----------------    
max_iters = 1000000 # maximum number of iterations allowed
num_iters = 0   # initialize the number of iterations performed to zero
num_non_improving_iters = 0 # initialize the number of consecutive non-improving iterations to zero
num_non_improving_iter_limit=10000
best_value = 0  # initialize the best value found to zero

while num_iters < max_iters and num_non_improving_iters < num_non_improving_iter_limit:
    # Generate a random number between 0 and 1
    rand_num = myPRNG.random()
    
    if rand_num <= p:  # Perform a random walk
        Neighborhood = neighborhood(x_curr)
        x_curr = random.choice(Neighborhood)[:]
        f_curr = evaluate(x_curr)[:]
    
    else:  # Evaluate the current solution
        Neighborhood = neighborhood(x_curr)
        found_improvement = False
        for s in Neighborhood:
            solutionsChecked = solutionsChecked + 1
            if evaluate(s)[0] > f_best[0]:
                x_best = s[:]
                f_best = evaluate(s)[:]
                found_improvement = True
        
if found_improvement:
            x_curr = x_best[:]
            f_curr = f_best[:]
            num_non_improving_iters = 0
            print ("\nTotal number of solutions checked: ", solutionsChecked)
            print ("Best value found so far: ", f_best)
            
            if f_best[0] > best_value:
                best_value = f_best[0]
        
        else:
            num_non_improving_iters += 1
            
    num_iters += 1
        
print ("\nTotal number of solutions checked: ", solutionsChecked)
print ("Best value found: ", f_best[0])
print ("Weight is: ", f_best[1])
print ("Total number of items selected: ", np.sum(x_best))
print ("Best solution: ", x_best)
