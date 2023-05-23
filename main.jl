using Test

include("functions.jl")
include("matrices.jl")

@test P(G3, 1, 2)[1] == 2
@test P(G3, 2, 3)[1] == 2
@test P(G3, 3, 4)[1] == 2
@test P(G3, 4, 1)[1] == 2
@test P(G5, 1, 12)[1] == 3
@test P(G5, 2, 3)[1] == 1
@test P(G5, 3, 4)[1] == 0

# Calcul de la SEC et de la coupe minimale
st = [1, 12, 2, 2, 0]
ct = ([(26, 25)],[(9, 2), (9, 3), (9, 10), (9, 11), (9, 13), (9, 14), (9, 17), (9, 19), (9, 20), (9, 23), (9, 24), (9, 26)],
[(1, 2), (1, 3)], [(1, 2), (1, 3)], [])
for (i, g) in enumerate((G1,G2,G3,G4,G5)) 
    s, c = sec(g, true)
    @test s == st[i]
    @test c == ct[i]
    println("SEC(G", i,")=", s)
    println("CUT(G", i,")=", c, "\n")
end
