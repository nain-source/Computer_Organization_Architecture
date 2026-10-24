module program_counter(input clk, input reset, output reg [31:0] pc_out);
always @(posedge clk or posedge reset)
begin
    if (reset)
        pc_out <= 32'b0;
    else
        pc_out <= pc_out + 4;
end

endmodule

module instruction_memory(input [3:0] addr, output reg [31:0] instruction);
reg [31:0] memory [15:0];

initial
begin
    memory[0] = 32'h00100093;
    memory[1] = 32'b0;
    memory[2] = 32'b0;
    memory[3] = 32'b0;
    memory[4] = 32'h00200113;
    memory[5] = 32'b0;
    memory[6] = 32'b0;
    memory[7] = 32'b0;
    memory[8] = 32'h00300193;
    memory[9] = 32'b0;
    memory[10] = 32'b0;
    memory[11] = 32'b0;
    memory[12] = 32'h00400213;
    memory[13] = 32'b0;
    memory[14] = 32'b0;
    memory[15] = 32'b0;
end

always @(addr)
begin
    instruction = memory[addr];
end

endmodule


module tb_3_program_counter;

reg clk;
reg reset;

wire [31:0] pc_out;
wire [31:0] instruction;

program_counter pc(
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out)
);

instruction_memory im(
    .addr(pc_out[3:0]),
    .instruction(instruction)
);

always
begin
    #5 clk = ~clk;
end

initial
begin
    clk = 0;
    reset = 1;

    #10 reset = 0;

    #60;
end
endmodule
