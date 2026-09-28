.text

addi t0, x0, 0
addi t1, x0, 1
addi t2, x0, 5

loop:
bgt t1, t2, end
addi t0, t0, 1
addi t1, t1, 1
j loop

end:
