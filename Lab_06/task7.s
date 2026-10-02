#task 7
.text
main:
addi a0,x0,8    #n
addi a1,x0,8    #k
beq a1,x0,func1     #func1(n)
beq a0,a1,func2     #func2(n)
jal x0,func3        #func3(n)

func1:  #int func1(int x)
mul t1,a0,a0    #y = x^2
jal x0,end

func2:  #int func2(int z)
mul t1,a0,a0
mul t1,t1,a0    #y = z^3
jal x0,end

func3:  #int func3(int w)
addi t1,a0,1     #y = w + 1 
jal x0,end

end:
