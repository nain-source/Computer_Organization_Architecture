.data
num: .word 2, 4, 6, 8, 10, 12, 14, 16, 18, 20

.text
.globl main

main:
li t0, 0
li t1, 5
la t2, num

loop:
bge t0, t1, end
slli t3, t0, 2
add t3, t2, t3
addi t4, t0, 5
sw t4, 0(t3)
addi t0, t0, 1
j loop

end:
