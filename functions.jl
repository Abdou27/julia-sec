using Cbc, JuMP
using LightGraphs, SimpleWeightedGraphs

function linear_model(graph::Matrix{Int}, source::Int, target::Int, flow_distribution::Matrix{Int})::Tuple{Int, Matrix{Int}}
    # Size of the matrix
    n = size(graph, 1)

    # Create an optimization model
    model = Model(Cbc.Optimizer)

    # The decision variables x[i, j], representing the flow on the arc (i, j) in the graph. 
    # The variables are non-negative and bounded by the capacity graph[i, j] of the corresponding arc.
    @variable(model, 0 <= x[i = 1:n, j = 1:n] <= graph[i, j], Bin)

    # For each vertex i (excluding the source and target), this constraint ensures that the sum of flow entering i is equal to the sum of flow leaving i. 
    for i in 1:n
        if i != source && i != target
            @constraint(model, sum(x[j, i] for j in 1:n if j != i) == sum(x[i, j] for j in 1:n if j != i))
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

    # Retrieve maximum flow value and flow distribution and convert them to Ints
    flow_value = round(Int, objective_value(model))
    flow_distribution[:] = round.(Int, value.(x))

    return flow_value, flow_distribution
end

function find_minimum_cut(graph::Matrix{Int})::Tuple{Int, Array{Tuple{Int, Int}}}
    # Size of the matrix
    n = size(graph, 1)

    # If only one vertex, the graph isn't strongly connected
    if n < 2
        return 0, []
    end

    # Find min cut by iteration
    p_min = Inf
    min_cut = []
    flow_matrix = zeros(Int, n, n)
    for a in 1:n
        b = a + 1
        if b > n
            b = 1
        end
        p, x = linear_model(graph, a, b, flow_matrix)

        if p == 0
            # The graph isn't strongly connected
            return p, []
        elseif p < p_min
            # Update p_min and min_cut with new values
            p_min = p
            min_cut = map(y -> (a, y), findall(x->x==1, x[a,:]))
        end
    end

    return p_min, min_cut
end

function P(graph::Matrix{Int}, source::Int, target::Int)::Int
    n = size(graph, 1)
    flow_matrix = zeros(Int, n, n)
    return linear_model(graph, source, target, flow_matrix)[1]
end

function SEC(graph::Matrix{Int})::Int
    return find_minimum_cut(graph)[1]
end

function min_set_of_edges(graph::Matrix{Int})::Array{Tuple{Int, Int}}
    return find_minimum_cut(graph)[2]
end

function generate_connected_graph(n::Int)::Matrix{Int}
    # Create an empty adjacency matrix
    graph = zeros(Int, n, n)

    # Start with a tree with n-1 vertices
    for i in 2:n
        # Connect the current vertex to a randomly selected previous vertex
        previous_vertex = rand(1:i-1)
        graph[i, previous_vertex] = 1
        graph[previous_vertex, i] = 1
    end

    # Connect the remaining vertex to a randomly selected vertex
    remaining_vertex = rand(1:n)
    graph[n, remaining_vertex] = 1
    graph[remaining_vertex, n] = 1

    return graph
end

function sec_lg(graph::Matrix{Int})::Int
    n = size(graph, 1)
    if n < 2
        return 0
    end

    g = SimpleWeightedGraph(graph)

    p_min = Inf
    for a in 1:n
        b = mod(a % n, n) + 1
        flow = maximum_flow(g, a, b)[1]

        if flow == 0
            return flow
        elseif flow < p_min
            p_min = flow
        end
    end

    return p_min
end