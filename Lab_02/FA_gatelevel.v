module FA_gatelevel(a,b,cin,cout,sum);
input a,b,cin;
output cout,sum;
wire c1,c2,c3;
xor S(sum,a,b,cin);

and C(c1,a,b);
xor A(c2,a,b);
and B(c3,cin,c2);
or D(cout,c3,c1);
endmodule

module testbench_FA_gatelevel();
reg x,y,z;
wire c,s;
FA_gatelevel FA(x,y,z,c,s);
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

