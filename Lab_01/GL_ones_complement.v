module ones_complement_gatelevel(a,b,c,d,e,f,g,h);
input a,b,c,d;
output e,f,g,h;
not a1(e,a);
not a2(f,b);
not a3(g,c);
not a4(h,d);
endmodule

module testbench_GL_ones_complement();
reg w,x,y,z;
wire z1,z2,z3,z4;

ones_complement_gatelevel oc(w,x,y,z,z1,z2,z3,z4);
initial 
begin
w=0; x=0; y=0; z=0;
#50 w=0; x=0; y=0; z=1;
#50 w=0; x=0; y=1; z=0;
#50 w=0; x=0; y=1; z=1;
#50 w=0; x=1; y=0; z=0;
#50 w=0; x=1; y=0; z=1;
#50 w=0; x=1; y=1; z=0;
#50 w=0; x=1; y=1; z=1;
#50 w=1; x=0; y=0; z=0;
#50 w=1; x=0; y=0; z=1;
#50 w=1; x=0; y=1; z=0;
#50 w=1; x=0; y=1; z=1;
#50 w=1; x=1; y=0; z=0;
#50 w=1; x=1; y=0; z=1;
#50 w=1; x=1; y=1; z=0;
#50 w=1; x=1; y=1; z=1;
#50;
end
endmodule

