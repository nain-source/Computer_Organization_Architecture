module HA_dataflow(a,b,carry,sum);
input a,b;
output carry,sum;
assign sum = a ^ b;
assign carry = a & b;
endmodule

module testbench_HA_dataflow();
reg x,y;
wire c,s;
HA_dataflow HA(x,y,c,s);
initial 
begin
x = 0; y = 0;
#50 x = 0; y = 1;
#50 x = 1; y = 0;
#50 x = 1; y = 1;
#50;
end
endmodule
