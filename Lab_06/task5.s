#task 5
.text
main:
addi a0,x0,5    #x
jal ra,EqSolver
add t0,x0,a0    #y = EqSolver(x) returned value
jal x0,end

EqSolver:
mul t1,a0,a0    #t1 = x^2
mul t2,t1,a0    #t2 = x^3
addi t3,x0,5
mul t1,t3,t1    #t1 = 5x^2
addi t3,x0,6
mul a0,a0,t3    #a0 = 6x
add a0,a0,t1
add a0,a0,t2    #a0 = 6x + 5x^2 + x^3
jalr x0,ra,0

end:
