"""
Group members :
- Abderrahim BENMELOUKA
- Elon COHEN

This file contains all the different functions used for this project.
"""

using Cbc, JuMP, SparseArrays

"""
Linear model to solve the max-flow problem of `graph` from `source` to `target`.
Uses binary variables representing whether each edge of the graph is used or not.

Optimisation idea for the 1000-vertex graph :
    Instead of keeping a dense adjacency matrix, we convert it into a sparse matrix.
    This way, we have one variable for each edge in the graph instead of one variable for each pair of two vertices (1000^2).
"""
function linear_model(graph::Matrix{Int}, source::Int, target::Int)::Tuple{Int,Matrix{Int}}
    # Size of the matrix
    n = size(graph, 1)

    # Create an optimisation model
    model = Model(Cbc.Optimizer)

    #  
    # Instead of keeping a dense adjacency matrix, we convert it into a sparse matrix
    # This way, we have one variable for each edge in the graph instead of one variable for each pair of two vertices (1000^2)

    # Convert the adjacency matrix into a sparse matrix
    sparse_graph = sparse(graph)

    # Get the row and column indices and zip them together
    nonzero_values = findnz(sparse_graph)
    row_indices = nonzero_values[1]
    col_indices = nonzero_values[2]
    zipped_indices = zip(row_indices, col_indices)
    enumerated_arcs = enumerate(zipped_indices)

    # The decision variables x[k], representing the flow on each arc in the graph.
    # The variables are binary.
    x = @variable(model, 0 <= x[i=1:length(enumerated_arcs)] <= 1, Bin)

    # For each vertex i (excluding the source and target), this constraint ensures that the sum of flow entering i is equal to the sum of flow leaving i. 
    for i in 1:n
        if i != source && i != target
            incoming_arcs = [idx for (idx, (row, col)) in enumerated_arcs if col == i]
            outgoing_arcs = [idx for (idx, (row, col)) in enumerated_arcs if row == i]
            @constraint(model, sum(x[incoming_arc] for incoming_arc in incoming_arcs) == sum(x[outgoing_arc] for outgoing_arc in outgoing_arcs))
        end
    end
    # This constraint ensures that the sum of flow entering the source vertex is zero.
    incoming_arcs_source = [idx for (idx, (row, col)) in enumerated_arcs if col == source]
    @constraint(model, sum(x[incoming_arc] for incoming_arc in incoming_arcs_source) == 0)

    # This constraint ensures that the sum of flow leaving the target vertex is zero.
    outgoing_arcs_target = [idx for (idx, (row, col)) in enumerated_arcs if row == target]
    @constraint(model, sum(x[outgoing_arc] for outgoing_arc in outgoing_arcs_target) == 0)

    # The objective is to maximize the total flow leaving the source vertex (source).
    outgoing_arcs_source = [idx for (idx, (row, col)) in enumerated_arcs if row == source]
    @objective(model, Max, sum(x[outgoing_arc] for outgoing_arc in outgoing_arcs_source))

    # Solve the optimisation problem
    MOI.set(model, MOI.Silent(), true)
    optimize!(model)

    # Check solution status
    @assert termination_status(model) == MOI.OPTIMAL "No optimal solution found for the maximum flow problem"

    # Retrieve maximum flow value and convert it to Int
    flow_value = round(Int, objective_value(model))
    # Retrieve the flow distribution values from the resulting sparse matrix and convert them into Int
    flow_distribution = zeros(Int, n, n)
    flow_distribution_int = round.(Int, value.(x))
    for (index, (i, j)) in enumerated_arcs
        flow_distribution[i, j] = flow_distribution_int[index]
    end

    return flow_value, flow_distribution
end

"""
The function finds the minimum cut of a strongly connected graph by iteratively applying the maximum flow algorithm. 

It considers all possible pairs of vertices in the graph and finds the maximum flow between them. 
The minimum cut is then determined as the cut with the minimum maximum flow value. 

The minimum cut represents the edges whose removal disconnects the source and target vertices with the least possible flow.
"""
function find_minimum_cut(graph::Matrix{Int})::Tuple{Int,Array{Tuple{Int,Int}}}
    # Size of the matrix
    n = size(graph, 1)

    # A graph containing less than 2 vertices can't be strongly connected
    if n < 2
        return 0, []
    end

    # Find min cut by iteration
    p_min = Inf
    min_cut = []
    for a in 1:n
        b = a + 1
        if b > n
            # v_n = v_0
            b = 1
        end
        p, min_edges = linear_model(graph, a, b)

        if p == 0
            # The graph isn't strongly connected
            return p, []
        elseif p < p_min
            # Update p_min and min_cut with new values
            p_min = p
            min_cut = map(y -> (a, y), findall(x -> x == 1, min_edges[a, :]))
        end
    end

    return p_min, min_cut
end

"""
Function to compute the maximum number of edge-disjoint paths from `source` to `target` in `graph`. 
"""
function P(graph::Matrix{Int}, source::Int, target::Int)::Int
    return linear_model(graph, source, target)[1]
end

"""
Function to compute the strong edge connectivity (SEC) of `graph`. 
"""
function SEC(graph::Matrix{Int})::Int
    return find_minimum_cut(graph)[1]
end

"""
Function to compute the minimum set of edges that have to be removed from `graph` in order to make it no longer strongly connected. 
"""
function min_set_of_edges(graph::Matrix{Int})::Array{Tuple{Int,Int}}
    return find_minimum_cut(graph)[2]
end

"""
Function to generate a stronglt connected graph of `n` vertices.

Please note that due to the way this graph is generated, it's SEC will always be 1.
"""
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
