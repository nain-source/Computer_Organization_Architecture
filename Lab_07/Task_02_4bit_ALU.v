module full_adder_gate(a,b,cin,sum,carry_out);
input a,b,cin;
output carry_out,sum;
wire c1,c2,c3;
xor S(sum,a,b,cin);

and C(c1,a,b);
xor A(c2,a,b);
and B(c3,cin,c2);
or D(carry_out,c3,c1);

endmodule

module Mux_4to1(I0,I1,I2,I3,S0,S1,Y);
input I0,I1,I2,I3,S0,S1;
wire nS0,nS1,t1,t2,t3,t4;
output Y;

not F(nS0,S0);
not G(nS1,S1);

and H(t1,nS0,nS1,I0);
and I(t2,nS0,S1,I1);
and J(t3,S0,nS1,I2);
and K(t4,S0,S1,I3);

or L(Y,t1,t2,t3,t4);

endmodule

module ALU_1bit_gatelevel(a,b,less,cin,b_inv,select,result,carry_out);
input a,b,cin,b_inv,less;
input [1:0] select;
output result,carry_out;
wire b_inverted,and_out,or_out,adder_out;

and Z1(and_out,a,b);
or Z2(or_out,a,b);

xor S(b_inverted,b,b_inv);
full_adder_gate FA(a,b_inverted,cin,adder_out,carry_out);

Mux_4to1 mx(and_out,or_out,adder_out,less,select[1],select[0],result);
endmodule

module ALU_4bit_gatelevel(a,b,cin,b_inv,select,result,carry_out,CF,SF,ZF,OF);
input [3:0] a,b;
input cin,b_inv;
input [1:0] select;
output [3:0] result,carry_out;
output CF,SF,ZF,OF;

wire less;
wire [3:0] sub_result;
wire [3:0] sub_carry;
wire sub_overflow;

full_adder_gate SUB0(a[0],~b[0],1'b1,sub_result[0],sub_carry[0]);
full_adder_gate SUB1(a[1],~b[1],sub_carry[0],sub_result[1],sub_carry[1]);
full_adder_gate SUB2(a[2],~b[2],sub_carry[1],sub_result[2],sub_carry[2]);
full_adder_gate SUB3(a[3],~b[3],sub_carry[2],sub_result[3],sub_carry[3]);

xor SO(sub_overflow,sub_carry[2],sub_carry[3]);
xor LT(less,sub_result[3],sub_overflow);

ALU_1bit_gatelevel A0(a[0],b[0],less,cin,b_inv,select,result[0],carry_out[0]);
ALU_1bit_gatelevel A1(a[1],b[1],1'b0,carry_out[0],b_inv,select,result[1],carry_out[1]);
ALU_1bit_gatelevel A2(a[2],b[2],1'b0,carry_out[1],b_inv,select,result[2],carry_out[2]);
ALU_1bit_gatelevel A3(a[3],b[3],1'b0,carry_out[2],b_inv,select,result[3],carry_out[3]);

assign CF = carry_out[3];
assign SF = result[3];
nor s1(ZF,result[0],result[1],result[2],result[3]);
xor s2(OF,carry_out[2],carry_out[3]);

endmodule

module ALU_4bit_tb;

reg [3:0] a,b;
reg cin,b_inv;
reg [1:0] select;
wire [3:0] result,carry_out;
wire CF,SF,ZF,OF;

ALU_4bit_gatelevel DUT(a,b,cin,b_inv,select,result,carry_out,CF,SF,ZF,OF);

initial begin
a=4'b0011;
b=4'b0001;
cin=0;
b_inv=0;
select=2'b00;
#10;

a=4'b0011;
b=4'b0001;
select=2'b01;
#10;

a=4'b0011;
b=4'b0001;
select=2'b10;
#10;

a=4'b0011;
b=4'b0001;
cin=1;
b_inv=1;
select=2'b10;
#10;

a=4'b0011;
b=4'b0101;
select=2'b11;
#10;

a=4'b0111;
b=4'b1111;
select=2'b11;
#10;

a=4'b1000;
b=4'b0001;
select=2'b11;
#10;

a=4'b0111;
b=4'b0001;
cin=0;
b_inv=0;
select=2'b10;
#10;

a=4'b0001;
b=4'b0001;
select=2'b10;
#10;

end
endmodule
