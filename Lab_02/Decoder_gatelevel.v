module decoder_3to8_gatelevel(a,b,c,D0,D1,D2,D3,D4,D5,D6,D7);
input a,b,c;
output D0,D1,D2,D3,D4,D5,D6,D7;
wire na,nb,nc;
not k(na,a);
not m(nb,b);
not n(nc,c);

and a0(D0,na,nb,nc);
and a1(D1,na,nb,c);
and a2(D2,na,b,nc);
and a3(D3,na,b,c);
and a4(D4,a,nb,nc);
and a5(D5,a,nb,c);
and a6(D6,a,b,nc);
and a7(D7,a,b,c);

endmodule

module testbench_g_decoder();
reg x,y,z;
wire d_0,d_1,d_2,d_3,d_4,d_5,d_6,d_7;

decoder_3to8_gatelevel DG(x,y,z,d_0,d_1,d_2,d_3,d_4,d_5,d_6,d_7);
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
