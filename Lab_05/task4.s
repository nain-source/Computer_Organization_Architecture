.text

addi t0, x0, 5
addi t1, x0, 10
addi t2, x0, 4
addi t3, x0, 3

beq t0, t1, result
add t4, t2, t3
j end

result:
sub t4, t2, t3

end:
