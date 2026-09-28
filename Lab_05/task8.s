.text

li t0, 0
li t1, 0
li t2, 3
li t4, 2

loop_outside:
bge t1, t2, end_outside
li t3, 0

loop_inside:
bge t3, t4, end_inside
add t0, t1, t3
addi t3, t3, 1
j loop_inside

end_inside:
addi t1, t1, 1
j loop_outside

end_outside:
