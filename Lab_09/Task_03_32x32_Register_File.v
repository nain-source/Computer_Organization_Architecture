module decoder_2_to_4(
    output reg [3:0] dec_out,
    input [1:0] wr,
    input write_enable
);
always @(*) begin
    if (write_enable) begin
        case (wr)
            2'b00: dec_out = 4'b0001;
            2'b01: dec_out = 4'b0010;
            2'b10: dec_out = 4'b0100;
            2'b11: dec_out = 4'b1000;
            default: dec_out = 4'b0000;
        endcase
    end else begin
        dec_out = 4'b0000;
    end
end
endmodule


module decoder_5_to_32(output [31:0] decoder_out,input [4:0] WR,input enable);
wire [3:0] T1;
wire [15:0] T2;
wire [31:0] unused;

decoder_2_to_4 d1(T1, WR[4:3], enable);

decoder_2_to_4 d2(T2[3:0],   WR[2:1], T1[0]);
decoder_2_to_4 d3(T2[7:4],   WR[2:1], T1[1]);
decoder_2_to_4 d4(T2[11:8],  WR[2:1], T1[2]);
decoder_2_to_4 d5(T2[15:12], WR[2:1], T1[3]);

decoder_2_to_4 d6 ({unused[1:0],  decoder_out[1:0]},  {1'b0, WR[0]}, T2[0]);
decoder_2_to_4 d7 ({unused[3:2],  decoder_out[3:2]},  {1'b0, WR[0]}, T2[1]);
decoder_2_to_4 d8 ({unused[5:4],  decoder_out[5:4]},  {1'b0, WR[0]}, T2[2]);
decoder_2_to_4 d9 ({unused[7:6],  decoder_out[7:6]},  {1'b0, WR[0]}, T2[3]);
decoder_2_to_4 d10({unused[9:8],  decoder_out[9:8]},  {1'b0, WR[0]}, T2[4]);
decoder_2_to_4 d11({unused[11:10], decoder_out[11:10]}, {1'b0, WR[0]}, T2[5]);
decoder_2_to_4 d12({unused[13:12], decoder_out[13:12]}, {1'b0, WR[0]}, T2[6]);
decoder_2_to_4 d13({unused[15:14], decoder_out[15:14]}, {1'b0, WR[0]}, T2[7]);
decoder_2_to_4 d14({unused[17:16], decoder_out[17:16]}, {1'b0, WR[0]}, T2[8]);
decoder_2_to_4 d15({unused[19:18], decoder_out[19:18]}, {1'b0, WR[0]}, T2[9]);
decoder_2_to_4 d16({unused[21:20], decoder_out[21:20]}, {1'b0, WR[0]}, T2[10]);
decoder_2_to_4 d17({unused[23:22], decoder_out[23:22]}, {1'b0, WR[0]}, T2[11]);
decoder_2_to_4 d18({unused[25:24], decoder_out[25:24]}, {1'b0, WR[0]}, T2[12]);
decoder_2_to_4 d19({unused[27:26], decoder_out[27:26]}, {1'b0, WR[0]}, T2[13]);
decoder_2_to_4 d20({unused[29:28], decoder_out[29:28]}, {1'b0, WR[0]}, T2[14]);
decoder_2_to_4 d21({unused[31:30], decoder_out[31:30]}, {1'b0, WR[0]}, T2[15]);

endmodule


module mux4_1(
    output reg [31:0] mux_out,
    input [31:0] in0, in1, in2, in3,
    input [1:0] select
);
always @(*) begin
    case (select)
        2'b00: mux_out = in0;
        2'b01: mux_out = in1;
        2'b10: mux_out = in2;
        2'b11: mux_out = in3;
        default: mux_out = 32'd0;
    endcase
end
endmodule


module mux32_1(
    output [31:0] mx_out,
    input [31:0] in0, in1, in2, in3, in4, in5, in6, in7,
                 in8, in9, in10, in11, in12, in13, in14, in15,
                 in16, in17, in18, in19, in20, in21, in22, in23,
                 in24, in25, in26, in27, in28, in29, in30, in31,
    input [4:0] sel
);
wire [31:0] t1, t2, t3, t4, t5, t6, t7, t8, t9, t10;
mux4_1 mx0(t1, in0,  in1,  in2,  in3,  sel[1:0]);
mux4_1 mx1(t2, in4,  in5,  in6,  in7,  sel[1:0]);
mux4_1 mx2(t3, in8,  in9,  in10, in11, sel[1:0]);
mux4_1 mx3(t4, in12, in13, in14, in15, sel[1:0]);
mux4_1 mx4(t5, in16, in17, in18, in19, sel[1:0]);
mux4_1 mx5(t6, in20, in21, in22, in23, sel[1:0]);
mux4_1 mx6(t7, in24, in25, in26, in27, sel[1:0]);
mux4_1 mx7(t8, in28, in29, in30, in31, sel[1:0]);

mux4_1 mx8(t9,  t1, t2, t3, t4, sel[3:2]);
mux4_1 mx9(t10, t5, t6, t7, t8, sel[3:2]);

mux4_1 mx10(mx_out, t9, t10, 32'd0, 32'd0, {1'b0, sel[4]});

endmodule


module register_32bit(
    output reg [31:0] Q,
    input [31:0] D,
    input load,
    input clk,
    input rst                
);

always @(posedge clk or posedge rst) begin
    if (rst)
        Q <= 32'd0;
    else if (load)
        Q <= D;
end
endmodule


module register_file_32x32(
    input clk,
    input rst,
    input [4:0] rs1,          
    output [31:0] rdata1,     
    input [4:0] rs2,          
    output [31:0] rdata2,     
    input [4:0] rd,           
    input [31:0] wdata,       
    input we                  
);

wire [31:0] dec_out;
wire [31:0] q0, q1, q2, q3, q4, q5, q6, q7;
wire [31:0] q8, q9, q10, q11, q12, q13, q14, q15;
wire [31:0] q16, q17, q18, q19, q20, q21, q22, q23;
wire [31:0] q24, q25, q26, q27, q28, q29, q30, q31;

decoder_5_to_32 dec(dec_out, rd, we);

assign q0 = 32'd0;
register_32bit reg1 (q1,  wdata, dec_out[1],  clk, rst);
register_32bit reg2 (q2,  wdata, dec_out[2],  clk, rst);
register_32bit reg3 (q3,  wdata, dec_out[3],  clk, rst);
register_32bit reg4 (q4,  wdata, dec_out[4],  clk, rst);
register_32bit reg5 (q5,  wdata, dec_out[5],  clk, rst);
register_32bit reg6 (q6,  wdata, dec_out[6],  clk, rst);
register_32bit reg7 (q7,  wdata, dec_out[7],  clk, rst);
register_32bit reg8 (q8,  wdata, dec_out[8],  clk, rst);
register_32bit reg9 (q9,  wdata, dec_out[9],  clk, rst);
register_32bit reg10(q10, wdata, dec_out[10], clk, rst);
register_32bit reg11(q11, wdata, dec_out[11], clk, rst);
register_32bit reg12(q12, wdata, dec_out[12], clk, rst);
register_32bit reg13(q13, wdata, dec_out[13], clk, rst);
register_32bit reg14(q14, wdata, dec_out[14], clk, rst);
register_32bit reg15(q15, wdata, dec_out[15], clk, rst);
register_32bit reg16(q16, wdata, dec_out[16], clk, rst);
register_32bit reg17(q17, wdata, dec_out[17], clk, rst);
register_32bit reg18(q18, wdata, dec_out[18], clk, rst);
register_32bit reg19(q19, wdata, dec_out[19], clk, rst);
register_32bit reg20(q20, wdata, dec_out[20], clk, rst);
register_32bit reg21(q21, wdata, dec_out[21], clk, rst);
register_32bit reg22(q22, wdata, dec_out[22], clk, rst);
register_32bit reg23(q23, wdata, dec_out[23], clk, rst);
register_32bit reg24(q24, wdata, dec_out[24], clk, rst);
register_32bit reg25(q25, wdata, dec_out[25], clk, rst);
register_32bit reg26(q26, wdata, dec_out[26], clk, rst);
register_32bit reg27(q27, wdata, dec_out[27], clk, rst);
register_32bit reg28(q28, wdata, dec_out[28], clk, rst);
register_32bit reg29(q29, wdata, dec_out[29], clk, rst);
register_32bit reg30(q30, wdata, dec_out[30], clk, rst);
register_32bit reg31(q31, wdata, dec_out[31], clk, rst);

mux32_1 mux1(rdata1,q0, q1, q2, q3, q4,
q5, q6, q7,q8, q9, q10, q11, q12, q13,
q14, q15,q16, q17, q18, q19, q20, q21,
q22, q23,q24, q25, q26, q27, q28, q29,
q30, q31,rs1);

mux32_1 mux2(rdata2,q0, q1, q2, q3, q4,
q5, q6, q7,q8, q9, q10, q11, q12, q13, 
q14, q15,q16, q17, q18, q19, q20, q21,
q22, q23,q24, q25, q26, q27, q28, q29, 
q30, q31,rs2);

endmodule

module tb_register_file_32x32();
reg clk;
reg rst;                     
reg [31:0] wdata;            
reg [4:0] rd;                
reg we;                      
reg [4:0] rs1, rs2;          

wire [31:0] rdata1, rdata2;  

register_file_32x32 dut(
    .clk(clk),
    .rst(rst),
    .rs1(rs1),
    .rdata1(rdata1),
    .rs2(rs2),
    .rdata2(rdata2),
    .rd(rd),
    .wdata(wdata),
    .we(we)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;                 
    wdata = 0;
    rd = 0;
    we = 0;
    rs1 = 0;
    rs2 = 0;

    #10;
    rst = 0;         
    we = 1;
    rd = 5'd1;
    wdata = 32'd100;

    #10;
    rd = 5'd2;
    wdata = 32'd200;

    #10;
    rd = 5'd3;
    wdata = 32'd300;

    #10;
    we = 0;
    rs1 = 5'd1;
    rs2 = 5'd2;

    #10;
    rs1 = 5'd3;
    rs2 = 5'd1;

    #10;
    rd = 5'd1;
    wdata = 32'd999;
    we = 0;

    #10;
    rs1 = 5'd1;
    rs2 = 5'd2;

    #10;
end
endmodule
