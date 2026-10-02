#task 1
.text
main:
li a0, 1
li s0, 2500
jal ra, procedure			# call procedure
add t1, s0, a0			# result should be 1003+2500

li a0,1						# setup system call for display (command in a0)
mv a1, t1						# data to display in a1
ecall						# displays result on console

procedure:
addi sp,sp,-4
sw s0,0(sp)
li s0, 3
li t0, 1000
add a0, s0, t0
lw s0,0(sp)
addi sp,sp,4
jalr zero, ra, 0			# return
