module ALU_32bit(A,B,alu_op,result,zero);

input [31:0] A,B;
input [3:0] alu_op;
output reg [31:0] result;
output reg zero;

always @(*) begin
    result = 32'b0;
    zero = 0;

    case (alu_op)
        4'b0000: begin
            result = A + B;
        end

        4'b0001: begin
            result = A - B;
        end

        4'b0010: begin
            result = A & B;
        end

        4'b0011: begin
            result = A | B;
        end

        4'b0100: begin
            result = A ^ B;
        end

        4'b0101: begin
            if ($signed(A) < $signed(B)) begin
                result = 32'b1;
            end
            else begin
                result = 32'b0;
            end
        end

        4'b0110: begin
            if (A < B) begin
                result = 32'b1;
            end
            else begin
                result = 32'b0;
            end
        end

        4'b0111: begin
            result = A << B[4:0];
        end

        4'b1000: begin
            result = A >> B[4:0];
        end

        4'b1001: begin
            result = $signed(A) >>> B[4:0];
        end

        default: begin
            result = 32'b0;
        end
    endcase

    if (result == 32'b0) begin
        zero = 1;
    end
    else begin
        zero = 0;
    end
end

endmodule


module ALU_32bit_tb();

reg [31:0] A,B;
reg [3:0] alu_op;
wire [31:0] result;
wire zero;

ALU_32bit DUT(A,B,alu_op,result,zero);

initial 
begin

    A = 10;
    B = 3;

    alu_op = 4'b0000;
    #10;

    alu_op = 4'b0001;
    #10;

    alu_op = 4'b0010;
    #10;

    alu_op = 4'b0011;
    #10;

    alu_op = 4'b0100;
    #10;

    alu_op = 4'b0101;
    #10;

    alu_op = 4'b0110;
    #10;

    alu_op = 4'b0111;
    #10;

    alu_op = 4'b1000;
    #10;

    alu_op = 4'b1001;
    #10;

    A = 5;
    B = 5;
    alu_op = 4'b0001;
    #10;

end

endmodule
