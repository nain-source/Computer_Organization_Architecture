module Adder_Subtractor(a,b,M,Y);
input [3:0] a;
input [3:0] b;
input M;
output reg [4:0] Y;
always @*
begin
if(M == 0)
Y = a + b;
else 
Y = a - b; 
end
endmodule

module testbench_add();
reg [3:0] x;
reg [3:0] y;
reg M;
wire [4:0] z;

Adder_Subtractor AS(x,y,M,z);

initial
begin
x = 15;
y = 15;
M = 0;
#50;
x = 13;
y = 10;
M = 0;
#50;

x = 15;
y = 4;
M = 1;
#50;

x = 13;
y = 12;
M = 0;
#50;

x = 7;
y = 4;
M = 1;
#50;

x = 7;
y = 7;
M = 1;
#50;
end
endmodule
