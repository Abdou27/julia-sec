# Group members 
- Abderrahim BENMELOUKA
- Elon COHEN

# Project description
This project consists of writing a Julia program using the JuMP library to solve an optimization problem. 
The problem we address is an application of the max-flow problem. 
It consists of finding a feature of a network, called the strong edge connectivity (SEC), which measures the fault resistance of a network.

# Linear model for the max-flow problem
## Decision Variables:
For each arc in the graph, a binary decision variable x is introduced. It represents whether the flow is present on that arc or not. 
The variable x takes a value of 1 if the flow is present and 0 otherwise. The bounds on the variable are defined as 0 <= x <= 1.

## Objective Function:
The objective is to maximize the total flow leaving the source vertex. 
The flow leaving the source vertex is calculated by summing the flow variables x over all the arcs going out from the source vertex. 
Thus, the objective function is defined as the sum of x for all outgoing arcs from the source vertex.

## Constraints:
- Flow Conservation Constraints:
    For each vertex in the graph (excluding the source and target), a flow conservation constraint is imposed. 
    This constraint ensures that the sum of the flow entering the vertex is equal to the sum of the flow leaving the vertex. 
    It is represented by the equation: ∑(x[incoming_arc]) = ∑(x[outgoing_arc]), for each vertex i (excluding source and target)
- Source and Target Constraints:
    - A constraint is added to ensure that the sum of flow entering the source vertex is zero. 
    This constraint represents the fact that no flow can enter the source vertex.
    ∑(x[incoming_arc]) = 0, for the source vertex
    - Similarly, a constraint is added to ensure that the sum of flow leaving the target vertex is zero. 
    This constraint represents the fact that no flow can leave the target vertex.
    ∑(x[outgoing_arc]) = 0, for the target vertex

## Maximum Flow:
The maximum flow value is determined by solving the linear model. 
The solver optimizes the objective function while satisfying the flow conservation constraints and the source/target constraints.

## Flow Distribution:
After solving the model, the flow distribution is obtained by examining the values of the flow variables x. 
The flow distribution matrix represents the flow values on each arc in the graph.

# Dependencies
The packages `Cbc` and `JuMP` are required for this project.

# Execution
To run the tests, run this command after making sure the packages are installed :
```shell
julia main.jl
```
Please note that calculating the SEC for the 1000-vertex graph will take around 10 seconds.