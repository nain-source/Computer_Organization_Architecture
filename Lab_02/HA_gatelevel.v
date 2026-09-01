module HA_gatelevel(a,b,carry,sum);
input a,b;
output carry,sum;
xor S(sum,a,b);
and C(carry,a,b);
endmodule

module testbench_halfadder();
reg x,y;
wire c,s;
HA_gatelevel HA(x,y,c,s);
initial 
begin
x = 0; y = 0;
#50 x = 0; y = 1;
#50 x = 1; y = 0;
#50 x = 1; y = 1;
#50;
end
endmodule
