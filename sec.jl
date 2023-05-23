using Cbc, JuMP

G1 = [
0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0;
0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0;
0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0;
0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0;
0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0;
0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0;
0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 1 0 1 0 1 0 0 0 0 0 1 1 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 0 1 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 1 0 0 0 0 0 0 0 0;
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1;
0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 0 0 0 0 0 0 0 1;
0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 1 0 0;
0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 1 0 0 0;
0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0;
0 0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0;
0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 1 0 0 0;
0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0;
0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 1 0;
1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1;
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 1 0
]

function P(g::Matrix{Int}, source::Int, target::Int)
    # Size of the matrix
    n = size(g, 1)

    # Create an optimization model
    model = Model(Cbc.Optimizer)

    # The decision variables x[i, j], representing the flow on the arc (i, j) in the graph. 
    # The variables are non-negative and bounded by the capacity g[i, j] of the corresponding arc.
    @variable(model, 0 <= x[i = 1:n, j = 1:n] <= g[i, j])

    # For each vertex i (excluding the source and target), this constraint ensures that the sum of flow entering i is equal to the sum of flow leaving i. 
    @constraint(model, sum(x[j, i] for j in 1:n if j ≠ i) == sum(x[i, j] for j in 1:n if j ≠ i) for i in 1:n if i ≠ source && i ≠ target)
    # This constraint ensures that the sum of flow entering the source vertex is zero.
    @constraint(model, sum(x[j, source] for j in 1:n) == 0)
    # This constraint ensures that the sum of flow leaving the target vertex is zero.
    @constraint(model, sum(x[target, j] for j in 1:n) == 0)

    # The objective is to maximize the total flow leaving the source vertex (source).
    @objective(model, Max, sum(x[source, j] for j in 1:n))

    # Solve the optimization problem
    optimize!(model)

    # Check solution status
    status = termination_status(model)
    @assert status == MOI.OPTIMAL "No optimal solution found for the maximum flow problem"

    # Retrieve maximum flow value and flow distribution
    flow_value = round(Int, objective_value(model))
    flow_distribution = round.(Int, value.(x))

    return flow_value, flow_distribution
end
