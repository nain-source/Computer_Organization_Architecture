#task 8 
.text
main:
addi a0,x0,5    #n
jal ra,fib
jal x0,end

fib:
li t1,0     #a = 0
li t2,1     #b = 1
beq a0,x0,if
else:
li t4,2     #i = 2
for:
bgt t4,a0,outside
add t3,t1,t2    #c = a+b
add t1,x0,t2   #a=b
add t2,x0,t3   #b=c
addi t4,t4,1    #i = i+1
jal x0,for
outside:
li a0,0
add a0,x0,t2
jalr x0,ra,0

if:
li a0,0
jalr x0,ra,0
end:
