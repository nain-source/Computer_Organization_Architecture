module data_memory (
    input wire i_clk,
    input wire i_we,
    input wire [31:0] i_data,
    input wire [9:0] i_addr,
    output wire [31:0] o_data
);

    reg [31:0] mem [0:1023];

    integer i;

    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            mem[i] = 32'b0;
        end
    end

    always @(posedge i_clk) begin
        if (i_we == 1'b1) begin
            mem[i_addr] <= i_data;
        end
    end

    assign o_data = mem[i_addr];

endmodule


module tb_data_memory();

    reg clk;
    reg i_we;
    reg [31:0] i_data;
    reg [9:0] i_addr;

    wire [31:0] o_data;

    integer i;
    integer pass_count;
    integer fail_count;

    data_memory DUT (
        .i_clk(clk),
        .i_we(i_we),
        .i_data(i_data),
        .i_addr(i_addr),
        .o_data(o_data)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        i_we = 1'b0;
        i_data = 32'b0;
        i_addr = 10'b0;
        pass_count = 0;
        fail_count = 0;

        #1;

        for (i = 0; i < 1024; i = i + 1) begin
            i_addr = i;
            #1;
            if (o_data !== 32'b0) begin
                fail_count = fail_count + 1;
                $display("Fail, Initialization at address %0d", i);
            end
            else begin
                pass_count = pass_count + 1;
            end
        end

        i_addr = 10;
        i_data = 32'd100;
        i_we = 1'b1;

        @(posedge clk);
        #1;

        i_we = 1'b0;

        if (o_data === 32'd100) begin
            pass_count = pass_count + 1;
            $display("Pass, Write and read");
        end
        else begin
            fail_count = fail_count + 1;
            $display("Fail, Write and read");
        end

        i_data = 32'd500;
        i_we = 1'b0;

        @(posedge clk);
        #1;

        if (o_data === 32'd100) begin
            pass_count = pass_count + 1;
            $display("Pass, Write enable disabled");
        end
        else begin
            fail_count = fail_count + 1;
            $display("Fail, Write enable disabled");
        end

        i_addr = 0;
        i_data = 32'd321;
        i_we = 1'b1;

        @(posedge clk);
        #1;

        i_addr = 1023;
        i_data = 32'd8790;

        @(posedge clk);
        #1;

        i_we = 1'b0;
        i_addr = 0;
        #1;

        if (o_data === 32'd321) begin
            pass_count = pass_count + 1;
            $display("Pass, First location");
        end
        else begin
            fail_count = fail_count + 1;
            $display("Fail, First location");
        end

        i_addr = 1023;
        #1;

        if (o_data === 32'd8790) begin
            pass_count = pass_count + 1;
            $display("Pass, Last location");
        end
        else begin
            fail_count = fail_count + 1;
            $display("Fail, Last location");
        end

        i_addr = 20;
        i_data = 32'd200;
        i_we = 1'b1;

        @(posedge clk);
        #1;

        i_data = 32'd300;

        @(posedge clk);
        #1;

        i_we = 1'b0;

        if (o_data === 32'd300) begin
            pass_count = pass_count + 1;
            $display("Pass, Overwriting");
        end
        else begin
            fail_count = fail_count + 1;
            $display("Fail, Overwriting");
        end

        for (i = 0; i < 1024; i = i + 1) begin
            i_addr = i;
            i_data = i * 10 + 1;
            i_we = 1'b1;

            @(posedge clk);
            #1;
        end

        i_we = 1'b0;

        for (i = 0; i < 1024; i = i + 1) begin
            i_addr = i;
            #1;

            if (o_data === (i * 10 + 1)) begin
                pass_count = pass_count + 1;
            end
            else begin
                fail_count = fail_count + 1;
                $display("Fail, Address %0d", i);
            end
        end

        i_addr = 20;
        i_data = 32'hABCDEFAB;
        i_we = 1'b1;

        @(posedge clk);
        #1;

        i_data = 32'hBAFEDCBA;

        @(posedge clk);
        #1;

        i_we = 1'b0;

        if (o_data === 32'hBAFEDCBA) begin
            pass_count = pass_count + 1;
            $display("Pass, Special hexadecimal overwrite");
        end
        else begin
            fail_count = fail_count + 1;
            $display("Fail, Special hexadecimal overwrite");
        end

        $display(" ");
        $display("Testbench completed.");
        $display("Passed checks: %0d", pass_count);
        $display("Failed checks: %0d", fail_count);

        if (fail_count == 0)
            $display("Overall result: PASS");
        else
            $display("Overall result: FAIL");

        #10;
        $finish;
    end

endmodule
