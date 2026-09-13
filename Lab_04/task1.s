
.text

# A = 5
# B = 4
addi t0, x0, 5
addi t1, x0, 4

# C = A + B
add t2, t0, t1

# D = A - B
sub t3, t0, t1

# E = A * B
mul t4, t0, t1

# F = A^2
mul t5, t0, t0
