module ALU_1bit_behavioral(a,b,cin,b_inv,select,result,carry_out);
input a,b,cin,b_inv;
input [1:0] select;
output reg result,carry_out;

reg b_inverted;
reg adder_out;

always @*
begin
b_inverted = b ^ b_inv;
{carry_out,adder_out} = a + b_inverted + cin;

case(select)
2'b00:
begin
result = a & b;
end

2'b01:
begin
result = a | b;
end

2'b10:
begin
result = adder_out;
end

2'b11:
begin
result = 1'b0;
end
endcase
end
endmodule

module tb_ALU_1bit_behavioral();

reg a, b, cin, b_inv;
reg [1:0] select;
wire result, carry_out;

ALU_1bit_behavioral uut(.a(a),.b(b),.cin(cin),.b_inv(b_inv),.select(select),.result(result),.carry_out(carry_out));
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
