module LogicGates_gatelevel(
a,b,
And_output_gate,
Or_output_gate,
Not_output_gate,
Nand_output_gate,
Nor_output_gate,
Xor_output_gate,
Xnor_output_gate
);

input a,b;
output And_output_gate,Or_output_gate,Not_output_gate,Nand_output_gate,Nor_output_gate,Xor_output_gate,Xnor_output_gate;

and a1(And_output_gate,a,b);
or a2(Or_output_gate,a,b);
nand a3(Nand_output_gate,a,b);
nor a4(Nor_output_gate,a,b);
xor a5(Xor_output_gate,a,b);
xnor a6(Xnor_output_gate,a,b);
not a7(Not_output_gate,a);

endmodule

module testBench_g_Gates();
reg x;
reg y;

wire And_out_gate,Or_out_gate,Not_out_gate,Nand_out_gate,Nor_out_gate,Xor_out_gate,Xnor_out_gate;
LogicGates_gatelevel LG(
x,y,
And_out_gate,
Or_out_gate,
Not_out_gate,
Nand_out_gate,
Nor_out_gate,
Xor_out_gate,
Xnor_out_gate
);
initial 
begin
x = 0; y = 0;
#50 x = 0; y = 1;
#50 x = 1; y = 0;
#50 x = 1; y = 1;
#50;
end
endmodule

