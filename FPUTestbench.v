`timescale 1 ns / 1 ps

module FPUTestbenchAdder;

    reg clock, reset;
    reg [31:0] A, B;
    reg [1:0] S;
    wire [31:0] O;
    wire done;

    FPU FPUTAdd (clock, reset, A, B, S, O, done);

    initial
        forever #5 clock = ~clock;

    initial
        begin
            clock = 1'b0;
            reset = 1'b1;
            A = 32'b0_01111101_00000000000000000000000; // A = 0.25
            B = 32'b0_10000101_10010000000000000000000; // B = 100
            S = 2'b00;
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #240 A = 32'd0; // A = 0.0
            B = 32'd0; // B = 0.0
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #240 A = {1'b0, 8'd127, 23'd0}; // A = 1.0
            B = {1'b1, 8'd127, 23'd0}; // B = -1.0
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #240 A = 32'b1_01111101_00000000000000000000000; // A = -0.25
            B = 32'b0_10000101_10010000000000000000000; // B = 100
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #240 A = 32'b0_01111101_00000000000000000000000; // A = 0.25
            B = 32'b1_10000101_10010000000000000000000; // B = -100
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #240 $finish;
        end

endmodule

module FPUTestbenchSubtractor;

    reg clock, reset;
    reg [31:0] A, B;
    reg [1:0] S;
    wire [31:0] O;
    wire done;

    FPU FPUTSub (clock, reset, A, B, S, O, done);

    initial
        forever #5 clock = ~clock;

    initial
        begin
            clock = 1'b0;
            reset = 1'b1;
            A = 32'b0_01111101_00000000000000000000000; // A = 0.25
            B = 32'b0_10000101_10010000000000000000000; // B = 100
            S = 2'b01;
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #240 A = 32'd0; // A = 0.0
            B = 32'd0; // B = 0.0
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #240 A = 32'b1_01111101_00000000000000000000000; // A = -0.25
            B = 32'b0_10000101_10010000000000000000000; // B = 100
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #240 A = 32'b0_01111101_00000000000000000000000; // A = 0.25
            B = 32'b1_10000101_10010000000000000000000; // B = -100
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #240 $finish;
        end

endmodule

module FPUTestbenchMultiplier;

    reg clock, reset;
    reg [31:0] A, B;
    reg [1:0] S;
    wire [31:0] O;
    wire done;

    FPU FPUTMul (clock, reset, A, B, S, O, done);

    initial
        forever #5 clock = ~clock;

    initial
        begin
            clock = 1'b0;
            reset = 1'b1;
            A = 32'b0_01111101_00000000000000000000000; // A = 0.25
            B = 32'b0_10000101_10010000000000000000000; // B = 100
            S = 2'b10;
            #240 A = 32'd0; // A = 0.0
            B = 32'd0; // B = 0.0
            #240 A = 32'b1_01111101_00000000000000000000000; // A = -0.25
            B = 32'b0_10000101_10010000000000000000000; // B = 100
            #240 A = 32'b0_01111101_00000000000000000000000; // A = 0.25
            B = 32'b1_10000101_10010000000000000000000; // B = -100
            #240 A = 32'b1_01111110_01100001010001111010111; // A = -0.69
            B = 32'b0_10000110_11101110000000000000000; // B = 247
            #240 A = 32'b0_10000110_00001110000000000000000; // A = 135
            B = 32'b1_10000010_01001011100001010001111; // B = -10.36
            #240 $finish;
        end

endmodule

module FPUTestbenchDivider;

    reg clock, reset;
    reg [31:0] A, B;
    reg [1:0] S;
    wire [31:0] O;
    wire done;

    FPU FPUTDiv (clock, reset, A, B, S, O, done);

    initial
        forever #5 clock = ~clock;

    initial
        begin
            clock = 1'b0;
            reset = 1'b1;
            A = 32'd0; // A = 0.0
            B = 32'd0; // B = 0.0
            S = 2'b11;
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #1000 A = 32'd0; // A = 0.0
            B = 32'b0_10000101_10010000000000000000000; // B = 100
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #1000 A = 32'b0_01111101_00000000000000000000000; // A = 0.25
            B = 32'b0; // B = 0.0
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #1000 A = 32'b0_01111111_00000000000000000000000; // A = 1.0
            B = 32'b0_10000001_01000000000000000000000; // B = 5.0
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #1000 A = 32'b0_10000001_01000000000000000000000; // A = 5.0
            B = 32'b0_01111111_00000000000000000000000; // B = 1.0
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #1000 A = 32'b1_01111110_01100001010001111010111; // A = -0.69
            B = 32'b0_10000110_11101110000000000000000; // B = 247
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #1000 A = 32'b0_10000110_00001110000000000000000; // A = 135
            B = 32'b1_10000010_01001011100001010001111; // B = -10.36
            #2 reset = 1'b0;
            #3 reset = 1'b1;
            #1000 $finish;
        end

endmodule