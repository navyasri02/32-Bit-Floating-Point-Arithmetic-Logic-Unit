`timescale 1 ns / 1 ps

module f0Testbench;

    reg clock, reset;
    reg [31:0] x;
    wire [31:0] y;
    wire done;

    f0 f0T (clock, reset, x, y, done);

    initial
        forever #5 clock = ~clock;

    initial
        begin
            clock = 1'b0;
            reset = 1'b1;
            x = 32'b0_10000000_00000000000000000000000;
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #1000 $finish;
        end

endmodule

module f2Testbench;

    reg clock, reset;
    reg [31:0] x;
    wire [31:0] y;
    wire done;

    f2 f2T (clock, reset, x, y, done);

    initial
        forever #5 clock = ~clock;

    initial
        begin
            clock = 1'b0;
            reset = 1'b1;
            x = 32'b0_10000000_00000000000000000000000;
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #1000 $finish;
        end

endmodule

module f3Testbench;

    reg clock, reset;
    reg [31:0] x;
    wire [31:0] y;
    wire done, done_d, done_i;
    wire [31:0] x_i, y_i, x_d, y_j;

    f3 f3T (clock, reset, x, y, done, done_d, done_i, x_i, y_i, x_d, y_j);

    initial
        forever #5 clock = ~clock;

    initial
        begin
            clock = 1'b0;
            reset = 1'b1;
            x = 32'b0_01111111_00000000000000000000000;
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #1000 $finish;
        end

endmodule