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

G2 = [
    0 1 1 0 1 1 0 0 1 0 0 1 0 1 0 1 0 1 1 0 1 0 0 1 0 1;
    1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 0 1 0 1 0 1 0 1;
    1 1 0 1 0 1 1 0 1 1 0 1 0 1 0 1 0 0 1 0 1 0 1 0 0 0;
    0 0 1 0 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0;
    0 1 0 1 0 1 0 1 1 0 1 0 1 0 1 1 0 1 1 0 1 0 1 0 1 0;
    0 1 0 1 1 0 1 0 1 1 0 1 1 0 1 1 1 0 1 1 0 1 1 0 1 0;
    1 0 1 0 1 1 0 1 1 0 1 1 0 1 0 1 1 0 1 1 0 1 1 0 1 1;
    1 0 1 1 0 1 1 0 1 0 1 1 0 1 1 0 1 1 0 1 0 1 1 1 0 1;
    0 1 1 0 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 1 0 1;
    1 1 1 0 1 1 0 1 1 0 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 1;
    1 0 1 1 0 1 0 1 1 1 0 1 1 0 1 0 1 1 0 1 0 1 1 0 1 1;
    0 1 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 1 0 1 1 0 1 1 1 0;
    1 0 1 0 1 1 0 1 0 1 1 1 0 1 1 0 1 1 1 0 1 1 0 1 0 1;
    1 1 0 1 0 1 1 0 1 0 1 1 0 0 1 1 0 1 1 0 1 1 0 1 1 0;
    0 1 0 1 0 1 0 1 1 1 0 1 1 1 0 1 1 0 1 1 0 1 1 0 0 1;
    1 0 1 0 1 0 1 0 0 0 1 0 1 1 1 0 1 1 0 1 0 1 1 0 1 0;
    1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 0 1 0 1 0 1 1 0 1 1;
    0 0 1 1 0 1 0 1 0 1 0 1 1 0 1 1 1 0 1 1 0 1 1 0 1 0;
    0 1 0 1 0 1 0 1 1 0 1 0 1 1 0 1 1 1 0 0 0 1 0 1 1 0;
    0 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 0 1 0 1 0 1 0;
    1 0 1 0 1 1 0 1 1 0 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 0;
    1 0 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 1 1 0 1;
    0 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1 0 1 1 0 1 0 1;
    0 1 0 0 1 0 1 1 0 1 0 1 1 0 1 0 1 1 0 1 0 1 1 0 1 0;
    1 1 0 1 0 1 1 0 1 0 1 1 0 1 1 0 1 0 1 0 1 1 0 1 0 1;
    0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 0
]

G3 = [
    0 1 1 0;
    0 0 1 1;
    1 0 0 1;
    1 1 0 0
]

G4 = [
    0 1 1 0 0 0 0;
    0 0 1 1 1 0 0;
    1 0 0 1 1 1 0;
    1 1 0 0 0 0 1;
    0 0 0 0 0 1 1;
    0 0 1 0 0 0 1;
    0 0 1 0 1 0 0
]

G5 = [
#   α a b c d e f g h i j β
    0 1 1 1 0 1 0 0 0 0 0 0; # α
    0 0 1 0 1 0 0 0 0 0 0 0; # a
    0 0 0 0 0 0 0 0 1 0 0 0; # b
    0 0 1 0 0 1 0 0 1 0 0 0; # c
    0 0 0 0 0 0 0 0 0 1 0 0; # d
    0 0 0 0 0 0 0 1 1 0 0 0; # e
    0 0 0 0 0 0 0 0 0 0 1 1; # f
    0 0 0 0 0 0 1 0 1 0 0 1; # g
    0 0 0 0 1 0 1 0 0 0 0 0; # h
    0 1 0 0 0 0 1 0 0 0 1 1; # i
    0 0 0 0 0 0 0 0 0 0 0 1; # j
    0 0 0 0 0 0 0 0 0 0 0 0  # β
]