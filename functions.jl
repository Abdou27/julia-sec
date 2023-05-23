using Cbc, JuMP

function P(g::Matrix{Int}, source::Int, target::Int)::Tuple{Int, Matrix{Int}}
    # Size of the matrix
    n = size(g, 1)

    # Create an optimization model
    model = Model(Cbc.Optimizer)

    # The decision variables x[i, j], representing the flow on the arc (i, j) in the graph. 
    # The variables are non-negative and bounded by the capacity g[i, j] of the corresponding arc.
    @variable(model, 0 <= x[i = 1:n, j = 1:n] <= g[i, j])

    # For each vertex i (excluding the source and target), this constraint ensures that the sum of flow entering i is equal to the sum of flow leaving i. 
    for i in 1:n
        if i ≠ source && i ≠ target
            @constraint(model, sum(x[j, i] for j in 1:n if j ≠ i) == sum(x[i, j] for j in 1:n if j ≠ i))
        end
    end
    # This constraint ensures that the sum of flow entering the source vertex is zero.
    @constraint(model, sum(x[j, source] for j in 1:n) == 0)
    # This constraint ensures that the sum of flow leaving the target vertex is zero.
    @constraint(model, sum(x[target, j] for j in 1:n) == 0)

    # The objective is to maximize the total flow leaving the source vertex (source).
    @objective(model, Max, sum(x[source, j] for j in 1:n))

    # Solve the optimization problem
    MOI.set(model, MOI.Silent(), true)
    optimize!(model)

    # Check solution status
    @assert termination_status(model) == MOI.OPTIMAL "No optimal solution found for the maximum flow problem"

    # Retrieve maximum flow value and flow distribution
    flow_value = round(Int, objective_value(model))
    flow_distribution = round.(Int, value.(x))

    return flow_value, flow_distribution
end

function sec(graph::Matrix{Int}, verbose::Bool = false)::Tuple{Int, Array{Tuple{Int, Int}}}
    # Size of the matrix
    n = size(graph, 1)

    # Handle base case
    if n < 2
        return 0, []
    end

    pmin = Inf
    mincut = []

    for a in 1:n
        b = mod(a % n, n) + 1
        p, x = P(graph, a, b)

        if verbose
            println("P($a, $b) = $p")
        end

        if p == 0
            return p, []
        elseif p < pmin
            pmin = p
            mincut = map(y -> (a, y), findall(x->x==1, x[a,:]))
        end
    end

    return pmin, mincut
end
