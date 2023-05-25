using Test
using SparseArrays
include("functions.jl")
include("matrices.jl")

G = generate_connected_graph(1000)
G_sparse = sparse(G)
print(G_sparse)

