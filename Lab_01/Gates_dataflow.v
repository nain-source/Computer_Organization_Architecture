
module LogicGates_dataflow(
a,b,
And_output_dataflow,
Or_output_dataflow,
Not_output_dataflow,
Nand_output_dataflow,
Nor_output_dataflow,
Xor_output_dataflow,
Xnor_output_dataflow
);

input a,b;
output And_output_dataflow,Or_output_dataflow,Not_output_dataflow,Nand_output_dataflow,Nor_output_dataflow,Xor_output_dataflow,Xnor_output_dataflow;

assign And_output_dataflow = a&b;
assign Or_output_dataflow = a|b;
assign Not_output_dataflow = ~a;
assign Nand_output_dataflow = ~(a&b);
assign Nor_output_dataflow = ~(a|b);
assign Xor_output_dataflow = a^b;
assign Xnor_output_dataflow = ~(a^b);
endmodule

module testBench_df_Gates();

reg x;
reg y;
wire And_out_dataflow,Or_out_dataflow,Not_out_dataflow,Nand_out_dataflow,Nor_out_dataflow,Xor_out_dataflow,Xnor_out_dataflow;

LogicGates_dataflow LGD(
x,y,
And_out_dataflow,
Or_out_dataflow,
Not_out_dataflow,
Nand_out_dataflow,
Nor_out_dataflow,
Xor_out_dataflow,
Xnor_out_dataflow
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
