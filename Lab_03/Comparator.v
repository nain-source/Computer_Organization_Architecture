module comparator(a,b,Equal,Greater,Lesser);
input [1:0] a;
input [1:0] b;
output reg Equal,Greater,Lesser;

always @*
begin
if (a > b)
begin
	Equal = 0;
	Greater = 1;
	Lesser = 0;
end
else if (a < b)
begin
	Equal = 0;
	Greater = 0;
	Lesser = 1;
end
else
begin
	Equal = 1;
	Greater = 0;
	Lesser = 0;
end
end

endmodule

module testbench_comparator();
reg [1:0] x;
reg [1:0] y;
wire E,G,L;
comparator C(x,y,E,G,L);
initial
begin
x = 3; y = 3;
#50;
x = 2; y = 1;
#50;
x = 0; y = 2;
#50;
x = 1; y = 1;
#50;
x = 2; y = 3;
#50;
end
endmodule
