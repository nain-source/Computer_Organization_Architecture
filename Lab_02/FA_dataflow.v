module FA_dataflow(a,b,cin,cout,sum);
input a,b,cin;
output cout,sum;

assign sum = a ^ b ^ cin;
assign cout = (a & b) | ((a ^ b) & cin);
endmodule

module testbench_FA_dataflow();
reg x,y,z;
wire c,s;
FA_dataflow FA(x,y,z,c,s);
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
