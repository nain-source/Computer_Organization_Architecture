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

module ALU_1bit_gatelevel(a,b,cin,b_inv,select,result,carry_out);
input a,b,cin,b_inv;
input [1:0] select;
output result,carry_out;
wire b_inverted,and_out,or_out,adder_out;

and Z1(and_out,a,b);
or Z2(or_out,a,b);

xor S(b_inverted,b,b_inv);
full_adder_gate FA(a,b_inverted,cin,adder_out,carry_out);

Mux_4to1 mx(and_out,or_out,adder_out,1'b0,select[1],select[0],result);
endmodule

module tb_ALU_1bit_gatelevel();

reg a, b, cin, b_inv;
reg [1:0] select;
wire result, carry_out;

ALU_1bit_gatelevel uut(
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

