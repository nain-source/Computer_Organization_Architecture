# Implemented m = (a-c) + (d+e)*f

.text

li t0, 1    # a
li t1, 4    # c
li t2, 6    # d
li t3, 8    # e
li t4, 9    # f

sub t5, t0, t1
add t6, t2, t3
mul s0, t6, t4
add s1, t5, s0
