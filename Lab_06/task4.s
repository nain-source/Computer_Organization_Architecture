#task 4
.text
main:
addi a0,x0,5    #side of square
jal ra,PerimeterFinder
add t1,x0,a0    #t1 = PerimeterFinder(s) returned value
addi a0,x0,5
jal ra,AreaFinder
add t2,x0,a0    #t2 = AreaFinder(s) returned value
jal x0,end

PerimeterFinder:
addi t3,x0,4
mul a0,a0,t3
jalr x0,ra,0

AreaFinder:
mul a0,a0,a0
jalr x0,ra,0

end:
