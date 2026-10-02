#task 3
.text
main:
addi a0,x0,5    #a
addi a1,x0,6    #b
jal ra,EqSolver
add t0,x0,a0    #x = EqSolver(a,b) returned value
jal x0,end

EqSolver:
add t1,a0,a1    #t1 = a+b
sub t2,a0,a1    #t2 = a-b
mul a0,t1,t2    #a0 = (a+b)(a-b)
jalr x0,ra,0

end:
