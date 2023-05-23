using Test

include("functions.jl")
include("matrices.jl")

"""
In this file, we test the different functions with the small graphs (G3, G4, G5), 
then we use those functions to compute the different P and SEC properties of the big graphs (G1, G2)
"""

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

# Testing the find_minimum_cut function
@test find_minimum_cut(G1) == (1, [(26, 25)])
@test find_minimum_cut(G2) == (12, [(9, 2), (9, 3), (9, 10), (9, 11), (9, 13), (9, 14), (9, 17), (9, 19), (9, 20), (9, 23), (9, 24), (9, 26)])
@test find_minimum_cut(G3) == (2, [(1, 2), (1, 3)])
@test find_minimum_cut(G4) == (2, [(1, 2), (1, 3)])
@test find_minimum_cut(G5) == (0, [])
println("All find_minimum_cut function tests passed !")
