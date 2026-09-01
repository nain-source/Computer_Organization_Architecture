module logicgate_xor(a,b,output_xor);

input a,b;
output output_xor;

wire c,c1,c2,c3;
not a1(c,a);
and a2(c1,c,b);
not a3(c2,b);
and a4(c3,c2,a);
or a5(output_xor,c1,c3);

endmodule

module testbench_gl_xor();
reg x;
reg y;
wire z;

logicgate_xor LGX(x,y,z);
initial
begin

x = 0; y = 0;
#50 x = 0; y = 1;
#50 x = 1; y = 0;
#50 x = 1; y = 1;
#50;

end
endmodule

