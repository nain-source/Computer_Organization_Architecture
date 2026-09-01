module two_to_one_Mux(a,b,M,Y);
input a,b,M;
output reg Y;
always @*
begin
if(M == 0)
Y = a & b;
else 
Y = a | b; 
end
endmodule

module testbench_mux();
reg  x;
reg  y;
reg M;
wire z;

two_to_one_Mux mmx(x,y,M,z);

initial
begin
 x = 0; y = 0; M = 0; 
    #50;
    x = 0; y = 1; M = 0; 
    #50;
    x = 1; y = 0; M = 1; 
    #50;
    x = 1; y = 1; M = 1; 
    #50;
end
endmodule