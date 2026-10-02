#with recursion
.text
main:
li a0,8     #n
jal ra,fib
add t0,x0,a0    #y = fib(n) returned value
jal x0,end

fib:
beq a0,x0,if     #if n == 0 

li t1,1             #t1 = 1
beq a0,t1,elseif    #else if n == 1

else:
addi sp,sp,-12
sw ra,0(sp)
sw a0,4(sp)

addi a0,a0,-1   #n - 1
jal ra,fib
sw a0,8(sp)

lw a0,4(sp)
addi a0,a0,-2   #n - 2
jal ra,fib

lw s0,8(sp)
add a0,s0,a0    #fib(n-1) + fib(n-2)

lw ra,0(sp)
addi sp,sp,12
jalr x0,ra,0

if:
   jalr x0,ra,0
elseif:
    jalr x0,ra,0
end:
