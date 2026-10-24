module full_adder_dataflowlevel(a, b, cin, sum, carry_out);
input a, b, cin;
output sum, carry_out;
assign sum = a ^ b ^ cin;
assign carry_out = (a & b) | (a & cin) | (b & cin);
endmodule

module Mux_4to1(I0, I1, I2, I3, S0, S1, Y);
input I0, I1, I2, I3, S0, S1;
output Y;
wire nS0, nS1;

assign nS0 = ~S0;
assign nS1 = ~S1;
assign Y = (nS0 & nS1 & I0) | (nS0 & S1 & I1) | (S0 & nS1 & I2) | (S0 & S1 & I3);
endmodule

module ALU_1bit_dataflow(a, b, cin, b_inv, select, result, carry_out);
input a, b, cin, b_inv;          
input [1:0] select;
output result, carry_out;
wire adder_out;
wire and_out, or_out, b_inverted;

assign and_out = a & b;
assign or_out  = a | b;

assign b_inverted = b ^ b_inv;
full_adder_dataflowlevel FA(a, b_inverted, cin, adder_out, carry_out);

Mux_4to1 mx (and_out, or_out, add_out,1'b0, select[1], select[0], result);            

endmodule

module tb_ALU_1bit_df();

reg a, b, cin, b_inv;
reg [1:0] select;
wire result, carry_out;

ALU_1bit_dataflow uut(
    .a(a),
    .b(b),
    .cin(cin),
    .b_inv(b_inv),
    .select(select),
    .result(result),
    .carry_out(carry_out)
);

initial
begin
select = 2'b00;                      
b_inv = 0;
cin = 0;
a = 0; b = 0; #50;
a = 0; b = 1; #50;
a = 1; b = 0; #50;
a = 1; b = 1; #50;

select = 2'b01;                      
b_inv = 0;
cin = 0;
a = 0; b = 0; #50;
a = 0; b = 1; #50;
a = 1; b = 0; #50;
a = 1; b = 1; #50;

select = 2'b10;                       
b_inv = 0;
a = 0; b = 0; cin = 0; #50;
a = 0; b = 0; cin = 1; #50;
a = 0; b = 1; cin = 0; #50;
a = 0; b = 1; cin = 1; #50;
a = 1; b = 0; cin = 0; #50;
a = 1; b = 0; cin = 1; #50;
a = 1; b = 1; cin = 0; #50;
a = 1; b = 1; cin = 1; #50;

select = 2'b10;
b_inv = 1;
cin = 1;
a = 0; b = 0; #50;
a = 0; b = 1; #50;
a = 1; b = 0; #50;
a = 1; b = 1; #50;

end
endmodule
