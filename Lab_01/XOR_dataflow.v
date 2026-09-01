module logicgate_xor_dataflow(a,b,output_xor);
input a,b;
output output_xor;

wire c,c1,c2,c3;
assign c = ~a;
assign c1 = c & b;
assign c2 = ~b;
assign c3 = c2 & a;
assign output_xor = c1 | c3;

endmodule

module testbench_xor_dfl();
reg x;
reg y;
wire z;

logicgate_xor_dataflow LGX(x,y,z);
initial
begin

x = 0; y = 0;
#50 x = 0; y = 1;
#50 x = 1; y = 0;
#50 x = 1; y = 1;
#50;
end
endmodule

