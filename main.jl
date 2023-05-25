"""
Group members :
- Abderrahim BENMELOUKA
- Elon COHEN

In this file, we test the different functions with the small graphs (G3, G4, G5) so that we can validate them by hand, 
then we use those functions to compute the different properties of the big graphs (G1, G2).

SEC Results :
SEC(G1) = 1
SEC(G2) = 12
SEC(G3) = 2
SEC(G4) = 2
SEC(G5) = 0

Minimum set of edges to make the graphs no longer strongly connected :
G1 = [(26, 25)]
G2 = [(9, 2), (9, 3), (9, 10), (9, 11), (9, 13), (9, 14), (9, 17), (9, 19), (9, 20), (9, 23), (9, 24), (9, 26)]
G3 == [(1, 2), (1, 3)]
G4 == [(1, 2), (1, 3)]
G5 == []
"""

using Test

include("functions.jl")
include("matrices.jl")

# Testing the P function
# With G3
@test P(G3, 1, 2) == 2
@test P(G3, 2, 3) == 2
@test P(G3, 3, 4) == 2
@test P(G3, 4, 1) == 2
# With G4
@test P(G4, 1, 2) == 2
@test P(G4, 2, 3) == 3
@test P(G4, 3, 4) == 2
@test P(G4, 4, 5) == 3
@test P(G4, 5, 6) == 2
@test P(G4, 6, 7) == 2
@test P(G4, 7, 1) == 2
# With G5
@test P(G5, 1, 2) == 2
@test P(G5, 2, 3) == 1
@test P(G5, 3, 4) == 0
@test P(G5, 4, 5) == 1
@test P(G5, 5, 6) == 0
@test P(G5, 6, 7) == 2
@test P(G5, 7, 8) == 0
@test P(G5, 8, 9) == 1
@test P(G5, 9, 10) == 1
@test P(G5, 10, 11) == 2
@test P(G5, 11, 12) == 1
@test P(G5, 12, 1) == 0

println("All P function tests passed !")

# G1
n = size(G1, 1)
seen_values = Int[]
for i in 1:n
    j = i+1
    if j > n
        j = 1
    end
    p = P(G1, i, j)
    if !in(p, seen_values)
        println("P(G1, $i, $j) = $p")
        push!(seen_values, p)
    end
end
# G2
n = size(G2, 1)
seen_values = Int[]
for i in 1:n
    j = i+1
    if j > n
        j = 1
    end
    p = P(G2, i, j)
    if !in(p, seen_values)
        println("P(G2, $i, $j) = $p")
        push!(seen_values, p)
    end
end

println("-------------------------------------")

# Testing the SEC function
@test SEC(G3) == 2
@test SEC(G4) == 2
@test SEC(G5) == 0

println("All SEC function tests passed !")

sec_G1 = SEC(G1)
println("SEC(G1) = $sec_G1")
sec_G2 = SEC(G2)
println("SEC(G2) = $sec_G2")

println("-------------------------------------")

# Testing the min_set_of_edges function
@test min_set_of_edges(G3) == [(1, 2), (1, 3)]
@test min_set_of_edges(G4) == [(1, 2), (1, 3)]
@test min_set_of_edges(G5) == []

println("All min_set_of_edges function tests passed !")

min_set_of_edges_G1 = min_set_of_edges(G1)
println("Minimum set of edges to make G1 no longer strongly connected = $min_set_of_edges_G1")
min_set_of_edges_G2 = min_set_of_edges(G2)
println("Minimum set of edges to make G2 no longer strongly connected = $min_set_of_edges_G2")

println("-------------------------------------")

# Computing the SEC of a connected graph of 1000 vertices
# PS: With the way this graph is generated: the SEC should always be 1.
# The goal here is to test if the code scales well with big graphs.
G_1000 = generate_connected_graph(1000)
print("SEC(G_1000) = ", SEC(G_1000))
