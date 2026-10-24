module ALU_parameterized #(parameter N=4)
(a,b,alu_op,result,carry_out);

input [N-1:0] a,b;
input [2:0] alu_op;
output reg [N-1:0] result;
output reg carry_out;
reg [N:0] sum;

always @(*) begin
    result = 0;
    carry_out = 0;
    sum = 0;

    case (alu_op)
        3'b000: begin
            sum = a + b;
            result = sum[N-1:0];
            carry_out = sum[N];
        end

        3'b001: begin
            result = a - b;
        end

        3'b010: begin
            result = a & b;
        end

        3'b011: begin
            result = a | b;
        end

        3'b100: begin
            result = ~a;
        end

        3'b101: begin
            result = a ^ b;
        end

        default: begin
            result = 0;
        end
    endcase
end

endmodule


module ALU_parameterized_tb;

parameter N=4;

reg [N-1:0] a,b;
reg [2:0] alu_op;
wire [N-1:0] result;
wire carry_out;

ALU_parameterized #(N) DUT(a,b,alu_op,result,carry_out);

initial begin

    a=5;
    b=3;

    alu_op=3'b000;
    #10;

    alu_op=3'b001;
    #10;

    alu_op=3'b010;
    #10;

    alu_op=3'b011;
    #10;

    alu_op=3'b100;
    #10;

    alu_op=3'b101;
    #10;

    a=15;
    b=1;
    alu_op=3'b000;
    #10;

end

endmodule
