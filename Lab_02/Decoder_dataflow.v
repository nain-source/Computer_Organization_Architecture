module decoder_3to8_dataflow(a,b,c,D0,D1,D2,D3,D4,D5,D6,D7);
input a,b,c;
output D0,D1,D2,D3,D4,D5,D6,D7;
wire na,nb,nc;
assign na = ~a;
assign nb = ~b;
assign nc = ~c;

assign D0 = na & nb & nc;
assign D1 = na & nb & c;
assign D2 = na & b & nc;
assign D3 = na & b & c;
assign D4 = a & nb & nc;
assign D5 = a & nb & c;
assign D6 = a & b & nc;
assign D7 = a & b & c;

endmodule


module testbench_df_decoder();
reg x,y,z;
wire d_0,d_1,d_2,d_3,d_4,d_5,d_6,d_7;

decoder_3to8_dataflow DD(x,y,z,d_0,d_1,d_2,d_3,d_4,d_5,d_6,d_7);
initial
begin
x = 0; y = 0; z = 0;
#50 x = 0; y = 0; z = 1;
#50 x = 0; y = 1; z = 0;
#50 x = 0; y = 1; z = 1;
#50 x = 1; y = 0; z = 0;
#50 x = 1; y = 0; z = 1;
#50 x = 1; y = 1; z = 0;
#50 x = 1; y = 1; z = 1;
#50;
end
endmodule
