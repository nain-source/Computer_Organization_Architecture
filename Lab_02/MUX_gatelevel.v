module MUX_gatelevel(s0,s1,s2,I0,I1,I2,I3,I4,I5,I6,I7,mux_out);
input s0,s1,s2,I0,I1,I2,I3,I4,I5,I6,I7;
output mux_out;
wire sn0,sn1,sn2,i_0,i_1,i_2,i_3,i_4,i_5,i_6,i_7;
not t(sn0,s0);
not u(sn1,s1);
not v(sn2,s2);

and l(i_0,I0,sn0,sn1,sn2);
and m(i_1,I1,sn0,sn1,s2);
and n(i_2,I2,sn0,s1,sn2);
and o(i_3,I3,sn0,s1,s2);
and p(i_4,I4,s0,sn1,sn2);
and q(i_5,I5,s0,sn1,s2);
and r(i_6,I6,s0,s1,sn2);
and s(i_7,I7,s0,s1,s2);

or(mux_out,i_0,i_1,i_2,i_2,i_3,i_4,i_5,i_6,i_7);
endmodule

module testbench_mux_gatelevel();
reg s0,s1,s2,I0,I1,I2,I3,I4,I5,I6,I7;
wire mux_out;

MUX_gatelevel MG(s0,s1,s2,I0,I1,I2,I3,I4,I5,I6,I7,mux_out);
initial 
begin
I0 = 1; I1 = 0; I2 = 0; I3 = 1; I4 = 1; I5 = 0; I6 = 0; I7 = 1;
s0 = 0; s1 = 0; s2 = 0;
#50 s0 = 0; s1 = 0; s2 = 1;
#50 s0 = 0; s1 = 1; s2 = 0;
#50 s0 = 0; s1 = 1; s2 = 1;
#50 s0 = 1; s1 = 0; s2 = 0;
#50 s0 = 1; s1 = 0; s2 = 1;
#50 s0 = 1; s1 = 1; s2 = 0;
#50 s0 = 1; s1 = 1; s2 = 1;
#50;
end
endmodule

