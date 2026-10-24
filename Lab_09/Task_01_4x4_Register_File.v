module decoder_2_to_4(output reg [3:0] dec_out,input [1:0] wr,input write_enable);
always @(*)
begin
	if (write_enable)
	begin
	case(wr)
	2'b00: dec_out = 4'b0001;
	2'b01: dec_out = 4'b0010;
	2'b10: dec_out = 4'b0100;
	2'b11: dec_out = 4'b1000;
	default: dec_out = 4'b0000;
	endcase
	end

	else
	begin
	dec_out = 4'b0000;
	end
end
endmodule

module mux4_1(output reg [3:0] mux_out,input [3:0] in0,in1,in2,in3, input [1:0] select);
always@(*)
begin
	case(select)
	2'b00: mux_out = in0;
	2'b01: mux_out = in1;
	2'b10: mux_out = in2;
	2'b11: mux_out = in3;
	default: mux_out = 4'b0000;
	endcase
end
endmodule

module register_4bit(output reg [3:0] Q,input [3:0] D,input load,input clk);
initial 
begin
	Q<=4'b0000; 
end
always @(posedge clk)
begin
if(load)
Q <= D;
end
endmodule

module register_file_4x4(
    output [3:0] dataout1, dataout2,
    input [3:0] data_in,
    input [1:0] wr,
    input write_enable,
    input [1:0] rd1, rd2,
    input clk
);

wire [3:0] dec_out, q0, q1, q2, q3;

decoder_2_to_4 dec(dec_out, wr, write_enable);

register_4bit reg0(q0, data_in, dec_out[0], clk);
register_4bit reg1(q1, data_in, dec_out[1], clk);
register_4bit reg2(q2, data_in, dec_out[2], clk);
register_4bit reg3(q3, data_in, dec_out[3], clk);

mux4_1 mux1(dataout1, q0, q1, q2, q3, rd1);
mux4_1 mux2(dataout2, q0, q1, q2, q3, rd2);

endmodule


//for task 2

module tb_register_file;

reg clk;
reg [3:0] data_in;
reg [1:0] wr;
reg write_enable;
reg [1:0] rd1, rd2;

wire [3:0] dataout1, dataout2;

register_file_4x4 dut(
    dataout1, dataout2,
    data_in, wr, write_enable,
    rd1, rd2, clk
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    data_in = 0;
    wr = 0;
    write_enable = 0;
    rd1 = 0;
    rd2 = 0;

    // Write 6 to Register 1
    #10;
    write_enable = 1;
    wr = 2'b01;
    data_in = 4'd6;

    // Write 3 to Register 2
    #10;
    wr = 2'b10;
    data_in = 4'd3;

    // Write 13 to Register 3
    #10;
    wr = 2'b11;
    data_in = 4'd13;

    // Read Register 1 and Register 2
    #10;
    write_enable = 0;
    rd1 = 2'b01;
    rd2 = 2'b10;


end
endmodule
