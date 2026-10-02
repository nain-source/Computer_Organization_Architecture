#task 6
.text
main:
addi a0,x0,4    #n
addi a1,x0,1    #k
addi t2,x0,1
beq a1,t2,F1     #F1(n,k) if k == 1
bgt a0,a1,F2     #F2(n) else if n > k
jal x0,F3        #F3(n) else

F1:  #int F1(int x,int z)
mul t1,a0,a0    #y = x^2
mul t3,a1,a1    #z^2
add t1,t1,t3    #y = x^2 + z^2
jal x0,end

F2:  #int F2(int z)
mul t1,a0,a0
mul t1,t1,a0    #y = z^3
jal x0,end

F3:  #int F3(int w)
addi t1,a0,5     #y = w + 5
jal x0,end
end:
