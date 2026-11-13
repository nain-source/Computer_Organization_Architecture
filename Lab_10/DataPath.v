module pc_adder(input [31:0] pc, output [31:0] pc4);
assign pc4 = pc + 32'd4;
endmodule


module pc_mux(input [31:0] pc4, input [31:0] target, input PCSel, output [31:0] pc_next);
assign pc_next = (PCSel == 1'b0) ? pc4 : target;
endmodule


module program_counter(input clk, input reset, input [31:0] next_pc, output reg [31:0] pc_out);
always @(posedge clk or posedge reset) begin
    if (reset)
        pc_out <= 32'b0;
    else
        pc_out <= next_pc;
end
endmodule


module instruction_memory(input [31:0] addr, output reg [31:0] instruction);
reg [31:0] memory [15:0];
integer i;

initial begin
    for (i = 0; i < 16; i = i + 1)
        memory[i] = 32'h00000013;

    memory[0] = 32'h00700293; // ADDI x5, x0, 7
    memory[1] = 32'h00500313; // ADDI x6, x0, 5
    memory[2] = 32'h006283B3; // ADD  x7, x5, x6
    memory[3] = 32'h40628433; // SUB  x8, x5, x6
    memory[4] = 32'h00038463; // BEQ  x7, x0, 8
    memory[5] = 32'h008384B3; // ADD  x9, x7, x8
end
always @(*) begin
    if (addr[31:2] < 16)
        instruction = memory[addr[5:2]];
    else
        instruction = 32'h00000013;
end
endmodule


module immediate_generator(input [31:0] instruction, input [1:0] ImmSel, output reg [31:0] Imm);
always @(*) begin
    case (ImmSel)
        2'b00: Imm = {{20{instruction[31]}}, instruction[31:20]};
        2'b01: Imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        2'b10: Imm = {{19{instruction[31]}}, instruction[31], instruction[7],
                      instruction[30:25], instruction[11:8], 1'b0};
        2'b11: Imm = {{11{instruction[31]}}, instruction[31], instruction[19:12],
                      instruction[20], instruction[30:21], 1'b0};
        default: Imm = 32'b0;
    endcase
end
endmodule


module decoder_2_to_4(
    output reg [3:0] dec_out,
    input [1:0] wr,
    input write_enable
);
always @(*) begin
    dec_out = 4'b0000;
    if (write_enable) begin
        case (wr)
            2'b00: dec_out = 4'b0001;
            2'b01: dec_out = 4'b0010;
            2'b10: dec_out = 4'b0100;
            2'b11: dec_out = 4'b1000;
            default: dec_out = 4'b0000;
        endcase
    end
end
endmodule


module decoder_5_to_32(output wire [31:0] decoder_out, input [4:0] WR, input enable);
wire [3:0] T1;
wire [15:0] T2;
wire [31:0] unused;

decoder_2_to_4 d1(T1, WR[4:3], enable);

decoder_2_to_4 d2(T2[3:0],   WR[2:1], T1[0]);
decoder_2_to_4 d3(T2[7:4],   WR[2:1], T1[1]);
decoder_2_to_4 d4(T2[11:8],  WR[2:1], T1[2]);
decoder_2_to_4 d5(T2[15:12], WR[2:1], T1[3]);

decoder_2_to_4 d6 ({unused[1:0],   decoder_out[1:0]},   {1'b0, WR[0]}, T2[0]);
decoder_2_to_4 d7 ({unused[3:2],   decoder_out[3:2]},   {1'b0, WR[0]}, T2[1]);
decoder_2_to_4 d8 ({unused[5:4],   decoder_out[5:4]},   {1'b0, WR[0]}, T2[2]);
decoder_2_to_4 d9 ({unused[7:6],   decoder_out[7:6]},   {1'b0, WR[0]}, T2[3]);
decoder_2_to_4 d10({unused[9:8],   decoder_out[9:8]},   {1'b0, WR[0]}, T2[4]);
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

mux4_1 mx0(t1, in0, in1, in2, in3, sel[1:0]);
mux4_1 mx1(t2, in4, in5, in6, in7, sel[1:0]);
mux4_1 mx2(t3, in8, in9, in10, in11, sel[1:0]);
mux4_1 mx3(t4, in12, in13, in14, in15, sel[1:0]);
mux4_1 mx4(t5, in16, in17, in18, in19, sel[1:0]);
mux4_1 mx5(t6, in20, in21, in22, in23, sel[1:0]);
mux4_1 mx6(t7, in24, in25, in26, in27, sel[1:0]);
mux4_1 mx7(t8, in28, in29, in30, in31, sel[1:0]);

mux4_1 mx8(t9, t1, t2, t3, t4, sel[3:2]);
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
initial Q = 32'd0; 
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

register_32bit reg1 (q1, wdata, dec_out[1], clk, rst);
register_32bit reg2 (q2, wdata, dec_out[2], clk, rst);
register_32bit reg3 (q3, wdata, dec_out[3], clk, rst);
register_32bit reg4 (q4, wdata, dec_out[4], clk, rst);
register_32bit reg5 (q5, wdata, dec_out[5], clk, rst);
register_32bit reg6 (q6, wdata, dec_out[6], clk, rst);
register_32bit reg7 (q7, wdata, dec_out[7], clk, rst);
register_32bit reg8 (q8, wdata, dec_out[8], clk, rst);
register_32bit reg9 (q9, wdata, dec_out[9], clk, rst);
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

mux32_1 mux1(rdata1,
    q0, q1, q2, q3, q4, q5, q6, q7,
    q8, q9, q10, q11, q12, q13, q14, q15,
    q16, q17, q18, q19, q20, q21, q22, q23,
    q24, q25, q26, q27, q28, q29, q30, q31, rs1);

mux32_1 mux2(rdata2,
    q0, q1, q2, q3, q4, q5, q6, q7,
    q8, q9, q10, q11, q12, q13, q14, q15,
    q16, q17, q18, q19, q20, q21, q22, q23,
    q24, q25, q26, q27, q28, q29, q30, q31, rs2);
endmodule


module Branch_comparator(input [31:0] A, input [31:0] B, output BrEq, output BrLT);
assign BrEq = (A == B);
assign BrLT = ($signed(A) < $signed(B));
endmodule


module alu_mux_a(input [31:0] A, input [31:0] PC, input ASel, output [31:0] ALU_A);
assign ALU_A = (ASel == 1'b0) ? A : PC;
endmodule


module alu_mux_b(input [31:0] B, input [31:0] Imm, input BSel, output [31:0] ALU_B);
assign ALU_B = (BSel == 1'b0) ? B : Imm;
endmodule


module writeback_mux(
    input [31:0] Mem_Data,
    input [31:0] ALU_Result,
    input [31:0] PC4,
    input [1:0] WBSel,
    output reg [31:0] wb
);
always @(*) begin
    case (WBSel)
        2'b00: wb = Mem_Data;
        2'b01: wb = ALU_Result;
        2'b10: wb = PC4;
        default: wb = 32'b0;
    endcase
end
endmodule


module ALU_32bit(input [31:0] A, B, input [2:0] alu_op, output reg [31:0] result);
always @(*) begin
    result = 32'b0;
    case (alu_op)
        3'b000: result = A + B;
        3'b001: result = A - B;
        3'b010: result = A & B;
        3'b011: result = A | B;
        3'b100: result = A ^ B;
        3'b101: result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;
        default: result = 32'b0;
    endcase
end
endmodule


module datapath_top(
    input clk,
    input reset,
    input PCSel,
    input RegWEn,
    input ASel,
    input BSel,
    input [2:0] ALUSel,
    input [1:0] ImmSel,
    input [1:0] WBSel,
    output [31:0] pc,
    output [31:0] inst,
    output [31:0] alu_result,
    output [31:0] wb,
    output BrEq,
    output BrLT
);
wire [31:0] pc4;
wire [31:0] next_pc;
wire [31:0] target;
wire [31:0] DataA;
wire [31:0] DataB;
wire [31:0] Imm;
wire [31:0] ALU_A;
wire [31:0] ALU_B;
wire [31:0] Mem_Data;

assign target = alu_result;
assign Mem_Data = 32'b0;

program_counter PC(clk, reset, next_pc, pc);
pc_adder PC_Adder(pc, pc4);
pc_mux PC_MUX(pc4, target, PCSel, next_pc);
instruction_memory IMEM(pc, inst);

register_file_32x32 RF(
    clk, reset, inst[19:15], DataA, inst[24:20], DataB,
    inst[11:7], wb, RegWEn
);

immediate_generator Imm_Gen(inst, ImmSel, Imm);
Branch_comparator Branch_Comp(DataA, DataB, BrEq, BrLT);
alu_mux_a ALU_MUX_A(DataA, pc, ASel, ALU_A);
alu_mux_b ALU_MUX_B(DataB, Imm, BSel, ALU_B);
ALU_32bit ALU(ALU_A, ALU_B, ALUSel, alu_result);
writeback_mux WB_MUX(Mem_Data, alu_result, pc4, WBSel, wb);
endmodule

module tb_datapath_top;

reg clk;
reg reset;
reg PCSel;
reg RegWEn;
reg ASel;
reg BSel;
reg [2:0] ALUSel;
reg [1:0] ImmSel;
reg [1:0] WBSel;

wire [31:0] pc;
wire [31:0] inst;
wire [31:0] alu_result;
wire [31:0] wb;
wire BrEq;
wire BrLT;

datapath_top DUT(
    clk, reset, PCSel, RegWEn, ASel, BSel,
    ALUSel, ImmSel, WBSel,
    pc, inst, alu_result, wb, BrEq, BrLT
);

always #5 clk = ~clk;
integer k = 0;
initial begin
    clk = 0;
    reset = 1;

    PCSel = 0;
    RegWEn = 0;
    ASel = 0;
    BSel = 0;
    ALUSel = 0;
    ImmSel = 0;
    WBSel = 1;

    #6;
    reset = 0;

    for (k = 0; k < 8; k = k + 1) begin

        @(negedge clk);

        PCSel = 0;
        RegWEn = 1;
        ASel = 0;
        BSel = 1;
        ALUSel = 3'b000;
        ImmSel = 2'b00;
        WBSel = 2'b01;

        case (pc)

            32'd0, 32'd4: begin
                RegWEn = 1;
                BSel = 1;
            end

            32'd8: begin
                RegWEn = 1;
                BSel = 0;
            end

            32'd12: begin
                RegWEn = 1;
                BSel = 0;
                ALUSel = 3'b001;
            end

            32'd16: begin
                RegWEn = 0;
                ASel = 1;
                BSel = 1;
                ImmSel = 2'b10;
                PCSel = BrEq;
            end

            32'd20: begin
                RegWEn = 1;
                BSel = 0;
            end

            default: begin
                RegWEn = 0;
                PCSel = 0;
            end
        endcase
        @(posedge clk);
    end
end
endmodule
